sub init()
    print "init EventFetcherForTimeGrid"
    m.top.functionName = "start"
end sub

function runEventFetcherForTimeGrid(param as string)
    print "RUN EventFetcherForTimeGrid"
    m.top.control = "RUN"
end function

function stopEventFetcherForTimeGrid(param as string)
    print "STOP EventFetcherForTimeGrid"
    m.top.control = "STOP"
end function

sub start()
    complete = EventForTimeGridScene(m.top.user_id, m.top.event_type, m.top.show_id, m.top.video_title, m.top.channel_id, m.top.is_live, m.top.video_time, m.top.schedule_id)
end sub

