sub init()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.title = m.top.findNode("title")
    m.icon = m.top.findNode("icon")
    m.animation = m.top.findNode("animation")
    m.testTimer = m.top.findNode("testTimer")
    m.parent = m.top.getParent()
    m.testTimer.ObserveField("fire", "startAnimation")
    m.parent.observeField("itemSelected", "onItemSelectedChanged")
    setInitialValues()
end sub

sub setInitialValues()
    fontmedium = createFont("Roboto-Bold", 32)
    m.title.font = fontmedium
    ' m.title.translation = [100, 0]
    m.title.translation = [-300, 0]
end sub

sub onItemContentChanged()
    m.item = m.top.itemContent
    m.title.text = m.item.title
    m.icon.uri = m.item.hdgridposterurl
    m.testTimer.duration = m.item.duration
    if m.top.index = 1 then
        '  m.redFlag.visible = true
    end if
    m.title.color = getTextColor()
    m.icon.blendColor = getTextColor()
    m.title.opacity = 0.3
    m.icon.opacity = 0.3
end sub

sub onItemHasFocus()
    if m.top.focusPercent > 0.5 then
        m.title.opacity = 1
        m.icon.opacity = 1
    else
        m.title.opacity = 0.3
        m.icon.opacity = 0.3
    end if
end sub

sub onItemSelectedChanged()
    itemSelected = m.parent.itemSelected
    if m.top.index = itemSelected then
    end if
end sub

sub onGridHasFocus()
    if m.top.gridHasFocus then
        m.icon.translation = [50, 7]
        m.testTimer.control = "start"
    else
        m.icon.translation = [50, 7]
        m.title.translation = [-300, 0]
    end if
end sub

sub startAnimation()
    m.animation.control = "start"
end sub

function createFont(fontName, fontSize)
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/" + fontName + ".ttf"
    font.size = fontSize
    return font
end function
