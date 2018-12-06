local AutoLayout = class('AutoLayout', function()
    return ccui.Layout:create()
end)

function AutoLayout:ctor()
    self:setNodeEventEnabled(true)
end

function AutoLayout:addChildAndResize(child, zOrder, tag)
    child:addTo(self, zOrder, tag)
    self:_reSize()
end

function AutoLayout:_reSize()
    local nodes = self:getChildren()
    local t = self:getLayoutType()
    if t == ccui.LayoutType.VERTICAL then
        local h = 0
        for i = 1 , #nodes do
            local node = nodes[i]
            h = h + node:getContentSize().height
            local margin = node:getLayoutParameter():getMargin()
            h = h + margin.top or 0
            h = h + margin.bottom or 0
        end
        local size = self:getContentSize()
        self:size(size.width, h)
        print(h)
    elseif t == ccui.LayoutType.HORIZONTAL then
        local w = 0
        for i = 1 , #nodes do
            local node = nodes[i]
            w = w + node:getContentSize().width
            local margin = node:getLayoutParameter():getMargin()
            w = w + margin.left or 0
            w = w + margin.right or 0
        end
        local size = self:getContentSize()
        self:size(w, size.height)
        print(h)
    end
end

return AutoLayout