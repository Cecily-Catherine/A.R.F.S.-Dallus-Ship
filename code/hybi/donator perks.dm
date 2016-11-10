// WIP





var/list/donatoritems = list(/obj/item/weapon/reagent_containers/food/snacks/grown/poppy/geranium, /obj/item/weapon/reagent_containers/food/snacks/cookie, /obj/item/weapon/drilldo, /obj/item/clothing/under/bowlingoutfit, /obj/item/clothing/under/middriftturtleneck, /obj/item/clothing/tie/watch, /obj/item/toy/cattoygreen, /obj/item/clothing/suit/space/hardsuit/miningsacafe)
// List of the items they can get while being a donator. If you have a donator item you want on the list, put object path in here.
// I.E: list(/obj/donatoritem,/obj/item/weapon/reagent_containers/food/snacks/cookie, /obj/item/weapon/pen)


var/donators = list("tk420634", "jonathanhybrid", "sacafe", "chokin and tokin", "andyman105", "hibou4", "suicidalpickles")
//List of all the donators, ckeys = their username all lowercased with no spaces.
// I.E: "Its hip to fuck bees" would be "itshiptofuckbees" and in the list it would look like list("itshiptofuckbees","randomckey")

/client/verb/d_spawnitem(mob/living/carbon/human/H, mob/user)
	set name = "Donator Item Spawn"
	set category = "Donators"
	set desc = "Spawn in an item!"

	if(!ishuman(H))
		usr << "This can only be used on instances of type /mob/living/carbon/human"
		return

	if(ckey in donators)

		var/list/show_items = list("EXIT" = null) + sortList(donatoritems) // the list that will be shown to the user to pick from

		var/input_item = input(user, "Choose an item to spawn.", "Choose an item.") in show_items //Gives the list to what the user wants.

		H.equip_to_slot_or_del( new input_item(H), slot_l_hand ) // Spawn the item into left hand
		if(!(istype(H.l_hand,input_item))) //The rest of this is just to make sure their hands aren't full.
			H.equip_to_slot_or_del( new input_item(H), slot_r_hand )
			if(!(istype(H.r_hand,input_item)))
				src << "Hands are full!"
				log_admin("[key] has attempted to spawn in [input_item] but their hands were full!")
				return
			else
				H.update_inv_r_hand()//To ensure the icon appears in the HUD
		else
			H.update_inv_l_hand() // Same thing as the proc above.
		log_admin("[key_name(H)] donator spawned [input_item]") //Logging
		message_admins("[key_name(H)] donator spawned [input_item]")
		H << "<span class='adminnotice'>You've spawned in your <b>[input_item]</b>!</span>"
		return

	else
		usr << "Sorry, you aren't a donator. If you have donated, you will be able to access this feature in the next update."

/*
/client/proc/build_donator_items(donatoritems)
	for(var/d_typepath in donatoritems)
		var/atom/d_temp = new d_typepath(null)
		var/datum/data/donatoritem/d_R = new /datum/data/donatoritem()
		d_R.name = initial(d_temp.name)
		d_R.name = d_typepath
Can't get this shit to work, rip.*/