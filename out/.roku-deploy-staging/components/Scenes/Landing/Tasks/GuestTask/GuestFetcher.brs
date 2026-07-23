sub init()
    m.top.functionName = "start"
    print "init GuestFetcher"  
End sub

function runGuestFetcher(param as String)
    print "RUN GuestFetcher"
    m.top.control = "RUN"
end function

function stopGuestFetcher(param as String)
    print "STOP GuestFetcher"
    m.top.control = "STOP"
end function

sub start()
  responseData = GuestRegister()
       if responseData <> invalid               
               m.top.GuestResponse = responseData
       else
           m.top.GuestResponse = "failed"          
       end if
end sub