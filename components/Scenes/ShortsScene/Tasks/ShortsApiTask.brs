sub init()
    m.top.functionName = "start"
end sub

function runShortsApiTask(param as string)
    m.top.control = "RUN"
end function

function stopShortsApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataShortsApiTaskList = callShortsApiTask()
    ' checking if response is not invalid. If it is not invalid,  then saves the response
    if responseDataShortsApiTaskList <> invalid and responseDataShortsApiTaskList.data <> invalid and responseDataShortsApiTaskList.data.data <> invalid   then
       m.top.ShortsApiTaskContent = responseDataShortsApiTaskList.data.data
        m.top.ShortsApiTaskListStatus = true

    else
        m.top.ShortsApiTaskContent = invalid
        m.top.ShortsApiTaskListStatus = false

    end if
end sub