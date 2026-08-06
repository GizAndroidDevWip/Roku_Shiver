sub init()
    m.top.functionName = "start"
end sub

function runMicroDramaApiTask(param)
    if m.top.control = "RUN" then
        m.top.control = "STOP"
    end if
    m.show_id = param
    m.top.functionName = "start"
    m.top.control = "RUN"
end function

function stopMicroDramaApiTask()
    m.top.control = "STOP"
end function

sub start()
    responseDataMicroDramaApiTaskList = callMicroDramaApiTask({ show_id: m.show_id })

    if responseDataMicroDramaApiTaskList <> invalid and responseDataMicroDramaApiTaskList.statusCode = 401 then
        m.top.logInOrSubscribeStatus = "LOGIN"
        return

      else if responseDataMicroDramaApiTaskList <> invalid and responseDataMicroDramaApiTaskList.statusCode = 419 then
        m.top.logInOrSubscribeStatusMessage = responseDataMicroDramaApiTaskList.message
        m.top.logInOrSubscribeStatus = "LOGGED_OUT_CASE"
        return   
    else if responseDataMicroDramaApiTaskList <> invalid and responseDataMicroDramaApiTaskList.statusCode = 403 then
        m.top.logInOrSubscribeStatus = "SUBSCRIBE"
        return
        
    end if


    ' m.top.logInOrSubscribeStatus = "" 'testchange - changed due to a loading issue 
    ' checking if response is not invalid. If it is not invalid,  then saves the response
    if responseDataMicroDramaApiTaskList <> invalid and responseDataMicroDramaApiTaskList.data <> invalid and responseDataMicroDramaApiTaskList.data.data <> invalid then
        m.top.MicroDramaApiTaskContent = responseDataMicroDramaApiTaskList.data
        m.top.MicroDramaApiTaskListStatus = true

    else
        m.top.MicroDramaApiTaskContent = invalid
        m.top.MicroDramaApiTaskListStatus = false

    end if
end sub


'========================================coin update task======================================================

function runUpdateCoinsUsageApiTask(param)
    ?"runUpdateCoinsUsageApiTask called with param: "
    if m.top.control = "RUN" then
        m.top.control = "STOP"
    end if
    m.show_id = param
    m.top.functionName = "updateCoinsUsageApi"
    m.top.control = "RUN"
end function

sub updateCoinsUsageApi()
    ?"updateCoinsUsageApi called with video_id: "; m.top.updateCoinsUsageAssoc.video_id; " and consumption_type: "; m.top.updateCoinsUsageAssoc.consumption_type
    responseDataUpdateCoinsUsageApi = updateCoinsUsage({
        "video_id": m.top.updateCoinsUsageAssoc.video_id,
        "consumption_type": m.top.updateCoinsUsageAssoc.consumption_type,
    })
end sub