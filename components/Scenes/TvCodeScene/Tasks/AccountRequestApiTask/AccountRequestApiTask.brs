sub init()
    m.top.functionName = "start"
end sub

function runAccountRequestApiTask(param as string)
    m.top.user_email = param
    m.top.control = "RUN"
end function

function stopAccountRequestApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataAccountRequestApiTaskList = callAccountRequest(m.top.user_email)

    if responseDataAccountRequestApiTaskList = invalid
        m.top.responseDataAccountRequestTaskContent = "invalid"
    end if

    if responseDataAccountRequestApiTaskList <> invalid then
        m.top.responseDataAccountRequestTaskContent = responseDataAccountRequestApiTaskList
        m.top.responseDataAccountRequestTaskListStatus = true

    else
        m.top.responseDataAccountRequestTaskContent = invalid
        m.top.responseDataAccountRequestTaskListStatus = false

    end if

end sub