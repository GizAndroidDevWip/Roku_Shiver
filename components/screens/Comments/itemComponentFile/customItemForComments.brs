sub Init()

    m.main_rect = m.top.findNode("main_rect")
    ' m.CornerRoundedforComments = m.top.findNode("CornerRoundedforComments")
    m.commentsPoster = m.top.findNode("commentsPoster")
    m.likePoster = m.top.findNode("likePoster")
    m.commentText = m.top.findNode("commentText")
    m.commentText.font.size = 25
    m.likeCount = m.top.findNode("likeCount")
    m.commentCount = m.top.findNode("commentCount")
    m.timePosted = m.top.findNode("timePosted")
    m.timePosted.font.size = 22
    m.userName = m.top.findNode("userName")
    m.userProfilePoster = m.top.findNode("userProfilePoster")
    m.bgPoster = m.top.findNode("bgPoster")



end sub



sub itemContentChanged()
    ? "itemContentChanged : customitemforComments called"
    ' ? m.top.itemContent


    if m.top.height < 400 and m.top.width < 400
    end if

    ' try
        m.userProfilePoster.uri = m.top.itemContent.user_image
        m.userName.text = m.top.itemContent.user_name
        m.timePosted.text = m.top.itemContent.created_at 'convertToDate(m.top.itemContent.created_at) + " " + convertZTimeToNormalLocalTime(m.top.itemContent.created_at)
        m.commentText.text = m.top.itemContent.comment_text
        m.likeCount.text = m.top.itemContent.like_count
        m.commentCount.text = m.top.itemContent.reply_count
        if m.top.itemContent.itemType = "REPLIES"
            m.commentsPoster.visible = false
            m.commentCount.visible = false
        else
            m.commentsPoster.visible = true
            m.commentCount.visible = true
        end if
    ' catch e
    ' end try
    updateLayout()



end sub



sub updateLayout()
    ?"width : " ; m.top.width
    ?"height : " ; m.top.height
    if m.top.height > 0 and m.top.width > 0 then
        m.bgPoster.width = m.top.width
        m.bgPoster.height = m.top.height

        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height

        'roundcorner
        ' m.CornerRoundedforComments.width = m.top.width
        ' m.CornerRoundedforComments.height = m.top.height

        'title position
        m.commentText.width = m.main_rect.width - 40
        m.commentText.height = 100

        m.likePoster.translation = [20, m.top.height -50]
        m.likeCount.translation = [m.likePoster.translation[0] + 30 , m.likePoster.translation[1]]

        m.commentsPoster.translation = [m.likePoster.translation[0] + 110, m.likePoster.translation[1]]
        m.commentCount.translation = [m.commentsPoster.translation[0] + 30 , m.likePoster.translation[1]]

        m.timePosted.translation = [m.top.width - 200, 35]

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

function onRowFocusPercentChanged()
    ?"m.top.rowHasFocus "m.top.rowHasFocus
    if m.top.rowHasFocus = 1
        m.bgPoster.blendColor = "#ffffff"
        m.userName.color = "#000000"
        m.timePosted.color = "#000000"
        m.commentText.color = "#000000"
        m.likeCount.color = "#000000"
        m.commentCount.color = "#000000"
        m.likePoster.blendColor = "#000000"
        m.commentsPoster.blendColor = "#000000"
    else
        m.bgPoster.blendColor = "#303030"
        m.userName.color = "#ffffff"
        m.timePosted.color = "#ffffff"
        m.commentText.color = "#ffffff"
        m.likeCount.color = "#ffffff"
        m.commentCount.color = "#ffffff"
        m.likePoster.blendColor = "#ffffff"
        m.commentsPoster.blendColor = "#ffffff"
    end if
end function