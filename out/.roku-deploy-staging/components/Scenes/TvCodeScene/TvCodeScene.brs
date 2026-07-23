
sub init()

    m.indexButtonGo = 0
    m.indexButtonBack = 1
    m.indexButtonPasswordShowHide = 0
    m.indexButtonPasswordGo = 1
    m.indexButtonPasswordBack = 2


    m.TvCodeSceneBackground = m.top.findNode("TvCodeSceneBackground")
    m.TvCodeSceneBackground.color = getBackGroundColor()
    m.isLoggedInCheckTimer = m.top.findNode("isLoggedInCheckTimer")
    m.isLoggedInCheckTimer.ObserveField("fire", "callCheckLoggedInApiTAsk")
    'm.top.NewCodeButton = m.top.CreateChild("Button")

    ' dialog box
    ' m.loadingIndicator = m.top.findNode("loading")
    ' m.loadingIndicator.visible = true

    m.logindialogbg_rect = m.top.findNode("logindialogbg_rect")
    m.logindialogmain_rect = m.top.findNode("logindialogmain_rect")
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")

    m.logindialogmessage_label = m.top.findNode("logindialogmessage_label")

    m.LoginViaEmail_Label = m.top.findNode("LoginViaEmail_Label")
    m.LoginWithCredentials_Label = m.top.findNode("LoginWithCredentials_Label")

    m.LoginWithCredentials_button = m.top.findNode("LoginWithCredentials_button")
    m.LoginWithCredentials_button.getChild(0).blendColor = getButtonSelectionColor()
    m.LoginWithCredentials_button.ObserveField("buttonSelected", "OnLoginWithCredentials")


    m.LoginViaEmail_button = m.top.findNode("LoginViaEmail_button")
    m.LoginViaEmail_button.getChild(0).blendColor = getButtonSelectionColor()
    m.LoginViaEmail_button.ObserveField("buttonSelected", "OnLoginViaEmail_button")
    m.loginpopupAlertDialogVisible = false



    ' **************************Two Ways To Sign In
    m.top.TwoWaysToSignIn = m.top.CreateChild("Label")
    ' m.top.TwoWaysToSignIn.text = "Two Ways To Sign In"

    
        m.top.TwoWaysToSignIn.text = getText("two_ways_signin")



    m.top.TwoWaysToSignIn.translation = "[149, 202]"
    m.top.TwoWaysToSignIn.color = getTextColor()
    m.top.TwoWaysToSignIn.width = 710
    m.top.TwoWaysToSignIn.height = 500
    ' m.top.SubmitText.font = font
    m.top.TwoWaysToSignIn.font = "font:LargeBoldSystemFont"
    m.top.TwoWaysToSignIn.font.size = 60


    ' **************************On the web
    m.top.OntheWeb = m.top.CreateChild("Label")
    
        m.top.OntheWeb.text = getText("on_web")
   

    m.top.OntheWeb.horizAlign = "left"
    m.top.OntheWeb.translation = "[149, 276]"
    m.top.OntheWeb.color = getTextColor()
    m.top.OntheWeb.width = 628
    m.top.OntheWeb.height = 510
    ' m.top.SubmitText.font = font
    m.top.OntheWeb.font = "font:LargeBoldSystemFont"
    m.top.OntheWeb.font.size = 60


    ' **************************Go to web link
    m.top.GoTo = m.top.CreateChild("Label")
    m.top.GoTo.text = ""
    m.top.GoTo.horizAlign = "left"
    m.top.GoTo.translation = "[175, 392]"
    m.top.GoTo.color = getTextColor()
    m.top.GoTo.width = 800
    m.top.GoTo.height = 510
    ' m.top.SubmitText.font = font
    m.top.GoTo.font.size = 30



    ' '**************************next line web link
    ' '**************************On the web
    ' m.top.weblink = m.top.CreateChild("Label")
    ' m.top.weblink.text = ""
    ' m.top.weblink.horizAlign = "left"
    ' m.top.weblink.translation = "[171, 340]"
    ' m.top.weblink.color = getTextColor()
    ' m.top.weblink.width = 628
    ' m.top.weblink.height = 510
    ' ' m.top.SubmitText.font = font
    ' m.top.weblink.font.size = 25



    ' ***********************Signincreateaccount text
    m.top.SigninOrCreateAccount = m.top.CreateChild("Label")
    m.top.SigninOrCreateAccount.text = getText("signin_or_create")


    m.top.SigninOrCreateAccount.horizAlign = "left"
    m.top.SigninOrCreateAccount.translation = "[175, 436]"

    m.top.SigninOrCreateAccount.color = getTextColor()
    m.top.SigninOrCreateAccount.width = 680
    m.top.SigninOrCreateAccount.height = 510
    m.top.SigninOrCreateAccount.font.size = 30


    ' nextline enter the following code
    m.top.EnterTheFollowingCode = m.top.CreateChild("Label")

    m.top.EnterTheFollowingCode.text = getText("enter_the_code")


    m.top.EnterTheFollowingCode.horizAlign = "left"
    m.top.EnterTheFollowingCode.translation = "[175, 481]"

    m.top.EnterTheFollowingCode.color = getTextColor()
    m.top.EnterTheFollowingCode.width = 628
    m.top.EnterTheFollowingCode.height = 510
    ' m.top.SubmitText.font = font
    m.top.EnterTheFollowingCode.font.size = 30


    'CODE
    m.top.code = m.top.CreateChild("Label")
    m.top.code.text = ""
    m.top.code.horizAlign = "left"
    m.top.code.translation = "[174, 605]"

    m.top.code.color = getTextColor()
    m.top.code.width = 628
    m.top.code.height = 510
    m.top.code.font = "font:LargeBoldSystemFont"

    m.top.code.font.size = 75

    'When connected this page
    m.top.WhenConnectedThisPage = m.top.CreateChild("Label")
    m.top.WhenConnectedThisPage.text = getText("page_automatically_updates")


    m.top.WhenConnectedThisPage.horizAlign = "left"
    m.top.WhenConnectedThisPage.translation = "[175, 794]"
    m.top.WhenConnectedThisPage.color = getTextColor()
    m.top.WhenConnectedThisPage.width = 590
    m.top.WhenConnectedThisPage.height = 90
    m.top.WhenConnectedThisPage.font.size = 29
    m.top.WhenConnectedThisPage.wrap = true


    'next line automatically updates
    ' m.top.AutomaticallyUpdates = m.top.CreateChild("Label")
    ' m.top.AutomaticallyUpdates.text = ""
    ' m.top.AutomaticallyUpdates.horizAlign = "left"
    ' m.top.AutomaticallyUpdates.translation = "[163, 861]"
    ' m.top.AutomaticallyUpdates.color = getTextColor()
    ' m.top.AutomaticallyUpdates.width = 700
    ' m.top.AutomaticallyUpdates.height = 510
    ' m.top.AutomaticallyUpdates.font.size = 30


    'OR_Text
    m.top.OR_Text = m.top.CreateChild("Label")
    
        m.top.OR_Text.text = getText("or")
    


    m.top.OR_Text.translation = "[861, 532]"
    m.top.OR_Text.color = getTextColor()
    m.top.OR_Text.width = 628
    m.top.OR_Text.height = 510
    ' m.top.SubmitText.font = font
    m.top.OR_Text.font = "font:LargeBoldSystemFont"
    m.top.OR_Text.font.size = 70



    ' **************************Scan OR Code
    m.top.ScanQRCode = m.top.CreateChild("Label")

    m.top.ScanQRCode.text = getText("scan_qr")





    m.top.ScanQRCode.translation = "[1029, 205]"
    m.top.ScanQRCode.color = getTextColor()
    m.top.ScanQRCode.width = 700
    m.top.ScanQRCode.height = 500
    ' m.top.SubmitText.font = font
    m.top.ScanQRCode.font = "font:LargeBoldSystemFont"
    m.top.ScanQRCode.font.size = 60


    'Use the camera app or scan QR code
    m.top.UseTheCameraApp = m.top.CreateChild("Label")
    
        m.top.UseTheCameraApp.text = getText("use_cam_app")
  

    m.top.UseTheCameraApp.horizAlign = "left"
    m.top.UseTheCameraApp.translation = "[1055, 310]"
    m.top.UseTheCameraApp.color = getTextColor()
    m.top.UseTheCameraApp.width = 600
    m.top.UseTheCameraApp.height = 90
    m.top.UseTheCameraApp.font.size = 29
    m.top.UseTheCameraApp.wrap = true


    'code reader on your mobile device
    ' m.top.QrCodeReader = m.top.CreateChild("Label")
    ' m.top.QrCodeReader.text = ""
    ' m.top.QrCodeReader.horizAlign = "left"
    ' m.top.QrCodeReader.translation = "[1058, 351]"
    ' m.top.QrCodeReader.color = getTextColor()
    ' m.top.QrCodeReader.width = 800
    ' m.top.QrCodeReader.height = 510
    ' m.top.QrCodeReader.font.size = 30


    'QR Code Image
    m.QRCodeImage = m.top.findNode("QRCodeImage")


    'Make sure QR code is visible
    m.top.MakeSureQrCode = m.top.CreateChild("Label")
    
        m.top.MakeSureQrCode.text = getText("make_sure_qr_visible")
   

    m.top.MakeSureQrCode.horizAlign = "left"
    m.top.MakeSureQrCode.color = getTextColor()
    m.top.MakeSureQrCode.wrap = true
    m.top.MakeSureQrCode.maxLines = 3
    m.top.MakeSureQrCode.numLines = 3
    m.top.MakeSureQrCode.translation = "[1055, 777]"
    m.top.MakeSureQrCode.width = 600
    m.top.MakeSureQrCode.height = 90
    m.top.MakeSureQrCode.font.size = 29





    'next line on your device screen
    ' m.top.VisibleOnYourDevice = m.top.CreateChild("Label")
    ' m.top.VisibleOnYourDevice.text = ""
    ' m.top.VisibleOnYourDevice.horizAlign = "left"
    ' m.top.VisibleOnYourDevice.translation = "[1058, 808]"
    ' m.top.VisibleOnYourDevice.color = getTextColor()
    ' m.top.VisibleOnYourDevice.width = 800
    ' m.top.VisibleOnYourDevice.height = 510
    ' m.top.VisibleOnYourDevice.font.size = 30



    'New code button
    m.top.NewCodeButton = m.top.CreateChild("Button")

    
        m.top.NewCodeButton.text = getText("get_new_code")
 

    m.top.NewCodeButton.focusedColor = "#ffffff"
    m.top.NewCodeButton.iconUri = ""
    m.top.NewCodeButton.focusedIconUri = ""
    m.top.NewCodeButton.color = getTextColor()
    m.top.NewCodeButton.focusedTextColor = "#ffffff"
    m.top.NewCodeButton.minWidth = 138
    ' m.top.NewCodeButton.focusedFont = font
    m.top.NewCodeButton.translation = [744, 935]
    m.top.NewCodeButton.focusFootprintBitmapUri = "pkg:/images/img_itemcatbg.png"
    m.top.NewCodeButton.focusBitmapUri = "pkg:/images/img_itemcatbg_selected.png"
    m.top.NewCodeButton.getChild(0).blendColor = getButtonSelectionColor()
    ' m.top.NewCodeButton.getChild(1).blendColor = "#313033"
    m.top.NewCodeButton.height = 80
    m.top.NewCodeButton.showFocusFootprint = true
    m.top.NewCodeButton.ObserveField("buttonSelected", "OnNewTvCodeButtonSelected")


    'Other ways to sign in
    m.top.OtherWaysToSignIn = m.top.CreateChild("Label")

   
        m.top.OtherWaysToSignIn.text = getText("sign_in_via_email_password")
  



    m.top.OtherWaysToSignIn.horizAlign = "left"
    m.top.OtherWaysToSignIn.translation = "[1310, 949]"
    m.top.OtherWaysToSignIn.color = getTextColor()
    m.top.OtherWaysToSignIn.width = 800
    m.top.OtherWaysToSignIn.height = 510
    m.top.OtherWaysToSignIn.font = "font:MediumBoldSystemFont"
    m.top.OtherWaysToSignIn.font.size = 35
    m.top.OtherWaysToSignIn.observeField("focusedChild", "OnOtherWaysToSignInFocused")

    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogOutAll")
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    ' m.top.dialogAuthExceed.title = "Login Limit Exceeded!. Please logout from all devices to continue."

   
        m.top.dialogAuthExceed.title = getText("reached_maximum_device_message")
    

    
        okTitle = getText("ok") ' Default value


    ' Set "Logout All" button text
  
        logoutAllTitle = getText("logout_all") ' Default value
    


    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected1")

    m.top.loading = m.top.CreateChild("Loading")
    m.top.loading.visible = false
    m.top.observeField("visible", "OnTopVisibleChange")

    ' Main dialog labels
