print("Should be printed!")
function special(x)
	print("special"..x.."_"..c)
end

Main = {}
function Main.onStop()
	print("Main.onStop")
end
function Main.onStart()
	f()
	print("Main.onStart")
end