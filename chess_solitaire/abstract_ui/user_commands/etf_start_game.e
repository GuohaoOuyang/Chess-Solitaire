note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
create
	make
feature -- command
	start_game
	local
		start : START_GAME
    	do
			-- perform some update on the model state
			create start
			model.extend_history (start)
            start.execute
			etf_cmd_container.on_change.notify ([Current])
    	end

end
