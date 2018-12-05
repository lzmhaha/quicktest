
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	-- local layer = display.newColorLayer(cc.c4b(180, 180, 0, 255))
	-- self.tickCount = 0
	-- self:addChild(layer)

	-- display.newTTFLabel({text = "Hello, World", size = 50})
	-- 	:align(display.CENTER, display.cx, display.cy)
	-- 	:addTo(self)
end

function MainScene:onEnter()
	-- self:readFile()
	-- self:showSprite()
	-- self:showSpine()
	-- self:showAnimation()
	-- self:addTouchNode()
	-- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
	-- self:scheduleUpdate()
	-- self:scheduleTest()
	-- self:showListView()
	self:showButton()
	-- self:showLayout()
	self:showTileMap()
	self:cameraTest()
end

function MainScene:onExit()
end

function MainScene:update(dt)
	print('dt '..dt)
end

function MainScene:showSprite()
	cc.Sprite:create('img/light.png'):center():addTo(self)
end

function MainScene:readFile()
	local node = cc.Node:create()
	local f = cc.FileUtils:getInstance()
	local str = f:getStringFromFile('json/test.json')
	local obj = json.decode(str)
	for k, v in pairs(obj) do
		print(k..v)
	end
end

function MainScene:showSpine()
	-- 读取json
	-- local sp = sp.SkeletonAnimation:createWithJsonFile("spine/hero.json", "spine/hero.atlas")
	-- 读取二进制文件
	local hero = sp.SkeletonAnimation:createWithBinaryFile('spine/hero.skel', 'spine/hero.atlas')
	hero:pos(200, 150):addTo(self)

	-- 播放动画
	hero:setAnimation(0, 'attack', true)
	hero:setMix('attack', 'run', 0.5)
	hero:addAnimation(0, 'run', true)

	-- 事件监听一
	-- hero:registerSpineEventHandler(function()
	-- 	print('event')
	-- end, sp.EventType.ANIMATION_COMPLETE)

	-- 事件监听二
	hero:registerSpineEventHandler(handler(self, MainScene._spineEventCall), sp.EventType.ANIMATION_COMPLETE)
	
end

function MainScene:_spineEventCall(event)
	-- print('-------------spine event call----------------')
	-- print('animation: '..event.animation)
	-- print('type: '..event.type)
	-- print('track index: '..event.trackIndex)
	-- print('loop count: '..event.loopCount)
	-- print('-------------spine event call----------------')
end

function MainScene:showAnimation()
	display.addSpriteFrames('img/dandan.plist', 'img/dandan.png')
	local frames = display.newFrames('%03d.png', 1, 10)
	local animation = display.newAnimation(frames, 0.1)
	local animate = cc.Animate:create(animation)
	local action = cc.RepeatForever:create(animate)
	display.newSprite(display.newSpriteFrame('001.png'))
		:addTo(self)
		:center()
		:scale(5)
		:align(display.LEFT_BOTTOM)
		:runAction(action)
end

function MainScene:addTouchNode()
	local node = display.newSprite('img/light.png'):center():pos(100, 100)
	node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		local dx = event.x - event.prevX
		local dy = event.y - event.prevY
		local x = node:getPositionX()
		local y = node:getPositionY()
		node:pos(x + dx, y + dy)
		return true
	end)
	node:setTouchEnabled(true)
	node.setTouchMode(cc.TOUCHES_ONE_BY_ONE)
	node:addTo(self)
end

-- quick 扩展的 schedule 方法实际上是利用action来实现的，取消定时器调用 stopAction 即可
function MainScene:scheduleTest()
	self.tickCount = 0
	local h = function()
		if self.tickCount > 10 then
			self:stopAction(self.handle)
		else
			print('tick  '..self.tickCount)
			self.tickCount = self.tickCount + 1
		end
	end
	self.handle = self:schedule(h, 1)
end

function MainScene:showListView()
	local lv = ccui.ListView:create()
	lv:center():addTo(self)
		:size(120, 200)
	-- 间隔
	lv:setItemsMargin(5)
	-- 背景颜色
	lv:setBackGroundColor(cc.c3b(0, 0, 255))
	lv:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)

	-- 滑动到最底部
	-- lv:performWithDelay(function()
	-- 	lv:scrollToBottom(0.2, true)
	-- 	-- lv:jumpToBottom()
	-- end, 1)

	-- 反弹
	lv:setBounceEnabled(true)
	-- 惯性
	lv:setInertiaScrollEnabled(true)

	-- 方向 默认为 纵向
	-- lv:setDirection(ccui.ListViewDirection.horizontal)
	-- lv:setDirection(ccui.ListViewDirection.horizontal)

	local item = ccui.Layout:create()
	item:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	item:setBackGroundColor(cc.c3b(255, 0, 0))
	item:setContentSize(100, 50)
	lv:setItemModel(item)
	for i = 1, 10 do
		lv:pushBackDefaultItem()
	end
end

function MainScene:showButton()
	local btn = ccui.Button:create('img/button_01.png', 'img/button_02.png', 'img/button_03.png', ccui.TextureResType.localType)

	-- addClickEventListener 无效
	-- btn:addClickEventListener(function(btn)
	-- 	print('on click')
	-- end)

	btn:addTouchEventListener(function(btn, eventType)
		if eventType == cc.EventCode.ENDED then
			btn:setEnabled(false)
			print('on click')
		end
	end)

	-- 无效按钮
	-- btn:setEnabled(false)

	btn:setScale9Enabled(true)
	-- btn:size(100, 100)

	-- 点击缩放
	btn:setZoomScale(-0.1)

	-- 缩放动画
	btn:setPressedActionEnabled(true)

	btn:center():addTo(self)
end

function MainScene:showLayout()

	local layout = ccui.Layout:create()
	layout:setBackGroundColor(cc.c3b(255,255,255,255), cc.c3b(0,0,0,255))
	layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
	layout:setBackGroundColorVector(cc.p(-1, -1))

	layout:setLayoutType(ccui.LayoutType.VERTICAL)

	for i = 1, 5 do
		local b = ccui.Button:create('img/button_01.png');
		-- 点击缩放
		b:setZoomScale(-0.1)

		-- 缩放动画
		b:setPressedActionEnabled(true)

		local p = ccui.LinearLayoutParameter:create()
		p:setGravity(ccui.LinearGravity.centerHorizontal)
		p:setMargin({top = 10, left = 5})

		b:setLayoutParameter(p)
		b:addTo(layout)
	end

	layout:addTo(self)
	:center()
	:align(display.CENTER)
	:size(500, 500)
end

function MainScene:showTileMap()
	local map = cc.TMXTiledMap:create('map/tiled.tmx')
	map:pos(100, 10):addTo(self)

	local layer = map:getLayer('shadow')
	layer:setTileGID(1, cc.p(1, 30))

	-- 获取图块节点坐标
	local pos = layer:getPositionAt(cc.p(1, 30))
	print(string.format('x: %f, y: %f', pos.x, pos.y))

	-- 获取图块
	local tile = layer:getTileAt(cc.p(1, 30)):scale(0.5)

	-- 获取自定义属性
	print(layer:getProperty('testKey'))

	map:setCameraMask(cc.CameraFlag.USER1)

end

function MainScene:cameraTest()
	local camera = cc.Camera:create()
	camera:addTo(self):pos(0, 100)
	camera:setCameraFlag(cc.CameraFlag.USER1)
	camera:moveBy(10, 1000, 1000)
end

return MainScene
