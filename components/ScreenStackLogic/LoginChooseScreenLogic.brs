
sub showLogicChooseScreen()
    m.LoginChooseScene = CreateObject("roSGNode", "LoginChooseScene")
    m.LoginChooseScene.observeField("closethispage", "closeThisPage3")

    m.LoginChooseScene.observeField("goToEmailLoginScene", "OngoToEmailLoginScene2")
    m.LoginChooseScene.observeField("goToLoginScene", "OngoToLoginScene2")
    m.LoginChooseScene.observeField("goToRegisterScene", "OngoToRegisterScene2")
    ShowScreen(m.LoginChooseScene)
end sub


sub closeThisPage3()
    ?"closeThisPage called"
    CloseLoginAndLandingPages()
end sub

sub OngoToEmailLoginScene2()
    showEmailLoginScreen()
end sub

sub OngoToLoginScene2()
    showLandingScreen()
end sub

sub OngoToRegisterScene2()
    showRegisterScene()
end sub