note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_CHESS
inherit
	ETF_SETUP_CHESS_INTERFACE
create
	make
feature -- command
	setup_chess(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require else
			setup_chess_precond(c, row, col)
		local

		    s: STRING
            setup : SETUP_CHESS
    	do
--			 perform some update on the model state
            s := "."
            if
            	c ~ 3
            then
            	s := "N"
            elseif
            	c ~ 1
            then
            	s := "K"
            elseif
            	c ~ 2
            then
            	s := "Q"
            elseif
            	c ~ 4
            then
            	s := "B"
            elseif
            	c ~ 5
            then
            	s := "R"
            elseif
            	c ~ 6
            then
            	s := "P"
            end


            if
            	not model.start.is_empty
            then
            	model.set_error("Game already started")
            else
            	if
            		row >= 1  AND row <=4 AND col >= 1 AND col <= 4
            	then
            		if
            		    not (model.chess_board.item (row, col) ~ ".")
            		then
            			model.set_error("Slot @ (" + row.out + ", " + col.out + ") already occupied")
                    else
                    	create setup.make (s, row, col)
--                    	if
--                    		(not (model.history.is_empty)) and (not (model.history.islast))
--                    	then
						model.extend_history (setup)
--                    	end

                    	setup.execute
            		end
            	else

            		model.set_error ( "(" + row.out  + ", " + col.out + ") not a valid slot" )
            	end

            end


			etf_cmd_container.on_change.notify ([Current])
    	end


end
