/obj/machinery/mining
	icon = 'icons/obj/mining_drill.dmi'
	anchored = 0
	use_power = USE_POWER_OFF //The drill takes power directly from a cell.
	density = 1
	layer = MOB_LAYER+0.1 //So it draws over mobs in the tile north of it.

/obj/machinery/mining/drill
	name = "mining drill head"
	desc = "An enormous drill."
	icon_state = "mining_drill"
	circuit = /obj/item/circuitboard/miningdrill
	var/braces_needed = 2
	var/list/obj/machinery/mining/brace/supports = list()
	var/supported = 0
	var/active = 0
	var/list/resource_field = list()
	var/obj/item/radio/intercom/faultreporter = new /obj/item/radio/intercom{channels=list("Supply")}(null)
	var/gps_tag = "DRILL0"
	var/list/ore_types = list(
		MAT_HEMATITE = /obj/item/ore/iron,
		MAT_URANIUM = /obj/item/ore/uranium,
		MAT_GOLD = /obj/item/ore/gold,
		MAT_SILVER = /obj/item/ore/silver,
		MAT_COPPER = /obj/item/ore/copper,
		MAT_DIAMOND = /obj/item/ore/diamond,
		MAT_PHORON = /obj/item/ore/phoron,
		MAT_OSMIUM = /obj/item/ore/osmium,
		"hydrogen" = /obj/item/ore/hydrogen,
		"silicates" = /obj/item/ore/glass,
		MAT_CARBON = /obj/item/ore/coal,
		MAT_MARBLE = /obj/item/ore/marble,
		MAT_LEAD = /obj/item/ore/lead,
		)

	//Upgrades
	var/harvest_speed
	var/capacity
	var/charge_use
	var/obj/item/cell/cell = null

	//Flags
	var/need_update_field = 0
	var/need_player_check = 0

/obj/machinery/mining/drill/Initialize(mapload)
	AddComponent(/datum/component/gps_signal, gps_tag)
	. = ..()
	component_parts = list(
		new /obj/item/stock_parts/matter_bin(src),
		new /obj/item/stock_parts/capacitor(src),
		new /obj/item/stock_parts/micro_laser(src),
		new /obj/item/cell/high(src)
	)
	RefreshParts()

/obj/machinery/mining/drill/get_cell()
	return cell

/obj/machinery/mining/drill/process(delta_time)

	if(need_player_check)
		return

	check_supports()

	if(!active) return

	if(!anchored || !use_cell_power())
		system_error("System configuration or charge error.")
		return

	if(need_update_field)
		get_resource_field()

	if(world.time % 10 == 0)
		update_icon()

	if(!active)
		return

	//Drill through the flooring, if any.
	if(istype(get_turf(src), /turf/simulated))
		var/turf/simulated/T = get_turf(src)
		LEGACY_EX_ACT(T, 2, null)

	//Dig out the tasty ores.
	if(resource_field.len)
		var/turf/simulated/harvesting = pick(resource_field)

		while(resource_field.len && !harvesting.resources)
			harvesting.has_resources = 0
			harvesting.resources = null
			resource_field -= harvesting
			if(resource_field.len) // runtime protection
				harvesting = pick(resource_field)
			else
				harvesting = null

		if(!harvesting) return

		var/total_harvest = harvest_speed //Ore harvest-per-tick.
		var/found_resource = 0 //If this doesn't get set, the area is depleted and the drill errors out.

		for(var/metal in GLOB.ore_types)

			if(contents.len >= capacity)
				system_error("Insufficient storage space.")
				active = 0
				need_player_check = 1
				update_icon()
				return

			if(contents.len + total_harvest >= capacity)
				total_harvest = capacity - contents.len

			if(total_harvest <= 0)
				break
			if(harvesting.resources[metal])

				found_resource  = 1

				var/create_ore = 0
				if(harvesting.resources[metal] >= total_harvest)
					harvesting.resources[metal] -= total_harvest
					create_ore = total_harvest
					total_harvest = 0
				else
					total_harvest -= harvesting.resources[metal]
					create_ore = harvesting.resources[metal]
					harvesting.resources[metal] = 0

				for(var/i=1, i <= create_ore, i++)
					var/oretype = GLOB.ore_types[metal]
					new oretype(src)

		if(!found_resource)	// If a drill can't see an advanced material, it will destroy it while going through.
			harvesting.has_resources = 0
			harvesting.resources = null
			resource_field -= harvesting
	else
		active = 0
		need_player_check = 1
		update_icon()
		system_error("Resources depleted.")

