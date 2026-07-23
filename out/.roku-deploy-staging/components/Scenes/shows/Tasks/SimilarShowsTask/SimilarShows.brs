sub init()
    m.top.functionName = "start"
end sub

function runSimilarShowsTask(param as string)
    m.top.control = "RUN"
end function

function stopSimilarShowsTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataSimilarShowsList =  callSimilarShowsApiTask(m.top.show_id)

     
' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataSimilarShowsList <> invalid then
        similarShowsApiList = parseSimilarShows(responseDataSimilarShowsList.data.data)
        m.top.similarShowsApiListContent = similarShowsApiList
        m.top.similarShowsApiListStatus = true
    else
        m.top.similarShowsApiListContent = invalid
        m.top.similarShowsApiListStatus = false
    end if

end sub