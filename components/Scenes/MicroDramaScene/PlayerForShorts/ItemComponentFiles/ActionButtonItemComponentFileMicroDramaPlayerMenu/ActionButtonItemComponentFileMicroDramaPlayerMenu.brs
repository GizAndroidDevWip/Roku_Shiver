sub init()
    m.bg = m.top.findNode("bg")
    m.bgPoster = m.top.findNode("bgPoster")
    m.buttonLeftIcon = m.top.findNode("buttonLeftIcon")
    m.label = m.top.findNode("label")
    m.icon = m.top.findNode("icon")
    m.iconLabel = m.top.findNode("iconLabel")
    m.watchProgressLine = m.top.findNode("watchProgressLine")
    m.watchProgressLineBg = m.top.findNode("watchProgressLineBg")
    m.watchProgressContainer = m.top.findNode("watchProgressContainer")
    ' Highlight when focused
    ' m.top.observeField("itemHasFocus", "onFocusChange")
end sub

sub updateContent()
    ?"m.top.itemContensdsdsdt"
    ?m.top.itemContent
    content = m.top.itemContent
    if content = invalid then return

    if content.title <> invalid
        m.label.text = content.title
        if m.top.focusPercent <> invalid and m.top.focusPercent > 0.5
            m.label.color = "#000000"
        else
            m.label.color = "#FFFFFF"
        end if
    end if

    if content.isiconNode = true
        m.iconLabel.text = content.title
    else
        m.iconLabel.text = ""
    end if

    m.watchProgressContainer.visible = false
    ' if content.buttonLeftIcon <> invalid
    '     m.buttonLeftIcon.uri = content.buttonLeftIcon
    '     m.buttonLeftIcon.visible = true
    ' else
    '     m.buttonLeftIcon.visible = false
    ' end if

    if content.isHighlighted <> invalid and content.ishighlighted = true
        m.icon.blendColor = getButtonSelectionColor()
    else
        if m.top.itemHasFocus <> invalid and m.top.itemHasFocus = true
            m.icon.blendColor = "#000000"
        else
            m.icon.blendColor = "#FFFFFF"
        end if
    end if


    if m.top.itemContent.id = "ADDTOMYLIST"
        m.icon.uri = "pkg:/images/plus.png"
        itemVisibility(false)

    else if m.top.itemContent.id = "REMOVEFROMMYLIST"
        m.icon.uri = "pkg:/images/minus.png"
        itemVisibility(false)

    else if m.top.itemContent.id = "WATCHTRAILER"
        m.icon.uri = "pkg:/images/playbutton2.png"
        itemVisibility(false)

    else if m.top.itemContent.id = "MORE"
        m.icon.uri = "pkg:/images/more_image.png"
        itemVisibility(false)

    else if content.id = "MORE_EPISODES"
        m.icon.uri = "pkg:/images/icons/media_list.png"
        itemVisibility(false)

    else if content.id = "GOTO_MICRO_DRAMA_DETAILS_PAGE"
        m.icon.uri = "pkg:/images/icons/info_button.png"
        itemVisibility(false)

    else if content.isiconNode = true
        m.icon.uri = content.HDLISTITEMICONURL
        if content.id = "LIKE"
            if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
                m.icon.uri = "pkg:/images/like_filled.png"
                ' m.icon.blendColor = getButtonSelectionColor()
            else
                m.icon.uri = "pkg:/images/like.png"
                ' m.icon.blendColor = "#FFFFFF"
            end if
        else if content.id = "DISLIKE"
            if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
                m.icon.uri = "pkg:/images/dislike_filled.png"
                ' m.icon.blendColor = getButtonSelectionColor()
            else
                m.icon.uri = "pkg:/images/dislike.png"
                ' m.icon.blendColor = "#FFFFFF"
            end if
        end if
        itemVisibility(false)
    else if content.id = "PLAY"
        itemVisibility(true)
        m.buttonLeftIcon.uri = "pkg:/images/play-xxl.png"
        m.label.translation = [0, 0]
        ' m.label.translation = [m.label.translation[0] + 5, m.label.translation[1]]
        m.watchProgressContainer.visible = true
    else
        itemVisibility(true)
        m.buttonLeftIcon.visible = false
    end if

    if m.top.itemContent.watched_percentage <> invalid then
        m.watchProgressLine.width = (m.top.itemContent.watched_percentage / 100.0) * m.watchProgressContainer.width
        if m.watchProgressLine.width = 0 then m.watchProgressContainer.visible = false
    else
        ' m.watchProgressLine.width = m.top.width / 3
        m.watchProgressContainer.visible = false
    end if
