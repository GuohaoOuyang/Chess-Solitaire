note
	description: "Summary description for {SETUP_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SETUP_CHESS

inherit
    COMMAND


create
    make

feature--attributes

	chess : STRING
	row : INTEGER
	column : INTEGER
--	s : STRING
--    ha : CHESS_SOLITAIRE

feature{NONE}    -- initialization
    make (c : STRING; r: INTEGER; d : INTEGER)

       do
       	chess := c
       	row := r
       	column := d

       end


feature --setup chess

    execute

        do
			 model_access.m.setup_chess (chess, row, column)
        end

feature --undo
    undo
        do
            model_access.m.undo_setup (row, column)

        end

feature --redo
    redo
        do
           model_access.m.redo_setup (chess, row, column)
        end

    state
       do
       	  model_access.m.set_state ("  Game being Setup...")
       end

end
