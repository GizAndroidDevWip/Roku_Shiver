sub init()
    m.top.functionName = "start"
end sub

function runMultiLanguageListApiTask(param as string)
    m.top.control = "RUN"
end function

function stopMultiLanguageListApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
       responseDataMultiLanguageListApiTaskList = callMultiLanguageListApiTask()

       ?responseDataMultiLanguageListApiTaskList

       ?responseDataMultiLanguageListApiTaskList

    ' checking if response is not invalid. If it is not invalid,  then saves the response

    if responseDataMultiLanguageListApiTaskList <> invalid then

        ?responseDataMultiLanguageListApiTaskList.data.data

        MultiLanguageListApiTaskList = parseMultiLanguageListApiContent(responseDataMultiLanguageListApiTaskList.data.data)

        ?MultiLanguageListApiTaskList
?"wwswdwsd"
        m.top.MultiLanguageListApiTaskContent = MultiLanguageListApiTaskList

        m.top.MultiLanguageListApiTaskListStatus = true
        ?"responseDataMultiLanguageListApiTaskList <> invalid"
    else
        m.top.MultiLanguageListApiTaskContent = invalid
        m.top.MultiLanguageListApiTaskListStatus = false

    end if

end sub