sub init()
    m.tagTitle = m.top.findNode("TagTitle")
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Medium.ttf"
    font.size = 25
    m.tagTitle.font = font
    m.selectionPoster = m.top.findNode("selectionPoster")
    m.selectionPoster.blendColor = getButtonSelectionColor()
    m.textMeasurerLabel = createObject("roSGNode", "Label")
    m.textMeasurerLabel.font = m.tagTitle.font
    m.main_rect = m.top.findNode("main_rect")
end sub


function itemContentChanged()
    m.tagTitle.text = m.top.itemContent.Title
    m.main_rect.width = backgroundPosterLength(m.top.itemContent.Title)
    m.main_rect.height = m.top.height
    m.tagTitle.width = backgroundPosterLength(m.top.itemContent.Title)
    m.selectionPoster.width = backgroundPosterLength(m.top.itemContent.Title)
    updateLayout()
end function

function updateLayout()
    ?"updateLayout : tagsListItemComponentFile called"
    if m.top.itemContent <> invalid and m.top.itemContent.Title <> invalid

    end if

end function

function onFocusPercentChanged()
    ' ?"onFocusPercentChanged called"
    if m.top.focusPercent > 0.5
        m.tagTitle.color = "#FFFFFF"
        m.selectionPoster.visibility = true
    else
        m.tagTitle.color = "#FFFFFF"
        ' m.selectionPoster.blendColor = "#343434"
        m.selectionPoster.visibility = false
    end if
end function

function onRowFocusPercentChanged()
    if m.top.rowHasFocus = 1
        if m.top.focusPercent > 0.5
            m.tagTitle.color = "#FFFFFF"
            ' m.selectionPoster.blendColor = getButtonSelectionColor()
        else
            m.tagTitle.color = "#FFFFFF"
            ' m.selectionPoster.blendColor = "#343434"
        end if
    else
        m.tagTitle.color = "#FFFFFF"
        ' m.selectionPoster.blendColor = "#343434"
    end if
end function

function backgroundPosterLength(input)
    m.textMeasurerLabel.text = input
    textWidth = m.textMeasurerLabel.boundingRect().width ' boundingRect() gives you the width and height of the rendered text
    return textWidth + 35 ' Adding some padding to the width for better aesthetics
end function

' function backgroundPosterLength(input)
'     ?input
'     ?"input7778"
'     for inputValue = 1 to 200
'         returnValue = calculateReturn(inputValue)
'         if input = inputValue
'             ?"backgroundPosterLength: ";Str(input) + m.top.itemContent.Title
'             print("Input: " + Str(inputValue) + ", Return Valuedfdfdfdf: " + Str(returnValue))
'             return returnValue
'         end if
'     end for
' end function

' function calculateReturn(inputValue as integer) as integer
'     if inputValue < 1 or inputValue > 200
'         ?"jjjii"
'         return invalid ' Input out of range
'     end if

'     return 60 + (inputValue - 1) * 15
'     ?"jhhj23445"
' end function