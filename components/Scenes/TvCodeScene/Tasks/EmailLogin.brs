sub init()
    m.top.dialogAuthFailed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailed.title = getTextOf("error_message")
    cancel = getTextOf("cancel")
    m.top.dialogAuthFailed.buttons = [cancel]
    m.top.dialogAuthFailed.ObserveField("buttonSelected", "On_dialogAuthFailed_buttonSelected")
    m.indexButtonGo = 0
    m.indexButtonBack = 1
    m.indexButtonPasswordShowHide = 0
    m.indexButtonPasswordGo = 1
    m.indexButtonPasswordBack = 2
    m.indexButtonOtpGo = 3
    m.top.login_text_msg = CreateObject("roSGNode", "BackDialog")
    m.top.login_text_msg.backgroundUri = "pkg:/images/black.jpg"
    m.top.login_text_msg.title = getTextOf("confirmation_link_sent")
    m.EmailLoginBackground = m.top.findNode("EmailLoginBackground")
    m.EmailLoginBackground.color = getBackGroundColor1()
    m.Email_texteditbox = m.top.findNode("Email_texteditbox")
    m.Email_texteditbox.getChild(0).uri = "pkg:/images/img_itemcatbg_selected.png"
    m.Email_texteditbox.translation = "[713,380]"
    m.Email_texteditbox.textColor = getTextColor()
    m.Email_texteditbox.hintText = getTextOf("email_address")
    m.Email_texteditbox.hintTextColor = "#5a5a5a"
    m.Email_texteditbox.observeField("focusedChild", "OnEmailTextEditBoxFocusChanged")
    ' if getTheme() = "LIGHT"
    '     m.Email_texteditbox.getChild(0).blendColor = "#4E545C"
    ' else
    m.Email_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    ' end if
    m.isLoggedInCheckTimer = m.top.findNode("isLoggedInCheckTimer")
    m.isLoggedInCheckTimer.ObserveField("fire", "callAccountCheckApi")
    m.QRCodeImage = m.top.findNode("QRCodeImage")
    m.top.code = m.top.CreateChild("Label")
    m.top.GoTo = m.top.CreateChild("Label")
    m.user_email = m.top.findNode("user_email")
    m.top.SignInViaEmail = m.top.CreateChild("Label")
    m.top.SignInViaEmail.text = getTextOf("sign_in_via_email")
    m.top.SignInViaEmail.translation = [836, 276]
    m.top.SignInViaEmail.textColor = getTextColor()
    m.top.SignInViaEmail.width = 700
    m.top.SignInViaEmail.height = 500
    m.top.SignInViaEmail.font.size = 30

    m.top.EnterTheEmail = m.top.CreateChild("Label")

    m.top.EnterTheEmail.text = getTextOf("please_enter_registered_mail")

    m.top.EnterTheEmail.observeField("focusedChild", "onEnterTheEmailFocusChanged")
    m.top.EnterTheEmail.translation = [465, 210]
    m.top.EnterTheEmail.textColor = getTextColor()
    m.top.EnterTheEmail.color = getTextColor()
    m.top.EnterTheEmail.width = 1080
    m.top.EnterTheEmail.height = 150

    m.top.EnterTheEmail.font = "font:MediumSystemFont"
    m.top.EnterTheEmail.font.size = 45
    m.top.Submit_button = m.top.CreateChild("Button")
    m.top.Submit_button.text = getTextOf("submit")
    m.top.Submit_button.focusedColor = "#ffffff"
    m.top.Submit_button.textColor = "#ffffff"
    m.top.Submit_button.focusedTextColor = "#ffffff"
    m.top.Submit_button.iconUri = ""
    m.top.Submit_button.focusedIconUri = ""
    m.top.Submit_button.minWidth = 138

    m.top.Submit_button.translation = [857, 530]
    m.top.Submit_button.focusBitmapUri = "pkg:/images/img_loginbg1.png"
    m.top.Submit_button.getChild(0).blendColor = getButtonSelectionColor()
    m.top.Submit_button.getChild(1).blendColor = "#313033"
    m.top.Submit_button.showFocusFootprint = true
    m.top.Submit_button.ObserveField("buttonSelected", "Submit_button")
    m.top.Submit_button.height = 80

    m.top.loading = m.top.CreateChild("Loading")
    m.top.loading.visible = false
    m.top.observeField("visible", "OnTopVisibleChange")
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogOutAll")
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = getTextOf("reached_maximum_device_message")
    okTitle = getTextOf("ok")
    logoutAllTitle = getTextOf("logout_all") ' Default value
    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected1")
    ' m.Email_texteditbox.setFocus(true)

end sub


sub OnTopVisibleChange()
end sub


sub callAccountRequestApi(user_email)
    m.AccountRequestApiTask = CreateObject("roSGNode", "AccountRequestApiTask")
    m.AccountRequestApiTask.ObserveField("responseDataAccountRequestTaskListStatus", "OnresponseDataAccountRequestTaskContent")
    m.AccountRequestApiTask.callFunc("runAccountRequestApiTask", user_email)
end sub


sub OnresponseDataAccountRequestTaskContent()
    content = m.AccountRequestApiTask.responseDataAccountRequestTaskContent
    m.parentScene.dialog = invalid

    m.top.id = content.id
    if content.id <> invalid
        if m.Email_texteditbox.text <> invalid
            emailId = m.Email_texteditbox.text
        else
            emailId = "you"
        end if
        success = getTextOf("success")
        login_with_email_message = getTextOf("login_with_email_message")
        showPopUpDialog(success, login_with_email_message)
        m.isLoggedInCheckTimer.control = "stop"
        m.isLoggedInCheckTimer.control = "start"
    else content.id = invalid
        m.parentScene.dialog = m.top.dialogAuthFailed
    end if
