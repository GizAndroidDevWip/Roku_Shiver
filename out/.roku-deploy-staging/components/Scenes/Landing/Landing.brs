sub init()
    m.TVCodeTextEditBox = m.top.findNode("TVCodeTextEditBox")
    m.TVCodeTextEditBox.textColor = getTextColor()
    m.TVCodeTextEditBox.hintTextColor = "#5a5a5a"
    if getTheme() = "LIGHT"
        m.TVCodeTextEditBox.getChild(0).blendColor = "#121212"
    end if
    m.EmailAddress_texteditbox = m.top.findNode("EmailAddress_texteditbox")
    m.EmailAddress_texteditbox.getChild(0).uri = "pkg:/images/img_itemcatbg_selected.png"
    m.EmailAddress_texteditbox.hintTextColor = "#5a5a5a"
    m.EmailAddress_texteditbox.color = "#c9c9c9"
    m.EmailAddress_texteditbox.textColor = getTextColor()
    ' if getTheme() = "LIGHT"
    '     m.EmailAddress_texteditbox.getChild(0).blendColor = "#4E545C"
    ' else
    m.EmailAddress_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    ' end if
    m.EmailAddress_texteditbox.hintText = getTextOf("email_address")
    m.EmailAddress_texteditbox.observeField("focusedChild", "onEmailPasswordTextEditBoxFocusChanged")

    m.password_TextEditBox = m.top.findNode("password_TextEditBox")
    m.password_TextEditBox.getChild(0).uri = "pkg:/images/img_itemcatbg_selected.png"
    m.password_TextEditBox.hintTextColor = "#5a5a5a"
    m.password_TextEditBox.textColor = getTextColor()
    ' if getTheme() = "LIGHT"
    '     m.password_TextEditBox.getChild(0).blendColor = "#4E545C"
    ' else
    m.password_TextEditBox.getChild(0).blendColor = "#2a2e32ff"
    ' end if


    m.password_TextEditBox.hintText = getTextOf("enter_password")

    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor()
    m.password_TextEditBox.observeField("focusedChild", "onPasswordTextEditBoxFocusChanged")
    m.GuestFetcher = CreateObject("roSGNode", "GuestFetcher")
    m.GuestFetcher.observeField("GuestResponse", "OnGuestResponse")
    m.LoginTask = CreateObject("roSGNode", "LoginTask")
    m.LoginTask.observeField("LoginResponse", "callUserSubscriptionApi")
    m.RegTask = CreateObject("roSGNode", "RegTask")
    m.RegTask.observeField("RegResponse", "OnRegResponse")
    m.OtpTask = CreateObject("roSGNode", "OtpTask")
    m.OtpTask.observeField("OtpResponse", "OnOtpResponse")
    m.CodeTask = CreateObject("roSGNode", "CodeTask")
    m.CodeTask.observeField("CodeResponse", "OnCodeResponse")
    m.ResendTask = CreateObject("roSGNode", "ResendTask")
    m.ResendTask.observeField("ResendResponse", "OnResendResponse")
    m.ForgotFetcher = CreateObject("roSGNode", "ForgotFetcher")
    m.ForgotFetcher.observeField("ForgotResponse", "OnForgotResponseDailog")
    m.count = 0
    m.top.signInToTvLabel = m.top.findNode("signInToTvLabel")

    m.deviceId = "roku"
    m.indexButtonGo = 0
    m.indexButtonBack = 1
    m.indexButtonPasswordShowHide = 0
    m.indexButtonPasswordGo = 1
    m.indexButtonPasswordBack = 2
    m.indexButtonOtpGo = 3
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogoutResponse")
    m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    m.buttonsLabelList.ObserveField("itemSelected", "onButtonsLabelList")
    m.buttonsLabelList.ObserveField("itemFocused", "onButtonsLabelListFocused")
    m.buttonsLabelList.focusBitmapBlendColor = getButtonSelectionColor()
    m.buttonsLabelList.color = getTextColor()
    m.buttonsLabelList.focusedColor = "#FFFFFF"
    initialiseButtonsLabelList()
    m.top.dialogErrEmail = CreateObject("roSGNode", "BackDialog")
    m.top.dialogErrEmail.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrEmail.title = "Email input error"
    m.top.dialogErrEmail.message = "Please enter a valid email address"
    m.top.dialogErrEmail.buttons = ["OK"]
    m.top.dialogErrEmail.ObserveField("buttonSelected", "On_dialogErrEmail_buttonSelected")

    m.top.dialogForgot = CreateObject("roSGNode", "BackDialog")
    m.top.dialogForgot.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogForgot.title = getText("email_conformation")
    m.top.dialogForgot.message = getText("please_check_mail")
    m.top.dialogForgot.buttons = ["OK"]
    m.top.dialogForgot.ObserveField("buttonSelected", "On_dialogForgot_buttonSelected")

    m.top.dialogForgotFailed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogForgotFailed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogForgotFailed.title = "Error"
    m.top.dialogForgotFailed.message = "Something Gone Wrong .Try Again Later!"
    m.top.dialogForgotFailed.buttons = ["OK"]
    m.top.dialogForgotFailed.ObserveField("buttonSelected", "On_dialogForgotFailed_buttonSelected")

    m.top.dialogErrEmailForgot = CreateObject("roSGNode", "BackDialog")
    m.top.dialogErrEmailForgot.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrEmailForgot.title = getText("error_message")
    m.top.dialogErrEmailForgot.message = getText("valid_email_message")
    m.top.dialogErrEmailForgot.buttons = ["OK"]
    m.top.dialogErrEmailForgot.ObserveField("buttonSelected", "On_dialogErrEmailForgot_buttonSelected")

    m.top.dialogErrPassword = CreateObject("roSGNode", "BackDialog")
    m.top.dialogErrPassword.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrPassword.title = "Password input error"
    m.top.dialogErrPassword.message = "Atleast 6 characters"
    m.top.dialogErrPassword.buttons = ["OK"]
    m.top.dialogErrPassword.ObserveField("buttonSelected", "On_dialogErrPassword_buttonSelected")

    m.top.kbdialogEmailReg = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogEmailReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.kbdialogEmailReg.title = getText("email_placeholder")
    m.top.kbdialogEmailReg.text = ""
    m.top.kbdialogEmailReg.buttons = ["Continue", "Back"]
    m.top.kbdialogEmailReg.ObserveField("buttonSelected", "On_kbdialogEmailReg_buttonSelected")

    m.top.kbdialogPasswordReg = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogPasswordReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.kbdialogPasswordReg.title = getText("password")

    m.top.kbdialogPasswordReg.text = ""
    m.top.kbdialogPasswordReg.buttons = ["Show/hide password", "Continue", "Back"]
    m.top.kbdialogPasswordReg.keyboard.textEditBox.secureMode = true
    m.top.kbdialogPasswordReg.ObserveField("buttonSelected", "On_kbdialogPasswordReg_buttonSelected")

    m.top.kbdialogOtpReg = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogOtpReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.kbdialogOtpReg.title = getText("otp_message")
    m.top.kbdialogOtpReg.text = ""
    continue = getText("continue")
    cancel = getText("cancel")
    cancel = getText("cancel")

    resend_otp = getText("resend_otp")


    m.top.kbdialogOtpReg.buttons = [continue, cancel, resend_otp]
    m.top.kbdialogOtpReg.ObserveField("buttonSelected", "On_kbdialogOtpReg_buttonSelected")
    m.top.kbdialogOtp = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogOtp.backgroundUri = "pkg:/images/black.jpg"
    m.top.kbdialogOtp.title = getText("otp_message")



    m.top.kbdialogOtp.text = ""
    m.top.kbdialogOtp.buttons = [continue, cancel, resend_otp]
    m.top.kbdialogOtp.ObserveField("buttonSelected", "On_kbdialogOtp_buttonSelected")


    m.top.dialogErrEmailReg = CreateObject("roSGNode", "BackDialog")
    m.top.dialogErrEmailReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrEmailReg.title = "Email input error"
    m.top.dialogErrEmailReg.message = "Please enter a valid email address"
    m.top.dialogErrEmailReg.buttons = ["OK"]
    m.top.dialogErrEmailReg.ObserveField("buttonSelected", "On_dialogErrEmailReg_buttonSelected")

    m.top.dialogErrPasswordReg = CreateObject("roSGNode", "BackDialog")
    m.top.dialogErrPasswordReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrPasswordReg.title = "Password input error"
    m.top.dialogErrPasswordReg.message = "Atleast 6 characters"
    m.top.dialogErrPasswordReg.buttons = ["OK"]
    m.top.dialogErrPasswordReg.ObserveField("buttonSelected", "On_dialogErrPasswordReg_buttonSelected")

    m.top.dialogErrName = CreateObject("roSGNode", "BackDialog")
    m.top.dialogErrName.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogErrName.title = "Name input error"
    m.top.dialogErrName.message = "Please enter a valid Full Name"
    m.top.dialogErrName.buttons = ["OK"]
    m.top.dialogErrName.ObserveField("buttonSelected", "On_dialogErrName_buttonSelected")

    m.top.pdialogAuth = CreateObject("roSGNode", "ProgressDialog")
    m.top.pdialogAuth.backgroundUri = "pkg:/images/black.jpg"

    m.top.pdialogAuth.title = getText("please_wait")

    m.top.dialogAuthFailed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailed.title = "Error"
    m.top.dialogAuthFailed.message = ""

    try_again_message = getText("try_again_message")

    cancel = getText("cancel")

    m.top.dialogAuthFailed.buttons = [try_again_message, cancel]

    m.top.dialogAuthFailed.ObserveField("buttonSelected", "On_dialogAuthFailed_buttonSelected")

    m.top.dialogAuthFailedReg = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailedReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailedReg.title = "Registration failed"
    m.top.dialogAuthFailedReg.buttons = ["Cancel"]
    m.top.dialogAuthFailedReg.ObserveField("buttonSelected", "On_dialogAuthFailedReg_buttonSelected")

    m.top.dialogAuthFailedCode = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailedCode.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailedCode.title = "Invalid Code! Please Try Again"
    m.top.dialogAuthFailedCode.buttons = ["Cancel"]
    m.top.dialogAuthFailedCode.ObserveField("buttonSelected", "On_dialogAuthFailedCode_buttonSelected")


    m.top.dialogAuthFailedRegOtpResend = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailedRegOtpResend.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailedRegOtpResend.title = "OTP resend failed"
    m.top.dialogAuthFailedRegOtpResend.buttons = ["Cancel"]
    m.top.dialogAuthFailedRegOtpResend.ObserveField("buttonSelected", "On_dialogAuthFailedRegOtpResend_buttonSelected")

    m.top.dialogAuthFailedRegOtpResendSuccess = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailedRegOtpResendSuccess.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailedRegOtpResendSuccess.title = "OTP Resend Successfully"
    m.top.dialogAuthFailedRegOtpResendSuccess.buttons = ["OK"]
    m.top.dialogAuthFailedRegOtpResendSuccess.ObserveField("buttonSelected", "On_dialogAuthFailedRegOtpResendSuccess_buttonSelected")


    m.top.dialogAuthExists = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExists.backgroundUri = "pkg:/images/black.jpg"


    m.top.dialogAuthExists.title = getText("existing_user_message")

    ok = getText("ok")

    m.top.dialogAuthExists.buttons = [ok]
    m.top.dialogAuthExists.ObserveField("buttonSelected", "On_dialogAuthExists_buttonSelected")

    m.Timer = m.top.findNode("Timer")
    m.Timer.control = "start"
    m.Timer.observeField("fire", "change")
    m.Timer.observeField("state", "changes")


    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Bold.ttf"
    font.size = 35

    m.top.buttonLogin = m.top.CreateChild("Button")
    m.top.buttonLogin.text = getText("submit")
    m.top.buttonLogin.focusedColor = "#ffffff"
    m.top.buttonLogin.iconUri = ""
    m.top.buttonLogin.focusedIconUri = ""
    m.top.buttonLogin.textColor = "#ffffff"
    m.top.buttonLogin.focusedTextColor = "#ffffff"
    m.top.buttonLogin.minWidth = 138
    m.top.buttonLogin.focusedFont = font
    m.top.buttonLogin.translation = [375, 790]
    m.top.buttonLogin.focusFootprintBitmapUri = "pkg:/images/img_itemcatbg.png"
    m.top.buttonLogin.focusBitmapUri = "pkg:/images/img_itemcatbg_selected.png"
    m.top.buttonLogin.getChild(0).blendColor = getButtonSelectionColor()
    m.top.buttonLogin.height = 80
    m.top.buttonLogin.visible = false
    m.top.buttonLogin.showFocusFootprint = true
    m.top.buttonLogin.ObserveField("buttonSelected", "On_Login")

    m.top.Login4BtrExprnce = m.top.CreateChild("Label")
    m.top.Login4BtrExprnce.text = "Login for a better experience"
    m.top.Login4BtrExprnce.translation = "[175, 200]"
    m.top.Login4BtrExprnce.textColor = "#ffffff"
    m.top.Login4BtrExprnce.width = 700
    m.top.Login4BtrExprnce.height = 500
    m.top.Login4BtrExprnce.font.size = 45
    m.top.Login4BtrExprnce.visible = false

    m.top.LinkText = m.top.CreateChild("Label")
    m.top.LinkText.text = getTvCodeUrl()
    m.top.LinkText.translation = "[175, 300]"
    m.top.LinkText.horizAlign = "center"
    m.top.LinkText.textColor = "#ffffff"
    m.top.LinkText.width = 628
    m.top.LinkText.height = 510
    m.top.LinkText.font.size = 29
    m.top.LinkText.visible = false

    m.top.or_text = m.top.CreateChild("Label")
    m.top.or_text.text = "Or"
    m.top.or_text.translation = "[450, 342]"
    m.top.or_text.textColor = "#ffffff"
    m.top.or_text.width = 628
    m.top.or_text.height = 510

    m.top.or_text.font.size = 29
    if getTvCodeUrl() = invalid or getTvCodeUrl() = ""
        m.top.or_text.visible = false
    end if
    m.top.or_text.visible = false


    m.top.signcreateaccntText = m.top.CreateChild("Label")


    m.top.signcreateaccntText.text = getText("signin_or_create")


    m.top.signcreateaccntText.horizAlign = "center"
    m.top.signcreateaccntText.translation = "[175, 379]"
    m.top.signcreateaccntText.textColor = "#ffffff"
    m.top.signcreateaccntText.width = 628
    m.top.signcreateaccntText.height = 510

    m.top.signcreateaccntText.font.size = 29
    m.top.signcreateaccntText.visible = false

    m.top.Androidiostext = m.top.CreateChild("Label")
    m.top.Androidiostext.text = "Android or iOS app and select"
    m.top.Androidiostext.horizAlign = "center"
    m.top.Androidiostext.translation = "[175, 420]"
    m.top.Androidiostext.textColor = "#ffffff"
    m.top.Androidiostext.width = 628
    m.top.Androidiostext.height = 510
    m.top.Androidiostext.font.size = 29
    m.top.Androidiostext.visible = "false"
    m.top.selecttvactivation = m.top.CreateChild("Label")
    m.top.selecttvactivation.text = "TV Activation from menu."
    m.top.selecttvactivation.horizAlign = "center"
    m.top.selecttvactivation.wrap = true
    m.top.selecttvactivation.translation = "[175, 464]"
    m.top.selecttvactivation.textColor = "#ffffff"
    m.top.selecttvactivation.width = 628
    m.top.selecttvactivation.height = 510

    m.top.selecttvactivation.font.size = 29
    m.top.selecttvactivation.visible = "false"


    m.top.buttonLogin2 = m.top.CreateChild("Button")

    m.top.buttonLogin2.text = getText("login")
    m.top.buttonLogin2.focusedColor = "#ffffff"
    m.top.buttonLogin2.textColor = getTextColor()
    m.top.buttonLogin2.focusedTextColor = "#ffffff"
    m.top.buttonLogin2.iconUri = ""
    m.top.buttonLogin2.focusedIconUri = ""
    m.top.buttonLogin2.minWidth = 138
    m.top.buttonLogin2.focusedFont = font
    m.top.buttonLogin2.translation = [908, 584]
    m.top.buttonLogin2.focusBitmapUri = "pkg:/images/img_newbg.9.png"
    m.top.buttonLogin2.getChild(0).blendColor = getButtonSelectionColor()
    m.top.buttonLogin2.showFocusFootprint = true
    m.top.buttonLogin2.ObserveField("buttonSelected", "On_Login2")
    m.top.buttonLogin2.height = 80


    login_with_magic_link = getLOGIN_WITH_MAGIC_LINK_REQUIRED()

    m.keyboarddialog = CreateObject("roSGNode", "KeyboardDialog")
    m.isKeyboardDialogOpenFlag = false
    m.top.loading = m.top.CreateChild("loading")
    m.top.loading.visible = false

    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogOutAll")
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"

    m.top.dialogAuthExceed.title = getText("reached_maximum_device_message")
    okTitle = getText("ok") ' Default value
    logoutAllTitle = getText("logout_all")
    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected1")

    m.top.observeField("triggerForgotPassword", "On_ForgotPassword")
