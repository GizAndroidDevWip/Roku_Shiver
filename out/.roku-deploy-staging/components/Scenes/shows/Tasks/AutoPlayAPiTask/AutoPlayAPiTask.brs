sub init()
    m.top.functionName = "start"
end sub

function runAutoPlayAPiTask(param as String, showId as String)
    m.videoId = param
    m.show_id=showId
    m.top.control = "RUN"
end function

function stopAutoPlayAPiTask(param as String)
    m.top.control = "STOP"
end function

sub start()
    ?m.top.show_id
    ?"m.top.show_id"
    responseDataAutoPlayAPiTaskList = GetAutoplayDetails(m.videoId,m.show_id)

     ' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataAutoPlayAPiTaskList <> invalid then

        m.top.AutoPlayAPiTaskContent = responseDataAutoPlayAPiTaskList

        m.top.AutoPlayAPiTaskListStatus = true
        ?"responseDataAutoPlayAPiTaskList <> invalid"
    else
        m.top.AutoPlayAPiTaskContent = invalid
        m.top.AutoPlayAPiTaskListStatus = false

    end if

end sub