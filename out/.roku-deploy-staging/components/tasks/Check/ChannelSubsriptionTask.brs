sub init()
    m.channelSubs = false
    m.top.functionName = "start"
    print "init ChannelSubsriptionTask"
end sub

function runChannelSubsriptionTask(param as string)
    print "RUN ChannelSubsriptionTask"
    m.top.control = "RUN"
end function

function stopChannelSubsriptionTask(param as string)
    print "STOP ChannelSubsriptionTask"
    m.top.control = "STOP"
end function

sub start()
    m.channelSubs = false
    userSubIDS = getUserSubscriptionsContent()
    channelSubIDS = getChannelSubscriptionsContent()
    if channelSubIDS.Count() <> 0
        for i = 0 to userSubIDS.Count() - 1
            for j = 0 to channelSubIDS.Count() - 1
                if channelSubIDS[j] = userSubIDS[i] then
                    m.channelSubs = true
                    ?"dahgjdhgsgdjahgsjdgh000"
                end if
            end for
        end for
    else if channelSubIDS.Count() = 0 '********** if video has no subscription, then subscribed flag set to true
        m.channelSubs = true
        ?"dahgjdhgsgdjahgsjdgh111"
    end if
    if m.channelSubs <> invalid
        ?"dahgjdhgsgdjahgsjdgh222"
        m.top.channelSubs = m.channelSubs
    end if
end sub

function getUserSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    subIDS = []
    video_index = 0
    for each jsonitem in GetUserSubscriptions(params)
        subIDS.Push(jsonitem.sub_id)
    end for
    return subIDS

end function


function getChannelSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    params.AddReplace("channel_id", m.top.channelID)
    subIDS = []
    for each jsonitem in GetChannelSubscriptions(params)
        subIDS.Push(jsonitem.subscription_id)
    end for
    ?subIDS
    ?"jjjkk"
    return subIDS

end function