end sub


sub onButtonsLabelList()

    itemSelected = m.buttonsLabelList.itemSelected
    idSelected = m.buttonsLabelList.content.getChild(itemSelected).id
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"

    if idSelected = "New_User"
        On_Signup()


    else if idSelected = "Sign_in_via_email"
        m.top.gotoEmailLoginScene = true

    else if idSelected = "Forgot_Password"
        On_ForgotPassword()

    else if idSelected = "Skip_Login"
        callGuestRegister()

    end if

end sub




sub onButtonsLabelListFocused()
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
end sub

sub initialiseButtonsLabelList()
    m.New_User = createObject("RoSGNode", "ContentNode")
    m.New_User.id = "New_User"
    m.New_User.title = "New User"


    m.Sign_in_via_email = createObject("RoSGNode", "ContentNode")
    m.Sign_in_via_email.id = "Sign_in_via_email"


    m.Sign_in_via_email.title = getText("sign_in_via_email")





    m.Forgot_Password = createObject("RoSGNode", "ContentNode")
    m.Forgot_Password.id = "Forgot_Password"

    m.Forgot_Password.title = getText("forgot_password")



    m.Skip_Login = createObject("RoSGNode", "ContentNode")
    m.Skip_Login.id = "Skip_Login"

    m.Skip_Login.title = getText("skip")





    m.buttonsLabelListItems = []
    m.buttonsLabelListItems.push(m.Forgot_Password)

    if getSKIP_LOGIN_REQUIRED() = "true"
        m.buttonsLabelListItems.push(m.Skip_Login)
    end if

    addbuttonLabelList(m.buttonsLabelListItems)

