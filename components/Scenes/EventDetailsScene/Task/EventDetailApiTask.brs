sub init()
    m.top.functionName = "start"
    print "init EventDetailApiTask"
end sub

function runEventDetailApiTask(param as string)
    print "RUN EventDetailApiTask"
    m.top.control = "RUN"
end function

function stopEventDetailApiTask(param as string)
    print "STOP EventDetailApiTask"
    m.top.control = "STOP"
end function

sub start()
    if m.top.taskType = "ContentRequest" then
        GetShowVideos(m.top.ContentRequest, m.top.itemType)
    end if
    if m.top.taskType = "EventRequest" then
        Event(m.top.user_id, m.top.event_type, m.top.video_id, m.top.video_title, m.top.channel_id, m.top.category, "0", "","")
    end if
end sub



sub GetShowVideos(shID as string, itemType)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("showidlist", shID)
    sec.Flush()



    ' if itemType = "UPCOMING_EVENT"
    '     '**********api calling and getting data
    '     data1 = getUPCOMINGEVENTResponse(shID, m.top.EVENT_ID) ' only for upcoming events case
    '     '***********preparsing response
    '     EventDetailApiTaskApiResponsePre = getShowResponseForUpcomingEventIfSeasonsAvailable(shID, data1)
    '     EventDetailApiTaskApiResponse = EventDetailApiTaskApiResponsePre[0][0]


    ' else if itemType = "LIVE_EVENT"
    '     '**********api calling and getting data
    '     data = getONGOINGEVENTResponse(shID, m.top.EVENT_ID) ' only for live_event  case
    '     '***********preparsing response
    '     EventDetailApiTaskApiResponse = getShowResponseForOngoingEventIfSeasonsAvailable(shID, data)
    '     return

    ' else if itemType = "ENDED_EVENT"
    '     '**********api calling and getting data
    '     EventDetailApiTaskApiResponse = getONGOINGEVENTResponse(shID, m.top.EVENT_ID)

    ' else
    '     '**********api calling and getting data
        
    ' end if
    EventDetailApiTaskApiResponse = getONGOINGEVENTResponse( m.top.EVENT_ID) ' all cases except above





    ' if itemType = "ENDED_EVENT" 
    '     '***********preparsing response
    '     oneRow = getShowVODForIfSeasonNotExits(shID, EventDetailApiTaskApiResponse)

    ' else
    '     m.top.rawEventDetailApiTaskContent = EventDetailApiTaskApiResponse
    '     return
    ' end if



    ' list = [
    '     {
    '         Title: "Videos are as follows"
    '         ContentList: oneRow
    '     }
    ' ]

    ' '********** parsing response
    ' EventDetailApiTaskContent = ParseContentForSeasonWiseShow(list)
    m.top.subscriptions = parseSubscriptionListData(EventDetailApiTaskApiResponse.subscriptions)
    m.top.rawEventDetailApiTaskContent = EventDetailApiTaskApiResponse
    m.top.Content = EventDetailApiTaskApiResponse
    m.top.EventDetailApiTaskStatus = true




    '**************** tags **********
    if itemType = "Shows"

    end if

end sub


