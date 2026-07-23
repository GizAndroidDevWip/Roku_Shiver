sub init()
    m.videoSubs = false
    m.top.functionName = "start"
    print "init VideoSubscriptionTask"
end sub

function runVideoSubscriptionTask(param as string)
    print "RUN VideoSubscriptionTask"
    m.top.control = "RUN"
end function

function stopVideoSubscriptionTask(param as string)
    print "STOP VideoSubscriptionTask"
    m.top.control = "STOP"
end function

sub start()
    ?m.top.show_id
    ?"m.top.show_idsas"
    ?"sdjsjkdhsdg";m.top.videoID
    m.videoSubs = false
    userSubIDS = getUserSubscriptionsContent()
    ' ?"userSubIDS.count()"
    ' ?userSubIDS.count()
    ' ?userSubIDS
    if userSubIDS <> invalid and userSubIDS.count() <> invalid
        m.top.userSubIDSCount = userSubIDS.count()
    else
        m.top.userSubIDSCount=0
    end if
    videoSubIDS = getVideoSubscriptionsContent()
?"kll"
    if videoSubIDS <> invalid and videoSubIDS.count() <> invalid
        m.top.videoSubIDSCount = videoSubIDS.count()
    else
        m.top.userSubIDSCount=0
    end if
    if videoSubIDS.Count() <> 0
        for i = 0 to userSubIDS.Count() - 1
            for j = 0 to videoSubIDS.Count() - 1
                if videoSubIDS[j] = userSubIDS[i] then
                    m.videoSubs = true
                    m.top.videoSubs = m.videoSubs
                end if
            end for
        end for
    else if videoSubIDS.Count() = 0 '********** if video has no subscription, then subscribed flag set to true
        m.videoSubs = true
        m.top.videoSubs = m.videoSubs
        ?"kk"
    end if
    ?m.top.show_id
    ?"m.top.show_id3434"
    m.top.videoSubs = m.videoSubs
    m.top.notifyClick = true
    ?m.top.show_id
    ?"m.top.show_idwewe"
    videoDetailsResponse = GetVideoDetails(m.top.videoID,m.top.show_id)
    ?videoDetailsResponse
    ?"videoDetailsResponse223we"
    m.top.videoDetailsResponse = videoDetailsResponse
    m.top.notifyClickForWatchNowOrSubscribeVisibility = true
end sub

function getUserSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    subIDSuser = []
    userSubsTypes = {}
    userSubResponse = GetUserSubscriptions3(params)
    if userSubResponse <> invalid
        m.top.userSubResponse = userSubResponse
        for each jsonitem in userSubResponse.data
            subIDSuser.Push(jsonitem.sub_id)
            userSubsTypes.AddReplace(jsonitem.subscription_type_name, jsonitem.subscription_type_name)
        end for
        m.top.userSubsTypes = userSubsTypes
        m.top.userSubIDS = subIDSuser
        return subIDSuser
    end if
end function



function getVideoSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana().Trim())
    params.AddReplace("pubid", getPubID())
    params.AddReplace("video_id", m.top.videoID.trim())
    responseData = GetVideoSubscriptions(params)
    '  m.top.videoSubscriptionResponseData = responseData
    subscription_type_name = {}


    subIDS = []
    for each jsonitem in responseData
        subIDS.Push(jsonitem.subscription_id)
        subscription_type_name.AddReplace(jsonitem.subscription_type_name, jsonitem.subscription_type_name)
    end for
    m.top.videoSubscriptionResponseData = subscription_type_name
    return subIDS
end function