end sub


sub addbuttonLabelList(nodes as object)
    content = createObject("RoSGNode", "ContentNode")
    m.buttonsLabelList.content = content

    for each node in nodes
        m.buttonsLabelList.content.appendChild(node)
    end for
end sub




sub OnsinginViaEmailGetFocused()

    if m.top.singinViaEmailLabel.hasFocus() then
        m.top.singinViaEmailLabel.color = getButtonSelectionColor()
    else
        m.top.singinViaEmailLabel.color = "#ffffff"

    end if
end sub




function IsFieldEmpty()
    if (m.TVCodeTextEditBox.text <> "") then
        return true
    else
        return false
    end if

end function


sub onFirstNametextEditBoxFocusChanged()
    if m.TVCodeTextEditBox.hasFocus() then
        m.TVCodeTextEditBox.active = true
    else
        m.TVCodeTextEditBox.active = false
    end if
end sub

sub onEmailPasswordTextEditBoxFocusChanged()
    if m.EmailAddress_texteditbox.hasFocus() then
        m.EmailAddress_texteditbox.active = true
        m.EmailAddress_texteditbox.hintTextColor = "#c9c9c9"
        m.EmailAddress_texteditbox.textColor = "#FFFFFF"
        m.EmailAddress_texteditbox.getChild(0).blendColor = "#4E545C"
    else
        m.EmailAddress_texteditbox.active = false
        m.EmailAddress_texteditbox.hintTextColor = "#5a5a5a"
        m.EmailAddress_texteditbox.textColor = getTextColor()
        m.EmailAddress_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    end if
