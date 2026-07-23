function init()
    m.top.functionName = "start"
    print "init PaymentFetcher"
end function

function runPaymentFetcherTask(param as string)
    print "RUN PaymentFetcher"
    m.top.control = "RUN"
end function

function stopPaymentFetcherTask(param as string)
    print "STOP PaymentFetcher"
    m.top.control = "STOP"
end function

sub start()
    GetPaymentContent()
end sub

sub GetPaymentContent()
    Payments = {}
    Payments.AddReplace("channelId", m.top.channelId)
    Payments.AddReplace("uid", getUserIdana())
    Payments.AddReplace("device_id", "roku")
    Payments.AddReplace("country_code", getCountrycode())
    Payments.AddReplace("pubid", getPubID())
    m.top.PayContent = ParseSubscription2(getTimeRgidChannelSubscription(Payments))
end sub
