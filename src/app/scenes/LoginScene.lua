local LoginScene = class('LoginScene', function()
	return display.newScene('LoginScene')
end)

function LoginScene:ctor()
	local bg = display.newColorLayer(cc.c4b(255, 255, 0, 255))
	self:addChild(bg)
end

function LoginScene:onEnter()
end

function LoginScene:onExit()
end

return LoginScene