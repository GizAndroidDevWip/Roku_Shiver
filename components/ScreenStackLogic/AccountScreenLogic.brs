sub ShowMyAccountScreen()
    m.myAccount = CreateObject("roSGNode", "MyAccount")
    m.myAccount.observeField("goBack", "onMyAccountGoBack")
    m.myAccount.observeField("goToMyListScreen", "onMyAccountGoToMyListScreen")
    m.myAccount.observeField("requestLogout", "onMyAccountRequestLogout")
    m.myAccount.observeField("requestLanguageSelection", "onMyAccountRequestLanguageSelection")
    m.myAccount.observeField("goToShowMoreScene", "onMyAccountGoToShowMoreScene")
    m.myAccount.observeField("goToInfoScreen", "onMyAccountGoToInfoScreen")
    m.myAccount.observeField("goToPlanDetailsScreen", "onMyAccountGoToPlanDetailsScreen")
    m.myAccount.observeField("requestChangePassword", "onMyAccountRequestChangePassword")
    m.myAccount.ObserveField("goToSplashScreen", "onGoToSplashScreen")
    m.myAccount.ObserveField("closeAllScreens", "onCloseAllScreens")
    ShowScreen(m.myAccount)
end sub

sub onMyAccountGoBack()
    CloseScreen(m.myAccount)
end sub

sub onMyAccountGoToMyListScreen()
    ShowMyListScreen()
end sub

sub onMyAccountRequestLogout()
    CloseScreen(m.myAccount)
    m.homeScene.triggerLogoutWarning = true
end sub

sub onMyAccountRequestLanguageSelection()
    CloseScreen(m.myAccount)
    m.homeScene.triggerLanguageSelection = true
end sub

sub onMyAccountGoToInfoScreen()
    ShowInfoTextScreen(m.myAccount.goToInfoScreen)
end sub

sub onMyAccountGoToShowMoreScene()
    data = m.myAccount.goToShowMoreScene
    if data = invalid then return
    utilityAssoc = {
        id: data.key,
        tagType: data.type,
        title: data.title
    }
    ShowShowMoreScene(utilityAssoc)
end sub

sub onMyAccountGoToPlanDetailsScreen()
    ShowPlanDetailsScreen()
end sub

sub onMyAccountRequestChangePassword()
    m.Landing = CreateObject("roSGNode", "Landing")
    m.Landing.observeField("closethispage", "onChangePasswordLandingClose")
    ShowScreen(m.Landing)
    m.Landing.triggerForgotPassword = true
end sub

sub onChangePasswordLandingClose()
    CloseScreen(m.Landing)
end sub

sub onCloseAllScreens()
    CloseAllScreen()
end sub
