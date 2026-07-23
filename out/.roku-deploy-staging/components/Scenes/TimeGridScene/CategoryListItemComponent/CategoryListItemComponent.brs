sub init()
    ?m.top.content
    m.label = m.top.findNode("label")
    m.bg = m.top.findNode("bg")
    m.bg_color = m.top.findNode("bg_color")
end sub

function updateContent()
    ?"djhegjhgdwjehgjdsg updateContent called"
    ?m.top.itemcontent
    content = m.top.itemcontent
    if content <> invalid and content.title <> invalid
        m.label.text = content.title
    else
        m.label.text = ""
    end if

    if m.top.itemcontent.isSelectedNow
        ' If the item is selected, set the background color to the selection color
        m.bg_color.color = "#FF0000"
    else 
        ' If the row has focus, set the background color to the focus color
        m.bg_color.color = "#545454ff" ' White text when not selected
    end if
end function

function onItemFocusPercentchanged()
    ' ?"onItemFocusPercentchanged"; m.top.focusPercent
    ' if m.top.focusPercent = 1 then
    '     ?"djhegjhgdwjehgjdsg onItemFocusPercentchanged 111"
    '     m.bg.blendColor = getButtonSelectionColor()
    ' else if m.top.focusPercent = 0 then
    '     ?"djhegjhgdwjehgjdsg onItemFocusPercentchanged 222"
    '     m.bg.blendColor = "#ffffff" ' White text when focused
    ' end if
end function

function onRowFocusPercentChanged()
    ' ?"m.top.rowHasFocus "m.top.rowHasFocus
    ' ?"m.top.onRowFocusPercentChanged "; m.top.rowFocusPercent
    ' if m.top.rowFocusPercent = 1 then
    '     ?"djhegjhgdwjehgjdsg onRowFocusPercentChanged 111"
    '     m.bg.blendColor = getButtonSelectionColor()
    ' else if m.top.focusPercent = 0 then
    '     ?"djhegjhgdwjehgjdsg onRowFocusPercentChanged 222"
    '     m.bg.blendColor = "#ffffff"
    ' else
    ' end if
end function


function onRowListFocusPercentChanged()
    ' if m.top.rowListHasFocus = true then
    ' else if m.top.rowListHasFocus = false then
    '     ?"djhegjhgdwjehgjdsg onRowListFocusPercentChanged 222"
    '     m.bg.blendColor = "#ffffff" ' White text when not selected
    ' end if
    
end function

function onitemHasFocus()
    ' This function is called when the item has focus
    if m.top.itemHasFocus = true then
        ' If the item has focus, set the background color to the selection color
        m.bg.blendColor = "#FF0000"
    else if m.top.itemHasFocus = false then
        ' If the item does not have focus, set the background color to white
        m.bg.blendColor = "#ffffff" ' White text when not selected
    end if
    
end function