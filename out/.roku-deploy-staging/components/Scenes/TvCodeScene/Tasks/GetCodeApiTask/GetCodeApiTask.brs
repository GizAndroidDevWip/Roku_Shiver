sub init()
    m.top.functionName = "start"
end sub

function runGetCodeApiTask(param as String)
    m.top.control = "RUN"
end function

function stopGetCodeApiTask(param as String)
    m.top.control = "STOP"
end function

sub start()
    responseDataGetCodeApiTaskList = callGetCodeApi()
?"responseDataGetCodeApiTaskList"
     ' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataGetCodeApiTaskList <> invalid then
        ?"responseDataGetCodeApiTaskList <> invalid"
        ?responseDataGetCodeApiTaskList
        m.top.GetCodeApiTaskContent = responseDataGetCodeApiTaskList
        m.top.GetCodeApiTaskListStatus = true
        ?"sfdfg"

    else
        ?"responseDataGetCodeApiTaskList <> invalid111"
        ?m.top.GetCodeApiTaskContent
        m.top.GetCodeApiTaskContent = invalid
        m.top.GetCodeApiTaskListStatus = false

    end if

end sub