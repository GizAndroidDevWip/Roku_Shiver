sub init()
    m.top.functionName = "start"
    print "init RegTask"  
End sub

function runRegTask(param as String)
    print "RUN RegTask"
    m.top.control = "RUN"
end function

function stopRegTask(param as String)
    print "STOP RegTask"
    m.top.control = "STOP"
end function

sub start()
    responseData = Register(m.top.Fullname,LCase(m.top.user_email),m.top.password,m.top.device_id)
    ?"responseDataRiniRaju"
    ?responseData
    if responseData <> invalid
        if responseData.count() <> 0
            m.top.RegResponse = responseData.user_id
        else 
            m.top.RegResponse = "exists"  
        end if
    else
        m.top.RegResponse = "failed"          
    end if
end sub
