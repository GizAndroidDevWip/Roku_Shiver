sub init()
    m.name_texteditbox = m.top.findNode("name_texteditbox")
    m.name_texteditbox.textColor = getTextColor()
    m.name_texteditbox.hintTextColor = "#5a5a5a"
    m.name_texteditbox.getChild(0).uri = "pkg:/images/img_itemcatbg_selected.png"
    ' if getTheme() = "LIGHT"
    '     m.name_texteditbox.getChild(0).blendColor = "#4E545C"
    ' else
        m.name_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    ' end if
    m.name_texteditbox.hintText = getTextOf("name")

    m.LineUnderName_textbox = m.top.findNode("LineUnderName_textbox")
    m.emailAddrees_texteditbox = m.top.findNode("emailAddrees_texteditbox")
    m.emailAddrees_texteditbox.textColor = getTextColor()
    m.emailAddrees_texteditbox.hintTextColor = "#5a5a5a"
    m.emailAddrees_texteditbox.getChild(0).uri = "pkg:/images/img_itemcatbg_selected.png"
    ' if getTheme() = "LIGHT"
    '     m.emailAddrees_texteditbox.getChild(0).blendColor = "#4E545C"
    ' else
        m.emailAddrees_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    ' end if


    m.emailAddrees_texteditbox.hintText = getTextOf("email_address")





    m.LineUnderemailAddress_textbox = m.top.findNode("LineUnderemailAddress_textbox")
    m.password_textbox = m.top.findNode("password_textbox")
    m.password_textbox.textColor = getTextColor()
    m.password_textbox.hintTextColor = "#5a5a5a"
    m.password_textbox.getChild(0).uri = "pkg:/images/img_itemcatbg_selected.png"
    ' if getTheme() = "LIGHT"
    '     m.password_textbox.getChild(0).blendColor = "#4E545C"
    ' else
        m.password_textbox.getChild(0).blendColor = "#2a2e32ff"
    ' end if

    m.password_textbox.hintText = getTextOf("enter_password")




    m.LineUnderpassword_textbox = m.top.findNode("LineUnderpassword_textbox")
    m.name_texteditbox.observeField("focusedChild", "onNameTextEditBoxGetFocused")
    m.emailAddrees_texteditbox.observeField("focusedChild", "onEmailAddressTextEditBoxGetFocused")
    m.password_textbox.observeField("focusedChild", "onPasswordTextEditBoxGetFocused")
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor()

    m.RegTask = CreateObject("roSGNode", "RegTask")
    m.RegTask.observeField("RegResponse", "OnRegResponse")
    m.OtpTask = CreateObject("roSGNode", "OtpTask")
    m.OtpTask.observeField("OtpResponse", "OnOtpResponse")
    m.CodeTask = CreateObject("roSGNode", "CodeTask")
    m.CodeTask.observeField("CodeResponse", "OnCodeResponse")
    m.ResendTask = CreateObject("roSGNode", "ResendTask")
    m.ResendTask.observeField("ResendResponse", "OnResendResponse")

    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Bold.ttf"
    font.size = 35

    ' Signup button
    m.top.SignupButton = m.top.CreateChild("Button")
    m.top.SignupButton.text = getTextOf("register")
    m.top.SignupButton.focusedColor = "#ffffff"
    m.top.SignupButton.textColor = getTextColor()
    m.top.SignupButton.focusedTextColor = "#ffffff"
    m.top.SignupButton.iconUri = ""
    m.top.SignupButton.focusedIconUri = ""
    m.top.SignupButton.minWidth = 230
    m.top.SignupButton.maxWidth = 230
    m.top.SignupButton.translation = [888, 700]
    ' m.top.SignupButton.focusFootprintBitmapUri = "pkg:/images/img_itemcatbg.png"
    m.top.SignupButton.focusBitmapUri = "pkg:/images/img_itemcatbg_selected.png"
    m.top.SignupButton.getChild(0).blendColor = getButtonSelectionColor()
    ' m.top.SignupButton.getChild(1).blendColor = "#ffffff"
    m.top.SignupButton.showFocusFootprint = true

    m.top.SignupButton.height = 80
    m.top.SignupButton.observeField("buttonSelected", "onSignUpButtonSelected")


    m.top.buttonLogin = m.top.CreateChild("Button")
    m.top.buttonLogin.focusedColor = "#ffffff"
    m.top.buttonLogin.iconUri = ""
    m.top.buttonLogin.focusedIconUri = ""
    m.top.buttonLogin.textColor = getTextColor()
    m.top.buttonLogin.focusedTextColor = "#ffffff"
    m.top.buttonLogin.showFocusFootprint = true
    m.top.buttonLogin.minWidth = 110
    m.top.buttonLogin.focusedFont = font
    m.top.buttonLogin.translation = [1185, 785]
    ' m.top.buttonLogin.focusFootprintBitmapUri = "pkg:/images/img_itemcatbg.png"
    m.top.buttonLogin.focusBitmapUri = "pkg:/images/img_itemcatbg_selected.png"
    m.top.buttonLogin.getChild(0).blendColor = getButtonSelectionColor()
    m.top.buttonLogin.height = 80
    m.top.buttonLogin.visible = true
    m.top.buttonLogin.text = "Login"
    m.top.buttonLogin.observeField("buttonSelected", "gotosignupPage")


    m.top.alreadyUser = m.top.CreateChild("Label")


    register_sign_in_text = getTextOf("register_sign_in_text")



    login_text = getTextOf("login")


    m.top.alreadyUser.text = register_sign_in_text + " "
    m.top.alreadyUser.horizAlign = "center"
    m.top.alreadyUser.translation = "[695, 815]"
    m.top.alreadyUser.color = getTextColor()
    m.top.alreadyUser.width = 628
    m.top.alreadyUser.height = 510
    m.top.alreadyUser.wrap = true
    ' m.top.SubmitText.font = font
    m.top.alreadyUser.font.size = 29
    m.top.alreadyUser.observeField("focusedChild", "OnalreadyUserGetFocused")


    m.top.kbdialogOtpReg = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogOtpReg.backgroundUri = "pkg:/images/black.jpg"

    otp_message = getText("otp_message")

    m.top.kbdialogOtpReg.title = otp_message
    m.top.kbdialogOtpReg.text = ""



    continue = getText("continue")
    cancel = getText("cancel")




    resend_otp = getText("resend_otp")

    m.top.kbdialogOtpReg.buttons = [continue, cancel, resend_otp]
    m.top.kbdialogOtpReg.ObserveField("buttonSelected", "On_kbdialogOtpReg_buttonSelected")

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

    m.top.kbdialogOtp = CreateObject("roSGNode", "BackKeyboardDialog")
    m.top.kbdialogOtp.backgroundUri = "pkg:/images/black.jpg"

    m.top.kbdialogOtp.title = getText("otp_message")


    ' m.top.kbdialogOtp.title = "Enter OTP that send to  your mail (check your SPAM, if not found in your INBOX.)"
    m.top.kbdialogOtp.text = ""



    continue = getText("continue")




    cancel = getText("cancel")



    cancel = getText("cancel")



    getText("resend_otp")



    m.top.kbdialogOtp.buttons = [continue, cancel, resend_otp]
    m.top.kbdialogOtp.ObserveField("buttonSelected", "On_kbdialogOtp_buttonSelected")

    m.top.dialogAuthFailedReg = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailedReg.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailedReg.title = "Registration failed"
    m.top.dialogAuthFailedReg.buttons = ["Cancel"]
    m.top.dialogAuthFailedReg.ObserveField("buttonSelected", "On_dialogAuthFailedReg_buttonSelected")

    m.top.dialogAuthExists = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExists.backgroundUri = "pkg:/images/black.jpg"



    m.top.dialogAuthExists.title = getText("existing_user_message")




    ok = getText("ok")




    m.top.dialogAuthExists.buttons = [ok]
    m.top.dialogAuthExists.ObserveField("buttonSelected", "On_dialogAuthExists_buttonSelected")

    m.top.loading = m.top.CreateChild("Loading") ' loading created this way because loading needs to above every views. some views are defined here in brs file. not in xml
    m.top.loading.visible = false

    m.global.channelStore.requestedUserData = "email"
    m.global.channelStore.command = "getUserData" 
    m.global.channelStore.observeField("userData", "OnrequestedUserData")



    'voice keyboard for static analysis

    m.nameKeyboard = m.top.CreateChild("DynamicKeyboard")
    m.nameKeyboard.voiceEnabled = true
    m.nameKeyboard.voiceEntryType = ""
    m.nameKeyboard.visible = false


