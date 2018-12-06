local CreatorScene = class('CreatorScene', function()
    return display.newScene("CreatorScene")
end)

function CreatorScene:ctor()
end

function CreatorScene:onEnter()
    require('util.creator').parseJson('creator/scenes/test-scene.json'):addTo(self)
end

return CreatorScene