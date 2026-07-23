sub Init()

    m.main_rect = m.top.findNode("main_rect")
    m.titleLabel = m.top.findNode("titleLabel")
    m.titleLabel.color = getTextColor()
    m.customFont = CreateObject("roSGNode", "Font")
    m.customFont.uri = "pkg:/fonts/Poppins-Bold.ttf"
    m.customFont.size = 34 
    m.titleLabel.font = m.customFont
    m.thumbnailPoster = m.top.findNode("thumbnailPoster")
    m.instructorPoster = m.top.findNode("instructorPoster")
    m.instructorLabel = m.top.findNode("instructorLabel")
    m.instructorLabel.color = getTextColor()
    m.instructorLabel.font.size = 30
    m.durationLabel = m.top.findNode("durationLabel")
    m.durationLabel.color = getTextColor()
    m.durationLabel.font.size = 27
    m.backgroundPoster = m.top.findNode("backgroundPoster")
    m.backgroundPoster.blendColor = "#ffffff"
    m.backgroundPoster.visible = false
    m.instructorFramePoster = m.top.findNode("instructorFramePoster")
    m.instructorFramePoster.blendColor = getBackGroundColor1()
    m.tickIcon = m.top.findNode("tickIcon")
end sub



sub itemContentChanged()
    ? "itemContentChanged : CalendarListItemComponent called"
    ? m.top.itemContent


     m.titleLabel.text = m.top.itemContent.title
     m.thumbnailPoster.uri = m.top.itemContent.thumbnail
     if m.top.itemContent.partner_image <> invalid and m.top.itemContent.partner_image <> "" then
        m.instructorFramePoster.visible = true
        m.instructorPoster.uri = m.top.itemContent.partner_image
        m.instructorPoster.visible = true
        m.instructorLabel.translation  = [698, 143]
     else
        m.instructorFramePoster.visible = false
        m.instructorPoster.visible = false
        m.instructorLabel.translation  = [615, 143]
     end if

     if m.top.itemContent.partner_name <> invalid or m.top.itemContent.partner_name = "" or m.top.itemContent.partner_name = "null"
        m.durationLabel.translation  = [525, 195]
     else 
        m.durationLabel.translation  = [525, 105]
     end if

     m.instructorLabel.text = m.top.itemContent.partner_name
     m.durationLabel.text = m.top.itemContent.duration_text

     if m.top.itemContent.completed <> invalid and m.top.itemContent.completed = true then
        m.tickIcon.visible = true
     else
        m.tickIcon.visible = false
     end if
    updateLayout()

end sub



sub updateLayout()
    ' ?"width : " ; m.top.width
    ' ?"height : " ; m.top.height
    if m.top.height > 0 and m.top.width > 0 then
        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height
        m.thumbnailPoster.width = m.top.width
        m.thumbnailPoster.height = m.top.height
        m.thumbnailPoster.loadWidth = m.top.width
        m.thumbnailPoster.loadHeight = m.top.height

        m.tickIcon.translation = [m.top.width - 70, 20]

    end if
end sub



function convertToDate(inputValue)
    date = CreateObject("roDateTime")
    date.FromSeconds(inputValue)
    date.ToLocalTime()
    return date.AsDateString("short-month-no-weekday")
end function

function convertZTimeToNormalLocalTime(input)
    dt = CreateObject("roDateTime")
    dt.FromSeconds(input)
    dt.ToLocalTime()
    shortTime = dt.asTimeStringLoc("short-h12")
    return shortTime
end function

' function onItemFocusPercentchanged()
'     ?"m.top.rowHasFocus "m.top.rowHasFocus
'     if m.top.focusPercent = 1 then
'         m.main_rect.backgroundColor = "0xFF0000FF" ' Red when focused
'         m.pillDateLabel.color = getButtonSelectionColor() ' White text when focused
'         m.pillPoster.blendColor = "#ffffff" ' White text when focused
'     else if m.top.focusPercent = 0 then
'         m.main_rect.backgroundColor = "0xFF000000" ' Black when not focused
'         m.pillDateLabel.color = "#FFFFFF" ' Light gray text when not focused
'         m.pillPoster.blendColor = getButtonSelectionColor()
'     else
'     end if
' end function