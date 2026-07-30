sub init()
    m.Poster = m.top.findNode("poster")
    m.Label = m.top.findNode("label")
    m.Label.font.size = 18
    m.Label2 = m.top.findNode("label2")
    m.Label2.font.size = 18
    m.main_rect = m.top.findNode("main_rect")
    m.descriptionBanner = m.top.findNode("descriptionBanner")
    m.poster_bottom_shadow = m.top.findNode("poster_bottom_shadow")
    m.descriptionBanner.font.size = 18
end sub

sub itemContentChanged()
    if getThumbnailOrientaion() = "LANDSCAPE"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE() 
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE() 

    else if getThumbnailOrientaion() = "PORTRAIT"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
    end if

    content = invalid
    if m.top.itemContent <> invalid and m.top.itemContent <> invalid 
        content = m.top.itemContent
    end if

    if content <> invalid and content.HDPosterUrl <> invalid and m.top.itemContent.HDPosterUrl <> ""
        m.Poster.uri = content.HDPosterUrl
    else
        if getThumbnailOrientaion() = "LANDSCAPE"
            m.Poster.uri = getPLACEHOLDER_IMAGE() 
    
        else if getThumbnailOrientaion() = "PORTRAIT"
            m.Poster.uri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        end if
    end if

 if getThumbnailOrientaion() = "LANDSCAPE"
    if content.HDPosterUrl<>invalid or content.HDPosterUrl<>""
            m.Poster.uri = content.HDPosterUrl
    end if
    
    else if getThumbnailOrientaion() = "PORTRAIT"
      if content.hdposterurlportrait<>invalid or content.hdposterurlportrait<>""
            m.Poster.uri = content.hdposterurlportrait 
        end if
end if





    if content <> invalid and content.SHORTDESCRIPTIONLINE2 <> invalid
        starttime = content.SHORTDESCRIPTIONLINE2
    else
        starttime = ""
    end if

    if content <> invalid and content.DESCRIPTION <> invalid
        endtime = content.DESCRIPTION
    else
        endtime = ""
    end if

    if content <> invalid and content.Title <> invalid
        m.Label2.text = content.Title
    else
        m.Label2.text = ""
    end if

    starttimes = Mid (starttime, 1, 19)
    endtimes = Mid (endtime, 1, 19)
    dtstart = convertZTimeToNormalLocalTime(starttime) 'timeConvertstart (starttimes)
    dtend = convertZTimeToNormalLocalTime(endtimes)'timeConvertend(endtimes)
    m.Label.text = dtstart.toStr() + " - " + dtend.toStr()
    
    m.descriptionBanner.text = convertToDate(starttime)
    todaysdate = getTodaysDate()
    setTitleVisibility()

    if m.descriptionBanner.text = todaysdate then
        m.descriptionBanner.visible = true
    else
        m.descriptionBanner.visible = true
        return
    end if
    updateLayout()
end sub

sub updateLayout()
    if m.top.height > 0 and m.top.width > 0
        m.Poster.width = m.top.width
        m.Poster.height = m.top.height
        m.Poster.loadHeight = m.top.height
        m.Poster.loadWidth = m.top.width
        m.main_rect.height = m.top.height
        m.main_rect.width = m.top.width
        m.Label.translation = [10, m.top.height - 30]
        m.Label.width = m.top.width - 10
        m.Label2.font.size = 18
        m.Label2.width = m.top.width - 10
        m.Label2.translation = [10, m.top.height + 8]
        m.descriptionBanner.translation = [10, m.top.height - 55]
        m.descriptionBanner.width = m.top.width - 10
        m.poster_bottom_shadow.translation = [0, m.top.height / 2]
        m.poster_bottom_shadow.width = m.top.width
        m.poster_bottom_shadow.height = m.top.height / 2
    end if
end sub


function timeConvertstart(estString as string) as object
    ' An roDateTime by default gives current time in UTC
    dt = CreateObject ("roDateTime")
    ' Set the time from the EST string input
    dt.FromISO8601String (estString)
    dt.ToLocalTime ()
    chour = dt.GetHours()
    cminute = dt.GetMinutes()
    if chour = 0
        chour = 12
        ampm = "AM"
    else
        if chour = 12
            chour = 12
            ampm = "PM"
        else
            if chour > 12
                chour = chour - 12
                ampm = "PM"
            else
                if chour < 12
                    chour = chour
                    ampm = "AM"
                end if
            end if
        end if
    end if
    if dt.getMinutes() < 10
        cminute = "0" + str(dt.getMinutes()).Trim()
    else
        cminute = str(dt.getMinutes()).Trim()
    end if
    ctime = str(chour) + ":" + cminute + " " + ampm
    ' Return the local time representation of the EST input
    return ctime
end function

function timeConvertend(estString as string) as object
    ' An roDateTime by default gives current time in UTC
    dt = CreateObject ("roDateTime")
    ' Set the time from the EST string input
    dt.FromISO8601String (estString)
    ' Convert to local time
    dt.ToLocalTime ()
    ' Return the local time representation of the EST input
    chour = dt.GetHours()
    cminute = dt.GetMinutes()
    if chour = 0
        chour = 12
        ampm = "AM"
    else
        if chour = 12
            chour = 12
            ampm = "PM"
        else
            if chour > 12
                chour = chour - 12
                ampm = "PM"
            else
                if chour < 12
                    chour = chour
                    ampm = "AM"
                end if
            end if
        end if
    end if
    if dt.getMinutes() < 10
        cminute = "0" + str(dt.getMinutes()).Trim()
    else
        cminute = str(dt.getMinutes()).Trim()
    end if
    ctime = str(chour) + ":" + cminute + " " + ampm
    ' Return the local time representation of the EST input
    return ctime
end function

function convertZTimeToNormalLocalTime(input)
    dt = CreateObject("roDateTime")
    dt.FromISO8601String(input)
    dt.ToLocalTime()
    shortTime = dt.asTimeStringLoc("short-h12")
    ' ?"shortTime printed: ";shortTime
    return shortTime
end function

function convertToDate(inputValue)
    date = CreateObject("roDateTime")
    date.FromISO8601String(inputValue)
    return date.AsDateString("short-month-short-weekday")
end function

function getTodaysDate()
    date = CreateObject("roDateTime")
    day = date.GetDayOfMonth()
    getyear = date.GetYear()
    dayofweek = date.GetDayOfWeek()
    dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    if dayofweek >= 0 and dayofweek < dayNames.Count()
        dayName = dayNames[dayofweek]
    else
    end if
    month = date.GetMonth()
    monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    abbreviatedMonth = monthNames[month - 1] ' Adjust for 0-based indexing
    currentdate = dayName + " " + abbreviatedMonth + " " + day.toStr() + ", " + getyear.toStr()
    return currentdate
end function

sub setTitleVisibility()
    if getHide_Title_Under_Movies() = "true"
        m.Label2.visible = false
    else
        m.Label2.visible = true
    end if
end sub