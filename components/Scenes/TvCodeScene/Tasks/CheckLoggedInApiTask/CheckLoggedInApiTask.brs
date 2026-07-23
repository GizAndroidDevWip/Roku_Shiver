sub init()
    m.top.functionName = "start"
end sub

function runCheckLoggedInApiTask(param as string)
    m.code = param
    m.top.control = "RUN"
end function

function stopCheckLoggedInApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataCheckLoggedInApiTaskList = callCheckLoggedInApi(m.code)

    ' checking if response is not invalid. If it is not invalid,  then saves the response
    if responseDataCheckLoggedInApiTaskList <> invalid then
        m.top.CheckLoggedInApiTaskContent = responseDataCheckLoggedInApiTaskList
        ?"responseDataCheckLoggedInApiTaskList <> invalid"
        ?m.top.CheckLoggedInApiTaskContent

        if m.top.CheckLoggedInApiTaskContent = 200
            m.top.CheckLoggedInApiTaskListStatus = true
            setSessionId1()
            ?"KJKKK887SES"
            ipInfoAPICall(getUserIdana())
        end if
    else
        m.top.CheckLoggedInApiTaskContent = invalid
        m.top.CheckLoggedInApiTaskListStatus = false

    end if

end sub