end sub


sub On_dialogAuthFailed_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    if m.top.dialogAuthFailed.buttonSelected = m.indexButtonGo then
        m.parentScene.dialog.close = true
        m.Email_texteditbox.text = ""

    else
        m.parentScene.dialog.close = true
    end if
end sub




function IsLoginFieldEmpty()
    if(m.Email_texteditbox.text <> "") then
        return true
    else
        return false
    end if

end function

sub callAccountCheckApi()
    if m.AccountRequestApiTask.responseDataAccountRequestTaskContent <> invalid and m.AccountRequestApiTask.responseDataAccountRequestTaskContent.id <> invalid
        m.AccountCheckApiTask = CreateObject("roSGNode", "AccountCheckApiTask")
        m.AccountCheckApiTask.ObserveField("responseAccountCheckApiTaskListStatus", "callUserSubscriptionApi")
        m.AccountCheckApiTask.id = m.AccountRequestApiTask.responseDataAccountRequestTaskContent.id
        m.AccountCheckApiTask.callFunc("runAccountCheckApiTask", m.AccountRequestApiTask.responseDataAccountRequestTaskContent.id)
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

    if forcibleLogout = true
        m.parentScene = GetParentScene()
        m.parentScene.dialog = m.top.dialogAuthExceed
        m.isLoggedInCheckTimer.control = "stop"
        m.top.loading.visible = false
    else
        OnresponseAccountCheckApiTaskContent()
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
    m.isLoggedInCheckTimer.control = "stop"
end sub

sub OnLogOutAll()
    m.parentScene.dialog.close = true
    m.top.loading.visible = false
end sub


function OnresponseAccountCheckApiTaskContent()
    m.isLoggedInCheckTimer.control = "stop"
    if m.parentScene.dialog <> invalid
        m.parentScene.dialog.close = true
    end if
    m.top.closethispage = "true"

end function


function onKeyEvent(key as string, press as boolean) as boolean

    ?"key: ";key
    ?"press: ";press

    handled = false
    if press = false
        if key = "down" then
            if m.Email_texteditbox.hasFocus() then
                m.top.Submit_button.setFocus(true)
                handled = true
            else
                m.Email_texteditbox.setFocus(true)
                handled = true
            end if

        else if key = "up" then
            if m.top.Submit_button.hasFocus() then
                m.Email_texteditbox.setFocus(true)
                handled = true
            end if

        else if key = "OK" then

        else if key = "back"

        end if

        if press = true

        else if m.top.Submit_button.hasFocus()
            handled = true
        end if
        return handled

    else if press = true
        if key = "OK"
            if m.Email_texteditbox.hasFocus()

                Email_texteditbox = getTextOf("email_address")

                showdialog(Email_texteditbox)
                handled = true
            end if
        else if key = "back"

        end if

    end if

end function

sub showPopUpDialog(title, message)
    m.top.dialogNode = CreateObject("roSGNode", "BackDialog")
    m.top.dialogNode.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogNode.title = title
    m.top.dialogNode.message = message
    m.top.dialogNode.buttons = ["OK"]
    m.top.dialogNode.ObserveField("buttonSelected", "On_dialogErrEmail_buttonSelected")
    m.parentScene.dialog = m.top.dialogNode
end sub

sub On_dialogErrEmail_buttonSelected()
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog.close = true
end sub

sub showdialog(titleValue)
    ?"showdialog called"
    if m.parentScene = invalid
        GetParentScene()
    end if

    cancel = getTextOf("cancel")
    enter = getTextOf("enter")
    buttonarray = [enter, cancel]


    m.keyboarddialog = CreateObject("roSGNode", "KeyboardDialog")
    m.keyboarddialog.title = titleValue
    m.keyboarddialog.text = ""
    m.keyboarddialog.text = ""
    m.keyboarddialog.buttons = buttonArray
    m.keyboarddialog.ObserveField("buttonSelected", "OnKeyboardButtonSelected")
    if titleValue = "Enter the Password"
        m.keyboarddialog.keyboard.textEditBox.secureMode = true
    end if
    m.parentScene.dialog = m.keyboarddialog
end sub


sub OnKeyboardButtonSelected()
    if m.keyboarddialog.buttonSelected = 0 then
        if m.Email_texteditbox.hasFocus()
            m.Email_texteditbox.text = m.keyboarddialog.text
        end if
        m.parentScene.dialog.close = true
    else m.keyboarddialog.buttonSelected = 1
        m.parentScene.dialog.close = true
    end if
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





sub Submit_button()
    if m.parentScene = invalid
        GetParentScene()
    end if

    if IsLoginFieldEmpty()
        callAccountRequestApi(m.Email_texteditbox.text)
    else
        fill_field_message = getTextOf("fill_field_message")

        showWarningDialoge(fill_field_message)
    end if
end sub





sub showWarningDialoge(param)
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = getTextOf("warning")
    dialog.optionsDialog = true
    dialog.message = param
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

sub OnEmailTextEditBoxFocusChanged()
    if m.Email_texteditbox.hasFocus() then
        m.Email_texteditbox.active = true
        m.Email_texteditbox.hintTextColor = "#c9c9c9"
        m.Email_texteditbox.textColor = "#FFFFFF"
        m.Email_texteditbox.getChild(0).blendColor = "#4E545C"
    else
        m.Email_texteditbox.active = false
        m.Email_texteditbox.hintTextColor = "#5a5a5a"
        m.Email_texteditbox.textColor = getTextColor()
        m.Email_texteditbox.getChild(0).blendColor = "#2a2e32ff"
    end if
end sub

function getTheme() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("THEME")
        THEME = ses.Read("THEME")
        return THEME
    else
        return "DARK"
    end if
end function