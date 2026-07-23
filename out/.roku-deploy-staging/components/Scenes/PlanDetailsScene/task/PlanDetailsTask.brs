sub init()
    m.top.functionName = "start"
end sub

sub start()
    if m.top.action = "CANCEL"
        cancelSubscription()
    else
        fetchSubscriptionData()
    end if
end sub

sub fetchSubscriptionData()
    response = GetUserSubscriptions3()
    if response <> invalid
        setUsersubscribedStatus(response)
        m.top.subscriptionData = response
    end if
end sub

sub cancelSubscription()
    id = m.top.cancelSubscriptionId
    sid = ""
    if m.top.sub_id <> invalid then sid = m.top.sub_id

    if id <> ""
        m.top.cancelResponse = callCancelSubscriptionApi(id, sid)
    end if
end sub

sub setUsersubscribedStatus(responseData)
    userData = responseData
    Subscription_Status = false
    if userData <> invalid and userData.data <> invalid and userData.data.count() > 0
        for each item in userData.data
            if item.subscription_type_id <> invalid
                if item.subscription_type_id = 3 or item.subscription_type_id = 4 then
                    Subscription_Status = true
                    exit for
                end if
            end if
        end for
    end if

    if Subscription_Status then
        setIsUserSubscribed("true")
    else
        setIsUserSubscribed("false")
    end if
end sub
