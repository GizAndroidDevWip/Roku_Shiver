sub init()
    m.loadingIndicator = m.top.getScene().findNode("loadingIndicator")
    showLoader(true)
    m.focusedIndex = 0
    m.scrollOffset = 0
    m.maxVisibleItems = 8
    m.cardTotalHeight = 108
    m.optionsList = m.top.findNode("optionsList")
    m.avatarBg = m.top.findNode("avatarBg")
    m.avatarPoster = m.top.findNode("avatarPoster")
    m.avatarPoster.observeField("loadStatus", "onAvatarLoadStatus")
    m.userName = m.top.findNode("userName")
    m.userEmail = m.top.findNode("userEmail")
    m.qrPoster = m.top.findNode("qrPoster")
    m.qrBg = m.top.findNode("qrBg")
    m.coinIcon = m.top.findNode("coinIcon")
    m.coinIcon.uri = getTokenSymbol()
    m.coinLabel = m.top.findNode("coinLabel")
    m.coinLabel.text = getCurrentCoinBalance()
    m.coinBalanceGroup = m.top.findNode("coinBalanceGroup")
    m.coinBalanceGroup.visible = true 'pnly needed for reelmuvi, hide for now
    m.coinLabelHeading = m.top.findNode("coinLabelHeading")
    m.coinLabelHeading.text = getTextOf("coin_balance")
    m.qrScanLabel = m.top.findNode("qrScanLabel")
    m.qrScanLabel.text = getTextOf("scan_qr")
    m.qrSubLabel = m.top.findNode("qrSubLabel")
    m.qrSubLabel.text = getTextOf("scan_qr_label")
    m.menuItems = getAccountMenuItems()
    m.cards = []
    buildOptionsList()
    setFocusOnItem(m.focusedIndex)
    loadAccountData()

    bgRect = m.top.findNode("bg")
    if bgRect <> invalid then bgRect.color = getBackGroundColor1()

    if m.avatarBg <> invalid then m.avatarBg.color = getDefaultCardColor()
    if m.userName <> invalid then m.userName.color = getTextColor()
    if m.userEmail <> invalid then m.userEmail.color = getSecondaryTextColor()
    if m.coinLabel <> invalid then m.coinLabel.color = getTextColor()
    c = getButtonSelectionColor()
    if Left(c, 1) = "#" then c = Mid(c, 2)
    if Len(c) = 6 then c = c + "FF"
    accentColor = "0x" + c
    ' if m.qrBg <> invalid then m.qrBg.blendColor = "#FFFFFF"

    avatarRing = m.top.findNode("avatarRing")
    if avatarRing <> invalid
        bgColor = getBackGroundColor1().Replace("#", "")
        avatarRing.blendColor = getBackGroundColor1() '"0x" + bgColor + "FF"
    end if
end sub

sub buildOptionsList()
    cardHeight = 94
    cardSpacing = 12
    for i = 0 to m.menuItems.count() - 1
        card = m.optionsList.createChild("AccountOptionItem")
        card.translation = [0, i * (cardHeight + cardSpacing)]
        card.itemContent = m.menuItems[i]
        m.cards.push(card)
    end for
end sub

sub setFocusOnItem(idx as integer)
    for i = 0 to m.cards.count() - 1
        card = m.cards[i]
        if card <> invalid
            card.isFocused = (i = idx)
        end if
    end for
    m.focusedIndex = idx
    updateScroll()
end sub

sub updateScroll()
    if m.focusedIndex > m.scrollOffset + m.maxVisibleItems - 1
        m.scrollOffset = m.focusedIndex - m.maxVisibleItems + 1
    else if m.focusedIndex < m.scrollOffset
        m.scrollOffset = m.focusedIndex
    end if

    for i = 0 to m.cards.count() - 1
        card = m.cards[i]
        if card = invalid then continue for
        visibleIdx = i - m.scrollOffset
        if visibleIdx >= 0 and visibleIdx < m.maxVisibleItems
            card.visible = true
            card.translation = [0, visibleIdx * m.cardTotalHeight]
        else
            card.visible = false
        end if
    end for
end sub

sub loadAccountData()
    m.accountTask = CreateObject("roSGNode", "AccountDataTask")
    m.accountTask.observeField("accountData", "onAccountDataLoaded")
    m.accountTask.control = "RUN"
end sub

sub onAccountDataLoaded()
    showLoader(false)
    data = m.accountTask.accountData
    if data = invalid then return

    firstName = ""
    lastName = ""
    if data.first_name <> invalid then firstName = data.first_name.Trim()
    if data.last_name <> invalid then lastName = data.last_name.Trim()

    fullName = firstName
    if lastName <> "" then fullName = firstName + " " + lastName
    if fullName.Len() > 18 then fullName = fullName.Left(18) + "..."
    m.userName.text = fullName

    if data.user_email <> invalid then m.userEmail.text = data.user_email.Trim()

    if data.user_image <> invalid and data.user_image <> ""
        m.avatarPoster.uri = data.user_image
    else
        m.avatarPoster.uri = "pkg:/images/avatar.png"
    end if

    if data.account_qr <> invalid and data.account_qr <> ""
        m.qrPoster.uri = data.account_qr
    end if
