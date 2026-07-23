sub init()
    m.top.functionName = "start"
    ?"startttttt"
end sub

function runAccountCheckApiTask(param as integer)
    m.id = param
    m.top.control = "RUN"
end function


function stopAccountCheckApiTask(param as integer)
    m.top.control = "STOP"
end function

sub start()

    responseAccountCheckApiTaskList = callAccountCheckApi(m.id)
    ?"898989responseAccountCheckApiTaskList"

    if responseAccountCheckApiTaskList <> invalid then
        ?"responseDataAccountRequestApiTaskList <> invalid"
        ?responseAccountCheckApiTaskList
        m.top.responseAccountCheckApiTaskContent = responseAccountCheckApiTaskList
        if responseAccountCheckApiTaskList = 200
            m.top.responseAccountCheckApiTaskListStatus = true
            setSessionId1()
            ipInfoAPICall(getUserIdana()) 'device api call 
        end if

    else
        ?"responseAccountCheckApiTaskList <> invalid111"
        ?m.top.responseAccountCheckApiTaskList
        m.top.responseAccountCheckApiTaskContent = invalid
        m.top.responseAccountCheckApiTaskListStatus = false

    end if

end sub