end sub

sub onPasswordTextEditBoxFocusChanged()
    if m.password_TextEditBox.hasFocus() then
        m.password_TextEditBox.active = true
        m.password_TextEditBox.hintTextColor = "#c9c9c9"
        m.password_TextEditBox.textColor = "#FFFFFF"
        m.password_TextEditBox.getChild(0).blendColor = "#4E545C"
    else
        m.password_TextEditBox.active = false
        m.password_TextEditBox.hintTextColor = "#5a5a5a"
        m.password_TextEditBox.textColor = getTextColor()
        m.password_TextEditBox.getChild(0).blendColor = "#2a2e32ff"
    end if
end sub

sub OnNewUserGetFocused()
    if m.top.NewUser.hasFocus() then
        m.top.NewUser.color = getButtonSelectionColor()
    else
        m.top.NewUser.color = "#ffffff"
    end if
end sub


sub OnForgotPasswordGetFocused()
    if m.top.forgotLabel.hasFocus() then
        m.top.forgotLabel.color = getButtonSelectionColor()
    else
        m.top.forgotLabel.color = "#ffffff"
    end if
end sub


sub OnSkipLoginGetFocused()
    if m.top.skipLogin.hasFocus() then
        m.top.skipLogin.color = getButtonSelectionColor()
    else
        m.top.skipLogin.color = "#ffffff"
    end if