end sub

sub onAvatarLoadStatus()
    if m.avatarPoster.loadStatus = "failed" or m.avatarPoster.loadStatus = "noResponse"
        m.avatarPoster.uri = "pkg:/images/avatar.png"
    end if
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "up"
        newIdx = m.focusedIndex - 1
        if newIdx >= 0 and m.cards.count() > 0
            setFocusOnItem(newIdx)
        end if
        return true
    else if key = "down"
        newIdx = m.focusedIndex + 1
        if newIdx < m.cards.count()
            setFocusOnItem(newIdx)
        end if
        return true
    else if key = "OK"
        selectedItem = m.menuItems[m.focusedIndex]
        itemKey = ""
        if selectedItem.key <> invalid then itemKey = selectedItem.key
        if selectedItem.type = "MY_LIST"
            m.top.goToMyListScreen = true
        else if selectedItem.type = "LOGOUT"
            m.top.requestLogout = true
        else if selectedItem.type = "LANGUAGE_SELECTION"
            m.top.requestLanguageSelection = true
        else if selectedItem.type = "GENRE"
            if selectedItem.key <> invalid and selectedItem.key <> ""
                m.top.goToShowMoreScene = { key: selectedItem.key, type: selectedItem.type, title: selectedItem.title }
            end if
        else if selectedItem.type = "MY_SUBSCRIPTIONS"
            m.top.goToPlanDetailsScreen = true
        else if selectedItem.type = "CHANGE_PASSWORD"
            m.top.requestChangePassword = true
        else if selectedItem.type = "LOGOUT_ALL"
            showWarningPopup(getTextOf("logout_all_devices_alert"), "LOGOUT_ALL")
        else if selectedItem.type = "DELETE_ACCOUNT"
            showWarningPopup(getTextOf("delete_confirmation"), "DELETE_ACCOUNT")
        else if selectedItem.type = "INFO"
            configKey = ""
            if selectedItem.key <> invalid then configKey = selectedItem.key
            sec = CreateObject("roRegistrySection", getAppKey2())
            rawText = ""
            if configKey <> "" and sec.Exists(configKey) then rawText = sec.Read(configKey)
            m.top.goToInfoScreen = { title: selectedItem.title, text: rawText, configType: configKey }
        end if
        return true
    else if key = "back"
        m.top.goBack = true
        return true
    end if

    return false
end function

function getAccountMenuItems() as object
    sec = CreateObject("roRegistrySection", getAppKey2())
    items = []
    if not sec.Exists("ACCOUNT_ITEMS") then return items
    parsed = ParseJson(sec.Read("ACCOUNT_ITEMS"))
    if parsed = invalid then return items
    for each item in parsed
        if item.type = "PROFILE" then continue for
        menuItem = {
            type: item.type,
            title: getTextOf(item.title_key),
            icon: ""
        }
        if item.icon <> invalid and item.icon <> "" then menuItem.icon = item.icon
        if item.key <> invalid and item.key <> "" then menuItem.key = item.key
        if item.sub_text_key <> invalid and item.sub_text_key <> ""
            menuItem.subtitle = getTextOf(item.sub_text_key)
        end if
        items.push(menuItem)
    end for
    return items
end function

sub showWarningPopup(message as string, id as string)
    scene = m.top.GetScene()
    scene.showCustomDialog = {
        id: id,
        title: getText("warning"),
        message: message,
        buttons: [getText("yes"), getText("no")],
        origin: m.top ' Passing this allows MainScene to talk back to this component
    }
end sub

sub callLogoutAllApi()
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogoutResponseAll")
    m.LogoutTaskAll.callFunc("runLogoutTask", "")
end sub

function OnLogoutResponseAll()
    ? "OnLogoutResponseAll called"
    m.LogoutTaskAll.callFunc("stopLogoutTask", "")
    DeleteRegistryCommon()
    m.top.closeAllScreens = true
    m.top.goToSplashScreen = true
end function

sub callDeleteAccountApi()
    m.DeleteAccountTask = CreateObject("roSGNode", "DeleteAccountTask")
    m.DeleteAccountTask.observeField("deleteAccountResponse", "OnDeleteAccountResponse")
    m.DeleteAccountTask.callFunc("runDeleteAccountTask", "")
end sub

sub OnDeleteAccountResponse()
    ? "OnDeleteAccountResponse called"
    m.DeleteAccountTask.callFunc("stopDeleteAccountTask", "")
    DeleteRegistryCommon()
    m.top.closeAllScreens = true
    m.top.goToSplashScreen = true
end sub

sub OnDialogAction(_event as object)
    result = _event.GetData()
    buttonClicked = result.buttonIndex
    buttonText = result.buttonText
    id = result.id

    if id = "LOGOUT_ALL" and buttonText = getText("yes")
        showLoader(true)
        callLogoutAllApi()
    else if id = "DELETE_ACCOUNT" and buttonText = getText("yes")
        showLoader(true)
        callDeleteAccountApi()
    end if
end sub

sub showLoader(show as boolean)
    if m.loadingIndicator <> invalid
        m.loadingIndicator.visible = show
    end if 
end sub
