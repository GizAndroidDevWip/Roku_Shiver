sub showRegisterScene()
    m.RegisterScene = CreateObject("roSGNode", "RegisterScene")
    ' m.RegisterScene.ObserveField("gotoHomeScene","onGoToHomeSceneFromRegister")
    m.RegisterScene.observeField("closethispage", "onGoToHomeSceneFromRegister")
    m.RegisterScene.observeField("gotoRegisterLoginScene", "onGoToRegisterScene")
    m.RegisterScene.ObserveField("gotoLandingScene", "onGoToLandingScene")
     m.RegisterScene.ObserveField("goToLoginSceneFromRegisterScene", "onGoToLandingSceneFromRegisterScene")
    showScreen(m.RegisterScene)
end sub


sub onGoToHomeSceneFromRegister()
    ' ?"onGoToHomeSceneFromLanding called"
    runEventApi()
    CloseLoginAndLandingPages()
    ?"kkkm"
    showHomeScene({})
    ?"mmmm"
end sub



sub onGoToLandingSceneFromRegisterScene()

    showLandingScreen()
end sub