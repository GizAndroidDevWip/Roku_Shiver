sub showEventDetailScreen(focusedContent)
    m.EventDetailsScene = CreateObject("roSGNode", "EventDetailsScene")
    m.EventDetailsScene.observeField("gotoLandingScene", "onGoToLandingScene7")
    m.EventDetailsScene.ObserveField("goToPaymentDescriptionScreen", "onGoToPaymentDescriptionScree3")
    m.EventDetailsScene.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenforEvent2")
    m.EventDetailsScene.ObserveField("rowItemSelected", "onGoToShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo")
    m.EventDetailsScene.ObserveField("goToVideoDetailScene", "onGotoVideoDetailScene")
    m.EventDetailsScene.ObserveField("goToShowMoreScene", "OnGoToShowMoreScene")
    ' m.EventDetailsScene.itemType = focusedContent.itemType '"SHOW"
    m.EventDetailsScene.EVENT_ID = focusedContent.event_id

    ' m.EventDetailsScene.start = focusedContent.show_id ' "23688"' '23913
    ShowScreen(m.EventDetailsScene)
end sub



sub onGoToLandingScene2()
    ?"onGoToLandingScreencalled"
    showLandingScreen()
end sub

sub onGoToLandingScene7()
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub


sub onGoToPaymentDescriptionScree3()
    ?"onGoToPaymentDescriptionScree2called"
    '**********below is done to prevent an issue - when we created multiple EventDetailsScene instance means
    'goes from one showdetail to another showdetail and so, coming back from one EventDetailsScene page does not give the very previous
    'EventDetailsScene pages's details, so previous EventDetailsScene page data is taken from screenstackarray.
    videoIdOfPeekshowPageInScreenStackArray = m.global.screenStackArray.Peek().goToPaymentDescriptionScreen
    paramsAssoc = {
        "videoId": videoIdOfPeekshowPageInScreenStackArray
    }
    videoSubscriptionListScreen(paramsAssoc)
end sub

sub onGoToPaymentDescriptionScreenforEvent2()
    ?"onGoToPaymentDescriptionScree2called"
    '**********below is done to prevent an issue - when we created multiple EventDetailsScene instance means
    'goes from one showdetail to another showdetail and so, coming back from one EventDetailsScene page does not give the very previous
    'EventDetailsScene pages's details, so previous EventDetailsScene page data is taken from screenstackarray.
    goToPaymentDescriptionScreenForEvent = m.global.screenStackArray.Peek().goToPaymentDescriptionScreenForEvent.Trim()
    videoSubscriptionListScreenForEvent(goToPaymentDescriptionScreenForEvent)
end sub


