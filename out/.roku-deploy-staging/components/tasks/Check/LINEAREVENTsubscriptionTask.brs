sub init()
    m.videoSubs = false
    m.top.functionName = "start"
    print "init LINEAREVENTsubscriptionTask"
end sub

function runVideoSubscriptionTask(param as string)
    print "RUN LINEAREVENTsubscriptionTask"
    m.top.control = "RUN"
end function

function stopVideoSubscriptionTask(param as string)
    print "STOP LINEAREVENTsubscriptionTask"
    m.top.control = "STOP"
end function

sub start()
    m.videoSubs = false
    userSubIDS = getUserSubscriptionsContent()
    ?"userSubIDS.count()"
    ?userSubIDS.count()
    ?userSubIDS
    m.top.userSubIDSCount = userSubIDS.count()
    videoSubIDS = getVideoSubscriptionsContent()
    m.top.videoSubIDSCount = videoSubIDS.count()
    ?"videoSubIDS"
    ?videoSubIDS


    if videoSubIDS.Count() <> 0
        for i = 0 to userSubIDS.Count() - 1
            for j = 0 to videoSubIDS.Count() - 1
                if videoSubIDS[j] = userSubIDS[i] then
                    m.videoSubs = true
                    m.top.videoSubs = m.videoSubs '**********   subscribed flag set to true, user is subscribed
                end if
            end for
        end for

    else if videoSubIDS.Count() = 0 '********** if video has no subscription, then subscribed flag set to true
        m.videoSubs = true
        m.top.videoSubs = m.videoSubs
    end if
    m.top.videoSubs = m.videoSubs
    m.top.notifyClick = true
    m.top.notifyClick2 = true
    ?"notifyClick triggered"
end sub

function getUserSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    subIDSuser = []
    userSubsTypes = {}
    for each jsonitem in GetUserSubscriptions(params)
        subIDSuser.Push(jsonitem.sub_id)
        userSubsTypes.AddReplace(jsonitem.subscription_type_name, jsonitem.subscription_type_name)
    end for
    m.top.userSubsTypes = userSubsTypes
    m.top.userSubIDS = subIDSuser
    return subIDSuser
end function



function getVideoSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana().Trim())
    params.AddReplace("pubid", getPubID())
    params.AddReplace("eventId", m.top.eventId.trim())
    params.AddReplace("IS_LISTING", m.top.IS_LISTING)
    responseData = GetLinearEventSubscriptions(params)
    m.top.eventSubscriptionResponseDataUnParsed = responseData
    subscription_type_name = {}


    subIDS = []
    for each jsonitem in responseData
        subIDS.Push(jsonitem.subscription_id)
        subscription_type_name.AddReplace(jsonitem.subscription_type_name, jsonitem.subscription_type_name)
    end for
    m.top.videoSubscriptionResponseData = subscription_type_name
    return subIDS
end function