/obj/machinery/mining/drill/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/mining/drill/attackby(obj/item/O as obj, mob/user as mob)
	if(!active)
		if(istype(O, /obj/item/multitool))
			var/newtag = text2num(sanitizeSafe(input(user, "Enter new ID number or leave empty to cancel.", "Assign ID number") as text, 4))
			if(newtag)
				name = "[initial(name)] #[newtag]"
				to_chat(user, "<span class='notice'>You changed the drill ID to: [newtag]</span>")
			return
		if(default_deconstruction_screwdriver(user, O))
			return
		if(default_deconstruction_crowbar(user, O))
			return
		if(default_part_replacement(user, O))
			return
	if(!panel_open || active) return ..()

	if(istype(O, /obj/item/cell))
		if(cell)
			to_chat(user, "The drill already has a cell installed.")
		else
			if(!user.attempt_insert_item_for_installation(O, src))
				return
			cell = O
			component_parts += O
			to_chat(user, "You install \the [O].")
		return
	..()

/obj/machinery/mining/drill/attack_hand(mob/user, list/params)
	check_supports()

	if (panel_open && cell && user.Adjacent(src))
		to_chat(user, "You take out \the [cell].")
		cell.loc = get_turf(user)
		component_parts -= cell
		cell = null
		return
	else if(need_player_check)
		to_chat(user, "You hit the manual override and reset the drill's error checking.")
		need_player_check = 0
		if(anchored)
			get_resource_field()
		update_icon()
		return
	else if(supported && !panel_open)
		if(use_cell_power())
			active = !active
			if(active)
				visible_message("<span class='notice'>\The [src] lurches downwards, grinding noisily.</span>")
				need_update_field = 1
			else
				visible_message("<span class='notice'>\The [src] shudders to a grinding halt.</span>")
		else
			to_chat(user, "<span class='notice'>The drill is unpowered.</span>")
	else
		to_chat(user, "<span class='notice'>Turning on a piece of industrial machinery without sufficient bracing or wires exposed is a bad idea.</span>")

	update_icon()

/obj/machinery/mining/drill/update_icon()
	if(need_player_check)
		icon_state = "mining_drill_error"
	else if(active)
		icon_state = "mining_drill_active"
	else if(supported)
		icon_state = "mining_drill_braced"
	else
		icon_state = "mining_drill"
	return

/obj/machinery/mining/drill/RefreshParts()
	..()
	harvest_speed = 0
	capacity = 0
	charge_use = 25

	for(var/obj/item/stock_parts/P in component_parts)
		if(istype(P, /obj/item/stock_parts/micro_laser))
			harvest_speed += P.rating * 3
		if(istype(P, /obj/item/stock_parts/matter_bin))
			capacity = 300 * P.rating
		if(istype(P, /obj/item/stock_parts/capacitor))
			charge_use -= 5 * P.rating
	charge_use = max(charge_use, 0)
	cell = locate(/obj/item/cell) in component_parts

/obj/machinery/mining/drill/proc/check_supports()

	supported = 0

	if((!supports || !supports.len) && initial(anchored) == 0)
		icon_state = "mining_drill"
		anchored = 0
		active = 0
	else
		anchored = 1

	if(supports)
		if(supports.len >= braces_needed)
			supported = 1
		else for(var/obj/machinery/mining/brace/check in supports)
			if(check.brace_tier >= 3)
				supported = 1

	update_icon()

