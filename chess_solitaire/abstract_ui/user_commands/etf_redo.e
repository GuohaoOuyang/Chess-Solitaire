note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state

			if
				not (model.history.is_empty) and not (model.history.islast)
			then
				model.history.forth
				model.history.item.redo
			else
				model.set_error ("Nothing to redo")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
