sub init()
    m.top.functionName = "doRequest"
end sub

function runlikeDislikeTask(param as string)
    m.top.control = "RUN"
end function

function stoplikeDislikeTask(param as string)
    m.top.control = "STOP"
end function

sub doRequest()

    ' prepare JSON payload
    data = {
        showId: m.top.showId
        action: m.top.action  ' "like" or "dislike"
    }

    responseData = callLikeDislikeApi(data)
    m.top.LikeDislikeTaskResult = responseData

    if responseData <> invalid and responseData.success =  true
        print "Action success: "; m.top.result
    else
        m.top.LikeDislikeTaskResult = invalid
        print "Action failed"
    end if
end sub
