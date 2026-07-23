sub init()
  m.top.functionName = "start"
  print "init OtpTask"  
End sub

function runOtpTask(param as String)
    print "RUN "OtpTask""
    m.top.control = "RUN"
end function

function stopOtpTask(param as String)
    print "STOP "OtpTask""
    m.top.control = "STOP"
end function

sub start()
    responseData = verifyOtpFromEmail(m.top.otp)
    if responseData <> invalid
        m.top.OtpResponse = "verified" 
    else
        m.top.OtpResponse = "failed"          
    end if 
end sub