note
	description: "Summary description for {START_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	START_GAME
inherit
	COMMAND


feature
	execute
	   do
          model_access.m.start_game
	   end
feature
	undo
	   do
          model_access.m.start.make_empty
	   end
feature
	redo
	   do
	   	model_access.m.start_game
	   end

feature
	state
	   do
          model_access.m.set_state ("  Game being Setup...")
	   end
end