m.logindialogmessage_label.color = getTextColor()
m.LoginViaEmail_Label.color = getTextColor()
m.LoginWithCredentials_Label.color = getTextColor()

    callGetCodeApiTask()
end sub


sub dialog2()

    m.top.dialogErrEmails = CreateObject("roSGNode", "Dialog")
    m.top.dialogErrEmails.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrEmails.title = ""
    m.top.dialogErrEmails.message = ""
    m.top.dialogErrEmails.buttons = ["OK"]
    m.top.dialogErrEmails.ObserveField("buttonSelected", "On_dialogErrEmail_buttonSelected")
end sub


function showsignindialog()
    if m.parentScene = invalid
        GetParentScene()
    end if

    m.top.signindialog = CreateObject("roSGNode", "Dialog")
    m.top.signindialog.backgroundUri = "pkg:/images/black.jpg"
    m.top.signindialog.title = "Choose login to sign in"
    ' m.top.signindialog.focusBitmapUri = "pkg:/images/star.png"
    ' m.top.signindialog.focusedIconUri = "pkg:/images/star.png"
    m.top.signindialog.optionsDialog = true
    m.top.signindialog.showFocusFootprint = true
    m.top.signindialog.buttons = ["Sign in via email", "Sign in using credentials"]
    m.top.signindialog.ObserveField("buttonSelected", "OnLoginViaEmail_button")
    m.top.signindialog.ObserveField("buttonSelected", "OnLoginWithCredentials")
    m.parentScene.dialog = m.top.signindialog


