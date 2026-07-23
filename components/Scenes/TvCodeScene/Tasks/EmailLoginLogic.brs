
sub showEmailLoginScreen()
    m.EmailLogin=CreateObject("roSGNode", "EmailLogin")
    m.EmailLogin.observeField("closethispage","closeThisPage2")
    ' m.EmailLogin.observeField("goToEmailLogin","OnGoToEmailLogin")
    ShowScreen(m.EmailLogin)
end sub


sub closeThisPage2()
    ' ?"closeThisPage called"
    runEventApi()
    CloseLoginAndLandingPages()
    showHomeScene({})
end sub
