note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVES
inherit
	ETF_MOVES_INTERFACE
create
	make
feature -- command
	moves(row: INTEGER_32 ; col: INTEGER_32)
    	do
			-- perform some update on the model state
			 if
            	model.start.is_empty
            then
            	model.set_error ("Game not yet started")
            elseif
            	model.count ~ 1
            then
            	model.set_error ("Game already over")
            elseif
            	model.s ~ "  Game Over: You Lose!"
            then
                model.set_error ("Game already over")
            else
            	if
            		row < 1 or row > 4
            	then
            		model.set_error ("(" + row.out + ", " + col.out + ") not a valid slot")
            	elseif
            		col < 1 or col > 4
            	then
            		model.set_error ("(" + row.out + ", " + col.out + ") not a valid slot")

            	else
            		model.moves (row, col)
            	end
            end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
