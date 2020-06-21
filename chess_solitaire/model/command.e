note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND


feature {NONE}



		  model_access: CHESS_SOLITAIRE_ACCESS


--feature -- Attributes
--	 may declare your own model state here
--	model : CHESS_SOLITAIRE


feature

	execute
	  deferred

	  end

feature

	undo
	  deferred

	  end

feature

    redo
      deferred
      end

    state
      deferred
      end

end
