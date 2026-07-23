sub init()
    m.top.functionName = "start"
end sub
function runGetShowDetailsTask(param as string)
    m.top.control = "RUN"
end function

function stopGetShowDetailsTask(param as string)
    m.top.control = "STOP"
end function 

sub start()
    ?"GetShowDetailsTask ";m.top.showId
    showDetailsResponse = GetShowDetails(m.top.showId)
    m.top.showDetailsResponse = showDetailsResponse
end sub