end sub

function onkeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press = false
        if key = "down" then
            if m.name_texteditbox.hasFocus() then
                m.emailAddrees_texteditbox.setFocus(true)
                handled = true
            else if m.emailAddrees_texteditbox.hasFocus() then
                m.password_textbox.setFocus(true)
                handled = true
            else if m.password_textbox.hasFocus() then
                m.top.SignupButton.setFocus(true)
                handled = true
            else if m.top.SignupButton.hasFocus() then
                m.top.buttonLogin.setFocus(true)
                handled = true
            else
                m.name_texteditbox.setFocus(true)
                handled = true
            end if
        else if key = "up" then
            if m.top.buttonLogin.hasFocus() then
                m.top.SignupButton.setFocus(true)
                handled = true
            else if m.top.SignupButton.hasFocus() then
                m.password_textbox.setFocus(true)
                handled = true
            else if m.password_textbox.hasFocus() then
                m.emailAddrees_texteditbox.setFocus(true)
                handled = true
            else if m.emailAddrees_texteditbox.hasFocus() then
                m.name_texteditbox.setFocus(true)
                handled = true
            end if
        end if
    end if
    if press = true
        if key = "OK" then
            if m.name_texteditbox.hasFocus()

                showdialog(m.name_texteditbox.hintText)
                handled = true
            else if m.emailAddrees_texteditbox.hasFocus()


                showdialog(m.emailAddrees_texteditbox.hintText)
                handled = true
            else if m.password_textbox.hasFocus()

                showdialog(m.password_textbox.hintText)
                handled = true
            else if m.top.SignupButton.hasFocus()
                onSignUpButtonSelected()
            else if m.top.buttonLogin.hasFocus()
                goTosignupPage()
            end if
        end if
    end if
