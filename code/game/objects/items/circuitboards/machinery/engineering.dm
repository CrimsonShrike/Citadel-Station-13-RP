#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/circuitboard/pipelayer
	name = T_BOARD("pipe layer")
	build_path = /obj/machinery/pipelayer
	board_type = new /datum/frame/frame_types/machine
	materials = list(MAT_STEEL = 50, MAT_GLASS = 50)
	req_components = list(
		/obj/item/stock_parts/motor = 1,
		/obj/item/stock_parts/gear = 1,
		/obj/item/stock_parts/matter_bin = 1,
	)
