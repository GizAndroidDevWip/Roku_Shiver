sub init()
    m.top.functionName = "start"
end sub

function runauthenticateApiTask(param as string)
    m.top.control = "RUN"
end function

function stopauthenticateApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    authenticateApiTaskList = authenticateApiTask()
    ' checking if response is not invalid. If it is not invalid,  then saves the response
    if authenticateApiTaskList <> invalid then
        m.top.authenticateApiTaskListcontent = authenticateApiTaskList
    else
        m.top.authenticateApiTaskListcontent = invalid
    end if

end sub