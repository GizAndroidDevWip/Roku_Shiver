
sub showLandingScreen()
    m.Landing = CreateObject("roSGNode", "Landing")
    m.Landing.ObserveField("gotoHomeScene","onGoToHomeSceneFromLanding")
    m.Landing.ObserveField("gotoLaunchScreen","onGoToLaunchScene")
    m.Landing.ObserveField("gotoShowScene","onGoTOShowScene")
    m.Landing.observeField("goToMyListScreen","onGoToMyListScreen")
    m.Landing.observeField("closethispage","closeThisPage1")
    m.Landing.observeField("gotoRegisterLoginScene","onGoToRegisterScene")
    m.Landing.observeField("gotoEmailLoginScene","onGoToEmailLoginScene")

    ShowScreen(m.Landing)
end sub 
 
sub onGoToHomeSceneFromLanding()
    runEventApi()
    CloseAllScreen()
    showHomeScene({})
end sub


sub onGoToEmailLoginScene()
    showEmailLoginScreen()
end sub

sub onGoToRegisterScene()
    showRegisterScene()
end sub

sub closeThisPage1()
    runEventApi()
    CloseLoginAndLandingPages()
    showHomeScene({})
end sub
