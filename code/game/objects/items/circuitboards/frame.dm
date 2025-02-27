#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

//Circuitboards for frames (mostly wall based frames).  Most of these don't fit into other categories.

//! Displays

/obj/item/circuitboard/guestpass
	name = T_BOARD("guestpass console")
	build_path = /obj/machinery/computer/guestpass
	board_type = new /datum/frame/frame_types/guest_pass_console
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/status_display
	name = T_BOARD("status display")
	build_path = /obj/machinery/status_display
	board_type = new /datum/frame/frame_types/display
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/ai_status_display
	name = T_BOARD("ai status display")
	build_path = /obj/machinery/ai_status_display
	board_type = new /datum/frame/frame_types/display
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/newscaster
	name = T_BOARD("newscaster")
	build_path = /obj/machinery/newscaster
	board_type = new /datum/frame/frame_types/newscaster
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/atm
	name = T_BOARD("atm")
	build_path = /obj/machinery/atm
	board_type = new /datum/frame/frame_types/atm
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/request
	name = T_BOARD("request console")
	build_path = /obj/machinery/requests_console
	board_type = new /datum/frame/frame_types/supply_request_console
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

//! Alarms

/obj/item/circuitboard/firealarm
	name = T_BOARD("fire alarm")
	build_path = /obj/machinery/firealarm
	board_type = new /datum/frame/frame_types/fire_alarm
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/airalarm
	name = T_BOARD("air alarm")
	build_path = /obj/machinery/air_alarm
	board_type = new /datum/frame/frame_types/air_alarm
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/intercom
	name = T_BOARD("intercom")
	build_path = /obj/item/radio/intercom
	board_type = new /datum/frame/frame_types/intercom
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/keycard_auth
	name = T_BOARD("keycard authenticator")
	build_path = /obj/machinery/keycard_auth
	board_type = new /datum/frame/frame_types/keycard_authenticator
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)

//! Computers

/obj/item/circuitboard/scanner_console
	name = T_BOARD("body scanner console")
	build_path = /obj/machinery/body_scanconsole
	board_type = new /datum/frame/frame_types/medical_console
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)

/obj/item/circuitboard/sleeper_console
	name = T_BOARD("sleeper console")
	build_path = /obj/machinery/sleep_console
	board_type = new /datum/frame/frame_types/medical_console
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)

//! Machines

/obj/item/circuitboard/photocopier
	name = T_BOARD("photocopier")
	build_path = /obj/machinery/photocopier
	board_type = new /datum/frame/frame_types/photocopier
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/motor = 1,
		/obj/item/stock_parts/scanning_module = 1,
	)

/obj/item/circuitboard/fax
	name = T_BOARD("fax")
	build_path = /obj/machinery/photocopier/faxmachine
	board_type = new /datum/frame/frame_types/fax
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/motor = 1,
		/obj/item/stock_parts/scanning_module = 1,
	)

/obj/item/circuitboard/conveyor
	name = T_BOARD("conveyor")
	build_path = /obj/machinery/conveyor
	board_type = new /datum/frame/frame_types/conveyor
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/gear = 2,
		/obj/item/stock_parts/motor = 2,
	)

/obj/item/circuitboard/microwave
	name = T_BOARD("microwave")
	build_path = /obj/machinery/microwave
	board_type = new /datum/frame/frame_types/microwave
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)
	req_components = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stock_parts/motor = 1,
	)

/obj/item/circuitboard/recharger
	name = T_BOARD("recharger")
	build_path = /obj/machinery/recharger
	board_type = new /datum/frame/frame_types/recharger
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/capacitor = 1,
	)

/obj/item/circuitboard/recharger/wrecharger
	name = T_BOARD("wall recharger")
	build_path = /obj/machinery/recharger/wallcharger
	board_type = new /datum/frame/frame_types/wall_charger

/obj/item/circuitboard/cell_charger
	name = T_BOARD("heavy-duty cell charger")
	build_path = /obj/machinery/cell_charger
	board_type = new /datum/frame/frame_types/cell_charger
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/capacitor = 1,
	)

