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
        ?"tyty"
        GetShowVideos(m.top.ContentRequest, m.top.itemType)
    end if
    if m.top.taskType = "EventRequest" then
        Event(m.top.user_id, m.top.event_type, m.top.video_id, m.top.video_title, m.top.channel_id, m.top.category, "0", "")
    end if


end sub







sub GetShowVideos(shID as string, itemType)
    ?"GetShowVideos called"

    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("showidlist", shID)
    sec.Flush()



    if itemType = "UPCOMING_EVENT"
        '**********api calling and getting data
        showFetcherApiResponse = getUPCOMINGEVENTResponse(shID, m.top.upcomingEventId) ' only for upcoming events case
        ?"yuuy"
        '***********preparsing response
        oneRow = getShowResponseForUpcomingEventIfSeasonsAvailable(shID, showFetcherApiResponse)
        ?oneRow
        ?"jhkkkjkj"


        
    else itemType = "LIVE_EVENT"
        '**********api calling and getting data
        showFetcherApiResponse = getONGOINGEVENTResponse(shID, m.top.upcomingEventId) ' only for live_event  case
        ?"jhjjj"
        '***********preparsing response
        oneRow = getShowResponseForOngoingEventIfSeasonsAvailable(shID, showFetcherApiResponse)
        ?"LIVE_EVENT222 "

    end if



    

    if showFetcherApiResponse <>invalid
        ?"ghghgh"
        if itemType ="UPCOMING_EVENT" 
            '***********preparsing response
            ?"hgh"
            oneRow =  getShowVODForIfUpcomingEventExists(shID, showFetcherApiResponse)
            ?"rffgfg"



        else  itemType ="LIVE_EVENT"
            '***********preparsing response
            ?"nbnn"
            oneRow = getShowVODForIfSeasonsExists(shID, showFetcherApiResponse)
            ?"hghghh"
            
        end if
   
    end if


  
    list = [
        {
            Title: "Videos are as follows"
            ContentList: oneRow
        }
    ]
    ?"listt776"

    '********** parsing response
    showfetcherContent = ParseContentForUpcomingEvent(list)
    ?"showfetcherContenttt"
    m.top.rawShowfetcherContent = showFetcherApiResponse
    m.top.Content = showfetcherContent
    ?"jhj"
    m.top.showFetcherStatus = true




    '**************** tags **********
    if itemType = "Shows"
        
    end if

end sub


