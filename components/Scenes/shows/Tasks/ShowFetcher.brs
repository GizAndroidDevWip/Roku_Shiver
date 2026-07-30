sub init()
    m.top.functionName = "start"
    print "init ShowFetcher"
end sub

function runShowFetcherTask(param as string)
    print "RUN ShowFetcher"
    m.top.control = "RUN"
end function

function stopShowFetcherTask(param as string)
    print "STOP ShowFetcher"
    m.top.control = "STOP"
end function

sub start()
    if m.top.taskType = "ContentRequest" then
        GetShowVideos(m.top.ContentRequest, m.top.itemType)
    end if
    if m.top.taskType = "EventRequest" then
        Event(m.top.user_id, m.top.event_type, m.top.video_id, m.top.video_title, m.top.channel_id, m.top.category, "0", "", "")
    end if


end sub



sub GetShowVideos(shID as string, itemType)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("showidlist", shID)
    sec.Flush()



    if itemType = "UPCOMING_EVENT"
        '**********api calling and getting data
        showFetcherApiResponse = getUPCOMINGEVENTResponse(shID, m.top.upcomingEventId) ' only for upcoming events case
        '***********preparsing response
        oneRow = getShowResponseForUpcomingEventIfSeasonsAvailable(shID, showFetcherApiResponse)
        ?"l"

    else if itemType = "LIVE_EVENT"
        '**********api calling and getting data
        showFetcherApiResponse = getONGOINGEVENTResponse(shID, m.top.upcomingEventId) ' only for live_event  case
        '***********preparsing response
        m.top.LiveEventResponseData = getShowResponseForOngoingEventIfSeasonsAvailable(shID, showFetcherApiResponse)
        return

    else if itemType = "NEWS"
        '**********api calling and getting data
        showFetcherApiResponse = getSHOWResponseForNews(shID) ' only for news case

    else
        '**********api calling and getting data
        showFetcherApiResponse = getSHOWResponse(shID) ' all cases except above

    end if
    m.top.rawShowfetcherContent = showFetcherApiResponse

    oneRow = invalid

    ' if showFetcherApiResponse.single_video <> invalid

    if showFetcherApiResponse <> invalid and showFetcherApiResponse.count() <> 0 and showFetcherApiResponse.single_video <> invalid

        if itemType <> "UPCOMING_EVENT" and showFetcherApiResponse.single_video = 1 ' if there is no  season , only normal epsodes
            '***********preparsing response
            oneRow = getShowVODForIfSeasonNotExits(shID, showFetcherApiResponse)
        else if itemType <> "UPCOMING_EVENT" and showFetcherApiResponse.single_video = 0 ' if there is season available
            '***********preparsing response
            oneRow = getShowVODForIfSeasonsExists(shID, showFetcherApiResponse)
        else if itemType <> "UPCOMING_EVENT" and showFetcherApiResponse.single_video = 2 ' if there are playlists available
            '***********preparsing response
            oneRow = getShowVODForIfSeasonNotExits(shID, showFetcherApiResponse)
        else if itemType <> "UPCOMING_EVENT" and showFetcherApiResponse.single_video = 2 ' case for if single_video is 2
            '***********preparsing response
            oneRow = getShowVODForIfSeasonsAndEpisodeNotExists(shID, showFetcherApiResponse)
        else if itemType = "MICRO_DRAMA"
            oneRow = getShowVODForIfSeasonNotExits(shID, showFetcherApiResponse)
        else
            oneRow = getShowVODForIfSeasonNotExits(shID, showFetcherApiResponse)
        end if

    else if showFetcherApiResponse <> invalid and showFetcherApiResponse.count() <> 0
        oneRow = getShowVODForIfSeasonNotExits(shID, showFetcherApiResponse)
    end if


    if oneRow <> invalid

        list = [
            {
                Title: getText("videos")
                ContentList: oneRow
            }
        ]

        '********** parsing response
        showfetcherContent = ParseContentForSeasonWiseShow(list)
        
        m.top.Content = showfetcherContent
        m.top.showFetcherStatus = true


    else
        m.top.showFetcherStatus = false
    end if

    '**************** tags **********
    if itemType = "Shows"

    end if

end sub


