class Blacksmith extends NPC
	scenes: "sample_indoor"
	new: =>
    	@getChar(1, 6)
    	@x, @y = 18*16, 13*16
    	super!
    	@dialog(true)
    collide: (other) =>
    	if other.__class.__name == "Player" @dialog(false)
	dialog: (cutscene) =>
		if player.data.token and not cutscene then Convoke(Bind(@inQuest, self))!
		else unless player.data.token then Convoke(Bind(@startQuest, self))!
	startQuest: (cont, wait) =>
		player\disable!
		@moveTo(15, 14, cont!)
		wait!
		@moveTo(16, 17, cont!)
		wait!
		@moveTo(18, 17, cont!)
		wait!
	    @say("Blacksmith", {
	    	"Ah, hello there young’un! Wait! I suppose I can’t call you that anymore. Happy Birthday! What can I do for you this morning?",
	     	"Ah, what’s this? What a strange token. I’ve never seen a symbol like this before. What fine craftsmanship. Here let me study it a bit more carefully.",
	     	"In the meanwhile, why don’t ye do something for me? I left my lucky gold ring at the tavern last night. I took it off to brawl someone. Poor sucker wasn’t even able to lay a finger on me.",
     		"I’ll tell ye what. Get me my ring back for me and I’ll tell you of the origins of this token, free of charge.",
     		"The road to the tavern may be a little dangerous. You’d better take this blade."
	 	}, cont!)
	    wait!
	    player.data.weapon = true
	    player\say({"Inventory", {0,255,0}}, {"You recieved bronze blade."}, cont!)
	    player\say({"Objective", {255,0,0}}, {"Ask the tavern server where Blacksmith Bono’s lucky ring is and return it to Bono."})
	    player.data.token = {started: true}
	inQuest: => @say("Blacksmith", {"Well, get a move on! I haven't got all day."})
		