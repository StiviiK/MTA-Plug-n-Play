print("Should be printed!")
function special(x)
	print("special"..x.."_"..c)
end

Main = {}
function Main.onStop()
	print("Main.onStop")
end

function Main.onStart()
	print("Main.onStart")
	f()

	print(Player:getSingleton())

	fetchRemote("page://error", Async.waitFor())
	print(Async.wait())
end