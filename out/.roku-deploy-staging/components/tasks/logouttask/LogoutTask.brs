sub init()
  m.top.functionName = "start"
  print "init LogoutTask"  
End sub

function runLogoutTask(param as String)
    print "RUN LogoutTask"
    m.top.control = "RUN"
end function

function stopLogoutTask(param as String)
    print "STOP LogoutTask"
    m.top.control = "STOP"
end function

sub start()
    responseData = Logout()
    if responseData <> invalid
        m.top.LogoutResponse = responseData
    else
        m.top.LogoutResponse = "failed"          
    end if
end sub