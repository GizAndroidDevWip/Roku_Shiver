sub init()
    m.bgPoster = m.top.findNode("bgPoster")
    m.itemIcon = m.top.findNode("itemIcon")
    m.itemTitle = m.top.findNode("itemTitle")
    m.itemSubtitle = m.top.findNode("itemSubtitle")
    m.rightArrow = m.top.findNode("rightArrow")

    c = getButtonSelectionColor()
    if Left(c, 1) = "#" then c = Mid(c, 2)
    if Len(c) = 6 then c = c + "FF"
    m.accentColor = "0x" + c

    if m.bgPoster <> invalid then m.bgPoster.blendColor = getDefaultCardColor()
    if m.itemIcon <> invalid then m.itemIcon.blendColor = getTextColor()
    if m.rightArrow <> invalid then m.rightArrow.color = getTextColor()
    if m.itemTitle <> invalid then m.itemTitle.color = getTextColor()
    if m.itemSubtitle <> invalid then m.itemSubtitle.color = getSecondaryTextColor()
end sub

sub onItemContentChanged()
    c = m.top.itemContent
    if c = invalid then return
    if c.title <> invalid then m.itemTitle.text = c.title
    if c.subtitle <> invalid and c.subtitle <> ""
        m.itemSubtitle.text = c.subtitle
        m.itemSubtitle.visible = true
        m.itemTitle.translation = [90, 16]
    else
        m.itemSubtitle.visible = false
        m.itemTitle.translation = [90, 32]
    end if
    if c.icon <> invalid and c.icon <> "" then m.itemIcon.uri = c.icon
end sub

sub onFocusStateChanged()
    c = m.top.itemContent
    isRedColorNeeded = (c <> invalid and (c.type = "LOGOUT" or c.type = "DELETE_ACCOUNT" or c.type = "LOGOUT_ALL"))
    logoutColor = "0xFF0000FF"

    if m.top.isFocused
        m.bgPoster.blendColor = getFocusedCardColor()
        if isRedColorNeeded
            m.itemIcon.blendColor = logoutColor
            m.rightArrow.color = logoutColor
            m.itemTitle.color = logoutColor
        else
            m.itemIcon.blendColor = getTextColor()
            m.rightArrow.color = getTextColor()
            m.itemTitle.color = getTextColor()
        end if
    else
        m.bgPoster.blendColor = getDefaultCardColor()
        m.itemTitle.color = getTextColor()
        if isRedColorNeeded
            m.itemIcon.blendColor = logoutColor
            m.rightArrow.color = logoutColor
            m.itemTitle.color = logoutColor
        else
            m.itemIcon.blendColor = m.accentColor
            m.rightArrow.color = m.accentColor
            m.itemTitle.color = getTextColor()
        end if
    end if
end sub
