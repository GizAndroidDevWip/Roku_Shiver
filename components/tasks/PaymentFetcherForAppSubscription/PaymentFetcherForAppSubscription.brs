function init()
    m.top.functionName = "start"
    print "init PaymentFetcherForEvent"
end function

function runPaymentFetcherTask(param as string)
    print "RUN PaymentFetcherForEvent"
    m.top.control = "RUN"
end function

function stopPaymentFetcherTask(param as string)
    print "STOP PaymentFetcherForEvent"
    m.top.control = "STOP"
end function

sub start()
    GetPaymentContent()
end sub

sub GetPaymentContent()
    Payments = {}
    Payments.AddReplace("uid", getUserIdana())
    Payments.AddReplace("device_id", "roku")
    Payments.AddReplace("country_code", getCountrycode())
    Payments.AddReplace("pubid", getPubID())

    m.top.PayContent = ParseSubscription2(GetAppSubscription(Payments))
end sub
