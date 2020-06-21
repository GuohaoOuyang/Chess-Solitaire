note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	CHESS_SOLITAIRE

inherit
	ANY
		redefine
			out
		end

create {CHESS_SOLITAIRE_ACCESS}
	make


feature -- linear attributes

    row: LINKED_LIST[INTEGER]
    col: LINKED_LIST[INTEGER]
    chess_board: ARRAY2 [STRING]
    chess_board_move : ARRAY2 [STRING]
    history : LINKED_LIST[COMMAND]


feature -- model attributes
	s : STRING
	i : INTEGER
    error : STRING
    count : INTEGER
    start : STRING
    move : STRING
    chess_a : STRING
    chess_b : STRING
    occur: INTEGER
    m : INTEGER
    n :INTEGER


feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			i := 0
			create chess_board.make_filled("." , 4, 4)
			s := "has not setup yet"
			create error.make_empty
			count := 0
		    create row.make
		    create col.make
		    create start.make_empty
		    create chess_board_move.make_filled (".", 4, 4)
		    create move.make_empty
		    occur := 0
            create history.make
            create chess_a.make_empty
            create chess_b.make_empty

		end


feature -- model operations
	--default_update
			-- Perform update to the model state.
	--	do
	--		i := i + 1
	--	end

	set_error(e :STRING)

	   do
	   	error := e
	   end


    set_lose(g : STRING)

       do
       	s := g
       end

    set_state (ss : STRING)

       do
        s := ss
       end



	setup_chess(c :STRING; ro: INTEGER; co :INTEGER)
