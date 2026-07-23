sub init()
    m.dot = m.top.findNode("dot")
    m.main_rect = m.top.findNode("mainRectangle")
    m.top.observeField("color", "onColorChanged")
end sub

sub onitemContent()
    m.dot.blendColor = m.top.itemContent.color
end sub