end sub


function IsLoginFieldEmpty()
    if(m.EmailAddress_texteditbox.text <> "" and m.password_TextEditBox.text <> "") then
        return true
    else
        return false
    end if
end function



function createNameDialog()
    if m.parentScene = invalid
        GetParentScene()
    end if
    m.top.kbdialogName = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogName.backgroundUri = "pkg:/images/black.jpg"
    m.top.kbdialogName.title = "Enter Full Name"
    m.top.kbdialogName.text = ""
    cancel = getText("cancel")
    continue = getText("continue")
    m.top.kbdialogName.buttons = [continue, cancel]
    m.top.kbdialogName.ObserveField("buttonSelected", "On_kbdialogName_buttonSelected")
    m.parentScene.dialog = m.top.kbdialogName
end function


function createForgotPassword()
    if m.parentScene = invalid
        GetParentScene()
    end if
    m.top.kbdialogEmailForgot = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogEmailForgot.backgroundUri = "pkg:/images/black.jpg"

    m.top.kbdialogEmailForgot.title = getText("reset_password_placeholder")

    m.top.kbdialogEmailForgot.text = ""
    cancel = getText("cancel")
    continue = getText("continue")
    m.top.kbdialogEmailForgot.buttons = [continue, cancel]
    m.top.kbdialogEmailForgot.ObserveField("buttonSelected", "On_kbdialogEmailForgot_buttonSelected")
    m.parentScene.dialog = m.top.kbdialogEmailForgot
end function

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

    if forcibleLogout = true
        m.parentScene = GetParentScene()
        m.parentScene.dialog = m.top.dialogAuthExceed
        m.top.loading.visible = false
    else
        OnLoginResponse()
    end if
end sub

sub On_dialogAuthExceed_buttonSelected1()
    if m.top.dialogAuthExceed.buttonSelected = 0
        m.parentScene.dialog.close = true
        m.top.loading.visible = false
    else if m.top.dialogAuthExceed.buttonSelected = 1
        m.LogoutTaskAll.callFunc("runLogoutTask", "")
        m.top.loading.visible = true
    end if
end sub

sub OnLogOutAll()
    m.parentScene.dialog.close = true
    m.top.loading.visible = false
end sub

sub OnLoginResponse()

    user_id = m.LoginTask.LoginResponse
    m.top.dialogAuthFailed.title = m.LoginTask.LoginResponse
    ?m.LoginTask.LoginResponse
    m.LoginTask.callFunc("stopLoginTask", "")
    m.top.loading.visible = false
    if user_id = "needotp"
        m.parentScene.dialog = m.top.kbdialogOtp
    else if user_id = "invalid"


        m.top.dialogAuthFailed.title = getText("login_failed")
        m.top.dialogAuthFailed.message = m.LoginTask.message
        ?m.LoginTask.message

        m.parentScene.dialog = m.top.dialogAuthFailed
        ?m.LoginTask.message
    else if user_id = "exceed"

        m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
        m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
        m.top.dialogAuthExceed.title = "Login Limit Exceeded! Try -> Logoutall"


        cancel = getText("cancel")
        logoutAllTitle = getText("logout_all")
        m.top.dialogAuthExceed.buttons = [logoutAllTitle, cancel]
        m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")

        m.parentScene.dialog = m.top.dialogAuthExceed
    else
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("USER_ID")
            tok = sec.Read("USER_ID")
            ? "logintest1"
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("USER_ID", tok)
            sec.Write("publish", "Template")
            sec.Flush()
            m.top.LoginFinish = "finished"
            m.top.closethispage = "true"
        end if
    end if
end sub

sub On_dialogAuthExceed_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.dialogAuthExceed.buttonSelected = 0 then
        m.LogoutTaskAll.callFunc("runLogoutTask", "")
        m.top.kbdialogEmail.text = ""
        m.parentScene.dialog = m.top.kbdialogEmail
    else
        m.parentScene.dialog.close = true
    end if
end sub




sub OnForgotResponseDailog()
    response = m.ForgotFetcher.ForgotResponse
    if response <> invalid and response.success = true
        msg = getText("please_check_mail")
        if response.message <> invalid and response.message <> ""
            msg = response.message
        end if
        m.top.dialogForgot.message = msg
        m.parentScene.dialog = m.top.dialogForgot
    else
        msg = "Something Gone Wrong .Try Again Later!"
        if response <> invalid and response.message <> invalid and response.message <> ""
            msg = response.message
        end if
        m.top.dialogForgotFailed.message = msg
        m.parentScene.dialog = m.top.dialogForgotFailed
    end if
    m.ForgotFetcher.callFunc("stopForgotFetcherTask", "")
end sub

sub On_dialogErrEmail_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.top.kbdialogEmail.text = ""
    m.parentScene.dialog = m.top.kbdialogEmail
end sub

sub On_dialogForgot_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
    if m.top.triggerForgotPassword = true
        m.top.closethispage = "true"
    end if
end sub

sub On_dialogForgotFailed_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
    m.parentScene.dialog = m.top.kbdialogEmailForgot
end sub

sub On_dialogErrEmailForgot_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.top.kbdialogEmailForgot.text = ""
    m.parentScene.dialog = m.top.kbdialogEmailForgot
end sub

