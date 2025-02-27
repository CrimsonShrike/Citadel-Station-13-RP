/obj/structure/outcrop
	name = "outcrop"
	desc = "A boring rocky outcrop."
	icon = 'icons/obj/outcrop.dmi'
	density = TRUE
	pass_flags_self = ATOM_PASS_THROWN | ATOM_PASS_OVERHEAD_THROW
	climb_allowed = TRUE
	depth_level = 12
	anchored = TRUE
	icon_state = "outcrop"
	var/mindrop = 5
	var/upperdrop = 10
	var/outcropdrop = /obj/item/ore/glass

/obj/structure/outcrop/Initialize(mapload)
	. = ..()
	if(prob(1))
		add_overlay(image(icon, "[initial(icon_state)]-egg"))

/obj/structure/outcrop/diamond
	name = "shiny outcrop"
	desc = "A shiny rocky outcrop."
	icon_state = "outcrop-diamond"
	mindrop = 2
	upperdrop = 4
	outcropdrop = /obj/item/ore/diamond

/obj/structure/outcrop/phoron
	name = "shiny outcrop"
	desc = "A shiny rocky outcrop."
	icon_state = "outcrop-phoron"
	mindrop = 4
	upperdrop = 8
	outcropdrop = /obj/item/ore/phoron

/obj/structure/outcrop/iron
	name = "rugged outcrop"
	desc = "A rugged rocky outcrop."
	icon_state = "outcrop-iron"
	mindrop = 10
	upperdrop = 20
	outcropdrop = /obj/item/ore/iron

/obj/structure/outcrop/coal
	name = "rugged outcrop"
	desc = "A rugged rocky outcrop."
	icon_state = "outcrop-coal"
	mindrop = 10
	upperdrop = 20
	outcropdrop = /obj/item/ore/coal

/obj/structure/outcrop/lead
	name = "rugged outcrop"
	desc = "A rugged rocky outcrop."
	icon_state = "outcrop-lead"
	mindrop = 2
	upperdrop = 5
	outcropdrop = /obj/item/ore/lead

/obj/structure/outcrop/gold
	name = "hollow outcrop"
	desc = "A hollow rocky outcrop."
	icon_state = "outcrop-gold"
	mindrop = 4
	upperdrop = 6
	outcropdrop = /obj/item/ore/gold

/obj/structure/outcrop/silver
	name = "hollow outcrop"
	desc = "A hollow rocky outcrop."
	icon_state = "outcrop-silver"
	mindrop = 6
	upperdrop = 8
	outcropdrop = /obj/item/ore/silver

/obj/structure/outcrop/platinum
	name = "hollow outcrop"
	desc = "A hollow rocky outcrop."
	icon_state = "outcrop-platinum"
	mindrop = 2
	upperdrop = 5
	outcropdrop = /obj/item/ore/osmium

/obj/structure/outcrop/uranium
	name = "spiky outcrop"
	desc = "A spiky rocky outcrop, it glows faintly."
	icon_state = "outcrop-uranium"
	mindrop = 4
	upperdrop = 8
	outcropdrop = /obj/item/ore/uranium

/obj/structure/outcrop/elder
	name = "chiming outcrop"
	desc = "A rocky outcrop. A faint chiming noise can be heard coming from inside."
	icon_state = "outcrop"
	mindrop = 1
	upperdrop = 2
	outcropdrop = /obj/item/elderstone

/obj/structure/outcrop/attackby(obj/item/W as obj, mob/user as mob)
	if (istype(W, /obj/item/pickaxe))
		to_chat(user, "<span class='notice'>[user] begins to hack away at \the [src].</span>")
		if(do_after(user,40))
			to_chat(user, "<span class='notice'>You have finished digging!</span>")
			for(var/i=0;i<(rand(mindrop,upperdrop));i++)
				new outcropdrop(get_turf(src))
			qdel(src)
			return

/obj/random/outcrop //In case you want an outcrop without pre-determining the type of ore.
	name = "random rock outcrop"
	desc = "This is a random rock outcrop."
	icon = 'icons/obj/outcrop.dmi'
	icon_state = "outcrop-random"

/obj/random/outcrop/item_to_spawn()
	return pick(prob(100);/obj/structure/outcrop,
				prob(100);/obj/structure/outcrop/iron,
				prob(100);/obj/structure/outcrop/coal,
				prob(65);/obj/structure/outcrop/silver,
				prob(50);/obj/structure/outcrop/gold,
				prob(30);/obj/structure/outcrop/uranium,
				prob(30);/obj/structure/outcrop/phoron,
				prob(7);/obj/structure/outcrop/diamond,
				prob(15);/obj/structure/outcrop/platinum,
				prob(15);/obj/structure/outcrop/lead)
