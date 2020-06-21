note
	description: "Summary description for {MOVE_AND_CAPTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_AND_CAPTURE

inherit
    COMMAND


create
    make

feature--attributes
    row1 : INTEGER
    column1 : INTEGER
    row2 : INTEGER
    column2 : INTEGER
    chess_m : STRING
    chess_d :STRING


feature{NONE}    -- initialization
    make (ch1: STRING; ro1: INTEGER; co1 :INTEGER; ch2: STRING; ro2 : INTEGER; co2: INTEGER)

        do
        	row1 := ro1
        	column1 := co1
        	row2 := ro2
        	column2 := co2
        	chess_m := ch1
        	chess_d := ch2
        end


feature --setup chess

    execute

        do
        	model_access.m.move_and_capture (row1, column1, row2, column2)
        end

feature --undo
    undo
        do
           model_access.m.chess_board.put (chess_d, row2, column2)
           model_access.m.chess_board.put (chess_m, row1, column1)
           model_access.m.row.force (row1)
           model_access.m.row.forth
           model_access.m.col.force (column1)
           model_access.m.col.forth
           model_access.m.undo_mac

        end

feature --redo
    redo
        do
           model_access.m.move_and_capture (row1, column1, row2, column2)
        end

    state
        do
        	model_access.m.set_state ("  Game In Progress...")
        end


end
