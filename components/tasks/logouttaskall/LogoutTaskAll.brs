sub init()
  m.top.functionName = "start"
    print "init LogoutTaskAll"
End sub

function runLogoutTask(param as String)
    print "RUN LogoutTaskAll"
    m.top.control = "RUN"
end function
function stopLogoutTask(param as String)
    print "STOP LogoutTaskAll"
    m.top.control = "STOP"
end function

sub start()

    responseData = Logoutall()
    if responseData <> invalid
        m.top.LogoutResponse = responseData
    else
        m.top.LogoutResponse = invalid       
    end if
end sub
