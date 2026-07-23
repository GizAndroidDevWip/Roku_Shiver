sub showTvCodeScreen()
    ?"showTvCodeScreen called"
    m.TvCodeScene = CreateObject("roSGNode", "TvCodeScene")
    m.TvCodeScene.observeField("closethispage", "closeThisPage1")
    m.TvCodeScene.observeField("goToLoginScene", "OnGoToLoginScene")
    m.TvCodeScene.observeField("goToLoginChooseScene", "OngoToLoginChooseScene")
    m.TvCodeScene.observeField("gotoHomeScene", "OngotoHomeScene2")

    'Login Popup
    m.TvCodeScene.ObserveField("goToEmailLoginScreen", "OngoToEmailLoginScreen")
    ShowScreen(m.TvCodeScene)
end sub


'Login  Popup
sub OngoToEmailLoginScreen()
    showEmailLoginScreen()
end sub

sub OnGoToLoginScene()
    ?"OnGoToLoginScene called"
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub

sub OngoToLoginChooseScene()
    showLogicChooseScreen()
end sub

sub OngotoHomeScene2()
    runEventApi()
    showHomeScene({})
end sub