end function


function GetParentScene() as object
    m.parentScene = m.top.GetParent()
    while m.parentScene <> invalid
        grandParent = m.parentScene.GetParent()
        if grandParent = invalid then
            exit while
        end if
        m.parentScene = grandParent
    end while
    return m.parentScene
end function





sub showChooseSignInPopUp()
    ?"showchoosesigninpopup"

    m.logindialogmessage_label.text = "Choose Sign In"
    m.LoginViaEmail_Label.text = "Via Email"
    m.LoginWithCredentials_Label.text = "Via Credentials"
    ' m.dialogbg_rect.visible = true
    m.logindialogbg_rect.visible = true
    ' m.loginviaemailvisible = true
    ' m.YesButton.setFocus(true)
    m.loginpopupAlertDialogVisible = true
    ' m.LoginWithCredentials_button.setFocus(true)
    m.LoginViaEmail_button.setFocus(true)
    ' m.loadingIndicator.visible = false
    ' m.loadingIndicator.visible = false
    ' m.logindialogmain_rect.visible=true


end sub

sub OnLoginViaEmail_button()
    if GetParentScene() = invalid then
        return
    end if

    if m.top.signindialog.buttonSelected = m.indexButtonGo then
        m.isLoggedInCheckTimer.control = "stop"
        m.top.goToEmailLoginScreen = true
        m.parentScene.dialog.close = invalid
        ' m.signindialog.dialog = m.top.signindialog
        '     end if
    end if
