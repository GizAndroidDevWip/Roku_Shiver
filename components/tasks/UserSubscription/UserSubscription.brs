sub init()
    m.top.functionName = "start"
    print "ini UserSubscription"
end sub

function runUserSubscription(param as string)
    print "RUN UserSubscription"
    m.top.control = "RUN"
end function

function stopUserSubscription(param as string)
    print "STOP UserSubscription"
    m.top.control = "STOP"
end function

sub start()

    responseData = getUserSubscriptions2()
    if responseData = invalid then return
    setUsersubscribedStatus(responseData)
    m.top.UserSubResponseData = responseData
    if responseData.forcibleLogout = true
        m.top.SubsResponse = "exceed"
    else
        m.top.SubsResponse = "valid"
    end if
end sub

sub setUsersubscribedStatus(responseData)
    userData = responseData

    Subscription_Status = false ' internal flag

    if userData <> invalid and userData.data <> invalid and userData.data.count() > 0

        for each item in userData.data
            if item.subscription_type_id <> invalid
                if item.subscription_type_id = 3 or item.subscription_type_id = 4 then
                    Subscription_Status = true
                    ?item.subscription_type_id
                    exit for
                end if
            end if
        end for

    end if

    ' Set the final value
    if Subscription_Status then
        setIsUserSubscribed("true")
    else
        setIsUserSubscribed("false")
    end if
end sub