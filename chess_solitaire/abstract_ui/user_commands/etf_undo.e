note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			if
				not (model.history.off)
			then
				model.history.item.undo

				model.history.item.state
                model.history.back
			else
				model.set_error ("Nothing to undo")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
