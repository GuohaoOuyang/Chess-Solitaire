note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_AND_CAPTURE
inherit
	ETF_MOVE_AND_CAPTURE_INTERFACE
create
	make
feature -- command
	move_and_capture(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32)
	    local
	    	c: STRING
            h, j : BOOLEAN
            mac : MOVE_AND_CAPTURE
            ch1 :STRING
            ch2 : STRING
    	do
			-- perform some update on the model state
			h := False
			j := True
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
            		r1 < 1 or r1 > 4
            	then
            		model.set_error ("(" + r1.out + ", " + c1.out + ") not a valid slot")
            	elseif
            		c1 < 1 or c1 > 4
            	then
            		model.set_error ("(" + r1.out + ", " + c1.out + ") not a valid slot")
            	elseif
            		r2 < 1 or r2 > 4
            	then
            		model.set_error ("(" + r2.out + ", " + c2.out + ") not a valid slot")
            	elseif
            		c2 < 1 or c2 > 4
            	then
            		model.set_error ("(" + r2.out + ", " + c2.out + ") not a valid slot")
            	elseif
        	        model.chess_board.item (r1, c1) ~ "."
        	    then
        		    model.set_error ("Slot @ (" + r1.out + ", " + c1.out + ") not occupied")
             	elseif
        	      	model.chess_board.item (r2, c2) ~ "."
            	then
        		    model.set_error ("Slot @ (" + r2.out + ", " + c2.out + ") not occupied")

            	else

            		model.invisible_move (r1, c1)
            		if
            			model.chess_board_move.item (r2, c2) ~ "+"
            		then
            			if
            				(r1 > r2) and (c1 > c2)
            			then
            				if
            					(r1 - r2) ~ (c1 -c2)
            				then
                                if
                                	(r1 - 1) > r2 and (not (model.chess_board.item (r1 - 1, c1 - 1) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                	(r1 - 2) > r2 and (not (model.chess_board.item (r1 - 2, c1 - 2) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   (not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+"))
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                            	h := False

                                			end

                                			   j := h and j
                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end

                                end

                            elseif
                            	(r1 - r2) /= (c1 - c2)
                            then
                            	if
                            		(not (model.chess_board.item (r1 - 1, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r1 - r2) < (c1 - c2) and (not (model.chess_board.item (r1 - 1, c1 - 1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r1 - r2) > (c1 - c2) and (not (model.chess_board.item (r1 - 2, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                            	h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                            	end
            				end
            			elseif
            			   (r1 < r2) and (c1 < c2)
            			then
            				if
            				    (r2 - r1) ~ (c2 -c1)
            				then
            					if
                                	(r2 - 1) > r1 and (not (model.chess_board.item (r2 - 1, c2 - 1) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                	(r2 - 2) > r1 and (not (model.chess_board.item (r2 - 2, c2 - 2) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end
                            elseif
                            	(r2 - r1) /= (c2 - c1)
                            then
                            	if
                            		(not (model.chess_board.item (r1 + 1, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r2 - r1) < (c2 - c1) and (not (model.chess_board.item (r1 + 1, c1 + 1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r2 - r1) > (c2 - c1) and (not (model.chess_board.item (r1 + 2, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                            	end
            				end
            			elseif
            				(r1 > r2) and (c1 < c2)
            			then
            				if
            				    (r1 - r2) ~ (c2 -c1)
            				then
            					if
                                	(r1 - 1) > r2 and (not (model.chess_board.item (r1 - 1, c1 + 1) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                	(r1 - 2) > r2 and (not (model.chess_board.item (r1 - 2, c1 + 2) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end
                            elseif
                            	(r1 - r2) /= (c2 - c1)
                            then
                            	if
                            		(not (model.chess_board.item (r1 - 1, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r1 - r2) < (c2 - c1) and (not (model.chess_board.item (r1 - 1, c1 + 1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r1 - r2) > (c2 - c1) and (not (model.chess_board.item (r1 - 2, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                            	end
            				end
            			elseif
            				(r1 < r2) and (c1 > c2)
            			then
            				if
            				    (r2 - r1) ~ (c1 - c2)
            				then
            					if
                                	(r1 + 1) < r2 and (not (model.chess_board.item (r1 + 1, c1 - 1) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                	(r1 + 2) < r2 and (not (model.chess_board.item (r1 + 2, c1 - 2) ~ "."))
                                then
                                	model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end
                            elseif
                            	(r2 - r1) /= (c1 - c2)
                            then
                            	if
                            		(not (model.chess_board.item (r1 + 1, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r2 - r1) < (c1 - c2) and (not (model.chess_board.item (r1 + 1, c1 - 1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	elseif
                            		(r2 - r1) > (c1 - c2) and (not (model.chess_board.item (r1 + 2, c1) ~ "."))
                            	then
                            		model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                            	else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			elseif
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 2  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 2  end)
--                                  			then
--                                				h := True

                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                            	end
            				end
            			elseif
            				(r1 ~ r2)
            			then
            				if
            					(c1 < c2)
            				then
            					if
                                    (c1 + 1) < c2 and (not (model.chess_board.item (r1, c1 + 1) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                    (c1 + 2) < c2 and (not (model.chess_board.item (r1, c1 + 2) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end


            			    elseif
                        	      (c1 > c2)
                            then
                        	    if
                                    (c1 - 1) > c2 and (not (model.chess_board.item (r1, c1 - 1) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                    (c1 - 2) > c2 and (not (model.chess_board.item (r1, c1 - 2) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end
                             end
                        elseif
                        	(c1 ~ c2)
                        then
                        	if
                        		(r1 > r2)
                        	then
                        		if
                                    (r1 - 1) > r2 and (not (model.chess_board.item (r1 - 1, c1) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                    (r1 - 2) > r2 and (not (model.chess_board.item (r1 - 2, c1) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end
                            elseif
                            	(r1 < r2)
                            then
                            	if
                                    (r1 + 1) < r2 and (not (model.chess_board.item (r1 + 1, c1) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                elseif
                                    (r1 + 2) < r2 and (not (model.chess_board.item (r1 + 2, c1) ~ "."))
                                then
                                    model.set_error ("Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out + ")")
                                else
                                	ch1 := model.chess_board.item (r1, c1)
                                	ch2 := model.chess_board.item (r2, c2)
            		                create mac.make (ch1, r1, c1, ch2, r2, c2)
                                    model.extend_history (mac)
            		                mac.execute
                                	if
                                	    model.count > 1
                                	then
                                		across
                                			1 |..| model.count is chessi
                                		loop
                                			model.invisible_move (model.row.at(chessi), model.col.at(chessi))
                                			if
                                				across
                                              	    1 |..| model.count is chesso
                                                all
                                                   not (model.chess_board_move.item (model.row.at (chesso), model.col.at (chesso)) ~ "+")
                                                end
                                			then
                                				h := True
--                                			else
--                                				if
--                                					model.chess_board_move.item (model.row.at (chessi), model.col.at (chessi)) ~ "N" and
--                                                    (across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) + 1  end
--                                                    or across 1 |..| model.count is chessk some model.row.at (chessk) ~ (model.row.at (chessi)) - 1  end)
--                                  				then
--                                					h := True
--                                				end
                                            else
                                                h := False
                                			end
                                			j := h and j

                                		end
                                        if
                                        	j
                                        then
                                        	model.set_lose ("  Game Over: You Lose!")
                                        end


                            	    end
                                end

                        	end
            			end
            		else
            		    c := model.chess_board.item (r1, c1)
            			model.set_error ("Invalid move of " + c + " from (" + r1.out + ", " + c1.out + ") to (" + r2.out + ", " + c2.out + ")")
            		end

            	end
            end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
