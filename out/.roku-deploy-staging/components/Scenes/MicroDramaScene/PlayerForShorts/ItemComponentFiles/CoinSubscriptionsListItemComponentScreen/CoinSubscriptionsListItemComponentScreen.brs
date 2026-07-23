sub init()
    m.background = m.top.findNode("background")
    m.iconBg = m.top.findNode("iconBg")
    m.icon = m.top.findNode("icon")
    m.title = m.top.findNode("title")
    m.title.font.size = 30
    m.description = m.top.findNode("description")
    m.rightTagGroup = m.top.findNode("rightTagGroup")
    m.tagBg = m.top.findNode("tagBg")
    m.tagText = m.top.findNode("tagText")
    m.rightArrow = m.top.findNode("rightArrow")
end sub

sub onContentChange()
    item = m.top.itemContent
    if item <> invalid
        m.title.text = item.title
        m.description.text = item.description
        m.icon.uri = item.HDPosterUrl

        if item.backgroundBlendColor <> invalid
            m.background.blendColor = item.backgroundBlendColor
        else
            m.background.blendColor = "#FFFFFF"
        end if

        if item.iconBgBlendColor <> invalid
            m.iconBg.blendColor = item.iconBgBlendColor
            m.icon.blendColor = item.iconBgBlendColor
        else
            m.iconBg.blendColor = "#FF7F7F"
            m.icon.blendColor = "#FFFFFF"
        end if

        ' Handle the right-side tags (like star count or arrow)
        if item.shortDescriptionLine1 <> ""
            m.rightTagGroup.visible = true
            m.tagBg.visible = true
            m.rightArrow.visible = false
            m.tagText.text = item.shortDescriptionLine1
            m.tagText.visible = true
        else if item.showArrow = true
            m.rightTagGroup.visible = true
            m.tagBg.visible = false
            m.tagText.visible = false
            m.rightArrow.visible = true
        else
            m.rightTagGroup.visible = false
        end if

        if m.top.itemContent["type"] = "subscription"
            m.background.blendColor = "#EE4B2B"
        end if
    end if
end sub

' Changes visual state when user scrolls onto the item
sub onFocusChange()
    if m.top.focusPercent > 0.5
        m.background.opacity = 0.5
        m.title.color = "#FFFFFFFF"
    else
        m.background.opacity = 0.3
        m.title.color = "#CCCCCCFF"
    end if
end sub