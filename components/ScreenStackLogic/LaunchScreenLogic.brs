sub showLaunchScene()
    m.LaunchScene = CreateObject("roSGNode", "LaunchScene")
    m.LaunchScene.ObserveField("gotoHomeScene", "onGoToHomeScene")
    m.LaunchScene.ObserveField("gotoLandingScene", "onGoToLandingScene")
    m.LaunchScene.ObserveField("gotoShowScene", "onGoTOShowScene")
    m.LaunchScene.observeField("closethispage", "CloseLaunchScene")
    m.LaunchScene.observeField("goToMainVideoPlayer", "OngoToMainVideoPlayer3")
    m.LaunchScene.observeField("goToTimeGridScreen", "onGoToTimeGridScene")
     m.LaunchScene.observeField("gotoPlayDeepLinkVideo", "OnGotoPlayDeepLinkVideo")
    showScreen(m.LaunchScene)
end sub

sub onGoToHomeScene()
    runEventAPI1()
    ?"onGoToHomeScene called time check"
    showHomeScene({})
end sub


sub onGoToLandingScene()
    ' CloseAllScreen()
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub


sub CloseLaunchScene()
    ?"CloseLaunchScene called"
    CloseScreen(m.LaunchScene)
end sub

sub OngoToMainVideoPlayer3()
    runEventAPI1()
    showVideoPlayerSceneForTimeGridScene(m.LaunchScene.goToMainVideoPlayer, "URL", "TIMEGRID_SCENE")
end sub

sub onGoToTimeGridScene()
    runEventAPI1()
    showTimeGridScene()
end sub

sub runEventAPI()
    
end sub

sub runEventAPI1()
    if getUserIdana() <> invalid and getUserIdana() <> "" and getPubID() <> invalid and getPubID() <> "" 
        m.EventLaunch = CreateObject("roSGNode", "EventLaunch")
        m.EventLaunch.user_id = getUserIdana()
        m.EventLaunch.event_type = "POP01"
        m.EventLaunch.callFunc("runEventLaunch", "")
    end if
end sub

sub OnGotoPlayDeepLinkVideo()
    showVideoPlayerScene3("https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")
end sub