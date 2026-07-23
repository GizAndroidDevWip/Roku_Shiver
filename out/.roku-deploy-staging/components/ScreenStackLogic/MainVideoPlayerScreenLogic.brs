sub showVideoPlayerScene2(inputValue as string, playUsing as string, id as string, fromSceneType as string)
    m.MainVideoPlayerScene = CreateObject("roSGNode", "MainVideoPlayerScene")
    ' m.MainVideoPlayerScene.selectedIndex = selectedIndex       'Here we are passing selectedIndex, videoListContent, and videoId to VideoPlayer file.
    m.MainVideoPlayerScene.ObserveField("closethispage", "OnCloseThisPage")
    if playUsing = "VIDEO_ID"
        m.MainVideoPlayerScene.videoId = inputValue
    else if playUsing = "URL"
        m.MainVideoPlayerScene.eventId = id
        m.MainVideoPlayerScene.URL = inputValue
    end if


    ShowScreen(m.MainVideoPlayerScene)
end sub


sub showVideoPlayerSceneForTimeGridScene(inputValue, playUsing as string, fromSceneType as string)
    m.MainVideoPlayerScene = CreateObject("roSGNode", "MainVideoPlayerScene")
    ' m.MainVideoPlayerScene.selectedIndex = selectedIndex       'Here we are passing selectedIndex, videoListContent, and videoId to VideoPlayer file.
    m.MainVideoPlayerScene.ObserveField("closethispage", "OnCloseThisPage")
    m.MainVideoPlayerScene.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenForEvent6")
    m.MainVideoPlayerScene.ObserveField("gotoLandingScene", "onGoToLandingScene9")
    m.MainVideoPlayerScene.ObserveField("goToLandingSceneAndCloseAllScreens", "OnGoToLandingSceneAndCloseAllScreens")
    ShowScreen(m.MainVideoPlayerScene)
    m.MainVideoPlayerScene.timeGridSceneInputData = inputValue
end sub

sub showVideoPlayerSceneForTimeGridSceneForTopMenuLive()
    m.MainVideoPlayerScene = CreateObject("roSGNode", "MainVideoPlayerScene")
    ' m.MainVideoPlayerScene.selectedIndex = selectedIndex       'Here we are passing selectedIndex, videoListContent, and videoId to VideoPlayer file.
    m.MainVideoPlayerScene.ObserveField("closethispage", "OnCloseThisPage")
    m.MainVideoPlayerScene.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenForEvent6")
    m.MainVideoPlayerScene.ObserveField("gotoLandingScene", "onGoToLandingScene9")
    m.MainVideoPlayerScene.ObserveField("goToLandingSceneAndCloseAllScreens", "OnGoToLandingSceneAndCloseAllScreens")
    ShowScreen(m.MainVideoPlayerScene)
    m.MainVideoPlayerScene.playLive = true
end sub


sub OnCloseThisPage()
    ?"OnCloseThisPage called:MainVideoPlayerSceneLogic "
    CloseScreen(m.MainVideoPlayerScene)
end sub

sub onGoToPaymentDescriptionScreenForEvent6()
    removeScreenFromScreenStack(m.MainVideoPlayerScene)
    videoSubscriptionListScreenForTimeGrid(m.MainVideoPlayerScene.goToPaymentDescriptionScreenForEvent)
end sub

sub onGoToLandingScene9()
    reverse_tv_code = getREVERSE_TV_CODE_FLOW()
    removeScreenFromScreenStack(m.MainVideoPlayerScene)
    if (reverse_tv_code = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub

sub showVideoPlayerScene3(URL as string)
    m.MainVideoPlayerScene = CreateObject("roSGNode", "MainVideoPlayerScene")
    ' m.MainVideoPlayerScene.selectedIndex = selectedIndex       'Here we are passing selectedIndex, videoListContent, and videoId to VideoPlayer file.
    m.MainVideoPlayerScene.ObserveField("closethispage", "OnCloseThisPage")
    m.MainVideoPlayerScene.deepLinkSampleVideo = URL
    m.MainVideoPlayerScene.ObserveField("closeAndgoToHomeScene", "onCloseAndgoToHomeScene")
    ShowScreen(m.MainVideoPlayerScene)
end sub


sub onCloseAndgoToHomeScene()
    closeAllAcreens()
    m.global.DEEPLINK_PARAMS = invalid
    showLaunchScene()
end sub