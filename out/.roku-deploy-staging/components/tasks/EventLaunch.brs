sub init()
    print "init EventLaunch"
  m.top.functionName = "start"
End sub

function runEventLaunch(param as String)
    print "RUN EventLaunch"
    m.top.control = "RUN"
end function

function stopEventLaunch(param as String)
    print "STOP EventLaunch"
    m.top.control = "STOP"
end function


sub start()
    Eventlaunch(m.top.user_id,m.top.event_type)
end sub

