sub init()
    ?"SquareItemComponent init called"
    m.bg = m.top.findNode("bg")
    m.title = m.top.findNode("titleLabel")
    m.title.font.size = 50
    m.lock = m.top.findNode("lockPoster")
    m.active = m.top.findNode("activePoster")
    m.active.blendColor = getButtonSelectionColor()
    m.graph = m.top.findNode("graphPoster")
    m.CornerRounded = m.top.findNode("CornerRounded")
    m.CornerRounded.blendColor = getBackGroundColor1()
end sub

sub onContentChanged()
    ' ?"SquareItemComponent onContentChanged called"
    ' ?m.top.itemContent.isLocked
    ' ?m.top.itemContent.title
    content = m.top.itemContent
    if content <> invalid
        m.title.text = content.title
        m.lock.visible = content.isLocked = true
        m.active.visible = content.isActive = true
        m.graph.visible = content.isActive = true

        ' m.graph.uri = content.graphIcon
        ' m.active.uri = content.activeGradient
    end if
end sub

sub OnsizeChanged()
    if m.top.height > 0 and m.top.width > 0 then
        ?"OnsizeChanged called"
        ?m.top.width; m.top.height
        m.title.width = m.top.width
        m.bg.width = m.top.width
        m.bg.height = m.top.height
        m.title.height = m.top.height
        m.lock.translation = [m.top.width - 40, 10]
        m.graph.translation = [m.top.width - 30, m.top.height - 30]
        m.CornerRounded.width = m.top.width
        m.CornerRounded.height = m.top.height
    end if
end sub
