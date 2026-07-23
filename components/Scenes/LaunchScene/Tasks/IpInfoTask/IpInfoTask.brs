sub init()
  m.top.functionName = "start"
  print "init IpInfoTask"  
End sub

function runIpInfoTask(param as String)
    print "RUN IpInfoTask"
    m.top.control = "RUN"
end function

function stopIpInfoTask(param as String)
    print "STOP IpInfoTask"
    m.top.control = "STOP"
end function

sub start()
    ipInfoResponsedata = getcountries()
    
    if ipInfoResponsedata <> invalid
        m.top.IpInfoResponse = "verified" 
    else
        m.top.IpInfoResponse = "failed"          
    end if 
end sub