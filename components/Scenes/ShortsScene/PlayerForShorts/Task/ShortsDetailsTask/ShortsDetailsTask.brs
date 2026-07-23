sub init()
    m.top.functionName = "start"
end sub
function runShortsDetailsTask(param as string)
    m.top.control = "RUN"
end function

function stopShortsDetailsTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    ?"GetshortsDetails shortsId ";m.top.shortsID
    shortsDetailsResponse = GetshortsDetails(m.top.shortsID)
    if shortsDetailsResponse <> invalid and shortsDetailsResponse<>invalid and shortsDetailsResponse[0] <> invalid
        m.top.shortsDetailsResponse = shortsDetailsResponse[0]
    end if
end sub