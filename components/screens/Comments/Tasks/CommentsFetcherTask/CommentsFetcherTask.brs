sub init()
    m.top.functionName = "start"
    m.count = 0
    print "init commentsFetcherTask"
end sub

function runCommentsFetcherTask(param as string)
    print "RUN commentsFetcherTask"
    m.top.control = "RUN"
end function

function stopCommentsFetcherTask(param as string)
    print "STOP commentsFetcherTask"
    m.top.control = "STOP"
end function

sub start()
    runCommentsFetcher()
end sub

sub runCommentsFetcher()
    reposnse = callCommentsFetcherAPI(m.top.video_id)
    if reposnse <> invalid and reposnse.data <> invalid
        CommentsFetcherTaskResponse = parseCommentsFetcherTaskResponse(reposnse.data)
        m.top.CommentsFetcherTaskResponse = CommentsFetcherTaskResponse
        m.top.CommentsFetcherTaskStatus = true
    else
        m.top.CommentsFetcherTaskStatus = false
    end if
end sub