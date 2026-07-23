sub init()
  m.top.functionName = "start"
  print "init ForgotFetcher"  
End sub

function runForgotFetcherTask(param as String)
    print "RUN ForgotFetcher"
    m.top.control = "RUN"
end function

function stopForgotFetcherTask(param as String)
    print "STOP ForgotFetcher"
    m.top.control = "STOP"
end function

sub start()
    responseData = GetForgotPassword(m.top.user_email)
    m.top.ForgotResponse = responseData
end sub