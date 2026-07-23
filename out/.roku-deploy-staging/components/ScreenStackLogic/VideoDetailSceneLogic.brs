sub showVideoDetailScene(id, ai_type, show_id)
    m.VideoDetailScene = CreateObject("roSGNode", "VideoDetailScene")
    m.VideoDetailScene.observeField("gotoLandingScene", "onGoToLandingScene6")
    m.VideoDetailScene.observeField("goToLandingSceneAndCloseAllScreens", "OnGoToLandingSceneAndCloseAllScreens")
    m.VideoDetailScene.ObserveField("goToPaymentDescriptionScreen", "onGoToPaymentDescriptionScree2")
    m.VideoDetailScene.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenforEvent")
    m.VideoDetailScene.ObserveField("goToShowMoreScene", "OnGoToShowMoreScene2")
    m.VideoDetailScene.ObserveField("goToVideoPlayerScene", "onGoToVideoPlayerScene3")
    m.VideoDetailScene.ObserveField("onclosethispage6", "OnClosethispage6")
    ' m.VideoDetailScene.ObserveField("ai_type", "goToVideoPlayerSceneAi_type")


    if show_id <> invalid and show_id.ToStr() <> ""
        m.VideoDetailScene.show_id = show_id
    end if

    if ai_type <> invalid and ai_type <> ""
        m.VideoDetailScene.ai_type = ai_type
    end if
    m.VideoDetailScene.videoId = id
    ShowScreen(m.VideoDetailScene)
end sub

sub onGoToLandingScene6()
    ?"lklll3455"
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub

' sub OnClosethispage6()
' CloseScreen(m.VideoDetailScene)
' end sub

sub OnGoToShowMoreScene2()
    ?"OnGoToShowMoreScene called"

    tagClicked = m.VideoDetailScene.tagsRowlistContent.getChild(m.VideoDetailScene.goToShowMoreScene[0]).getChild(m.VideoDetailScene.goToShowMoreScene[1]).name
    tagType = m.VideoDetailScene.tagsRowlistContent.getChild(m.VideoDetailScene.goToShowMoreScene[0]).getChild(m.VideoDetailScene.goToShowMoreScene[1]).type
    utilityAssoc = {
        key: tagClicked,
        type: tagType
    }
    ShowShowMoreScene(utilityAssoc)
end sub

sub onGoToVideoPlayerScene3()

    utilityAssoc = {
    }
    showVideoPlayerScene(m.VideoDetailScene.videoId, m.VideoDetailScene.ai_type, m.VideoDetailScene.show_id, true, utilityAssoc)


end sub




' sub onGoToPaymentDescriptionScree2()
'     ?"onGoToPaymentDescriptionScree2called"
'     '**********below is done to prevent an issue - when we created multiple show instance means
'     'goes from one showdetail to another showdetail and so, coming back from one show page does not give the very previous
'     'show pages's details, so previous show page data is taken from screenstackarray.
'     videoIdOfPeekshowPageInScreenStackArray = m.global.screenStackArray.Peek().goToPaymentDescriptionScreen
'     videoSubscriptionListScreen(videoIdOfPeekshowPageInScreenStackArray)
' end sub

' sub onGoToPaymentDescriptionScreenforEvent()
'     ?"onGoToPaymentDescriptionScree2called"
'     goToPaymentDescriptionScreenForEvent = m.global.screenStackArray.Peek().goToPaymentDescriptionScreenForEvent.Trim()
'     videoSubscriptionListScreenForEvent(goToPaymentDescriptionScreenForEvent)
' end sub


