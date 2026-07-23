sub init()
    print "init EventFetcher"
    m.top.functionName = "start"
end sub

function runEventFetcher(param as string)
    print "RUN EventFetcher"
    m.top.control = "RUN"
end function

function stopEventFetcher(param as string)
    print "STOP EventFetcher"
    m.top.control = "STOP"
end function

sub start()
    complete = Event(m.top.user_id, m.top.event_type, m.top.video_id, m.top.video_title, m.top.channel_id, m.top.titleSeason, m.top.is_live, m.top.video_time, m.top.ai_type)

    ?"djhfksjhkfjhkdf resp200"
    section = CreateObject("roRegistrySection", getAppKey()) ' to mainly notify homescreen to refresh homescreen
    section.Write("isJustLoggedIn", "yes")
end sub

