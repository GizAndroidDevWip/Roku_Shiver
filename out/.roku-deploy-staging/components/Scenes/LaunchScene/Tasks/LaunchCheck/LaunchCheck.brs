sub init()
    print "init LaunchCheck"
  m.top.functionName = "start"
End sub

function runLaunchCheck(param as String)
    print "RUN LaunchCheck"
    m.top.control = "RUN"
end function

function stopLaunchCheck(param as String)
    print "STOP LaunchCheck"
    m.top.control = "STOP"
end function 

sub start()
    responseData = Getpubidcheck()
    if responseData <> invalid               
        m.top.LaunchResponse = responseData.registration_mandatory_flag 
    else
        m.top.LaunchResponse = "failed"          
    end if
end sub