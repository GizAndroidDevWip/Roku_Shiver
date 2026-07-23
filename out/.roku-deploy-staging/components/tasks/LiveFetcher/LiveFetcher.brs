sub init()
    m.top.functionName = "start"
    m.count = 0
    print "init LiveFetcher"
end sub

function runLiveFetcherTask(param as string)
    print "RUN LiveFetcher"
    m.IS_FROM = param
    m.top.control = "RUN"
end function

function stopLiveFetcherTask(param as string)
    print "STOP LiveFetcher"
    m.top.control = "STOP"
end function

sub start()
    GetScheduledetails()
end sub

sub GetScheduledetails()
    params1 = {}
    if m.IS_FROM <> invalid and m.IS_FROM <> "" and m.IS_FROM = "TIMEGRIDSCENE"
        channelID = m.top.channel_id
    else if m.IS_FROM = "HOMESCENE_BANNER_PLAY"
        channelID = m.top.channel_id
    else
        channelID = getFastChannelId()
    end if
     params1.AddReplace("fastchannelid", channelID)
    'live api is calling each minute
    'params1.AddReplace("linear_channel_id",getchannelsid())
    responseData = GetNowPlayingLiveData(params1)
    ?responseData
    ?"responseDatawwws"
    m.top.livefetcherResponse= responseData
   
end sub