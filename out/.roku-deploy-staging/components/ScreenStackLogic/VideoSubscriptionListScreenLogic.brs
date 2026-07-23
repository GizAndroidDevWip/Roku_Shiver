sub videoSubscriptionListScreen(inputAssoc)
    m.PaymentDescription = CreateObject("roSGNode", "PaymentDescription")
    m.PaymentDescription.ObserveField("gotoHomeScenen", "onGoToHomeScene")
    m.PaymentDescription.ObserveField("gotoLaunchScene", "onGoToLaunchScene")
    m.PaymentDescription.ObserveField("gotoshowscene", "onGoToShowScene")
    m.PaymentDescription.ObserveField("gotoSubscriptionListScreen", "onGoToSubscriptionListScreen")
    m.PaymentDescription.observeField("isSubscribed", "closeThisPage")
    m.PaymentDescription.addFields({
        "isGoadsFreeclicked": inputAssoc.isGoadsFreeclicked
    })
    m.PaymentDescription.videoID = inputAssoc.videoId
    showScreen(m.PaymentDescription)
end sub


'**********show subscription listing page for LINEAR_EVENT/LIVE_EVENT
sub videoSubscriptionListScreenForEvent(eventId)
    m.PaymentDescription = CreateObject("roSGNode", "PaymentDescription")
    m.PaymentDescription.ObserveField("gotoHomeScenen", "onGoToHomeScene")
    m.PaymentDescription.ObserveField("gotoLaunchScene", "onGoToLaunchScene")
    m.PaymentDescription.ObserveField("gotoshowscene", "onGoToShowScene")
    m.PaymentDescription.ObserveField("gotoSubscriptionListScreen", "onGoToSubscriptionListScreen")
    m.PaymentDescription.observeField("isSubscribed", "closeThisPage")
    m.PaymentDescription.eventID = eventId
    showScreen(m.PaymentDescription)
end sub

'**********show subscription listing page for LINEAR_EVENT/LIVE_EVENT
sub videoSubscriptionListScreenForTimeGrid(channelId)
    m.PaymentDescription = CreateObject("roSGNode", "PaymentDescription")
    m.PaymentDescription.ObserveField("gotoHomeScenen", "onGoToHomeScene")
    m.PaymentDescription.ObserveField("gotoLaunchScene", "onGoToLaunchScene")
    m.PaymentDescription.ObserveField("gotoshowscene", "onGoToShowScene")
    m.PaymentDescription.ObserveField("gotoSubscriptionListScreen", "onGoToSubscriptionListScreen")
    m.PaymentDescription.observeField("isSubscribed", "closeThisPage")
    m.PaymentDescription.channelId = channelId
    showScreen(m.PaymentDescription)
end sub


sub onGoToLaunchScene()
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub



sub onGoToShowScene()
    ShowShowDetailsScreen()
end sub

sub closeThisPage()
    ?"closeThisPage called"
    CloseScreen(m.PaymentDescription)
end sub