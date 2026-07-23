sub init()
    ?m.top.content
    m.label = m.top.findNode("label")
    m.bgRect = m.top.findNode("bgRect")
    m.separator = m.top.findNode("separator")
    m.searchIcon = m.top.findNode("searchIcon")
end sub

function updateContent()
    content = m.top.itemcontent
    if content <> invalid and content.title <> invalid
        m.label.text = content.title
    else
        m.label.text = ""
    end if

    if content <> invalid and content.isSelectedNow <> invalid and content.isSelectedNow = true then
        m.label.color = getButtonSelectionColor()    '"#FF0000"
    else if content <> invalid and content.isSelectedNow <> invalid and content.isSelectedNow = false then
        m.label.Color = "#ffffff" ' White text when not selected
    end if

    if content <> invalid and content.isSearchIcon <> invalid and content.isSearchIcon = true then
        m.searchIcon.visible = true
        m.label.visible = false
    else
        m.searchIcon.visible = false
        m.label.visible = true
    end if

    if content.title = "Subscribe" 
        m.separator.visible = true
    else
        m.separator.visible = false
    end if
end function

function onSizeChanged()
    ' Set a fixed larger width for the label to prevent text truncation
    textWidth = m.top.width   ' Add extra space for text
    
    m.label.width = textWidth
    m.label.height = m.top.height
    
    m.bgRect.height = m.top.height
    m.bgRect.width = textWidth  ' Match the label width for proper focus coverage
    
    ' Also set the component width to prevent clipping
    m.top.width = textWidth

    ' m.searchIcon.height = m.top.height
    ' m.searchIcon.width = m.top.width
end function

function onItemFocusPercentchanged()
    ' ?"onItemFocusPercentchanged"; m.top.focusPercent
    if m.top.focusPercent > 0.5 then
        m.label.color = getButtonSelectionColor()   
        m.searchIcon.blendColor = getButtonSelectionColor()   
    else if m.top.focusPercent = 0 then
        m.label.color = "#ffffff"
        m.searchIcon.blendColor = "#ffffff"
    end if
end function


function onRowListFocusPercentChanged()
    ' if m.top.rowListHasFocus = true then
    ' else if m.top.rowListHasFocus = false then
    '     ?"djhegjhgdwjehgjdsg onRowListFocusPercentChanged 222"
    '     m.bg.blendColor = "#ffffff" ' White text when not selected
    ' end if

end function

function onitemHasFocus()
    if m.top.itemcontent <> invalid
        ' This function is called when the item has focus
        if m.top.itemHasFocus = true then
            ' If the item has focus, set the background color to the selection color
            m.label.color = getButtonSelectionColor()     '"#FF0000"
            m.searchIcon.blendColor = getButtonSelectionColor()    '"#FF0000"
        else if m.top.itemHasFocus = false then
            ' If the item does not have focus, set the background color to white
            if m.top.rowHasFocus
                m.label.Color = "#ffffff" ' White text when not selected
                m.searchIcon.blendColor = "#ffffff"
            end if
        end if
    end if
end function


function onRowHasFocus()
    if m.top.itemcontent <> invalid then
    else
    end if
    if m.top.rowHasFocus = true then
        ' m.bg.blendColor = getButtonSelectionColor()
    else if m.top.rowHasFocus = false then
    else
        if m.top.itemHasFocus = true then
            ' m.label.color = "#FF0000"
        else if m.top.itemHasFocus = false then
            m.label.Color = "#ffffff" ' White text when not selected
        end if
    end if
end function