sub OnRegResponse()
    user_id = m.RegTask.RegResponse
    m.RegTask.callFunc("stopRegTask", "")
    if user_id = "exists"
        m.parentScene.dialog = m.top.dialogAuthExists

    else if user_id = "failed"
        m.parentScene.dialog = m.top.dialogAuthFailedReg
    else
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("userIDOtp", user_id)
        sec.Flush()

    end if
    if(getRegisterationOTPRequired() = "false")
        m.top.RegFinish = "finished"
        m.top.closethispage = "true"
    end if
end sub

sub OnOtpResponse()
    user_id = m.OtpTask.OtpResponse
    m.OtpTask.callFunc("stopOtpTask", "")
    if user_id = "failed"
        m.parentScene.dialog = m.top.dialogAuthFailedReg
    else
        m.parentScene.dialog.close = true
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("userIDOtp")
            tok = sec.Read("userIDOtp")
        end if
        sec.Write("USER_ID", tok)
        sec.Write("publish", "Template")
        sec.Flush()
        m.top.RegFinish = "finished"
        m.top.closethispage = "true"
    end if
end sub


sub OnCodeResponse()
    user_id = m.CodeTask.CodeResponse
    m.CodeTask.callFunc("stopCodeTask", "")
    m.top.loading.visible = false
    print user_id
    if user_id = "invalid"
        m.parentScene.dialog = m.top.dialogAuthFailedCode
    else

        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("publish", "Template")
        sec.Flush()
        m.top.RegFinish = "finished"
        m.top.closethispage = "true"
    end if
end sub



sub OnResendResponse()
    user_id = m.ResendTask.ResendResponse
    m.ResendTask.callFunc("stopResendTask", "")
    if user_id = "failed"
        m.parentScene.dialog = m.top.dialogAuthFailedRegOtpResend
    else
        m.parentScene.dialog = m.top.dialogAuthFailedRegOtpResendSuccess
    end if
end sub

sub On_Login()
    if m.parentScene = invalid
        GetParentScene()
    end if

    if IsTVCodeFieldEmpty()
        m.CodeTask.code = m.TVCodeTextEditBox.text
        m.top.loading.visible = true
        m.CodeTask.callFunc("runCodeTask", "")
        m.TVCodeTextEditBox.text = ""

    else
        fill_field_message = getText("fill_field_message")
        showWarningDialoge(fill_field_message)
    end if
end sub


function IsTVCodeFieldEmpty()
    if(m.TVCodeTextEditBox.text <> "") then
        return true
    else
        return false
    end if
end function



sub On_Login2()
    if m.parentScene = invalid
        GetParentScene()
    end if

    if IsLoginFieldEmpty()
        m.LoginTask.user_email = m.EmailAddress_texteditbox.text
        m.LoginTask.password = m.password_TextEditBox.text
        m.LoginTask.device_id = m.deviceId
        m.top.loading.visible = true
        m.LoginTask.callFunc("runLoginTask", "")
        authenticateapi()

    else
        fill_field_message = getText("fill_field_message")
        showWarningDialoge(fill_field_message)
    end if

end sub

sub authenticateapi()

    m.AuthenticateApi = CreateObject("roSGNode", "AuthenticateApi")
    m.AuthenticateApi.callFunc("runauthenticateApiTask", "")

end sub


sub showWarningDialoge(param)
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = getText("warning")
    dialog.optionsDialog = true
    dialog.message = param
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

sub On_ForgotPassword()
    createForgotPassword()
end sub


sub On_kbdialogOtpReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogOtpReg.buttonSelected = 0 then

        if (getRegisterationOTPRequired() = "true")
            m.OtpTask.otp = m.top.kbdialogOtpReg.text
            m.OtpTask.callFunc("runOtpTask", "")
            m.top.kbdialogOtpReg.text = ""
        else
            OtpRegisterationSuceess()
        end if

    else if m.top.kbdialogOtpReg.buttonSelected = 1 then
        m.top.kbdialogPasswordReg.text = ""
        m.top.kbdialogName.text = ""
        m.top.kbdialogEmailReg.text = ""
        m.top.kbdialogPasswordReg.text = ""
        m.parentScene.dialog = m.top.kbdialogEmail
    else
        m.ResendTask.callFunc("runResendTask", "")
    end if
end sub

sub On_kbdialogOtp_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogOtp.buttonSelected = 0 then
        m.OtpTask.otp = m.top.kbdialogOtp.text
        m.OtpTask.callFunc("runOtpTask", "")
        m.top.kbdialogOtp.text = ""
    else if m.top.kbdialogOtp.buttonSelected = 1 then
        if m.top.kbdialogPasswordReg <> invalid
            m.top.kbdialogPasswordReg.text = ""
        end if
        if m.top.kbdialogName <> invalid
            m.top.kbdialogName.text = ""
        end if
        if m.top.kbdialogEmail <> invalid
            m.top.kbdialogEmail.text = ""
        end if
        if m.top.kbdialogPassword <> invalid
            m.top.kbdialogPassword.text = ""
        end if
        m.parentScene.dialog = m.top.kbdialogEmail
    else if m.top.kbdialogOtp.buttonSelected = 2 then
        m.ResendTask.callFunc("runResendTask", "")
    else if m.top.kbdialogPassword.buttonSelected = m.indexButtonPasswordShowHide then
        m.parentScene.dialog.keyboard.textEditBox.secureMode = not m.parentScene.dialog.keyboard.textEditBox.secureMode
    end if
end sub



