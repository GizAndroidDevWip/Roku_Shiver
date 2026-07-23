sub init()
    m.top.functionName = "start"
end sub

function runPodCastApiTask(param as String)
    m.top.control = "RUN"
end function

function stopPodCastApiTask(param as String)
    m.top.control = "STOP"
end function

sub start()
    responseDataPodcastApiTaskList = callPodCastApi()

     
' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataPodcastApiTaskList <> invalid then

        PodCastApiTaskList = parsePodCastApiContent(responseDataPodcastApiTaskList.data.data)

        m.top.PodCastApiTaskContent = PodCastApiTaskList

        m.top.PodCastApiTaskListStatus = true
        ?"responseDataPodcastApiTaskList <> invalid"
    else
        m.top.PodCastApiTaskContent = invalid
        m.top.PodCastApiTaskListStatus = false

    end if

end sub