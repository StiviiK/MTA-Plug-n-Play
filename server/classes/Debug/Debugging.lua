if DEBUG then
	Debugging = inherit(Singleton)

	function Debugging:constructor()
		addCommandHandler("drun", bind(Debugging.runString, self))
	end

	function Debugging:runString(player, cmd, ...)
		local codeString = table.concat({...}, " ")
		runString(codeString, player)
	end
end