end sub

sub OnLoginWithCredentials()
    if GetParentScene() = invalid then
        return
    end if

    if m.top.signindialog.buttonSelected = m.indexButtonBack then
        m.isLoggedInCheckTimer.control = "stop"
        m.top.goToLoginScene = true
        m.parentScene.dialog.close = invalid
    end if
end sub


sub OnTopVisibleChange()
    ?"OnTopVisibleChange : TVCodeScene called"
    if m.top.visible = true
        callGetCodeApiTask()
    end if
end sub


sub callGetCodeApiTask()
    if getUserIdana() <> invalid and getUserIdana() <> ""
        m.GetCodeApiTask = CreateObject("roSGNode", "GetCodeApiTask")
        m.GetCodeApiTask.ObserveField("GetCodeApiTaskListStatus", "OnGetCodeApiTaskListContent")
        m.GetCodeApiTask.callFunc("runGetCodeApiTask", "")
    else
        ?"callGetCodeApiTask222"
        m.GuestFetcher = CreateObject("roSGNode", "GuestFetcher")
        m.GuestFetcher.observeField("GuestResponse", "callGetCodeApiTask")
        m.GuestFetcher.callFunc("runGuestFetcher", "")
    end if
end sub

sub OnGetCodeApiTaskListContent()
    if m.GetCodeApiTask.GetCodeApiTaskContent <> invalid
        content = m.GetCodeApiTask.GetCodeApiTaskContent
        
            m.top.GoTo.text = getText("go_to") + " " + content.url
      


        m.top.code.text = content.code
        m.QRCodeImage.uri = content.qr
        m.isLoggedInCheckTimer.control = "stop"
        m.isLoggedInCheckTimer.control = "start"
        m.top.loading.visible = false
    end if
end sub

sub callCheckLoggedInApiTAsk()
    ?"callCheckLoggedInApiTAsk called"
    if m.GetCodeApiTask.GetCodeApiTaskContent <> invalid and m.GetCodeApiTask.GetCodeApiTaskContent.code <> invalid
        m.CheckLoggedInApiTask = CreateObject("roSGNode", "CheckLoggedInApiTask")
        m.CheckLoggedInApiTask.ObserveField("CheckLoggedInApiTaskListStatus", "callUserSubscriptionApi")
        m.CheckLoggedInApiTask.code = m.GetCodeApiTask.GetCodeApiTaskContent.code
        m.CheckLoggedInApiTask.callFunc("runCheckLoggedInApiTask", m.GetCodeApiTask.GetCodeApiTaskContent.code)
    end if
