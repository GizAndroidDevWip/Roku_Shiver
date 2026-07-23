sub init()
    m.top.functionName = "start"
end sub
function runGetVideoDetailsTask(param as string)
    m.top.show_id = param
    m.top.control = "RUN"
end function

function stopGetVideoDetailsTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    videoDetailsResponse = GetVideoDetails2(m.top.videoID, m.top.show_id)
    ?videoDetailsResponse
    ?"videoDetailsResponsesdsd"

    if videoDetailsResponse <> invalid and videoDetailsResponse.data <> invalid
        m.top.tagsContent = parseVideoDetails(videoDetailsResponse.data)
        if videoDetailsResponse.data.resolutions <> invalid and videoDetailsResponse.data.resolutions.count() > 0
            m.top.resolutions_parsed = parseResolutionLabelList(videoDetailsResponse.data.resolutions)
        end if
        m.top.videoDetailsResponse = videoDetailsResponse.data
        if videoDetailsResponse.data.up_next <> invalid and videoDetailsResponse.data.up_next.count() <> 0
            m.top.playListVideosParsed = parsedPlayListVideosResponse(videoDetailsResponse.data.up_next)
        end if
    else
        m.top.videoDetailsResponse = videoDetailsResponse
    end if
end sub