sub On_kbdialogEmailForgot_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogEmailForgot.buttonSelected = m.indexButtonGo then
        if IsValidEmail(m.top.kbdialogEmailForgot.text) then
            m.ForgotFetcher.user_email = m.top.kbdialogEmailForgot.text
            m.ForgotFetcher.callFunc("runForgotFetcherTask", "")
            m.parentScene.dialog = m.top.pdialogAuth
        else
            m.top.kbdialogEmailForgot.text = ""
            m.parentScene.dialog = m.top.dialogErrEmailForgot
        end if
    else if m.top.kbdialogEmailForgot.buttonSelected = m.indexButtonBack or m.top.kbdialogEmailForgot.buttonSelected < 0 then
        m.top.kbdialogEmailForgot.text = ""
        m.parentScene.dialog.close = true
        if m.top.triggerForgotPassword = true
            m.top.closethispage = "true"
        end if
    end if
end sub


sub On_kbdialogEmailReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogEmailReg.buttonSelected = m.indexButtonGo then
        if IsValidEmail(m.top.kbdialogEmailReg.text) then
            m.parentScene.dialog = m.top.kbdialogPasswordReg
        else
            m.top.kbdialogEmailReg.text = ""
            m.parentScene.dialog = m.top.dialogErrEmailReg
        end if

    else if m.top.kbdialogEmailReg.buttonSelected = m.indexButtonBack or m.top.kbdialogEmailReg.buttonSelected < 0 then
        m.top.kbdialogName.text = ""
        m.top.kbdialogEmailReg.text = ""
        m.parentScene.dialog = m.top.kbdialogName
    end if
end sub

sub On_dialogErrPassword_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.top.kbdialogPassword.text = ""
    m.parentScene.dialog = m.top.kbdialogPassword

end sub

sub On_dialogErrPasswordReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if

    m.top.kbdialogPasswordReg.text = ""
    m.parentScene.dialog = m.top.kbdialogPasswordReg
end sub

sub On_kbdialogName_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogName.buttonSelected = m.indexButtonGo then
        if IsValidName(m.top.kbdialogName.text) then
            m.parentScene.dialog = m.top.kbdialogEmailReg
        else
            m.top.kbdialogName.text = ""
            m.parentScene.dialog = m.top.dialogErrName
        end if

    else if m.top.kbdialogName.buttonSelected = m.indexButtonBack or m.top.kbdialogName.buttonSelected < 0 then
        m.top.kbdialogName.text = ""
        m.parentScene.dialog.close = true
    end if
end sub



sub On_kbdialogPasswordReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogPasswordReg.buttonSelected = m.indexButtonPasswordGo then
        if IsValidPassword(m.top.kbdialogPasswordReg.text) then
            m.RegTask.Fullname = m.top.kbdialogName.text
            m.RegTask.user_email = m.top.kbdialogEmailReg.text
            m.RegTask.password = m.top.kbdialogPasswordReg.text
            m.RegTask.device_id = m.deviceId
            m.RegTask.callFunc("runRegTask", "")
            if (getRegisterationOTPRequired() = "true")
                m.parentScene.dialog = m.top.kbdialogOtpReg
            else
                m.parentScene.dialog.close = true
            end if

            m.top.kbdialogEmailReg.text = ""
            m.top.kbdialogPasswordReg.text = ""
        else
            m.top.kbdialogName.text = ""
            m.top.kbdialogEmailReg.text = ""
            m.top.kbdialogPasswordReg.text = ""
            m.parentScene.dialog = m.top.dialogErrPasswordReg
        end if

    else if m.top.kbdialogPasswordReg.buttonSelected = m.indexButtonPasswordBack or m.top.kbdialogPasswordReg.buttonSelected < 0 then
        m.top.kbdialogPasswordReg.text = ""
        m.top.kbdialogName.text = ""
        m.top.kbdialogEmailReg.text = ""
        m.top.kbdialogPasswordReg.text = ""
        m.parentScene.dialog = m.top.kbdialogEmail

    else if m.top.kbdialogPasswordReg.buttonSelected = m.indexButtonPasswordShowHide then
        m.parentScene.dialog.keyboard.textEditBox.secureMode = not m.parentScene.dialog.keyboard.textEditBox.secureMode

    end if
end sub

function IsValidName(name as string) as boolean
    return CreateObject("roRegex", m.top.regexName, "i").IsMatch(name)
end function



sub On_dialogErrEmailReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.top.kbdialogEmailReg.text = ""
    m.parentScene.dialog = m.top.kbdialogEmailReg
end sub

sub On_Signup()


    m.top.gotoRegisterLoginScene = true
end sub

sub On_Signupfocused()
end sub

sub On_Guest()
    m.GuestFetcher.callFunc("runGuestFetcher", "")
end sub

sub On_dialogErrName_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.top.kbdialogName.text = ""
    m.parentScene.dialog = m.top.kbdialogName
end sub


function IsValidPassword(password as string) as boolean
    return CreateObject("roRegex", m.top.regexPassword, "i").IsMatch(password)
end function

function IsValidEmail(email as string) as boolean
    return CreateObject("roRegex", m.top.regexEmail, "i").IsMatch(email)
end function