end sub


sub callUserSubscriptionApi()
    m.UserSubscription = CreateObject("roSGNode", "UserSubscription")
    m.UserSubscription.observeField("SubsResponse", "checkUserLoggedInLimit")
    m.top.loading.visible = true
    m.UserSubscription.callFunc("runUserSubscription", "")
end sub

sub checkUserLoggedInLimit()
    if m.UserSubscription <> invalid and m.UserSubscription.UserSubResponseData <> invalid and m.UserSubscription.UserSubResponseData.forcibleLogout <> invalid
        forcibleLogout = m.UserSubscription.UserSubResponseData.forcibleLogout
    else
        forcibleLogout = false
    end if

    if m.UserSubscription <> invalid and m.UserSubscription.UserSubResponseData <> invalid and m.UserSubscription.UserSubResponseData.session_expired <> invalid
        session_expired = m.UserSubscription.UserSubResponseData.session_expired
    else
        session_expired = false
    end if

    if forcibleLogout = true ' user logged in limit - case
        m.parentScene = GetParentScene()
        m.parentScene.dialog = m.top.dialogAuthExceed
        m.isLoggedInCheckTimer.control = "stop"
        m.top.loading.visible = false
    else
        OnCheckLoggedInApiTaskListContent() ' normal login flow
    end if
end sub

sub On_dialogAuthExceed_buttonSelected1()
    OnNewTvCodeButtonSelected()
    if m.top.dialogAuthExceed.buttonSelected = 0
        m.parentScene.dialog.close = true
        m.top.loading.visible = false
    else if m.top.dialogAuthExceed.buttonSelected = 1
        m.LogoutTaskAll.callFunc("runLogoutTask", "")
        m.top.loading.visible = true
    end if
    m.isLoggedInCheckTimer.control = "stop"
    m.isLoggedInCheckTimer.control = "start"
end sub

sub OnLogOutAll()
    m.parentScene.dialog.close = true
    m.top.loading.visible = false
end sub


sub OnCheckLoggedInApiTaskListContent()
    ?"OnCheckLoggedInApiTaskListContent called"
    m.isLoggedInCheckTimer.control = "stop"
    ' m.top.closethispage = "true"
    m.top.gotoHomeScene = true
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ?"onKeyEvent called"
    ?"key: ";key
    ?"press: ";press
    handled = false
    if press = false

        if key = "left" and m.loginpopupAlertDialogVisible
            m.LoginViaEmail_button.setFocus(true)
        end if

        if key = "right" and m.loginpopupAlertDialogVisible
            m.LoginWithCredentials_button.setFocus(true)
        end if

        if key = "down" then
            if m.top.OtherWaysToSignIn.hasFocus() = false and m.top.NewCodeButton.hasFocus() = false
                m.top.NewCodeButton.setFocus(true)
            end if
        else if key = "right" then
            if m.top.NewCodeButton.hasFocus()
                m.top.OtherWaysToSignIn.setFocus(true)
            end if
        else if key = "left" then
            if m.top.OtherWaysToSignIn.hasFocus() then
                m.top.NewCodeButton.setFocus(true)
            end if

        end if

    end if

    if press = true
        if key = "OK" then
            if m.top.OtherWaysToSignIn.hasFocus()
                m.isLoggedInCheckTimer.control = "stop"
                m.isLoggedInCheckTimer.control = "stop"
                m.top.goToLoginChooseScene = true

            else if m.LoginViaEmail_button.hasFocus()
                OnLoginViaEmail_button()

            else if m.LoginWithCredentials_button.hasFocus()
                OnLoginWithCredentials()

            end if



        else if key = "back" then
            m.isLoggedInCheckTimer.control = "stop"
        end if
    end if
    return handled
end function



'''''''''
' OnNewTvCodeButtonSelected:
'
' @return {dynamic}
'''''''''
function OnNewTvCodeButtonSelected()
    ' ?"OnNewTvCodeButtonSelected called"
    m.top.loading.visible = true
    callGetCodeApiTask()
end function

function OnOtherWaysToSignInFocused()
    ' ?"OnOtherWaysToSignInFocused called"
    if m.top.OtherWaysToSignIn.hasFocus() then
        m.top.OtherWaysToSignIn.color = getButtonSelectionColor()
    else
        m.top.OtherWaysToSignIn.color = getTextColor()  
    end if
end function