sub init()
    m.top.functionName = "start"
end sub

function runGetCalendarVideosTask(param as string)
    m.top.control = "RUN"
end function

function stopGetCalendarVideosTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataCalendarVideos = callCalendarVideosApi(m.top.dateRange)
    ' Check if response is valid and contains expected data
    if responseDataCalendarVideos <> invalid and responseDataCalendarVideos.data <> invalid and responseDataCalendarVideos.data.data <> invalid then
        calendarVideosList = parseCalendarVideosResponse(responseDataCalendarVideos.data.data)
        m.top.CalendarVideosContent = calendarVideosList
        m.top.CalendarVideosListStatus = true
    else
        m.top.CalendarVideosContent = invalid
        m.top.CalendarVideosListStatus = false
    end if
end sub
