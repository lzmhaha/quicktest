local ShaderTest = class('shaderTest', function()
    return display.newSprite('img/card.png')
end)

function ShaderTest:ctor()
    self:setNodeEventEnabled(true)
end

function ShaderTest:onEnter()
    print('-----------------')
    local prog = cc.GLProgram:createWithFilenames('shaders/test.vert', 'shaders/test.frag')
    cc.GLProgramCache:getInstance():addGLProgram(prog, "test")
    local stat = cc.GLProgramState:getOrCreateWithGLProgramName("test")
    stat:setUniformVec2("v_mousePosition", cc.p(0.5, 0.5))
    self:setGLProgramState(stat)
end

return ShaderTest