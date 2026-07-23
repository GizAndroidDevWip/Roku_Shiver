sub init()
    m.top.functionName = "listenSearch"
    print "init MarkCompletedTask"
end sub

function runMarkCompletedTask(param as string)
    print "RUN MarkCompletedTask"
    m.top.control = "RUN"
end function

function stopMarkCompletedTask(param as string)
    print "STOP MarkCompletedTask"
    m.top.control = "STOP"
end function

sub listenSearch()
    params = {}
    params.AddReplace("calendarId", m.top.calendarId)
    params.AddReplace("completed", m.top.isCompletedBoolean)
    m.top.completedContent = callCompletedApi(params)
end sub