/obj/machinery/mining/drill/proc/system_error(var/error)

	if(error)
		src.visible_message("<span class='notice'>\The [src] flashes a '[error]' warning.</span>")
		faultreporter.autosay(error, src.name, "Supply")
	need_player_check = 1
	active = 0
	update_icon()

/obj/machinery/mining/drill/proc/get_resource_field()

	resource_field = list()
	need_update_field = 0

	var/turf/T = get_turf(src)
	if(!istype(T))
		return

	for(var/turf/simulated/mining_turf in RANGE_TURFS(7, T))
		if(!mining_turf.has_resources)
			continue
		resource_field += mining_turf

	if(!resource_field.len)
		system_error("Resources depleted.")

/obj/machinery/mining/drill/proc/use_cell_power()
	if(!cell) return 0
	if(cell.charge >= charge_use)
		cell.use(charge_use)
		return 1
	return 0

/obj/machinery/mining/drill/verb/unload()
	set name = "Unload Drill"
	set category = "Object"
	set src in oview(1)

	if(usr.stat) return

	var/obj/structure/ore_box/B = locate() in orange(1)
	if(B)
		for(var/obj/item/ore/O in contents)
			B.take(O)
		to_chat(usr, "<span class='notice'>You unload the drill's storage cache into the ore box.</span>")
	else
		to_chat(usr, "<span class='notice'>You must move an ore box up to the drill before you can unload it.</span>")


/obj/machinery/mining/brace
	name = "mining drill brace"
	desc = "A machinery brace for an industrial drill. It looks easily two feet thick."
	icon_state = "mining_brace"
	circuit = /obj/item/circuitboard/miningdrillbrace
	var/brace_tier = 1
	var/obj/machinery/mining/drill/connected

/obj/machinery/mining/brace/examine(mob/user)
	. = ..()
	if(brace_tier >= 3)
		. += SPAN_NOTICE("The internals of the brace look resilient enough to support a drill by itself.")

/obj/machinery/mining/brace/Initialize()
	. = ..()


/obj/machinery/mining/brace/RefreshParts()
	..()
	brace_tier = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		brace_tier += M.rating

/obj/machinery/mining/brace/attackby(obj/item/W as obj, mob/user as mob)
	if(connected && connected.active)
		to_chat(user, "<span class='notice'>You can't work with the brace of a running drill!</span>")
		return

	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	if(default_part_replacement(user,W))
		return

	if(W.is_wrench())

		if(istype(get_turf(src), /turf/space))
			to_chat(user, "<span class='notice'>You can't anchor something to empty space. Idiot.</span>")
			return

		playsound(src, W.tool_sound, 100, 1)
		to_chat(user, "<span class='notice'>You [anchored ? "un" : ""]anchor the brace.</span>")

		anchored = !anchored
		if(anchored)
			connect()
		else
			disconnect()

/obj/machinery/mining/brace/proc/connect()

	var/turf/T = get_step(get_turf(src), src.dir)

	for(var/thing in T.contents)
		if(istype(thing, /obj/machinery/mining/drill))
			connected = thing
			break

	if(!connected)
		return

	if(!connected.supports)
		connected.supports = list()

	icon_state = "mining_brace_active"

	connected.supports += src
	connected.check_supports()

/obj/machinery/mining/brace/proc/disconnect()

	if(!connected) return

	if(!connected.supports) connected.supports = list()

	icon_state = "mining_brace"

	connected.supports -= src
	connected.check_supports()
	connected = null

/obj/machinery/mining/brace/verb/rotate_clockwise()
	set name = "Rotate Brace Clockwise"
	set category = "Object"
	set src in oview(1)

	if(usr.stat) return

	if (src.anchored)
		to_chat(usr, "It is anchored in place!")
		return 0

	src.setDir(turn(src.dir, 270))
	return 1
