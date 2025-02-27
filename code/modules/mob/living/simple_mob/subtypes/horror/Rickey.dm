/datum/category_item/catalogue/fauna/horror/Rickey
	name = "!)*AKE@#US*!PRETT"
	desc = "%WARNING% PROCESSING FAILURE! RETURN SCANNER TO A CENTRAL \
	ADMINISTRATOR FOR IMMEDIATE MAINTENANCE! %ERROR%"
	value = CATALOGUER_REWARD_TRIVIAL

/mob/living/simple_mob/horror/Rickey
	name = "???"
	desc = "What a handsome Man, his mother must think."

	icon_state = "Rickey"
	icon_living = "Rickey"
	icon_dead = "r_head"
	icon_rest = "Rickey"
	faction = "horror"
	icon = 'icons/mob/horror_show/GHPS.dmi'
	icon_gib = "generic_gib"
	catalogue_data = list(/datum/category_item/catalogue/fauna/horror/Rickey)

	attack_sound = 'sound/h_sounds/wor.ogg'

	maxHealth = 175
	health = 175

	melee_damage_lower = 25
	melee_damage_upper = 35
	grab_resist = 100

	response_help = "pets the"
	response_disarm = "bops the"
	response_harm = "hits the"
	attacktext = list("amashes")
	friendly = list("nuzzles", "boops", "bumps against", "leans on")


	say_list_type = /datum/say_list/Rickey
	ai_holder_type = /datum/ai_holder/simple_mob/horror

	meat_amount = 4
	meat_type = /obj/item/reagent_containers/food/snacks/meat/human
	bone_amount = 2
	hide_amount = 2
	exotic_amount = 2

/mob/living/simple_mob/horror/Rickey/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/horror_aura/weak)

/mob/living/simple_mob/horror/Rickey/death()
	playsound(src, 'sound/h_sounds/headcrab.ogg', 50, 1)
	..()

/mob/living/simple_mob/horror/Rickey/bullet_act()
	playsound(src, 'sound/h_sounds/holla.ogg', 50, 1)
	..()

/mob/living/simple_mob/horror/Rickey/attack_hand(mob/user, list/params)
	playsound(src, 'sound/h_sounds/holla.ogg', 50, 1)
	..()

/mob/living/simple_mob/horror/Rickey/throw_impacted(atom/movable/AM, datum/thrownthing/TT)
	. = ..()
	playsound(src, 'sound/h_sounds/holla.ogg', 50, 1)

/mob/living/simple_mob/horror/Rickey/attackby()
	playsound(src, 'sound/h_sounds/holla.ogg', 50, 1)
	..()

/datum/say_list/Rickey
	speak = list("Uuurrgh?","Aauuugghh...", "AAARRRGH!")
	emote_hear = list("shrieks horrifically", "groans in pain", "cries", "whines")
	emote_see = list("flexes to no one in particular", "shakes violently in place", "stares aggressively")
	say_maybe_target = list("Uuurrgghhh?")
	say_got_target = list("AAAHHHHH!")
