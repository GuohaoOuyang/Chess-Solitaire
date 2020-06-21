note
	description: "Singleton access to the default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	CHESS_SOLITAIRE_ACCESS

feature
	m: CHESS_SOLITAIRE
		once
			create Result.make
		end

invariant
	m = m
end




