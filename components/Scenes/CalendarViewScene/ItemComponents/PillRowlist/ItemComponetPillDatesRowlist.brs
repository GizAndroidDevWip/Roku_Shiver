sub Init()

    m.main_rect = m.top.findNode("main_rect")
    m.pillPoster = m.top.findNode("pillPoster")
    m.pillDateLabel = m.top.findNode("pillDateLabel")
    m.pillDateLabel.font.size = 32
    m.pillPoster.blendColor = "#ffffff"
    ?"itemContentChanged : customitemforComments called ssdsdsd"
end sub



sub itemContentChanged()

    if m.top.itemContent.is_streak_start = true
        m.pillPoster.blendColor = "#31762c" '#ADD8E6
        m.pillDateLabel.color = "#FFFFFF"
    else
        m.pillPoster.blendColor = "#FFFFFF"
        m.pillDateLabel.color = getButtonSelectionColor() ' White text when focused
    end if
    m.pillDateLabel.text = m.top.itemContent.readable_date
    updateLayout()

end sub



sub updateLayout()
    ' ?"width : " ; m.top.width
    ' ?"height : " ; m.top.height
    if m.top.height > 0 and m.top.width > 0 then

        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height
        

        'roundcorner
        ' m.CornerRoundedforComments.width = m.top.width
        ' m.CornerRoundedforComments.height = m.top.height


    end if
end sub


' Function FormatDateTime(epoch) As String
'     ' Calculate the local date and time from epoch time
'     localTime = CreateObject("roDateTime")
'     localTime.Mark(epoch + CreateObject("roDateTime").GetSeconds() - CreateObject("roDateTime").FromISO8601String("1970-01-01T00:00:00Z").GetSeconds())

'     ' Create DateTime object for current local time
'     today = CreateObject("roDateTime")
'     today.Mark()

'     ' Extract date components for comparison
'     localDay = localTime.GetDayOfMonth()
'     localMonth = localTime.GetMonth()
'     localYear = localTime.GetYear()

'     todayDay = today.GetDayOfMonth()
'     todayMonth = today.GetMonth()
'     todayYear = today.GetYear()

'     ' Format the date
'     if localDay = todayDay And localMonth = todayMonth And localYear = todayYear Then
'         formattedDate = "today"
'     else
'         formattedDate = localDay.ToStr() + " " + localTime.GetMonthName()
'     end if

'     ' Format the time
'     hour = localTime.GetHours()
'     minute = localTime.GetMinutes()
'     ampm = "am"

'     if hour >= 12 Then
'         ampm = "pm"
'         if hour > 12 Then
'             hour = hour - 12
'         end if
'     Else If hour = 0 Then
'         hour = 12
'     End If

'     formattedTime = hour.ToStr() + ":" + Right("00" + minute.ToStr(), 2) + " " + ampm

'     ' Combine date and time
'     return formattedDate + " " + formattedTime
' End Function


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

function onItemFocusPercentchanged()
    ' ?"onItemFocusPercentchanged"; m.top.focusPercent
    if m.top.focusPercent = 1 then
        m.main_rect.backgroundColor = "0xFF000000" ' Black when not focused
        m.pillDateLabel.color = "#FFFFFF" ' Light gray text when not focused
        m.pillPoster.blendColor = getButtonSelectionColor()
    else if m.top.focusPercent = 0 then
        m.main_rect.backgroundColor = "0xFF0000FF" ' Red when focused
        ' m.pillPoster.blendColor = "#ffffff" ' White text when focused

        if m.top.itemContent <> invalid and m.top.itemContent.is_streak_start = true
            m.pillPoster.blendColor = "#31762c"
            m.pillDateLabel.color = "FFFFFF"
        else
            if m.top.itemContent.isToday = true
                m.pillPoster.blendColor = "#C2B8A3"
                m.pillDateLabel.color = "#FFFFFF" ' White text when focused

            else if m.top.itemContent.isToday = false
                m.pillPoster.blendColor = "#FFFFFF"
                m.pillDateLabel.color = getButtonSelectionColor() ' White text when focuse
            end if
        end if
    end if
end function

function onRowFocusPercentChanged()
    ?"m.top.rowHasFocus "m.top.rowHasFocus
    ?"m.top.onRowFocusPercentChanged "; m.top.rowFocusPercent
    if m.top.rowFocusPercent = 1 then
        m.main_rect.backgroundColor = "0xFF000000" ' Black when not focused
        m.pillDateLabel.color = "#FFFFFF" ' Light gray text when not focused
        m.pillPoster.blendColor = getButtonSelectionColor()

    else if m.top.focusPercent = 0 then

        ' m.main_rect.backgroundColor = "0xFF0000FF" ' Red when focused
        ' m.pillDateLabel.color = getButtonSelectionColor() ' White text when focused
        ' m.pillPoster.blendColor = "#ffffff" ' White text when focused

        m.main_rect.backgroundColor = "0xFF0000FF" ' Red when focused
        if m.top.itemContent <> invalid
            if m.top.itemContent.is_streak_start = true
                m.pillPoster.blendColor = "#31762c"
                m.pillDateLabel.color = "#FFFFFF" ' White text when focused
            else
                if m.top.itemContent.isToday = true
                    m.pillPoster.blendColor = "#C2B8A3"
                    m.pillDateLabel.color = "#FFFFFF" ' White text when focused

                else if m.top.itemContent.isToday = false
                    m.pillPoster.blendColor = "#FFFFFF"
                    m.pillDateLabel.color = getButtonSelectionColor() ' White text when focuse
                end if
            end if
        end if
    else
    end if
end function