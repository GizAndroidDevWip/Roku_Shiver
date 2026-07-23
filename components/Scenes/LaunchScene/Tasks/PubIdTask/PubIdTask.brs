sub init()
    m.top.functionName = "start"
    print "init PubIdTask"
end sub

function runPubIdTask(param as string)
    print "RUN PubIdTask"
    m.top.control = "RUN"
end function

function stopPubIdTask(param as string)
    print "STOP PubIdTask"
    m.top.control = "STOP"
end function

sub start()

    ' if getUserIdana() <> invalid and getUserIdana() <> ""
    '     accessToken = callAccessTokenAPI()
    ' end if
    responseData = Getpubidcheck()

    if responseData <> invalid
        m.top.PubIdResponse = "verified"
    else
        m.top.PubIdResponse = "failed"
    end if
end sub