end function



sub goTosignupPage()
    m.top.goToLoginSceneFromRegisterScene = true
    ' m.top.gotoLandingScene = true
end sub




sub showdialog(titleValue)
    ?"showdialog called"
    if m.parentScene = invalid
        GetParentScene()
    end if



    cancel = getText("cancel")

    ?"jjkjkk"



    enter = getText("enter")




    buttonarray = [enter, cancel]
    m.keyboarddialog = CreateObject("roSGNode", "KeyboardDialog")
    m.keyboarddialog.title = titleValue
    m.keyboarddialog.text = ""
    m.keyboarddialog.text = ""
    m.keyboarddialog.buttons = buttonArray
    m.keyboarddialog.ObserveField("buttonSelected", "OnKeyboardButtonSelected")
    ' m.keyboarddialog.keyboard.textEditBox.secureMode = true
    m.parentScene.dialog = m.keyboarddialog
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

sub OnalreadyUserGetFocused()
    if m.top.alreadyUser.hasFocus() then
        m.top.alreadyUser.color = getButtonSelectionColor()
    else
        m.top.alreadyUser.color = getTextColor()
    end if
end sub

sub onNameTextEditBoxGetFocused()
    if m.name_texteditbox.hasFocus() then
        m.name_texteditbox.active = true
        m.name_texteditbox.hintTextColor = "#c9c9c9"
        m.name_texteditbox.textColor = "#FFFFFF"
        m.name_texteditbox.getChild(0).blendColor = "#4E545C"
    else
        m.name_texteditbox.active = false
        m.name_texteditbox.hintTextColor = "#5a5a5a"
        m.name_texteditbox.textColor = getTextColor()
        m.name_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    end if
end sub

sub onEmailAddressTextEditBoxGetFocused()
    if m.emailAddrees_texteditbox.hasFocus() then
        m.emailAddrees_texteditbox.active = true
        m.emailAddrees_texteditbox.hintTextColor = "#c9c9c9"
        m.emailAddrees_texteditbox.textColor = "#FFFFFF"
        m.emailAddrees_texteditbox.getChild(0).blendColor = "#4E545C"
    else
        m.emailAddrees_texteditbox.active = false
        m.emailAddrees_texteditbox.hintTextColor = "#5a5a5a"
        m.emailAddrees_texteditbox.textColor = getTextColor()
        m.emailAddrees_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    end if
end sub

