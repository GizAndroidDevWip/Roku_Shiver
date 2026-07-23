sub init()
    m.top.dialogAuthFailed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthFailed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthFailed.title = "Error occured!"
    m.top.dialogAuthFailed.buttons = ["Cancel"]
    m.top.dialogAuthFailed.ObserveField("buttonSelected", "On_dialogAuthFailed_buttonSelected")
    m.indexButtonGo = 0
    m.indexButtonBack = 1
    m.indexButtonPasswordShowHide = 0
    m.indexButtonPasswordGo = 1
    m.indexButtonPasswordBack = 2
    m.indexButtonOtpGo = 3
    m.top.login_text_msg = CreateObject("roSGNode", "BackDialog")
    m.top.login_text_msg.backgroundUri = "pkg:/images/black.jpg"
    m.top.login_text_msg.title = "Confirmation link has been sent to the registered email!"
    m.EmailLoginBackground = m.top.findNode("EmailLoginBackground")
    m.EmailLoginBackground.color = getBackGroundColor1()
    m.QRCodeImage = m.top.findNode("QRCodeImage")
    m.top.code = m.top.CreateChild("Label")
    m.top.GoTo = m.top.CreateChild("Label")
    m.user_email = m.top.findNode("user_email")
    m.top.SignInViaEmail = m.top.CreateChild("Label")
    m.top.SignInViaEmail.text = getText("start_watching") + "  " + getAppTitle()
    m.top.SignInViaEmail.translation = [120, 342]
    m.top.SignInViaEmail.color = getTextColor()
    m.top.SignInViaEmail.width = 1000
    m.top.SignInViaEmail.height = 500
    m.top.SignInViaEmail.font = "font:LargeBoldSystemFont"
    m.top.SignInViaEmail.font.size = 44
    m.top.EnterTheEmail = m.top.CreateChild("Label")
    m.top.EnterTheEmail.text = getSignInMessage2()
    m.top.EnterTheEmail.translation = [120, 430]
    m.top.EnterTheEmail.color = getTextColor()
    m.top.EnterTheEmail.width = 840
    m.top.EnterTheEmail.height = 250
    m.top.EnterTheEmail.maxLines = 2
    m.top.EnterTheEmail.numLines = 2
    m.top.EnterTheEmail.wrap = true
    m.top.EnterTheEmail.font = "font:LargeSystemFont"
    m.top.EnterTheEmail.font.size = 30

    m.top.loading = m.top.CreateChild("Loading")
    m.top.loading.visible = false
    m.top.observeField("visible", "OnTopVisibleChange")
    m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    m.buttonsLabelList.ObserveField("itemSelected", "onButtonsLabelList")
    m.buttonsLabelList.color = getTextColor()
    m.buttonsLabelList.focusedColor = "FFFFFF"
    m.buttonsLabelList.focusBitmapBlendColor = getButtonSelectionColor()
    initialiseButtonsLabelList()
    m.buttonsLabelList.setFocus(true)
    m.Logo = m.top.findNode("Logo")
    m.Logo.uri = "pkg:/images/logos/watermarklogo.png"
    m.Logo.visible = true
end sub



sub OnTopVisibleChange()
    if m.top.visible = true
        m.buttonsLabelList.setFocus(true)
    end if
end sub



function onKeyEvent(key as string, press as boolean) as boolean

    handled = false
    if press = false
        if key = "down" then
        end if

    else if key = "up" then

    end if

    if press = true
        if key = "OK" then
        end if

    end if
    return handled

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


sub onButtonsLabelList()
    itemSelected = m.buttonsLabelList.itemSelected
    idSelected = m.buttonsLabelList.content.getChild(itemSelected).id
    if idSelected = "Log_in"
        m.top.goToLoginScene = true
    else if idSelected = "Sign_in_via_email"
        m.top.goToEmailLoginScene = true
    else if idSelected = "Create_Free_Account"
        m.top.goToRegisterScene = true
    end if
end sub


sub initialiseButtonsLabelList()
    m.createFreeAccount = createObject("RoSGNode", "ContentNode")
    m.createFreeAccount.id = "Create_Free_Account"
    m.createFreeAccount.title = getText("sign_in_register_text")
    m.Sign_in_via_email = createObject("RoSGNode", "ContentNode")
    m.Sign_in_via_email.id = "Sign_in_via_email"
    m.Sign_in_via_email.title = getText("sign_in_via_email")
    m.LogIn = createObject("RoSGNode", "ContentNode")
    m.LogIn.id = "Log_in"
    m.LogIn.title = getText("login")
    m.buttonsLabelListItems = []

    if getSIGN_UP_REQUIRED() = "true"
        m.buttonsLabelListItems.push(m.createFreeAccount)
    end if

    m.buttonsLabelListItems.push(m.LogIn)

    if getLOGIN_WITH_MAGIC_LINK_REQUIRED() = "true"
        m.buttonsLabelListItems.push(m.Sign_in_via_email)
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

function getSignInMessage2() as object

    signin_complete_catalog = getText("signin_complete_catalog") + " " + getText("watchlist_and_more")

    data = CreateObject("roRegistrySection", getAppKey())
    if data.Exists("SIGN_IN_MESSAGE")
        output = data.Read("SIGN_IN_MESSAGE")
        return output
    else
        return signin_complete_catalog
    end if
end function

