sub showMicroDramaScene(param)
    m.microDramaScene = CreateObject("roSGNode", "MicroDramaScene")
    m.microDramaScene.observeField("closethispage", "closeMicroDramaPage")
    m.microDramaScene.observeField("goToShowDetailsPage", "OngoToShowDetailsPage")
    m.microDramaScene.observeField("goToPaymentDescriptionScreen", "onGoToPaymentDescriptionScreen2")
    m.microDramaScene.observeField("gotoLandingScene", "onGoToLandingSceneFromMicrodramaScene")
    m.microDramaScene.playSelectedShortsVideo = param.selectedVideoId
    m.microDramaScene.show_name = param.show_name
    m.microDramaScene.show_id = param.show_id
    ShowScreen(m.microDramaScene)
end sub

sub playSelectedMicroDramaVideo(video_id)
    m.microDramaScene = CreateObject("roSGNode", "MicroDramaScene")
    m.microDramaScene.observeField("closethispage", "closeMicroDramaPage")
    m.microDramaScene.playSelectedMicroDramaVideo = video_id
    ShowScreen(m.microDramaScene)
end sub

sub closeMicroDramaPage()
    ?"k;zlkcxcz"
    CloseScreen(m.microDramaScene)
end sub

sub OngoToShowDetailsPage()
    ShowShowDetailsScreen(m.microDramaScene.goToShowDetailsPage)
end sub

sub onGoToPaymentDescriptionScreen2()
    videoSubscriptionListScreen({
        "videoId": m.microDramaScene.goToPaymentDescriptionScreen
    })
end sub

sub onGoToLandingSceneFromMicrodramaScene()
    CloseScreen(m.microDramaScene)
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub