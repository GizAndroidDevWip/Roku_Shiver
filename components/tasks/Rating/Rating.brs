sub init()
    m.top.functionName = "start"
    print "init Rating"
end sub

function runRatingTask(param as string)
    print "RUN Rating"
    m.top.control = "RUN"
end function

function stopRatingTask(param as string)
    print "STOP Rating"
    m.top.control = "STOP"
end function

sub start()
    ratings = m.top.rating
    showid = m.top.showid
    post = {
        show_id: showid,
        rating: ratings
    }
    responseData = updateRating(post)
    if responseData = invalid
        m.top.RatingResponse = "invalid"
    else
        m.top.RatingResponse = "valid"
    end if
end sub