/obj/item/circuitboard/washing
	name = T_BOARD("washing machine")
	build_path = /obj/machinery/washing_machine
	board_type = new /datum/frame/frame_types/washing_machine
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)
	req_components = list(
		/obj/item/stock_parts/gear = 2,
		/obj/item/stock_parts/motor = 1,
	)

/obj/item/circuitboard/grinder
	name = T_BOARD("reagent grinder")
	build_path = /obj/machinery/reagentgrinder
	board_type = new /datum/frame/frame_types/grinder
	req_components = list(
		/obj/item/reagent_containers/glass/beaker/large = 1,
		/obj/item/stock_parts/gear = 1,
		/obj/item/stock_parts/motor = 1,
	)

/obj/item/circuitboard/distiller
	build_path = /obj/machinery/portable_atmospherics/powered/reagent_distillery
	board_type = new /datum/frame/frame_types/reagent_distillery
	req_components = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/gear = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/motor = 2,
	)

/obj/item/circuitboard/tele_pad
	name = T_BOARD("teleporter pad")
	build_path = /obj/machinery/tele_pad
	board_type = "tele_pad"
	origin_tech = list(TECH_DATA = 2, TECH_BLUESPACE = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stock_parts/micro_laser = 4,
		/obj/item/stock_parts/scanning_module = 4,
	)

/obj/item/circuitboard/tele_projector
	name = T_BOARD("teleporter projector")
	build_path = /obj/machinery/tele_projector
	board_type = "tele_projector"
	origin_tech = list(TECH_DATA = 2, TECH_BLUESPACE = 3)
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/smes_coil = 1,
	)

/obj/item/circuitboard/body_scanner
	name = T_BOARD("body scanner")
	build_path = /obj/machinery/bodyscanner
	board_type = new /datum/frame/frame_types/medical_pod
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)
	req_components = list(
		/obj/item/stack/material/glass/reinforced = 2,
		/obj/item/stock_parts/scanning_module = 3,
	)

/obj/item/circuitboard/sleeper
	name = T_BOARD("sleeper")
	build_path = /obj/machinery/sleeper
	board_type = new /datum/frame/frame_types/medical_pod
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)
	req_components = list(
		/obj/item/reagent_containers/glass/beaker = 3,
		/obj/item/reagent_containers/syringe = 3,
		/obj/item/stack/material/glass/reinforced = 2,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/scanning_module = 1,
	)

/obj/item/circuitboard/vr_sleeper
	name = T_BOARD("VR sleeper")
	build_path = /obj/machinery/vr_sleeper
	board_type = new /datum/frame/frame_types/medical_pod
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)
	req_components = list(
		/obj/item/stack/material/glass/reinforced = 2,
		/obj/item/stock_parts/scanning_module = 1,
	)

/obj/item/circuitboard/dna_analyzer
	name = T_BOARD("dna analyzer")
	build_path = /obj/machinery/dnaforensics
	board_type = new /datum/frame/frame_types/dna_analyzer
	origin_tech = list(TECH_MAGNET = 4, TECH_BIO = 2, TECH_DATA = 2)
	req_components = list(
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/scanning_module = 2,
	)

/obj/item/circuitboard/mass_driver
	name = T_BOARD("mass driver")
	build_path = /obj/machinery/mass_driver
	board_type = new /datum/frame/frame_types/mass_driver
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/gear = 2,
		/obj/item/stock_parts/motor = 2,
		/obj/item/stock_parts/spring = 1,
	)

/obj/item/circuitboard/operating_table
	name = T_BOARD("operating table")
	build_path = /obj/machinery/optable
	board_type = new /datum/frame/frame_types/operating_table
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)
	req_components = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/material/glass/reinforced = 2,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/scanning_module = 1,
	)

/obj/item/circuitboard/arf_generator
	name = T_BOARD("atmospheric field generator")
	build_path = /obj/machinery/atmospheric_field_generator
	board_type = new /datum/frame/frame_types/arfgs
	origin_tech = list(TECH_MAGNET = 4, TECH_POWER = 4, TECH_BIO = 3)
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stock_parts/capacitor/adv = 1,    //for the JUICE
		/obj/item/stock_parts/micro_laser/high = 2, //field emitters
		/obj/item/stock_parts/scanning_module = 1,  //atmosphere sensor
	)