--	    local
--	    	setup : SETUP_CHESS

	    do
	    	if
	    		start.is_empty
	    	then
	    		s := "  Game being Setup..."
	    	if
	    		row.has (ro) and col.at(row.index_of (ro, 1)) ~ co
	        then
	        	error := "Slot @ (" + ro.out + ", " + co.out + ") already occupied"
	        else
	        	chess_board.put (c, ro, co)
                count := count + 1
                row.force (ro)
                row.forth
                col.force (co)
                col.forth
	    	end
	    	else
	    		error := "Game already started"
	    	end

	    end

	undo_setup (ur: INTEGER; uc : INTEGER)
	local
		pp : INTEGER
	    do
	    	chess_board.put (".", ur, uc)
	    	count := count - 1

            if
                  	col.at (row.index_of (ur, 1)) ~ uc
                then
                	pp := row.index_of (ur,1)
                  	row.go_i_th (pp)
                  	row.remove
                  	row.finish
                  	col.go_i_th (pp)
                  	col.remove
                  	col.finish
                elseif
                	col.at (row.index_of (ur, 2)) ~ uc
                then
                	pp := row.index_of (ur,2)
                	row.go_i_th (pp)
                  	row.remove
                  	row.finish
                  	col.go_i_th (pp)
                  	col.remove
                  	col.finish
                elseif
                	col.at (row.index_of (ur, 3)) ~ uc
                then
                	pp := row.index_of (ur,3)
                	row.go_i_th (pp)
                  	row.remove
                  	row.finish
                  	col.go_i_th (pp)
                  	col.remove
                  	col.finish
                elseif
                	col.at (row.index_of (ur, 4)) ~ uc
                then
                	pp := row.index_of (ur,4)
                	row.go_i_th (pp)
                  	row.remove
                  	row.finish
                  	col.go_i_th (pp)
                  	col.remove
                  	col.finish
                end


	    end

	redo_setup (rch: STRING; rr: INTEGER; rc: INTEGER)
	    do
	        chess_board.put (rch, rr, rc)
	        count := count + 1
	        row.force (rr)
	        row.forth
	        col.force (rc)
	        col.forth
	    end

	moves(ro1: INTEGER; co1 : INTEGER)

	    do
	    	if
	    	    start.is_empty
	    	then
	    		error := "Game not yet started"
	    	elseif
	    		chess_board.item (ro1, co1) ~ "."
	    	then
	    		error := "Slot @ (" + ro1.out + ", " + co1.out + ") not occupied"
	    	else
	    		s := "  Game In Progress..."
	    		move := "move example board"
                create chess_board_move.make_filled (".", 4, 4)
                if
                	chess_board.item (ro1, co1) ~ "B"
                then
                	chess_board_move.put("B", ro1, co1)

                	across
                		1 |..| 4 is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ro1 - 1) and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -2) and cm ~ (co1 -2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -3) and cm ~ (co1 - 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 1 ) and cm ~ ( co1 + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 2) and cm ~ (co1 + 2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 3) and cm ~ (co1 + 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 - 1) and cm ~ (co1 + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 - 2) and cm ~ (co1 + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 - 3) and cm ~ (co1 + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 1) and cm ~ (co1 - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 2) and cm ~ (co1 - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 3) and cm ~ (co1 - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ro1, co1) ~ "R"
                then
                	chess_board_move.put("R", ro1, co1)

                	across
                		1 |..| 4 is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ro1 - 1) and cm ~ co1
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -2) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -3) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 1 ) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 2) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 3) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ro1, co1) ~ "Q"
                then
                	chess_board_move.put("Q", ro1, co1)

                	across
                		1 |..| 4 is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ro1 - 1) and cm ~ co1
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -2) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -3) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 1 ) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 2) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 3) and cm ~ co1
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ro1 and cm ~ (co1 - 3)
                            then
                                chess_board_move.put ("+", rm, cm)

                			elseif
                				rm ~ (ro1 - 1) and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -2) and cm ~ (co1 -2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 -3) and cm ~ (co1 - 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 1 ) and cm ~ ( co1 + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 2) and cm ~ (co1 + 2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 3) and cm ~ (co1 + 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 - 1) and cm ~ (co1 + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 - 2) and cm ~ (co1 + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 - 3) and cm ~ (co1 + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 1) and cm ~ (co1 - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 2) and cm ~ (co1 - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ro1 + 3) and cm ~ (co1 - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ro1, co1) ~ "P"
                then
                	chess_board_move.put("P", ro1, co1)

                	across
                		1 |..| 4  is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ro1 - 1) and cm ~ (co1 -1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 - 1) and cm ~ (co1 + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ro1, co1) ~ "N"
                then
                	chess_board_move.put("N", ro1, co1)
                	across
                		1 |..| 4  is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ro1 - 1) and cm ~ (co1 + 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 - 1) and cm ~ (co1 - 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 1) and cm ~ (co1 + 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 1) and cm ~ (co1 - 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 - 2) and cm ~ (co1 + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 - 2) and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 2) and cm ~ (co1 + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 2) and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ro1, co1) ~ "K"
                then
                	chess_board_move.put("K", ro1, co1)
                	across
                		1 |..| 4  is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ro1 - 1) and cm ~ co1
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 1) and cm ~ co1
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ ro1 and cm ~ (co1 + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ ro1 and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 - 1) and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 - 1) and cm ~ (co1 + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 1) and cm ~ (co1 - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ro1 + 1) and cm ~ (co1 + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                end
	    	end

	    end

	invisible_move (ir : INTEGER; ic : INTEGER)

	    do
	    	create chess_board_move.make_filled (".", 4, 4)

	    	if
                	chess_board.item (ir, ic) ~ "B"
                then
                	chess_board_move.put("B", ir, ic)

                	across
                		1 |..| 4 is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ir - 1) and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -2) and cm ~ (ic -2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -3) and cm ~ (ic - 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 1 ) and cm ~ ( ic + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 2) and cm ~ (ic + 2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 3) and cm ~ (ic + 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir - 1) and cm ~ (ic + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir - 2) and cm ~ (ic + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir - 3) and cm ~ (ic + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 1) and cm ~ (ic - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 2) and cm ~ (ic - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 3) and cm ~ (ic - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ir, ic) ~ "R"
                then
                	chess_board_move.put("R", ir, ic)

                	across
                		1 |..| 4 is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ir - 1) and cm ~ ic
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -2) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -3) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 1 ) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 2) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 3) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ir, ic) ~ "Q"
                then
                	chess_board_move.put("Q", ir, ic)

                	across
                		1 |..| 4 is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ir - 1) and cm ~ ic
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -2) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -3) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 1 ) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 2) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 3) and cm ~ ic
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ ir and cm ~ (ic - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                			if
                				rm ~ (ir - 1) and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -2) and cm ~ (ic -2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir -3) and cm ~ (ic - 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 1 ) and cm ~ ( ic + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 2) and cm ~ (ic + 2)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 3) and cm ~ (ic + 3)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir - 1) and cm ~ (ic + 1)
                            then
                            	chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir - 2) and cm ~ (ic + 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir - 3) and cm ~ (ic + 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 1) and cm ~ (ic - 1)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 2) and cm ~ (ic - 2)
                            then
                                chess_board_move.put ("+", rm, cm)
                            elseif
                            	rm ~ (ir + 3) and cm ~ (ic - 3)
                            then
                                chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ir, ic) ~ "P"
                then
                	chess_board_move.put("P", ir, ic)

                	across
                		1 |..| 4  is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ir - 1) and cm ~ (ic -1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir - 1) and cm ~ (ic + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ir, ic) ~ "N"
                then
                	chess_board_move.put("N", ir, ic)
                	across
                		1 |..| 4  is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ir - 1) and cm ~ (ic + 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir - 1) and cm ~ (ic - 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 1) and cm ~ (ic + 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 1) and cm ~ (ic - 2)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir - 2) and cm ~ (ic + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir - 2) and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 2) and cm ~ (ic + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 2) and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                elseif
                	chess_board.item (ir, ic) ~ "K"
                then
                	chess_board_move.put("K", ir, ic)
                	across
                		1 |..| 4  is rm
                	loop
                		across
                			1 |..| 4 is cm
                		loop
                			if
                				rm ~ (ir - 1) and cm ~ ic
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 1) and cm ~ ic
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ ir and cm ~ (ic + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ ir and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir - 1) and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir - 1) and cm ~ (ic + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 1) and cm ~ (ic - 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			elseif
                				rm ~ (ir + 1) and cm ~ (ic + 1)
                			then
                				chess_board_move.put ("+", rm, cm)
                			end
                		end
                	end
                end
	    end

	move_and_capture(r1: INTEGER; c1 :INTEGER; r2 : INTEGER; c2: INTEGER)


        local
             p :INTEGER
        do

        	if
        		start.is_empty
        	then
        		error := "Game not yet started"

        	else
        		s := "  Game In Progress..."
                chess_board.put (chess_board.item (r1, c1), r2, c2)
                chess_board.put (".", r1, c1)
                move.make_empty
                count := count - 1
--                occur := row.occurrences (r1)
--                across 1 |..| 4 as o
--                loop
--                	m := row.index_of (r1, o.item)
--                	if
--                		col.at (m) ~ c1
--                	then
--                		row.go_i_th (m)
--                        row.remove
--                        col.go_i_th (m)
--                        col.remove
--                	end
--                end
--                from
--                	n := 1
--                until
--                	n > 4
--                loop
--                	m := row.index_of (r1, n)
--                	if
--                		col.at (m) ~ c1
--                	then
--                		row.go_i_th (m)
--                	    row.remove
--                	    col.go_i_th (m)
--                	    col.remove

--                	end
--                	n := n + 1
--                end

                if
                  	col.at (row.index_of (r1, 1)) ~ c1
                then
                	p := row.index_of (r1,1)
                  	row.go_i_th (p)
                  	row.remove
                  	row.finish
                  	col.go_i_th (p)
                  	col.remove
                  	col.finish
                elseif
                	col.at (row.index_of (r1, 2)) ~ c1
                then
                	p := row.index_of (r1,2)
                	row.go_i_th (p)
                  	row.remove
                  	row.finish
                  	col.go_i_th (p)
                  	col.remove
                  	col.finish
                elseif
                	col.at (row.index_of (r1, 3)) ~ c1
                then
                	p := row.index_of (r1,3)
                	row.go_i_th (p)
                  	row.remove
                  	row.finish
                  	col.go_i_th (p)
                  	col.remove
                  	col.finish
                elseif
                	col.at (row.index_of (r1, 4)) ~ c1
                then
                	p := row.index_of (r1,4)
                	row.go_i_th (p)
                  	row.remove
                  	row.finish
                  	col.go_i_th (p)
                  	col.remove
                  	col.finish
                end
                if
                	count ~ 1
                then
                	s := "  Game Over: You Win!"

                end


        	end

	    end

	undo_mac
	    do
	       count := count + 1
	    end

	check_lose

	    local

	    do
	    	chess_a := chess_board.item (row.at (1), col.at (1))
	    	chess_b := chess_board.item (row.at (2), col.at (2))



--            s := "  Game Over: You Lose!"
	    end

	start_game

	    do
	    	if
	    		start.is_empty
	    	then
	    		if
	    			count = 0
	    		then
	    			s := "  Game Over: You Lose!"
	    		elseif
	    			count = 1
	    		then
	    			s := "  Game Over: You Win!"
	    			start := "game is over"
	    		else
	    		s := "  Game In Progress..."
		        start := "game started"
		        end
		    else
		    	error := "Game already started"
	    	end

	    end

	reset_game

        do

        	if
        		start.is_empty
        	then
        		error := "Game not yet started"
        	else
                history.wipe_out
        		chess_board.make_filled (".", 4, 4)
        		s := "  Game being Setup..."
        	    start.make_empty
        	    row.wipe_out
        	    col.wipe_out
        	    count := 0
        	end

	    end

	reset
			-- Reset model state.
		do
			s := "  Game In Progress..."

		end


	extend_history(cmd: COMMAND)
		do
			if (not (history.is_empty)) and (not (history.islast))
			then
				remove_right
			end
			   history.extend (cmd)
			   history.finish
			-- move cursor to last element
		end

	remove_right
		-- remove right of current pos
		do
			from
				history.forth
			until
				history.after
			loop
				history.remove
--				history.forth
			end
		end



feature -- queries
	out : STRING
		do
			create Result.make_empty
			Result.append ("  # of chess pieces on board: ")
			Result.append (count.out)
--			Result.append ("%N")
--			Result.append (occur.out)
--			Result.append ("  row count :")
--			Result.append (m.out)
--			Result.append (row.count.out)
--			Result.append ("%N")
--			across 1 |..| row.count is rc
--			loop

--				Result.append (row.at(rc).out)
--			end
--			Result.append (chess_a)
--			Result.append ("%N")
--			Result.append ("  col count :")
--		    Result.append (col.count.out)
--		    Result.append ("%N")
--		    across 1 |..| col.count is cc
--			loop

--				Result.append (col.at(cc).out)
--			end
--		    Result.append (chess_b)
--		    Result.append ("%N")
--		    Result.append (history.count.out)
		    Result.append ("%N")
			if
				error.is_empty
			then
				if
			    not (s ~ "has not setup yet")
			then
				Result.append_string (s)
		        Result.append ("%N  ")
		    else
		    	Result.append ("  Game being Setup...")
		    	Result.append ("%N  ")
			end
			else
				Result.append ("  Error: ")
				Result.append(error)
				Result.append ("%N  ")
				error.make_empty
			end

            if
            	not move.is_empty
            then
            	across
		    		chess_board_move as cbm
		    	loop
		    		Result.append(cbm.item.out)

		    	    if
		    		   cbm.cursor_index\\4 ~ 0 AND
		    		   cbm.cursor_index /= 0 AND
		    		   cbm.cursor_index /= 16
		         	then
		    		   Result.append("%N  ")
		    	    end
		    	end
		    	move.make_empty
		    else
		    	across
		    	    chess_board as cb
		        loop
		    	    Result.append(cb.item.out)

		    	    if
		    		   cb.cursor_index\\4 ~ 0 AND
		    		   cb.cursor_index /= 0 AND
		    		   cb.cursor_index /= 16
		         	then
		    		   Result.append("%N  ")
		    	    end

		        end
		        move.make_empty

--            then
--            	across
--		    	    chess_board as cb
--		        loop
--		    	    Result.append(cb.item.out)

--		    	    if
--		    		   cb.cursor_index\\4 ~ 0 AND
--		    		   cb.cursor_index /= 0 AND
--		    		   cb.cursor_index /= 16
--		         	then
--		    		   Result.append("%N  ")
--		    	    end

--		        end
--		        move.make_empty
--		    else

--		    	across
--		    		chess_board_move as cbm
--		    	loop
--		    		Result.append(cbm.item.out)

--		    	    if
--		    		   cbm.cursor_index\\4 ~ 0 AND
--		    		   cbm.cursor_index /= 0 AND
--		    		   cbm.cursor_index /= 16
--		         	then
--		    		   Result.append("%N  ")
--		    	    end
--		    	end
----		    	move.make_empty
--		    	chess_board_move.make_filled ("." , 4, 4)
            end

		end

end