sub onPasswordTextEditBoxGetFocused()
    if m.password_textbox.hasFocus() then
        m.password_textbox.active = true
        m.password_textbox.hintTextColor = "#c9c9c9"
        m.password_textbox.textColor = "#FFFFFF"
        m.password_textbox.getChild(0).blendColor = "#4E545C"
    else
        m.password_textbox.active = false
        m.password_textbox.hintTextColor = "#5a5a5a"
        m.password_textbox.textColor = getTextColor()
        m.password_textbox.getChild(0).blendColor = "#2a2e32ff"
    end if
end sub

sub OnKeyboardButtonSelected()
    ?"OnKeyboardButtonSelected called"
    if m.keyboarddialog.buttonSelected = 0 then
        if m.name_texteditbox.hasFocus()
            m.name_texteditbox.text = m.keyboarddialog.text
        else if m.emailAddrees_texteditbox.hasFocus()
            m.emailAddrees_texteditbox.text = m.keyboarddialog.text
        else if m.password_textbox.hasFocus()
            m.password_textbox.text = m.keyboarddialog.text
        end if
        m.parentScene.dialog.close = true
    else m.keyboarddialog.buttonSelected = 1
        m.parentScene.dialog.close = true
    end if
end sub


sub onSignUpButtonSelected()
    if IsFieldEmpty()
        runSignUpTask()
    else

        fill_field_message = getText("fill_field_message")
        showWarningDialoge(fill_field_message)
    end if
end sub

sub runSignUpTask()
    m.RegTask.Fullname = m.name_texteditbox.text
    m.RegTask.user_email = m.emailAddrees_texteditbox.text
    m.RegTask.password = m.password_textbox.text
    m.RegTask.device_id = m.deviceId
    m.top.loading.visible = true
    setLanguageSettingToTrueForNewUser()
    ' callAccessTokenAPI()
    authenticateapi1()
    m.RegTask.callFunc("runRegTask", "")

    if GetParentScene() = invalid then
        return
    end if
    if (getRegisterationOTPRequired() = "true")
        m.parentScene.dialog = m.top.kbdialogOtpReg
    else
        ' m.parentScene.dialog.close = true
        ?"fkshkdjfhdkfjhdk"
    end if

end sub

function setLanguageSettingToTrueForNewUser()
    sec = CreateObject("roRegistrySection", getAppKey2())
    if sec.Exists("Is_Language_Setting_First_Time")
        sec.Delete("Is_Language_Setting_First_Time") ' Delete the key
        sec.Flush() ' Save the changes
        ?"rtrttrt"

    end if
    if sec.Exists("Is_Language_Selected") then
        sec.Delete("Is_Language_Selected") ' Delete the key
        sec.Flush()
        ?"erer"
    end if

    if sec.Exists("LANGUAGE_CODE_SELECTED") then
        sec.Delete("LANGUAGE_CODE_SELECTED") ' Delete the key
        sec.Flush()
        ?"ww2e"
    end if




end function



sub On_dialogAuthFailedRegOtpResend_buttonSelected()

    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
    m.parentScene.dialog = m.top.kbdialogOtpReg

end sub







'**********SignUp   validation
function IsFieldEmpty()
    if (m.name_texteditbox.text <> "" and m.emailAddrees_texteditbox.text <> "" and m.password_textbox.text <> "") then
        return true
    else
        return false
    end if
end function

' Validation warning dialogue
sub showWarningDialoge(param)
    dialog = createObject("roSGNode", "Dialog")
    ' dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"


    dialog.title = getText("warning")



    dialog.optionsDialog = true
    dialog.message = param
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

sub OnOtpResponse()
    user_id = m.OtpTask.OtpResponse
    m.OtpTask.callFunc("stopOtpTask", "")
    m.top.loading.visible = false
    if user_id = "failed"
        m.parentScene.dialog = m.top.dialogAuthFailedReg
    else
        m.parentScene.dialog.close = true
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("userIDOtp")
            tok = sec.Read("userIDOtp")
        end if
        ? "name_texteditbox"
        sec.Write("USER_ID", tok)
        sec.Write("publish", "Template")
        sec.Flush()
        m.top.RegFinish = "finished"
        m.top.closethispage = "true"
    end if
end sub

