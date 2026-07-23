sub init()
    m.top.functionName = "start"
end sub

function runTimeGridApiTask(param as String)
    m.top.control = "RUN"
end function

function stopTimeGridApiTask(param as String)
    m.top.control = "STOP"
end function

sub start()
    responseDataTimeGridApiTaskList = callTimeGridApiTask()
    m.top.responseDataTimeGridApiTaskList = responseDataTimeGridApiTaskList

     
' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataTimeGridApiTaskList <> invalid then

        TimeGridApiTaskList = parseTimeGridApiContent(responseDataTimeGridApiTaskList.data.data)

        m.top.TimeGridApiTaskContentCOPY = TimeGridApiTaskList.clone(true)
        m.top.TimeGridApiTaskContent = TimeGridApiTaskList

        m.top.TimeGridApiTaskListStatus = true
        ?"responseDataTimeGridApiTaskList <> invalid"
    else
        m.top.TimeGridApiTaskContent = invalid
        m.top.TimeGridApiTaskListStatus = false

    end if

end sub