function onKeyEvent(key as string, press as boolean) as boolean

    ?key
    handled = false
    if press = false

        if key = "down" then

            if m.EmailAddress_texteditbox.hasFocus() then
                m.password_TextEditBox.setFocus(true)
                handled = true
            else if m.password_TextEditBox.hasFocus() then
                m.top.buttonLogin2.setFocus(true)
                handled = true

            else if m.top.buttonLogin2.hasFocus() then
                m.buttonsLabelList.setFocus(true)
                handled = true

            else
                if not m.buttonsLabelList.hasFocus()
                    m.EmailAddress_texteditbox.setFocus(true)
                    handled = true
                end if
            end if

        else if key = "up" then
            if m.top.buttonLogin2.hasFocus() then
                m.password_TextEditBox.setFocus(true)
                handled = true

            else if m.password_TextEditBox.hasFocus() then
                m.EmailAddress_texteditbox.setFocus(true)
                handled = true

            else if m.buttonsLabelList.hasFocus() then
                m.top.buttonLogin2.setFocus(true)
                handled = true

            else if m.password_TextEditBox.hasFocus() then
                m.EmailAddress_texteditbox.setFocus(true)
                handled = true

            end if



        else if key = "OK" then
            if m.EmailAddress_texteditbox.hasFocus()
                if not m.isKeyboardDialogOpenFlag = true


                    email = getText("email_placeholder")
                    ?m.top.kbdialogEmailReg.title
                    showdialog(email)
                    handled = true
                end if
                m.isKeyboardDialogOpenFlag = false

            else if m.password_TextEditBox.hasFocus()
                if not m.isKeyboardDialogOpenFlag = true


                    enter_password = getText("enter_password")' Default value


                    showdialog(enter_password)
                    handled = true
                end if
                m.isKeyboardDialogOpenFlag = false

            end if

        end if
    end if
    return handled
end function


sub callGuestRegister()

    m.GuestFetcher = CreateObject("roSGNode", "GuestFetcher")
    m.GuestFetcher.observeField("GuestResponse", "OnGuestResponse")
    m.top.loading.visible = true
    m.GuestFetcher.callFunc("runGuestFetcher", "")
end sub


sub OnGuestResponse()
    user_id = m.GuestFetcher.GuestResponse
    m.GuestFetcher.callFunc("stopGuestFetcher", "")
    m.top.loading.visible = false
    print "userid on guest iss"
    print user_id
    if user_id <> "failed"
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("USER_ID", user_id)
        sec.Flush()
        m.top.goToHomeScene = true
    else
    end if
end sub


sub On_dialogAuthFailed_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.dialogAuthFailed.buttonSelected = m.indexButtonGo then
        m.parentScene.dialog.close = true
        m.EmailAddress_texteditbox.text = ""
        m.password_TextEditBox.text = ""
    else
        m.parentScene.dialog.close = true
    end if
end sub

sub On_dialogAuthFailedReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
end sub

sub On_dialogAuthFailedCode_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
end sub

sub On_dialogAuthFailedRegOtpResend_buttonSelected()

    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
    m.parentScene.dialog = m.top.kbdialogOtpReg

end sub

sub On_dialogAuthFailedRegOtpResendSuccess_buttonSelected()

    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true

    m.parentScene.dialog = m.top.kbdialogOtpReg

end sub

sub On_dialogAuthExists_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.dialogAuthExists.buttonSelected = m.indexButtonGo then
        m.top.kbdialogEmailReg.text = ""
        m.parentScene.dialog = m.top.kbdialogEmailReg
    else
        m.parentScene.dialog.close = true
    end if
end sub



sub changes()
end sub



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



sub showTVCodeDialog(titleValue)
    ?"showdialog called"
    if m.parentScene = invalid
        GetParentScene()
    end if
    buttonarray = ["hhj", "hhjj"]
    m.keyboarddialog = CreateObject("roSGNode", "PinDialog")
    m.keyboarddialog.title = titleValue
    m.keyboarddialog.pin = ""
    m.keyboarddialog.buttons = buttonArray
    m.keyboarddialog.keyboard.textEditBox.keyboardType = "number"
    m.keyboarddialog.ObserveField("buttonSelected", "OnKeyboardButtonSelected")

    m.parentScene.dialog = m.keyboarddialog
end sub


sub showdialog(titleValue)

    if m.parentScene = invalid
        GetParentScene()
    end if




    cancel = getText("cancel")


    enter = getText("enter")




    buttonarray = [enter, cancel]

    m.keyboarddialog.title = titleValue
    m.keyboarddialog.text = ""
    m.keyboarddialog.buttons = buttonArray
    m.keyboarddialog.ObserveField("buttonSelected", "OnKeyboardButtonSelected")
    if titleValue = "Enter the Password"
        m.keyboarddialog.keyboard.textEditBox.secureMode = true
    else
        m.keyboarddialog.keyboard.textEditBox.secureMode = false
    end if
    m.parentScene.dialog = m.keyboarddialog
end sub


sub OnKeyboardButtonSelected()

    if m.keyboarddialog.buttonSelected = 0 then
        if m.TVCodeTextEditBox.hasFocus()
            m.TVCodeTextEditBox.text = m.keyboarddialog.text
        else if m.EmailAddress_texteditbox.hasFocus()
            m.EmailAddress_texteditbox.text = m.keyboarddialog.text
        else if m.password_TextEditBox.hasFocus()
            m.password_TextEditBox.text = m.keyboarddialog.text

        end if
    else m.keyboarddialog.buttonSelected = 1

    end if
    m.parentScene.dialog.close = true
    m.isKeyboardDialogOpenFlag = true
end sub


sub OtpRegisterationSuceess()
    m.parentScene.dialog.close = true
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("userIDOtp")
        tok = sec.Read("userIDOtp")
    end if
    ? "logintest3"
    sec.Write("USER_ID", tok)
    sec.Write("publish", "Template")
    sec.Flush()
    m.top.RegFinish = "finished"
    m.top.closethispage = "true"
end sub