sub OnRegResponse()
    user_id = m.RegTask.RegResponse
    m.RegTask.callFunc("stopRegTask", "")
    m.top.loading.visible = false
    if user_id = "exists"
        m.parentScene.dialog = m.top.dialogAuthExists

    else if user_id = "failed"
        m.parentScene.dialog = m.top.dialogAuthFailedReg
    else
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("userIDOtp", user_id)
        sec.Flush()
        ' m.parentScene.dialog = m.top.dialogAuthExists
        if (getRegisterationOTPRequired() = "true")
            m.parentScene.dialog = m.top.kbdialogOtpReg
        else
            m.top.RegFinish = "finished"
            m.top.closethispage = "true"
        end if
    end if

end sub


sub On_kbdialogOtpReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.kbdialogOtpReg.buttonSelected = 0 then

        if (getRegisterationOTPRequired() = "true")
            m.OtpTask.otp = m.top.kbdialogOtpReg.text
            m.OtpTask.callFunc("runOtpTask", "")
            ?"OtpTask Run"
            m.top.kbdialogOtpReg.text = ""
        else
            OtpRegisterationSuceess()
        end if

    else if m.top.kbdialogOtpReg.buttonSelected = 1 then
        ' m.top.kbdialogPasswordReg.text = ""
        ' m.top.kbdialogName.text = ""
        ' m.top.kbdialogEmailReg.text = ""
        ' m.top.kbdialogPasswordReg.text = ""
        m.parentScene.dialog = m.top.kbdialogEmail
    else if m.top.kbdialogOtpReg.buttonSelected = 2 then
        m.ResendTask.callFunc("runResendTask", "")
    else
        m.parentScene.dialog.close = true
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
        m.top.kbdialogPasswordReg.text = ""
        m.top.kbdialogName.text = ""
        m.top.kbdialogEmail.text = ""
        m.top.kbdialogPassword.text = ""
        m.parentScene.dialog = m.top.kbdialogEmail
    else if m.top.kbdialogOtp.buttonSelected = 2 then
        m.ResendTask.callFunc("runResendTask", "")
    else if m.top.kbdialogPassword.buttonSelected = m.indexButtonPasswordShowHide then
        m.parentScene.dialog.keyboard.textEditBox.secureMode = not m.parentScene.dialog.keyboard.textEditBox.secureMode
    end if
end sub







sub OtpRegisterationSuceess()
    m.parentScene.dialog.close = true
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("userIDOtp")
        tok = sec.Read("userIDOtp")
    end if
    ? "OtpRegisterationSuceess"
    sec.Write("USER_ID", tok)
    sec.Write("publish", "Template")
    sec.Flush()
    m.top.RegFinish = "finished"
    m.top.closethispage = "true"
end sub

sub On_dialogAuthFailedRegOtpResendSuccess_buttonSelected()

    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true

    m.parentScene.dialog = m.top.kbdialogOtpReg
end sub

sub OnCodeResponse()
    user_id = m.CodeTask.CodeResponse
    m.CodeTask.callFunc("stopCodeTask", "")
    print "responseDataresponseData"
    print user_id
    if user_id = "invalid"
        m.parentScene.dialog = m.top.dialogAuthFailedCode
    else
        ' m.parentScene.dialog.close = true
        ? "logintest4"
        sec = CreateObject("roRegistrySection", getAppKey())
        '     if sec.Exists("userIDOtp")
        '        tok = sec.Read("userIDOtp")
        '        end if
        '        sec.Write("USER_ID", tok)
        sec.Write("publish", "Template")
        sec.Flush()
        m.top.RegFinish = "finished"
        m.top.closethispage = "true"
    end if
end sub

sub On_dialogAuthFailedReg_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
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

sub OnResendResponse()
    user_id = m.ResendTask.ResendResponse
    m.ResendTask.callFunc("stopResendTask", "")
    if user_id = "failed"
        m.parentScene.dialog = m.top.dialogAuthFailedRegOtpResend
    else
        m.parentScene.dialog = m.top.dialogAuthFailedRegOtpResendSuccess
    end if
end sub


sub OnrequestedUserData()
    ?"OnrequestedUserData"
    if m.global.channelStore.userData <> invalid and m.global.channelStore.userData.email <> invalid
        m.emailAddrees_texteditbox.text = m.global.channelStore.userData.email
    end if
end sub