end sub

sub itemVisibility(visibility)
    ?"itemVisibility called: "; visibility
    m.bg.visible = visibility
    m.label.visible = visibility
    m.buttonLeftIcon.visible = false
    m.bgPoster.visible = visibility
    m.icon.visible = not visibility
end sub

' sub onFocusChange()
'     if m.top.itemHasFocus
'         m.bg.blendColor = "#FFFFFF"
'         m.label.color = "#000000"
'         ' m.buttonLeftIcon.blendColor = "#000000"
'     else
'         m.bg.blendColor = "#3A3A5A"
'         m.label.color = "#FFFFFF"
'         ' m.buttonLeftIcon.blendColor = "#FFFFFF"
'     end if
' end sub

sub updateLayout()
    w = m.top.width
    h = m.top.height

    ' m.label.translation = [ (w - m.label.width) / 2 + 40, (h - m.label.height) / 2 ]
    m.buttonLeftIcon.translation = [20, (h - m.buttonLeftIcon.height) / 2]

    m.bg.width = m.top.width
    m.bg.height = m.top.height

    m.label.height = m.top.height
    m.label.width = m.top.width

    m.bgPoster.width = m.top.width
    m.bgPoster.height = m.top.height

    m.iconLabel.width = m.top.width + 40

    m.icon.translation = [(w - m.icon.width) / 2, (h - m.icon.height) / 2]


    UIwidth = m.top.width - 20
    m.watchProgressLineBg.width = UIwidth
    m.watchProgressContainer.width = UIwidth
    m.watchProgressContainer.translation = [10, m.top.height + 10]
end sub

sub onitemHasFocus()
    if m.top.itemHasFocus
        m.bg.blendColor = "#FFFFFF"
        m.label.color = "#000000"
        if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
            m.icon.blendColor = getButtonSelectionColor()
        else
            m.icon.blendColor = "#000000"
        end if
        m.iconLabel.visible = true
        ' m.buttonLeftIcon.blendColor = "#000000"
        ' m.bgPoster.opacity = 1
    else
        m.bg.blendColor = "#3A3A5A"
        m.label.color = "#FFFFFF"
        if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
            m.icon.blendColor = getButtonSelectionColor()
        else
            m.icon.blendColor = "#FFFFFF"
        end if
        m.iconLabel.visible = false
        ' m.buttonLeftIcon.blendColor = "#FFFFFF"
        ' m.bgPoster.opacity = 0.2
    end if

end sub

sub onItemFocusPercentchanged()
    ' Optional: Implement any behavior based on focus percent if needed
    if m.top.focusPercent > 0.5
        ' Item is mostly focused
        ' m.bgPoster.opacity = 1
        m.label.color = "#000000"
        if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
            m.icon.blendColor = getButtonSelectionColor()
        else
            m.icon.blendColor = "#FFFFFF" 'testchange
        end if
        m.iconLabel.visible = true
        m.buttonLeftIcon.blendColor = "#000000"
    else
        ' Item is not focused
        ' m.bgPoster.opacity = 0.2
        m.label.color = "#ffffff"
        if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
            m.icon.blendColor = getButtonSelectionColor()
        else
            m.icon.blendColor = "#FFFFFF"
        end if
        m.iconLabel.visible = false
        m.buttonLeftIcon.blendColor = "#FFFFFF"
    end if
end sub

sub onRowHasFocus()
    ?"onRowHasFocus called: "; m.top.rowHasFocus
    if m.top.rowHasFocus
        if m.top.itemHasFocus = true
            if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
                m.icon.blendColor = getButtonSelectionColor()
            else
                m.icon.blendColor = "#000000"
            end if
            m.iconLabel.visible = true
        else
            if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
                m.icon.blendColor = getButtonSelectionColor()
            else
                m.icon.blendColor = "#FFFFFF"
            end if
            m.iconLabel.visible = false
        end if
    else
        if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
            m.icon.blendColor = getButtonSelectionColor()
        else
            m.icon.blendColor = "#FFFFFF"
        end if
        m.iconLabel.visible = false
    end if
end sub

sub highlightIconsCase(input)
    if m.top.itemContent.isHighlighted <> invalid and m.top.itemContent.ishighlighted = true
        m.icon.blendColor = getButtonSelectionColor()
    else
        m.icon.blendColor = "#FFFFFF"
    end if
end sub