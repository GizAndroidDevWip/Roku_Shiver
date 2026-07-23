sub init()
    m.top.functionName = "start"
end sub

function runCategoryVideosListApiTask(param as String)
    m.top.control = "RUN"
end function

function stopCategoryVideosListApiTask(param as String)
    m.top.control = "STOP"
end function

sub start()
    params = {}
    params.AddReplace("key",m.top.key)
    responseDataCategoryVideosListApiTaskList = GetCategoryVideoss(params)

     ' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataCategoryVideosListApiTaskList <> invalid and responseDataCategoryVideosListApiTaskList.shows <> invalid then
        CategoryVideosListApiTaskList = parseCategoryVideosListApiTaskList(responseDataCategoryVideosListApiTaskList)
        m.top.CategoryVideosListApiTaskContent = CategoryVideosListApiTaskList
        m.top.CategoryVideosListApiTaskListStatus = true
        
    else
        m.top.CategoryVideosListApiTaskContent = invalid
        m.top.CategoryVideosListApiTaskListStatus = false

    end if

end sub