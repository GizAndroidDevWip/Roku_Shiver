sub showVideoPlayerScene(video_id, ai_type, show_id, needToShowContinueWatchingDialog, utilityAssoc)
    if video_id <> invalid and video_id <> 0
        ?"showVideoPlayerScene called"
        m.VideoPlayerScene = CreateObject("roSGNode", "VideoPlayerScene")
        m.VideoPlayerScene.ObserveField("closethispage", "onclosethispage2")
        m.VideoPlayerScene.observeField("gotoLandingScene", "onGoToLandingScene3")
        m.VideoPlayerScene.observeField("goToLandingSceneAndCloseAllScreens", "OnGoToLandingSceneAndCloseAllScreens")
        m.VideoPlayerScene.ObserveField("goToPaymentDescriptionScreen", "onGoToPaymentDescriptionScree4")
        m.VideoPlayerScene.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenforEvent5")
        m.VideoPlayerScene.ObserveField("reloadvideoPlayerScene", "onReloadVideoPlayerScene")
        m.VideoPlayerScene.ObserveField("reloadvideoPlayerScene2", "onReloadVideoPlayerScene2")

        if utilityAssoc.DoesExist("calendarId") and utilityAssoc.calendarId <> invalid
            m.VideoPlayerScene.calendarId = utilityAssoc.calendarId
        end if
        if ai_type <> invalid and ai_type <> ""
            m.VideoPlayerScene.ai_type = ai_type
        end if
        if show_id <> invalid and show_id <> ""
            m.VideoPlayerScene.show_id = show_id
        end if
        m.VideoPlayerScene.videoId = video_id
        if needToShowContinueWatchingDialog <> invalid
            m.VideoPlayerScene.needToShowContinueWatchingDialog = needToShowContinueWatchingDialog
        else
            m.VideoPlayerScene.needToShowContinueWatchingDialog = true
        end if

        m.VideoPlayerScene.addFields({
            "isStartOverButtonClicked": utilityAssoc.isStartOverButtonClicked
        })

        ' if ai_type <> invalid and ai_type <> ""
        ' ai_type=ai_type
        '     ?"kk"
        '     m.VideoPlayerScene.addFields({
        '         "ai_type":video_id
        '       })
        ' end if
        ' ?m.VideoPlayerScene.ai_type
        ShowScreen(m.VideoPlayerScene)
    end if
end sub


sub onclosethispage2()
    ?"onclosethispage2 called:VideoPlayerSceneLogic "
    CloseScreen(m.VideoPlayerScene)
end sub

sub onGoToPaymentDescriptionScree4()
    ?"onGoToPaymentDescriptionScree4"
    '**********below is done to prevent an issue - when we created multiple show instance means
    'goes from one showdetail to another showdetail and so, coming back from one show page does not give the very previous
    'show pages's details, so previous show page data is taken from screenstackarray.

    videoIdOfPeekshowPageInScreenStackArray = m.global.screenStackArray.Peek().goToPaymentDescriptionScreen
    removeScreenFromScreenStack(m.VideoPlayerScene)
    if m.VideoPlayerScene.isGoadsFreeclicked = true then isGoadsFreeclicked = true else isGoadsFreeclicked = false
    paramsAssoc = {
        "videoId": videoIdOfPeekshowPageInScreenStackArray,
        "isGoadsFreeclicked": isGoadsFreeclicked
    }
    videoSubscriptionListScreen(paramsAssoc)
    m.VideoPlayerScene.isGoadsFreeclicked = false
end sub

sub onGoToPaymentDescriptionScreenforEvent5()
    ?"onGoToPaymentDescriptionScreenforEvent5"
    CloseScreen(m.VideoPlayerScene)
    goToPaymentDescriptionScreenForEvent = m.global.screenStackArray.Peek().goToPaymentDescriptionScreenForEvent.Trim()
    videoSubscriptionListScreenForEvent(goToPaymentDescriptionScreenForEvent)
end sub

sub onGoToLandingScene3()
    removeScreenFromScreenStack(m.VideoPlayerScene)
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub

'this is when playlist or similar shows clicked form player overlay
sub onReloadVideoPlayerScene()
    ?m.top.reloadvideoPlayerScene2
    ?"onReloadVideoPlayerScene called"
    CloseScreen(m.VideoPlayerScene)
    currentVideoId = m.VideoPlayerScene.videoId
    ?m.VideoPlayerScene.showid_2
   
    utilityAssoc = {
    }
    showVideoPlayerScene(m.VideoPlayerScene.reloadvideoPlayerScene.toint(), "", m.VideoPlayerScene.showid_2, true, utilityAssoc)
    m.VideoPlayerScene.previous_videoId = currentVideoId

end sub


sub onReloadVideoPlayerScene2()
    ?m.reloadvideoPlayerScene2
    ?m.top.reloadvideoPlayerScene2
    ?"onReloadVideoPlayerScene2 called"
    ?m.VideoPlayerScene.reloadvideoPlayerScene2
    ?m.VideoPlayerScene.reloadvideoPlayerScene2.toint()
    ' CloseScreen(m.VideoPlayerScene)
    ' currentVideoId = m.VideoPlayerScene.videoId
    utilityAssoc = {
    }
    showVideoPlayerScene(m.VideoPlayerScene.reloadvideoPlayerScene2.toint(), "", "", true, utilityAssoc)
    ' m.VideoPlayerScene.previous_videoId = currentVideoId
end sub