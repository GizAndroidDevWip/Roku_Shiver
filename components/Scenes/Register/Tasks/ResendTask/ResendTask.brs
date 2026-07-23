sub init()
  m.top.functionName = "start"
  print "init ResendTask"  
End sub

function runResendTask(param as String)
    print "RUN ResendTask"
    m.top.control = "RUN"
end function

function stopResendTask(param as String)
    print "STOP ResendTask"
    m.top.control = "STOP"
end function

sub start()
    responseData = resendOtp()
    if responseData <> invalid
        m.top.ResendResponse = "resend" 
    else
        m.top.ResendResponse = "failed"          
    end if
end sub