/mob/living/carbon/superior_animal/genetic_atrocity/ambusher
	name = "Genetic Atrocity" //give a different shadow drop noise
	desc = "An experiment taken too far. Its flesh stretches and distorts in ways you wish weren't possible. Spindly, mutated spider legs twist from its body, it appears to be in utter agony."
	icon = 'icons/mob/mobs-monster.dmi'
	icon_state = "ambusher"
	maxHealth = 70
	health = 60
	melee_damage_lower = 10
	melee_damage_upper = 20
	flash_resistances = 10 //its eyes are useless, it uses echo-location to find its prey
	move_to_delay = 1
	emote_see = list("twitches.","oozes saliva.","convulses.","screeches in pain.")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = "roach"

/mob/living/carbon/superior_animal/genetic_atrocity/ambusher/UnarmedAttack(var/atom/A, var/proximity)
	if(isliving(A))
		var/mob/living/L = A
		if(istype(L) && !L.weakened && prob(10))
			if(L.stats.getPerk(PERK_ASS_OF_CONCRETE) || L.stats.getPerk(PERK_BRAWN))
				return
			else
				L.Weaken(3)
				L.visible_message(SPAN_DANGER("\the [src] knocks down \the [L]!"))

	. = ..()

/mob/living/carbon/superior_animal/genetic_atrocity/ambusher/Process()
	heal_overall_damage(0.1,0.1)
	if (health == maxHealth && src.z == 4)
		health = 0
		visible_message(SPAN_WARNING("\red The [src] suddenly collapses, its skin bubbles under the warm sunlight!"))

	if (health == maxHealth)
		new /mob/living/carbon/superior_animal/genetic_atrocity/shadow
		qdel(src)

/mob/living/carbon/superior_animal/genetic_atrocity/ambusher/death(gibbed)

/mob/living/carbon/superior_animal/genetic_atrocity/injured_ambusher
	name = "Genetic Atrocity"
	desc = "An experiment taken too far. Its flesh stretches and distorts in ways you wish weren't possible. Spindly, mutated spider legs twist from its body, it appears to be in utter agony."
	icon = 'icons/mob/mobs-monster.dmi'
	icon_state = "ambusher"
	maxHealth = 70
	health = 20
	melee_damage_lower = 10
	melee_damage_upper = 20
	flash_resistances = 10 //its eyes are useless, it uses echo-location to find its prey
	stunned = 4
	move_to_delay = 1
	emote_see = list("twitches.","oozes saliva.","convulses.","screeches in pain.")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = "roach"

/mob/living/carbon/superior_animal/genetic_atrocity/ambusher/UnarmedAttack(var/atom/A, var/proximity)
	if(isliving(A))
		var/mob/living/L = A
		if(istype(L) && !L.weakened && prob(10))
			if(L.stats.getPerk(PERK_ASS_OF_CONCRETE) || L.stats.getPerk(PERK_BRAWN))
				return
			else
				L.Weaken(3)
				L.visible_message(SPAN_DANGER("\the [src] knocks down \the [L]!"))

	. = ..()

/mob/living/carbon/superior_animal/genetic_atrocity/injured_ambusher/Process()
	. = ..()
	heal_overall_damage(0.1,0.1)
	if (health == maxHealth && src.z == 4)
		health = -5
		visible_message(SPAN_WARNING("\red The [src] suddenly collapses, its skin bubbles under the warm sunlight!"))

	if (health == maxHealth)
		new /mob/living/carbon/superior_animal/genetic_atrocity/shadow
		qdel(src)

/mob/living/carbon/superior_animal/genetic_atrocity/injured_ambusher/death(gibbed)

/mob/living/carbon/superior_animal/genetic_atrocity/shadow
	name = "odd shadow"
	desc = "You see an odd shadow, cast by something above you. A brown, pungent substance drips onto the ground. A quick glance and you're greeted with a malformed visage, chittering mindlessly to itself."
	icon = 'icons/mob/mobs-monster.dmi'
	icon_state = "shadow"
	maxHealth = 40
	health = 40
	melee_damage_lower = 1
	melee_damage_upper = 1
	move_to_delay = 4
	mob_size = MOB_SMALL
	flags = PROXMOVE
	faction = list("spiders", "roach")

/mob/living/carbon/superior_animal/genetic_atrocity/shadow/HasProximity(atom/movable/AM as mob|obj)
	if(iscarbon(AM))
		var/mob/living/carbon/M = AM
		playsound(src.loc, 'sound/sanity/screech.ogg', 300, 1)
		M.Weaken(3)
		new /mob/living/carbon/superior_animal/genetic_atrocity/ambusher(src.loc)
		qdel(src)

/mob/living/carbon/superior_animal/genetic_atrocity/shadow/death()
	new /mob/living/carbon/superior_animal/genetic_atrocity/injured_ambusher(src.loc)
	qdel(src)