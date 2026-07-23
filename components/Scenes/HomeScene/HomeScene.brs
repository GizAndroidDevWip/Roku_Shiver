function Init()
    m.collapsedMenu = m.top.findNode("collapsedMenu")
    m.collapsedMenu.observeField("itemSelected", "OnMenuButtonSelected")
    m.collapsedMenu.loginlogout = true
    m.collapsedMenu.visible = true
    m.onceGuestRegisterCalled = 0
    m.GridScreen = m.top.findNode("GridScreen")
    m.loadingIndicator = m.top.findNode("loading")
    m.loadingIndicatorBelowTopMenu = m.top.findNode("loading2")
    m.GuestFetcher = CreateObject("roSGNode", "GuestFetcher")
     m.top.signalBeacon("AppLaunchComplete")
    m.languageLblListReact = m.top.findNode("languageLbllist_react")
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor()
    m.loadingIndicator.visible = true
    m.top.itemComponentName = "customitemhome"
    font = CreateObject("roSGNode", "Font")
    font.size = 50
    font.color = "#FFFFFF"
    m.top.rowLabelFont = font

    if IsNotBlank(m.top.getScene().SMARTHOME_SELECTED) then
        m.lastSelectedSmarthomeType = m.top.getScene().SMARTHOME_SELECTED ' to store last selected smart home type when coming from other scene to set focus on same smart home type in top menu and load the same smart home type content in home scene
    else
        m.lastSelectedSmarthomeType = "LOAD_HOME" ' to store last selected smart home type to avoid setting homeType again when same smart home type is selected from top menu
    end if

    if getMULTI_LANGUAGE_REQUIRED() = "true"
        if IsLanguageSettingFirstTime() = "true" 'and (m.global.langauge_id = invalid or m.global.langauge_id = 0)
            m.languageLblListReact.visible = true
            runMultiLanguageListApiTask()
        else
            m.languageLblListReact.visible = false
            m.GridScreen.homeType = m.lastSelectedSmarthomeType
        end if
    else
        m.languageLblListReact.visible = "false"
        m.GridScreen.homeType = m.lastSelectedSmarthomeType
    end if

    m.loadingIndicator = m.top.findNode("loading")
    m.PaymentDescription = m.top.findNode("PaymentDescription")
    m.LiveTV = m.top.findNode("LiveTV")
    m.LiveTV.observeField("Finish", "OnFinishedLive")
    m.screenStack = []
    m.Hud = m.top.findNode("Hud")
    
    ' userSubscriptionChecking()
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = "You are no longer Logged in this device. Please  again to access."
    okTitle = getTextOf("ok")' Default value
    logoutAllTitle = getTextOf("logout_all") ' Default value
    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")
    m.LogoutTask1 = CreateObject("roSGNode", "LogoutTask")
    m.LogoutTask1.observeField("LogoutResponse", "logoutAndGoToLandingScene")
    m.top.sessionExpiredPopUp = CreateObject("roSGNode", "BackDialog")
    m.top.sessionExpiredPopUp.backgroundUri = "pkg:/images/black.jpg"
    m.top.sessionExpiredPopUp.title = getTextOf("session_expired_message")
    m.top.sessionExpiredPopUp.buttons = ["Ok"]
    m.top.sessionExpiredPopUp.ObserveField("buttonSelected", "OnsessionExpiredClick")
    m.count2 = 0
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")
    m.dialogbg_rect.observeField("visible", "onDialogRectVisibleChange")
    m.NoButton = m.top.findNode("NoButton")
    m.NoButton.getChild(0).blendColor = getButtonSelectionColor()
    m.YesButton = m.top.findNode("YesButton")
    m.YesButton.getChild(0).blendColor = getButtonSelectionColor()
    m.dialogmessage_label = m.top.findNode("dialogmessage_label")
    m.cancelbutton_Label = m.top.findNode("cancelbutton_Label")
    m.exitbutton_Label = m.top.findNode("exitbutton_Label")
    m.NoButton.ObserveField("buttonSelected", "onDialogNoSelected")
    m.YesButton.ObserveField("buttonSelected", "onDialogYesSelected")
    m.isWatchWithOutAdsDialogRectVisibleForHome = false ' dialog box visible flag for watch withoutads
    m.continueWatchingDialogVisibleForHome = false 'same dialog box using another flag for continue watching
    m.AlertDialogVisible = false 'same dialog box using another flag for  alert
    m.menuslideRight = m.top.findNode("menuslideRight")
    m.menuslideLeft = m.top.findNode("menuslideLeft")
    m.zoomInHeight = m.top.findNode("zoomInHeight")
    m.isCollapsedMenuOpenNow = false
    m.top.observeField("visible", "onTopVisibleChange")
    m.top.observeField("triggerLogoutWarning", "onTriggerLogoutWarning")
    m.top.observeField("triggerLanguageSelection", "onTriggerLanguageSelection")
    m.language_Lbl2 = m.top.findNode("language_Lbl2")
    m.languageLbl = m.top.findNode("language_Lbl")
    m.languageLbl.text = getTextOf("select_language")
    m.language_Lbl2.text = getTextOf("language_selection_subtext")
    m.languageLabelist = m.top.findNode("selectLanguage")
    m.languageLabelist.focusBitmapBlendColor = getButtonSelectionColor()
    m.languageLabelist.focusFootprintBlendColor = getButtonSelectionColor()
    m.languageLabelist.observeField("itemSelected", "onLanguageLabelListSelected")
    ? m.languageLabelist
    m.ExitButtonDialogRectVisible = false ' dialog box visible flag for Exit button in menu Bar
    m.LogoutButtonDialogVisible = false 'same dialog box using another flag for Logout Button in menu bar
    m.global.channelStore.command = "getAllPurchases"
    m.global.channelStore.ObserveField("purchases", "OnGetPurchases")
    m.global.channelStore.observeField("requestStatus", "onRequestStatus")
    m.languageLblListReact.color = getBackGroundColor()
    m.languageLbl.color = getTextColor()
    m.language_Lbl2.color = getTextColor()
    m.languageLabelist.color = getTextColor()
    m.languageLabelist.color = getTextColor()
    m.languageLabelist.focusedColor = "#FFFFFF"

    m.prev_Home_Topmenu_Index = 0' to store previous focused index of top menu rowlist -setting focus to home on load
    m.HomeTopMenuRowlist = m.top.getScene().findNode("HomeTopMenuRowlist")
    m.HomeTopMenuRowlist.initialiseTopMenuRowlist = true ' to initialise top menu rowlist on home scene load
    initialiseTopMenuRowlist({})
end function

sub onUtilityDataChange()
    if m.top.utilityAssoc <> invalid

        initialiseTopMenuRowlist(m.top.utilityAssoc)
        utilityData = m.top.utilityAssoc
    end if

end sub



function setLanguageSettingToTrueForNewUser()
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("Is_Language_Setting_First_Time", "true") ' Reset the value to "true"
    sec.Flush()
end function


sub onLanguageLabelListSelected()
    m.MultiLanguageUserUpdateTask = CreateObject("roSGNode", "MultiLanguageUserUpdateTask")
    languageselected = m.languageLabelist.content.getChild(m.languageLabelist.itemSelected).language_id
    m.MultiLanguageUserUpdateTask.observeField("MultiLanguageUserUpdateApiTaskListStatus", "ResponseUpdateStatus")
    m.MultiLanguageUserUpdateTask.callFunc("runMultiLanguageUserUpdateApiTask", languageselected)
end sub



sub ResponseUpdateStatus()
    setIsLanguageSettingFirstTime("updated")
    setLanguageSelected(m.languageLabelist.content.getChild(m.languageLabelist.itemSelected).TITLE)
    ' m.loadingIndicator.visible = true
    ' m.languageLblListReact.visible = false
    ' m.GridScreen.homeType = "LOAD_HOME"
    ' m.collapsedMenu.start = true
    m.top.closeAllScreen = true
    m.top.goToSplashScreen = true
end sub



sub onTopVisibleChange()
    if m.top.visible = true
        section = CreateObject("roRegistrySection", getAppKey())
        if section.Exists("isJustLoggedIn") and section.read("isJustLoggedIn") = "yes"
            OnFinished()
            section.Write("isJustLoggedIn", "noChange")
        else
            m.collapsedMenu.logout = "OnFinished"
            m.GridScreen.setFocus(true)
        end if
    else
        stopAllPlayers()
        if m.global.Live_player <> invalid and m.global.Live_player.getchild(3) <> invalid
            m.global.Live_player.getchild(3).control = "stop" ' stopping the live player in homebanner when going to other pages
            ?m.global.Live_player.state
            m.global.Live_player = invalid
        end if

    end if
end sub

sub OnFinished()
    print "OnFinished"
    m.loadingIndicator.visible = true
    m.GridScreen.homeType = m.lastSelectedSmarthomeType
    m.collapsedMenu.logout = "OnFinished"
end sub

sub initCheck()
    ?"initCinitCheckheck called"
    if check() <> invalid
        if isGuest() = "true"
            print "templateGuest"
            m.collapsedMenu.logout = "OnFinished"
        else
            print "logged in"
            m.collapsedMenu.logout = "OnFinished"
        end if
    else
        print "first "
    end if

    m.GridScreen.setFocus(true)
end sub



sub onVisibleChangelist()
    if m.Player <> invalid
        if m.Player.visibility = false then
            m.MyListScene.visible = true
            m.MyListScene.setFocus(true)
        end if
    end if
end sub



sub onVisibleChangesearch()
    if m.Player <> invalid
        if m.Player.visibility = false then
            m.Search.visible = true
        end if
    end if
end sub

sub OnFinishedLive()
    print "OnFinished"
    m.Landing.visible = false
    m.loadingIndicator.visible = true
    m.GridScreen.homeType = m.lastSelectedSmarthomeType
    m.collapsedMenu.logout = "OnFinished"
end sub


sub runMultiLanguageListApiTask()
    print " runMultiLanguageListApiTask called"
    m.loadingIndicator.visible = true
    m.MultiLanguageListApiTask = CreateObject("roSGNode", "MultiLanguageListApiTask")
    m.MultiLanguageListApiTask.observeField("MultiLanguageListApiTaskContent", "onResponse")
    m.MultiLanguageListApiTask.callFunc("runMultiLanguageListApiTask", "")
end sub

sub onResponse()
    m.languageLabelist.content = m.MultiLanguageListApiTask.MultiLanguageListApiTaskContent
    m.languageLabelist.setFocus(true)

    for i = 0 to m.languageLabelist.content.getChildCount() - 1
        if m.languageLabelist.content.getChild(i).title = getLanguageSelected() '********code to set select previously selected language
            m.languageLabelist.jumpToItem = i
        end if
    end for
    m.loadingIndicator.visible = false
end sub

sub runMultiLanguageUserUpdateApiTask()
    print "runMultiLanguageUserUpdateApiTask"
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



sub DeleteRegistry()
    print "Starting Delete Registry"
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1
            if key <> "templateInstalled" and key <> "templateGuestEvent" and key <> "country_code" and key <> "ippaddress" and key <> "channelsids" and key <> "PubID" and key <> "countrycode" and key <> "channelID" and key <> "MENU_ITEMS_TITLE" and key <> "MENU_ITEMS_ORDER" and key <> "MENU_ITEMS_TYPE" and key <> "Is_Language_Setting_First_Time"
                print "Deleting " section + ":" key
                RegistrySection.Delete(key)
            else
                ?key + " not deleted"
            end if
        end for
        RegistrySection.flush()
    end for
    print i.toStr() " Registry Keys Deleted"
    m.loadingIndicator.visible = true
end sub

function checkregtrue() as dynamic
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("regtrue")
        print "exists reg true"
        return sec.Read("regtrue")
    else
        print "invalid"
        return invalid
    end if
end function

function checksubtrue() as dynamic
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("subtrue")
        tok = sec.Read("subtrue")
        print "subtruecond"
        print tok
        return tok
    else
        print "invalid"
        return invalid
    end if
end function

function loadDeep()
    print "***load deep***"
    jsonitem = m.top.deepLinkContent
    print jsonitem
    m.GridScreen.setFocus(false)
    print "....video started...."
    VODcontent = jsonitem
    m.global.AdTracker = 0
    m.global.Options = 1
    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    macroDNT = "true"
    if di.IsRIDADisabled()
        macroDNT = "false"
    end if
    macroIP = di.GetExternalIp()
    version = di.GetVersion()
    version_major = mid(version, 3, 1)
    version_minor = mid(version, 5, 2)
    version_build = mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = mid(version_minor, 2)
    end if
    macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()

    print "channelid"
    print VODcontent.channel_id
    macroChannelID = VODcontent.channel_id
    macroVideoID = Str(VODcontent.video_id).Trim()
    macroDuration = VODcontent.video_duration
    macrouserID = VODcontent.user_id
    cat = VODcontent.cate

    if cat <> invalid then
        category = ""
        arrayLength = cat.count()
        lastItem = cat[arrayLength - 1]

        for each item in cat
            if(arrayLength < 2)
                category = category + item
            else
                if(item = lastItem)
                    category = category + item
                else
                    category = category + item + ","
                end if


            end if
        end for
    end if

    print "macrocate"
    print category

    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("category", category)
    sec.Flush()
    print "***********videoidiss**********8"
    macrvideoID = VODcontent.video_id
    print macrvideoID
    print "***********videotitle**********8"
    macrotitle = VODcontent.title
    print macrotitle
    m.uidana = getUserIdana()
    print "m.uidana"
    print m.uidana
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("videoID", VODcontent.video_id)
    sec.Write("videoTITLE", VODcontent.title)
    sec.Write("channelID", VODcontent.channel_id)
    sec.Flush()
    adUURRLL = VODcontent.ad_link
    finalAdURL = "https://search.spotxchange.com/vast/2.0/224109?VPI[]=MP4&player_width=1920&player_height=1280&app[bundle]=" + getBundleID()
    ? "********************"
    ? finalAdURL
    ? "********************"
    videoContent = {
        streamFormat: VODcontent.streamFormat,
        '        titleSeason: VODcontent.titleSeason,
        title: VODcontent.title,
        url: VODcontent.url,
        categories: VODcontent.categories
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: VODcontent.video_duration
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.ad_url = finalAdURL.EncodeUri()
    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if

    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.control = "play"
    m.Player.observeField("visibility", "onVisibleChange")
end function


function check() as dynamic
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("publish")
        toks = sec.Read("publish")
        if(toks = "Template")
            if sec.Exists("USER_ID")
                return sec.Read("USER_ID")
            else
                return invalid
            end if
        end if
    end if
end function


function OnRowItemSelected()
    print "OpenDetailsScreen called"
    m.GridScreen.releasePlayer = true
    rowFocused = m.gridScreen.focusedRow[0]
    if m.gridScreen.focusedContent.checkout_qr <> invalid and m.gridScreen.focusedContent.checkout_qr <> ""
        showQrOverlay(m.gridScreen.focusedContent.checkout_qr)
        return true
    end if
    if m.gridScreen.focusedContent.itemType = "banner"
        m.loadingIndicator.visible = false

    else if m.gridScreen.focusedContent.itemType = "CONTINUE_WATCHING"
        ?"CONTINUE_WATCHING called"
        m.top.ai_type = m.gridScreen.focusedContent.ai_type
        m.top.goToVideoPlayerScene = m.gridScreen.focusedContent.video_id


    else if m.gridScreen.focusedContent.itemType <> invalid and m.gridScreen.focusedContent.itemType = "SHOW" or m.gridScreen.focusedContent.itemType = "BANNER" or m.gridScreen.focusedContent.itemType = "SCHEDULE" or m.gridScreen.focusedContent.itemType = "UPCOMING_EVENT" or m.gridScreen.focusedContent.itemType = "LIVE_EVENT"
        m.loadingIndicator.visible = false


    else if m.gridScreen.focusedContent.itemType = "LIVE"
        checkLiveNowSubscription()

    else if m.gridScreen.focusedContent.itemType = "FASTCHANNEL"
        checkTimeGridSubscription()

    else if m.gridScreen.focusedContent.itemType = "SHORTS"
        if getSHORTS_LOGIN_REQUIRED() = "true" and isGuest() = "true"
            showAlertDialog()
        else
            m.top.playSelectedShortsVideo = str(m.gridScreen.focusedContent.video_id)
            ?"k"
        end if
    else if m.gridScreen.focusedContent.itemType = "SMART_HOME"
        selectedKey = invalid
        if m.gridScreen <> invalid and m.gridScreen.focusedContent <> invalid
            selectedKey = m.gridScreen.focusedContent.key
        end if
        utilityAssoc = {
            key: m.gridScreen.focusedContent.key,
            title: m.gridScreen.focusedContent.title,
            type: m.gridScreen.focusedContent.type
        }
        initialiseTopMenuRowlist(utilityAssoc)

    end if

end function

sub showQrOverlay(checkout_qr_url)
    if isGuest() = "true"
        m.top.goToLandingScene = true
        return
    end if
    ' 1. Create the instance using the component name defined in XML
    m.qrOverlay = invalid
    m.qrOverlay = m.top.createChild("BigQRComponent")
    m.qrOverlay.unobserveField("closeQROverlay")
    m.qrOverlay.ObserveField("closeQROverlay", "onQrOverlayClose")
    m.qrOverlay.unobserveField("refreshRequested")
    m.qrOverlay.ObserveField("refreshRequested", "onQrOverlayRefreshRequested")

    ' 2. Set the fields programmatically
    m.qrOverlay.id = "myQrOverlay"
    m.qrOverlay.buttonsArray = [getTextOf("refresh"), getTextOf("cancel")] ' Set button titles dynamically based on localization
    ' m.qrOverlay.text = ""
    ' m.qrOverlay.description1 = ""
    ' m.qrOverlay.description2 = ""
    ' m.qrOverlay.description3 = ""
    m.qrOverlay.qrUrl = checkout_qr_url

    ' 3. Manage visibility and focus
    m.qrOverlay.visible = true
    m.qrOverlay.setFocus(true)
end sub

sub onQrOverlayClose()
    if m.qrOverlay <> invalid
        m.qrOverlay.visible = false
        m.qrOverlay.setFocus(false)
        m.top.removeChild(m.qrOverlay)
        m.GridScreen.setFocus(true)
        m.qrOverlay = invalid
    end if
end sub

sub onQrOverlayRefreshRequested()
    m.top.gotoHomeScenen = true
end sub


sub On_dialogAuthExceed_buttonSelected()
    if m.top.dialogAuthExceed.buttonSelected = 0
        m.parentScene.dialog.close = true
        m.loadingIndicator.visible = false
    else if m.top.dialogAuthExceed.buttonSelected = 1
        m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
        m.LogoutTaskAll.observeField("LogoutResponse", "logoutAndGoToLandingScene")
        m.LogoutTaskAll.callFunc("runLogoutTask", "")
        m.loadingIndicator.visible = true
    end if
end sub

sub OnsessionExpiredClick()
    m.LogoutTask1.callFunc("runLogoutTask", "")
    m.loadingIndicator.visible = true
end sub

sub logoutAndGoToLandingScene()
    ?"logoutAndGoToLandingScene called"
    try
        if GetParentScene() = invalid then
            return
        end if

        Registry = CreateObject("roRegistry")
        i = 0
        for each section in Registry.GetSectionList()
            RegistrySection = CreateObject("roRegistrySection", section)
            for each key in RegistrySection.GetKeyList()
                i = i + 1
                ' if key <> "templateInstalled" and key <> "templateGuestEvent" and key <> "country_code" and key <> "ippaddress" and key <> "channelsids" and key <> "PubID" and key <> "countrycode" and key <> "channelID" and key <> "MENU_ITEMS_TITLE" and key <> "MENU_ITEMS_ORDER" and key <> "MENU_ITEMS_TYPE" and key <> "REVERSE_TV_CODE_FLOW" and key <> "BUTTON_SELECTION_COLOR" and key <> "SIGN_IN_MESSAGE" and key <> "REGISTRATION_MANDATORY" and key <> "SIGN_UP_REQUIRED"
                if key = "USER_ID" or key = "userName" or key = "userEmail" or key = "userPhone"
                    print "Deleting " section + ":" key
                    RegistrySection.Delete(key)
                else
                    ?key + " not deleted"
                end if
            end for
            RegistrySection.flush()
        end for
        print i.toStr() " Registry Keys Deleted"
        m.top.logout = true
        m.loadingIndicator.visible = false
        m.parentScene.dialog.close = true
        m.top.goToLandingSceneAndCloseAllScreens = true
    catch E
    end try
end sub

sub checkTimeGridSubscription()

    if m.gridscreen.content <> invalid and m.gridscreen.content.getchild(1) <> invalid and m.gridscreen.content.getchild(1).getChildCount() <> invalid
        m.channelId = m.gridscreen.content.getchild(m.gridscreen.rowitemselected[0]).getchild(m.gridscreen.rowitemselected[1]).channel_id
    else
        m.channelId = getchannelsid()
    end if


    if (getSubscriptionRequired() = "true")
        if isGuest() = "true"
            ?"rerer"
            m.top.goToLandingScene = true

        else if isGuest() = "false"
            ?"hjrrere"
            callSubCheckAPi(Str(m.channelId).Trim())
        end if
    else
        if isGuest() = "true"
            ?"erree33"
            ifRegisterationMandatoryOrNot() '************** Registeration Mandatory checking

        else
            ?"889ijjkkj"
            focusedRow = m.top.rowItemSelected
            OnLiveItemSelected(focusedRow)
        end if
    end if
end sub



sub checkLiveNowSubscription()
    if m.gridscreen.content <> invalid and m.gridscreen.content.getchild(29) <> invalid and m.gridscreen.content.getchild(29).getchild(0) <> invalid
        m.channelId = m.gridscreen.content.getchild(m.gridscreen.rowitemselected[0]).getchild(m.gridscreen.rowitemselected[1]).channel_id

    else
        m.channelId = getchannelsid()
    end if


    if (getSubscriptionRequired() = "true")
        if isGuest() = "true"
            m.top.goToLandingScene = true

        else if isGuest() = "false"
            callSubCheckAPi(m.channelId.Trim())
        end if
    else
        if isGuest() = "true"
            ifRegisterationMandatoryOrNot() '************** Registeration Mandatory checking

        else
            focusedRow = m.top.rowItemSelected
            OnLiveItemSelected(focusedRow)
        end if
    end if
end sub

sub callSubCheckAPi(channelId)
    ?channelId
    m.ChannelSubsriptionTask = CreateObject("roSGNode", "ChannelSubsriptionTask")
    m.ChannelSubsriptionTask.channelID = channelId
    m.ChannelSubsriptionTask.observeField("channelSubs", "checkLiveNowSubscription2")
    m.ChannelSubsriptionTask.callFunc("runChannelSubsriptionTask", "")
end sub

' Registerartion Mandatory checking
sub ifRegisterationMandatoryOrNot()
    if (getLiveLoginCheck() = "true")
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
    else
        focusedRow = m.top.rowItemSelected
        OnLiveItemSelected(focusedRow)
    end if
end sub

sub checkLiveNowSubscription2()
    if m.ChannelSubsriptionTask.channelSubs = true
        focusedRow = m.top.rowItemSelected
        OnLiveItemSelected(focusedRow)
    else

        showSubscriptionPageForLive(Str(m.channelId).Trim())
    end if
end sub


function loadShows()
    if m.count2 = 0
        m.count2 = 1
        m.loadingIndicator.visible = false
        selectedShowId = m.gridScreen.focusedContent.user_id
        print "selectedShowId 2"
        print selectedShowId
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("templateGuest")
            tok = sec.Read("templateGuest")
            guest = 1
            if(guest = 1)
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("shwid", str(selectedShowId))
                sec.Flush()
            else
            end if
        end if

        ' m.Show.start = selectedShowId
        ' m.Show.Content = m.gridScreen.focusedContent
        m.top.goToShowScreen = true
        ' ShowScreen(m.Show)
    end if
end function

function playLive()
    print "*************live video started**************"

    selectedId = m.gridScreen.focusedContent.channel_id
    VODcontent = m.gridScreen.focusedContent
    ? VODcontent
    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    macroDNT = "true"
    if di.IsRIDADisabled()
        macroDNT = "false"
    end if
    macroIP = di.GetExternalIp()
    version = di.GetVersion()
    version_major = mid(version, 3, 1)
    version_minor = mid(version, 5, 2)
    version_build = mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = mid(version_minor, 2)
    end if
    macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    macroChannelID = Str(VODcontent.channel_id).Trim()
    ' macroVideoID = Str(VODcontent.channel_id).Trim()
    macroDuration = "0"
    ' macrouserID = VODcontent.user_id



    m.EventFetcher = CreateObject("roSGNode", "EventFetcher")
    m.EventFetcher.user_id = getUserIdana()
    m.EventFetcher.event_type = "POP02"
    m.EventFetcher.video_id = "0"
    m.EventFetcher.video_title = ""
    m.EventFetcher.category = ""
    ' m.EventFetcher.channel_id = getChannelid()
    m.EventFetcher.callFunc("runEventFetcher", "")

    videoContent = {

        title: VODcontent.now_playing.video_title,
        url: VODcontent.live_link,
        channel_name: VODcontent.channel_name,
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.

    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)

    if m.PlayerLive = invalid:
        m.PlayerLive = m.top.CreateChild("PlayerLive")
        m.PlayerLive.observeField("state", "PlayerStateChanged")
        m.PlayerLive.observeField("visible", "onVideoVisibleChange")
    end if

    m.PlayerLive.content = content
    m.PlayerLive.visible = true
    m.PlayerLive.setFocus(true)
    m.PlayerLive.control = "play"
    m.PlayerLive.observeField("visibility", "onVisibleChange")
end function

function strReplace(basestr, oldsub, newsub) as string

    newstr = ""


    i = 1
    while i <= Len(basestr)
        x = Instr(i, basestr, oldsub)
        if x = 0 then
            newstr = newstr + Mid(basestr, i)
            exit while
        end if

        if x > i then
            newstr = newstr + Mid(basestr, i, x - i)
            i = x
        end if
        newstr = newstr + newsub.toStr()
        i = i + Len(oldsub)
    end while

    return newstr
end function



function OnLogout()
    m.loadingIndicator.visible = true
    '    HideTop()
    m.LogoutTask.callFunc("runLogoutTask", "")
    ' m.LaunchCheck.callFunc("runLaunchCheck", "")
end function

function OnLogoutResponse()
    ? "OnLogoutResponse called"
    m.LogoutTask.callFunc("stopLogoutTask", "")
    DeleteRegistry()
    ' m.top.appExit = true
    ' m.pubIdTask.callFunc("runPubIdTask", "")
    ' initCheck()
    m.top.closeAllScreen = true
    m.top.goToSplashScreen = true
end function

function OnLogoutall()
    m.loadingIndicator.visible = true
    HideTop()
    m.LaunchCheck.callFunc("runLaunchCheck", "")
end function

function OnLogoutvideo()
    m.loadingIndicator.visible = true
    HideTop()
    m.LaunchCheck.callFunc("runLaunchCheck", "")
    'sleep(3000)
end function

function playVideo()
    m.loadingIndicator.visible = true
    VODcontent = m.gridScreen.focusedContent
    videoDetailsResponse = m.VideoSubscriptionTask.videoDetailsResponse
    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    macroDNT = "1"
    if di.IsRIDADisabled()
        macroDNT = "0"
    end if
    macroIP = di.GetExternalIp()
    version = di.GetVersion()
    version_major = mid(version, 3, 1)
    version_minor = mid(version, 5, 2)
    version_build = mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = mid(version_minor, 2)
    end if
    macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = getCountrycode()'di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    macroChannelID = getChannelsid().Trim()
    macroVideoID = ""
    if VODcontent <> invalid and VODcontent.video_id <> invalid
        macroVideoID = Str(VODcontent.video_id).Trim()
    end if

    macroDuration = ""
    if m.VODcontent1 <> invalid and m.VODcontent1.video_duration <> invalid
        macroDuration = m.VODcontent1.video_duration
    end if
    macrouserID = getUserIdana() 'VODcontent.user_id

    season = ""
    if videoDetailsResponse <> invalid and videoDetailsResponse.season <> invalid
        season = videoDetailsResponse.season.ToStr().Trim()
    end if

    video_order = ""
    if videoDetailsResponse <> invalid and videoDetailsResponse.video_order <> invalid
        video_order = Str(videoDetailsResponse.video_order).Trim()
    end if


    producer = ""
    if videoDetailsResponse <> invalid and videoDetailsResponse.producer <> invalid
        producer = videoDetailsResponse.producer
    end if

    categoryid = ""
    for j = 0 to m.VODcontent1.category_id.count() - 1
        if invalid <> m.VODcontent1.category_id[j]
            if j = m.VODcontent1.category_id.count() - 1
                categoryid = categoryid + Str(m.VODcontent1.category_id[j]).Trim()
            else
                categoryid = categoryid + Str(m.VODcontent1.category_id[j]).trim() + ","
            end if
        else
            categoryid = ""
        end if
    end for

    category_name = ""
    if invalid <> videoDetailsResponse.category_name
        for j = 0 to videoDetailsResponse.category_name.count() - 1
            if videoDetailsResponse.category_name[j] <> invalid and j = videoDetailsResponse.category_name.count() - 1
                category_name = category_name + videoDetailsResponse.category_name[j].Trim()
            else
                category_name = category_name + videoDetailsResponse.category_name[j].trim() + ","
            end if
        end for
    else
        category_name = ""
    end if

    if getCountrycode() = "EU"
        consent = "1"
        GDPR = "1"
    else
        consent = "0"
        GDPR = "0"
    end if

    if videoDetailsResponse <> invalid and videoDetailsResponse.synopsis <> invalid
        synopsis = videoDetailsResponse.synopsis
    else
        synopsis = ""
    end if

    show_id = ""
    if VODcontent <> invalid and VODcontent.show_id <> invalid
        show_id = VODcontent.show_id.ToStr()
    end if

    title = ""
    if VODcontent <> invalid and VODcontent.title <> invalid
        title = VODcontent.title.Trim()
    end if

    video_name = ""
    if m.VODcontent1 <> invalid and m.VODcontent1.video_name <> invalid
        video_name = m.VODcontent1.video_name.Trim()
    end if

    TITLESEASON = ""
    if VODcontent <> invalid and VODcontent.TITLESEASON <> invalid
        TITLESEASON = VODcontent.TITLESEASON.Trim()
    end if

    rating = ""
    if VODcontent <> invalid and VODcontent.rating <> invalid
        rating = VODcontent.rating.Trim()
    end if

    dt = CreateObject("roDateTime")
    timestamp = dt.AsSeconds().ToStr()
    timeStampPre = dt.AsSeconds()
    timeStampMilliSeconds = (timeStampPre.ToStr() + "000")
    adUURRLL = VODcontent.ad_link
    dt = CreateObject("roDateTime")

    ' ad_link = "https://ads.poppo.tv/vmap?pid=366&width=[WIDTH]&height=[HEIGHT]&dnt=[DNT]&ip=[IP_ADDRESS]&lat=[LATITUDE]&lon=[LONGITUDE]&ua=[USER_AGENT]&advid=[DEVICE_IFA]&uuid=[UUID]&country=[COUNTRY]&city=[CITY]&region=[REGION]&deviceid=[DEVICE_ID]&kwds=[KEYWORDS]&device_model=[DEVICE_MODEL]&device_make=[DEVICE_MAKE]&channelid=[CHANNEL_ID]&userid=[USER_ID]&videoid=[VIDEO_ID]&bundleid=[BUNDLE]&appname=[APP_NAME]&totalduration=[DURATION]&showid=[SHOW_ID]&categories=[CATEGORIES]&description_url=[APP_STORE_URL]"
    ' ad_link          = "https://ads.poppo.tv/vmap?pid=366&width=1920&height=1080&dnt=true&ip=103.165.21.42&lat=9.9628&lon=76.2964&ua=Roku/DVP-9.99(999.99E99999A)&advid=000bf2e5-4323-5a82-9013-d91b03fdcc14&uuid=eca87af1-ab57-5a84-8540-0a12efd2a423&country=IN&city=Ernakulam&region=Kerala&deviceid=eca87af1-ab57-5a84-8540-0a12efd2a423&kwds=Eh%20to%20Zed,Stranger%20than%20Fiction,Agent%20Provocateur&device_model=3920X&device_make=RA&channelid=366&userid=183916&videoid=7392&bundleid=com.justwatchmetv.roku&appname=ISG &totalduration=3120&showid=3359&categories=455,444,454&description_url=https://channelstore.roku.com/en-ot/details/58f2493e3b9096c12326a1a31d2640e2/isg"
    ' adUURRLL = ad_link
    adUURRLL = m.VODcontent1.ad_link

    categories = []
    if VODcontent <> invalid and VODcontent.categories <> invalid and VODcontent.categories[0] <> invalid
        categories = VODcontent.categories
    end if
    categoriesWithComma = ""
    if categories <> invalid
        for i = 0 to categories.Count() - 1
            if categories <> invalid and categories[i] <> invalid and categories[i].category_name <> invalid
                if categoriesWithComma <> ""
                    categoriesWithComma = categoriesWithComma + "," + categories[i].category_name
                else
                    categoriesWithComma = categoriesWithComma + categories[i].category_name
                end if
            end if
        end for
    end if


    temp1 = strReplace(adUURRLL, "[WIDTH]", macroWidth)
    temp2 = strReplace(temp1, "[HEIGHT]", macroHeight)
    temp3 = strReplace(temp2, "[DNT]", macroDNT)
    temp4 = strReplace(temp3, "[IP_ADDRESS]", macroIP)
    temp5 = strReplace(temp4, "[USER_AGENT]", macroUserAgent)
    temp6 = strReplace(temp5, "[DEVICE_IFA]", macroADID.Escape())
    temp7 = strReplace(temp6, "[UUID]", macroUUID)
    temp8 = strReplace(temp7, "[USER_ID]", macrouserID.Trim())
    temp9 = strReplace(temp8, "[REGION]", getRegion().Escape())
    temp10 = strReplace(temp9, "[COUNTRY]", getCountrycode().Escape())
    temp11 = strReplace(temp10, "[DEVICE_ID]", macroUUID)
    temp12 = strReplace(temp11, "[DEVICE_MODEL]", macroDevModel.Escape())
    temp13 = strReplace(temp12, "[CHANNEL_ID]", macroChannelID.Trim())
    temp14 = strReplace(temp13, "[VIDEO_ID]", macroVideoID.Trim())
    temp15 = strReplace(temp14, "[APP_STORE_URL]", getRokuChannelStoreURL().EncodeUri())
    temp16 = strReplace(temp15, "[DEVICE_MAKE]", "RA")
    temp17 = strReplace(temp16, "[BUNDLE]", getBundleID())
    temp18 = strReplace(temp17, "[LATITUDE]", getLatitude().Trim())
    temp19 = strReplace(temp18, "[LONGITUDE]", getLongitude().Trim())
    temp20 = strReplace(temp19, "[KEYWORDS]", category_name.Escape())
    temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle().Escape())
    temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
    temp23 = strReplace(temp22, "[CITY]", getCity().Escape())
    temp24 = strReplace(temp23, "[SHOW_ID]", show_id.Trim())
    temp25 = strReplace(temp24, "[CATEGORIES]", category_name.Escape())
    temp26 = strReplace(temp25, "[CONTENT_TITLE]", title.Escape())
    temp27 = strReplace(temp26, "[VIDEO_TITLE]", title.Escape())
    temp28 = strReplace(temp27, "[VIDEO_URL]", video_name.Escape())
    temp29 = strReplace(temp28, "[CHANNEL_NAME]", getAppTitle().Escape())
    temp30 = strReplace(temp29, "[AUTOPLAY]", "0")
    temp31 = strReplace(temp30, "[MUTE]", "0")
    temp32 = strReplace(temp31, "[DEVICE_IFA]", di.GetRIDA())
    temp33 = strReplace(temp32, "[OS]", "rokuos")
    temp34 = strReplace(temp33, "[OS_VERSION]", di.GetOSVersion().major)
    temp35 = strReplace(temp34, "[ISP]", getIsp().Escape())
    temp36 = strReplace(temp35, "[DEVICE_BRAND_NAME]", "roku")
    temp37 = strReplace(temp36, "[LMT]", "0")
    temp38 = strReplace(temp37, "[SEASON]", season.Escape())
    temp39 = strReplace(temp38, "[EPISODE]", video_order.Escape())
    temp40 = strReplace(temp39, "[SERIES]", TITLESEASON.Escape())
    temp41 = strReplace(temp40, "[PRODUCER]", producer.Trim().Escape())
    temp42 = strReplace(temp41, "[IS_LIVE]", "0")
    temp43 = strReplace(temp42, "[RATING]", rating.Escape())
    temp44 = strReplace(temp43, "[LANGUAGE]", "English")
    temp45 = strReplace(temp44, "[AD_POSITION]", "7")
    temp46 = strReplace(temp45, "[PLACEMENT]", "1")
    temp47 = strReplace(temp46, "[SKIPPABLE]", "0")
    temp48 = strReplace(temp47, "[PRODUCTION_QUALITY]", "1")
    temp49 = strReplace(temp48, "[CONSENT]", consent)
    temp50 = strReplace(temp49, "[GDPR]", GDPR)
    temp51 = strReplace(temp50, "[COPPA]", "1")
    temp52 = strReplace(temp51, "[DNT]", "1")
    temp53 = strReplace(temp52, "[CACHEBUSTER]", timeStampMilliSeconds)
    temp54 = strReplace(temp53, "[TIMESTAMP]", timestamp)
    temp55 = strReplace(temp54, "[TIMESTAMP_MS]", timeStampMilliSeconds)
    temp56 = strReplace(temp55, "[DESCRIPTION]", synopsis.Escape())
    temp57 = strReplace(temp56, "[APPID]", getappId())
    temp58 = strReplace(temp57, "[US_PRIVACY]", "")
    temp59 = strReplace(temp58, "[DURATION]", macroDuration.Trim())
    finalAdURL = strReplace(temp59, "[CATEGORY_ID]", categoryid)


    ?"finalAdURL printed Homescreen:"
    ? "*****************************************"
    ? finalAdURL
    ? "*****************************************"

    subtitle_config = videoDetailsResponse.subtitles

    SubtitleTracks = []
    for each item in videoDetailsResponse.subtitles
        subtitleItem = {}
        subtitleItem.Language = item.language_name
        subtitleItem.Description = item.short_code
        subtitleItem.TrackName = item.subtitle_url
        SubtitleTracks.push(subtitleItem)
    end for

    videoContent = {
        streamFormat: "m3u8",
        titleSeason: ""'category_name.Trim().Escape()
        title: VODcontent.title,
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        url: m.VODcontent1.video_name 'VODcontent.video_name,
        categories: VODcontent.categoriesWithComma
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: VODcontent.video_duration
    }


    content = CreateObject("roSGNode", "VideoContent")
    content.SetFields(videoContent)
    content.addFields({
        video_id: VODcontent.video_id,
        "is_live": "0",
        "audio_languages": videoDetailsResponse.audio_languages,
        "category": categoriesWithComma,
        "categoriesWithComma": categoriesWithComma
    })

    content.ad_url = finalAdURL.EncodeUri()
    if subtitle_config <> invalid
        content.ClosedCaptions = True
        content.globalCaptionMode = "On"
        content.HDBranded = True
        content.IsHD = True
        content.SubtitleConfig = subtitle_config
        content.SubtitleTracks = SubtitleTracks
        content.subtitleTrack = SubtitleTracks
    end if
    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if

    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.watched_duration = videoDetailsResponse.watched_duration 'setting watched_duration
    ?"iu"
    ' ' m.Player.control = "stop"
    ' if m.VideoSubscriptionTask.userSubIDSCount > 0 'setting flags in player class for watchwithoutad
    '     m.Player.skipAd = true
    ' else if m.VideoSubscriptionTask.userSubsTypes <> invalid and m.VideoSubscriptionTask.userSubsTypes.DoesExist("Monthly") 'if user if monthly subscribed
    '     if m.isExceptionalCaseForMonthlyUserAndRentalForHomePage = true and m.VideoSubscriptionTask.videoSubs = false
    '         m.Player.skipAd = false
    '     else
    '         m.Player.skipAd = true
    '     end if
    ' else
    '     m.Player.skipAd = false
    ' end if
    if m.skipAd = true
        m.Player.skipAd = true
    else
        m.Player.skipAd = false
    end if
    m.Player.control = "play"

    m.Player.observeField("visibility", "onVisibleChange")

end function


function OnSubscriptionComplete()
    ?"OnSubscriptionComplete called"
    if m.PaymentDescription.isSubscribed = true
        ' HideScreen(m.PaymentDescription)

        m.loadingIndicator.visible = false
        m.PaymentDescription.visible = false
        m.GridScreen.visible = true
        m.collapsedMenu.visible = true
        m.GridScreen.setFocus(true)
        ' playVideo()
    end if
end function

sub onVisibleChange()
    ?m.Player.visibility
    if m.Player <> invalid
        if m.Player.visibility = false then
            m.loadingIndicator.visible = false
            m.loadingIndicatorBelowTopMenu.visible = false
            m.GridScreen.setFocus(true)
        end if
    end if
    if m.PlayerLive <> invalid
        if m.PlayerLive.visibility = false then
            m.loadingIndicator.visible = false
            m.GridScreen.setFocus(true)
        end if
    end if
end sub

sub OnChangeContent()
    print "deep OnChangeContent"
    ShowScreen(m.GridScreen)
    ' m.GridScreen.setFocus(true)
    m.loadingIndicator.visible = false
    m.loadingIndicatorBelowTopMenu.visible = false
    if m.top.deepLinkContent <> invalid then
        m.loadingIndicator.visible = true
        loadDeep()
    end if
    m.dialogbg_rect.visible = false
    m.ExitButtonDialogRectVisible = false
    m.LogoutButtonDialogVisible = false
    m.AlertDialogVisible = false
end sub


function OnMenuButtonSelected()
    ?"OnMenuButtonSelected called"
    m.GridScreen.stopAutobannerScroll = true
    menuItemSelected = m.collapsedMenu.itemSelected.type
    menuItemSelected_key = m.collapsedMenu.itemSelected.title
    stopAllPlayers()
    if m.global.Live_player <> invalid and m.global.Live_player.getchild(3) <> invalid
        ?"OnMenuButtonSelected called: stopping live player if playing hhfkjdshkfnnnfsdf334"
        m.global.Live_player.getchild(3).control = "stop" ' stopping the live player in homebanner when going to other pages
        m.global.Live_player = invalid

    end if


    m.GridScreen.releasePlayer = true

    m.collapsedMenu.callFunc("collapseMenu")
    if m.isCollapsedMenuOpenNow = true
        m.menuslideLeft.control = "start"
    end if
    m.isCollapsedMenuOpenNow = false

    if menuItemSelected = "HOME"
        m.top.gotoHomeScenen = true
        ' m.loadingIndicator.visible = true
        ' m.GridScreen.homeType = menuItemSelected_key
        setTopMenuSelected(menuItemSelected_key)
    else if menuItemSelected = "CATEGORY" then ' categories
        m.global.MENU_FOR_ISLAND = "false"
        m.global.MENU_FOR_SMART_HOME_PAGES = "false"
        m.top.goToCategoryScreen = true

    else if menuItemSelected = "SMART_HOME_PAGES" then ' categories
        m.global.MENU_FOR_SMART_HOME_PAGES = "true"
        m.top.goToCategoryScreen = true



    else if menuItemSelected = "ISLANDS"
        m.global.MENU_FOR_ISLAND = "true"
        m.top.goToCategoryScreen = true

    else if menuItemSelected = "MY_LIST" then ' my list
        if isGuest() = "true"
            showAlertDialog()
        else
            m.top.goToMyListScreen = true
        end if

    else if menuItemSelected = "SUBSCRIPTION" then ' subsciption list
        if isGuest() = "true"
            showAlertDialog()
        else
            m.top.goToSubscriptionListScreen = true
        end if

    else if menuItemSelected = "SEARCH" then ' search
        m.top.goToSearchScreen = true

    else if menuItemSelected = "AUDIO" then ' podcast
        if isGuest() = "true" and getRegisterationMandatory() = "true"
            showAlertDialog()
        else
            m.top.goToPodcastScene = true
        end if

    else if menuItemSelected = "LIVE" then ' live
        ' if getMULTI_CHANNELS_REQUIRED() = "true" ' from kalingo asked to change no check needed for guest to go to timegrid
        '     m.top.goToMyTimeGridScreen = true
        ' else
        m.loadingIndicator.visible = true
        checkLiveNowSubscriptionForMenuClick()
        ' end if


    else if menuItemSelected = "CALENDAR" then ' calendar
        m.top.goToCalendarScene = true

    else if menuItemSelected = "LANGUAGE" then ' language
        showLanguageSelection()

    else if menuItemSelected = "ADDITIONAL_DONOR_CONTENT"
        if m.collapsedMenu.itemSelected <> invalid and m.collapsedMenu.itemSelected.key <> invalid and m.collapsedMenu.itemSelected.key <> ""
            m.top.goToShowMoreScene = m.collapsedMenu.itemSelected
        end if

    else if menuItemSelected = "SHOP" then ' podcast

    else if menuItemSelected = "MY_ORDERS" then ' podcast

        '    else if menuItemSelected="SMART_HOME_PAGES" then
        '            m.top.goToNewCategoryScreen = true

    else if menuItemSelected = "SUBSCRIBE" then
        ?"ertyujk"
        if isGuest() = "true"
            m.top.gotoLandingScene = true
            'userSubscriptionChecking() 'usersubscription checking
        else
            m.top.goToSubscriptionListScreenForAppSubscription = true 'app subscription list screen
        end if


    else if menuItemSelected = "HOME" then
        m.GridScreen.setFocus(true)
        ?"J"

    else if menuItemSelected = "LOGOUT" then ' logout
        showLogoutWarningPopUp()

    else if menuItemSelected = "LOGIN" then ' logout
        goToLandingScene()

    else if menuItemSelected = "LANGUAGE_SELECTION" then ' continue watching
        showLanguageSelection()

    else if menuItemSelected = "SHORTS" then 'SHORTS
        if getSHORTS_LOGIN_REQUIRED() = "true" and isGuest() = "true"
            showAlertDialog()

            ' if isGuest() = "true"
        else
            m.top.goToShortsScreen = true

        end if
    else if menuItemSelected = "GENRE"
        if m.collapsedMenu.itemSelected <> invalid and m.collapsedMenu.itemSelected.key <> invalid and m.collapsedMenu.itemSelected.key <> ""
            m.top.goToShowMoreScene = m.collapsedMenu.itemSelected
        end if
    else if menuItemSelected = "ACCOUNT" then
        if isGuest() = "true"
            showAlertDialog()
        else
            m.top.goToMyAccountScreen = true
        end if
    end if

    m.GridScreen.releasePlayer = true
    m.collapsedMenu.jumpToItemIndexInSideMenu = 0
end function


' function userSubscriptionChecking()
'     ' checking whether guest inorer to show continuw watching
'     ?""
'     m.UserSubscription = CreateObject("roSGNode", "UserSubscription")
'     m.UserSubscription.ObserveField("UserSubResponseData", "OnUserSubResponseData")
'     m.UserSubscription.callFunc("runUserSubscription", "")
' end function

sub showLanguageSelection()
    ' UI Visibility & API Calls
    m.languageLblListReact.visible = true
    runMultiLanguageListApiTask()

    ' Update UI text using common helper
    m.languageLbl.text = getTextOf("select_language")
    m.language_Lbl2.text = getTextOf("language_selection_subtext")

    ' Minimalist logging
    ? "Language labels updated: "; m.languageLbl.text; " | "; m.language_Lbl2.text
end sub


' sub OnUserSubResponseData()
'     userData = m.UserSubscription.UserSubResponseData

'     Subscription_Status = false ' internal flag

'     if userData <> invalid and userData.data <> invalid and userData.data.count() > 0

'         for each item in userData.data
'             if item.subscription_type_id <> invalid
'                 if item.subscription_type_id = 3 or item.subscription_type_id = 4 then
'                     Subscription_Status = true
'                     ?item.subscription_type_id
'                     exit for
'                 end if
'             end if
'         end for

'     end if

'     ' Set the final value
'     if Subscription_Status then
'         setIsUserSubscribed("true")
'     else
'         setIsUserSubscribed("false")
'     end if

'     ' COMMON — should run ALWAYS after checking
'     m.collapsedMenu.start1 = true
' end sub




function OnkeyEvent(key, press) as boolean

    result = false
    if press
        ?"key pressed: " + key

        if m.HomeTopMenuRowlist.isInFocusChain() and key = "right" or m.HomeTopMenuRowlist.isInFocusChain() and key = "left"
            return true
        end if

        if m.isCollapsedMenuOpenNow = true and key = "up" or m.isCollapsedMenuOpenNow = true and key = "down"
            return true
        end if

        if m.qrOverlay <> invalid and m.qrOverlay.isInFocusChain() then return true

        if key = "back"

            if m.loadingIndicator.visible = true
                m.loadingIndicator.visible = false
                m.loadingIndicator.control = "stop"
                m.top.closethispage = true
            end if

            if m.languageLblListReact.visible = true
                if IsLanguageSettingFirstTime() = "true"
                    m.top.appExit = true
                else
                    m.languageLblListReact.visible = false
                    m.GridScreen.setFocus(true)
                end if
                return true
            end if

            m.count2 = 0
            numberOfScreens = m.screenStack.Count()
            if numberOfScreens = 1 and m.continueWatchingDialogVisibleForHome = true and m.ExitButtonDialogRectVisible = true
                print "exit app"
                result = true
            end if

            if numberOfScreens = 1 and m.PaymentDescriptionVisibleForHomePage = true
                print "exit app"
                result = true
            end if

            if m.PaymentDescriptionVisibleForHomePage = true
                m.PaymentDescription.visible = false
                m.PaymentDescriptionVisibleForHomePage = false
                m.GridScreen.visible = true
                m.collapsedMenu.visible = true
                result = true
                return result
            end if


            if m.ExitButtonDialogRectVisible = true
            end if


            if m.LogoutButtonDialogVisible = true
                m.dialogbg_rect.visible = false
                m.LogoutButtonDialogVisible = false
                m.GridScreen.visible = true
                m.collapsedMenu.visible = true
                result = true
                return result
            end if


            if m.continueWatchingDialogVisibleForHome = true
                m.dialogbg_rect.visible = false
                m.continueWatchingDialogVisibleForHome = false
                m.GridScreen.setFocus(true)
            end if

            if m.AlertDialogVisible = true
                m.dialogbg_rect.visible = false
                m.AlertDialogVisible = false
                m.GridScreen.setFocus(true)
                return true
            end if

            if m.isWatchWithOutAdsDialogRectVisibleForHome = true
                ?"isWatchWithOutAdsDialogRectVisibleForHome back pressed"
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisibleForHome = false
                m.continueWatchingDialogVisibleForHome = false
                m.GridScreen.setFocus(true)
                result = true
            end if


            if (m.screenStack.Peek() <> invalid and m.screenStack.Peek().id = "GridScreen") and m.ExitButtonDialogRectVisible = false and m.LiveTV.visible = false
                if m.isCollapsedMenuOpenNow = true
                    m.menuslideLeft.control = "start"
                    m.isCollapsedMenuOpenNow = false
                end if
                showExitWaringPopUp()
                result = true
            else

                m.dialogbg_rect.visible = false
                m.ExitButtonDialogRectVisible = false
                m.GridScreen.visible = true
                m.collapsedMenu.visible = true
                m.GridScreen.setFocus(true)
                result = true
            end if

            if m.LiveTV.visible = true
                HideScreen(m.LiveTV)
                m.screenStack.peek()
                result = true
                return true
            end if

        else if key = "down"
            if m.HomeTopMenuRowlist.isInFocusChain()
                m.GridScreen.setFocus(true)

            else

                if m.gridScreen.focusedRow = invalid or m.gridScreen.focusedRow.Count() = 0 then
                    m.collapsedMenu.callFunc("expandMenu")
                    if m.isCollapsedMenuOpenNow = false
                        m.menuslideRight.control = "start"
                    end if
                    m.isCollapsedMenuOpenNow = true
                    result = true

                end if
            end if


        end if

        print "key pressed start"
        print m.GridScreen.visible
        focusedRowItemPosition = m.gridScreen.focusedRow[1]

        if key = "left" and m.continueWatchingDialogVisibleForHome or key = "left" and m.isWatchWithOutAdsDialogRectVisibleForHome or key = "left" and m.ExitButtonDialogRectVisible or key = "left" and m.LogoutButtonDialogVisible or key = "left" and m.AlertDialogVisible
            ?"left"
            m.NoButton.setFocus(true)
            handled = true



        else if key = "left" and focusedRowItemPosition = 0 and m.GridScreen.visible then
            print "in menu open"
            m.collapsedMenu.callFunc("expandMenu")
            if m.isCollapsedMenuOpenNow = false
                m.menuslideRight.control = "start"
            end if
            m.isCollapsedMenuOpenNow = true
            result = true



        else if key = "right" and m.continueWatchingDialogVisibleForHome or key = "right" and m.isWatchWithOutAdsDialogRectVisibleForHome or key = "right" and m.ExitButtonDialogRectVisible or key = "right" and m.LogoutButtonDialogVisible or key = "right" and m.AlertDialogVisible
            ?"right"
            m.YesButton.setFocus(true)
            handled = true


        else if key = "right" and m.GridScreen.visible then
            print "in menu close"
            m.collapsedMenu.callFunc("collapseMenu")
            if m.isCollapsedMenuOpenNow = true
                m.menuslideLeft.control = "start"
            end if
            m.isCollapsedMenuOpenNow = false
            m.GridScreen.setFocus(true)
            result = true



        else if key = "up"

            if m.HomeTopMenuRowlist.visible = true and m.GridScreen.isInFocusChain() = true
                ' m.GridScreen.callHomeEnlargeAnimation = true
                m.HomeTopMenuRowlist.SET_FOCUS = true

            else if m.isCollapsedMenuOpenNow = true
                m.menuslideLeft.control = "start" 'newvibechange
                m.HomeTopMenuRowlist.SET_FOCUS = true

            end if
        end if

    end if
    return result
end function


sub ShowScreen(node)
    prev = m.screenStack.peek()
    if prev <> invalid
        prev.visible = false
    end if

    if node.id = "GridScreen"

        ' print "2 m.collapsedMenu.visible = true"
        m.collapsedMenu.visible = true
    else

        m.collapsedMenu.visible = false
    end if

    node.visible = true
    node.setFocus(true)
    m.screenStack.push(node)
end sub

sub showdialog()
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = "You are exiting " + getAppTitle() + "!"
    dialog.optionsDialog = true
    dialog.message = "           Press Home To EXIT This Application"
    m.top.dialog = dialog
end sub

sub HideTop()
    HideScreen(invalid)
end sub

sub HideScreen(node as object)
    if node = invalid or (m.screenStack.peek() <> invalid and m.screenStack.peek().isSameNode(node))
        Count = m.screenStack.count()

        print "count of back"
        print count
        if Count = 1
            showdialog()
        else


            last = m.screenStack.pop()
            last.visible = false

            prev = m.screenStack.peek()
            if prev <> invalid
                prev.visible = true
                prev.setFocus(true)
            end if

        end if
    end if
end sub



sub goToLandingScene()
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.top.gotoLandingScene = true
end sub

sub goToSubscriptionListingScene()
    showSubscriptionPage()
end sub



sub continueWatchingLogic(VODcontent1)
    m.VODcontent1 = VODcontent1

    if m.VODcontent1.watched_duration > 0

        m.watched_duration = m.VODcontent1.watched_duration
        playvideo()
    else
        m.watched_duration = 0
        playvideo()
    end if
end sub



sub showAlertDialog()
    ' Update UI text
    m.dialogmessage_label.text = getTextOf("please_login")
    m.cancelbutton_Label.text = getTextOf("cancel")
    m.exitbutton_Label.text = getTextOf("continue")

    ' State management
    m.dialogbg_rect.visible = true
    m.AlertDialogVisible = true
    m.YesButton.setFocus(true)
    m.loadingIndicator.visible = false

    ?"showAlertDialog called"
end sub



sub showExitWaringPopUp()
    ?"showExitWaringPopUp called"
    ' UI Visibility setup
    m.collapsedMenu.callFunc("collapseMenu")
    m.collapsedMenu.visible = false
    m.Gridscreen.visible = false

    ' Update UI text using your common helper
    m.dialogmessage_label.text = getTextOf("do_you_want_to_exit")
    m.cancelbutton_Label.text = getTextOf("no")
    m.exitbutton_Label.text = getTextOf("exit")

    ' Dialog State
    m.dialogbg_rect.visible = true
    m.ExitButtonDialogRectVisible = true
    m.YesButton.setFocus(true)

end sub


sub showLogoutWarningPopUp()
    m.collapsedMenu.visible = false
    m.Gridscreen.visible = false
    m.dialogmessage_label.text = getTextOf("logout_confirmation")
    m.cancelbutton_Label.text = getTextOf("cancel")
    m.exitbutton_Label.text = getTextOf("sign_out")
    m.dialogbg_rect.visible = true
    m.LogoutButtonDialogVisible = true
    m.YesButton.setFocus(true)
end sub

sub onTriggerLogoutWarning()
    showLogoutWarningPopUp()
end sub

sub onTriggerLanguageSelection()
    showLanguageSelection()
end sub



sub onDialogYesSelected()
    ?"onDialogYesSelected called"

    if m.isWatchWithOutAdsDialogRectVisibleForHome = true
        ?"m.isWatchWithOutAdsDialogRectVisibleForHome = true"
        showSubscriptionPage()

    else if m.continueWatchingDialogVisibleForHome = true ' this is start over case when start over button is pressed
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisibleForHome = false
        m.continueWatchingDialogVisibleForHome = false'
        m.watched_duration = 0
        playvideo()

    else if m.ExitButtonDialogRectVisible = true
        m.top.appExit = true

    else if m.AlertDialogVisible = true
        m.top.goToLandingScene = true
        m.dialogbg_rect.visible = false
        m.AlertDialogVisible = false

    else if m.LogoutButtonDialogVisible = true

        m.LogoutTask = createObject("roSGNode", "LogoutTask")
        m.LogoutTask.LogoutResponse = "noResponseeeee"
        m.LogoutTask.observeField("LogoutResponse", "OnLogoutResponse")
        OnLogout()
        ' setLanguageAfterLogOut()
    end if
end sub



function setLanguageAfterLogOut()
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("Is_Language_Setting_First_Time", "true")
    sec.Flush()
    print "Language setting key reset to 'true' for new user registration."
end function

sub onDialogNoSelected()
    ?"onDialogNoSelected"
    if m.isWatchWithOutAdsDialogRectVisibleForHome = true
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisibleForHome = false
        m.continueWatchingDialogVisibleForHome = false'
        if getRegisterationMandatory() = "true"
            if isGuest() = "true"
                goToLandingScene()
                return
            else if getAdRequired() = "true" 'play video with ads
                m.skipAd = false
            else 'play video
                m.skipAd = true
            end if
        else if getAdRequired() = "true" '
            m.skipAd = false
        else
            m.skipAd = true
        end if
        continueWatchingLogic(m.VODcontent1)

    else if m.continueWatchingDialogVisibleForHome = true
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisibleForHome = false
        m.continueWatchingDialogVisibleForHome = false'
        m.watched_duration = m.VODcontent1.watched_duration
        ?m.watched_duration
        playvideo()
    else if m.ExitButtonDialogRectVisible = true
        m.dialogbg_rect.visible = false
        m.ExitButtonDialogRectVisible = false
        m.collapsedMenu.visible = true
        m.Gridscreen.visible = true
        m.GridScreen.setFocus(true)

    else if m.AlertDialogVisible = true
        m.dialogbg_rect.visible = false
        m.AlertDialogVisible = false
        m.Gridscreen.visible = true
        m.collapsedMenu.visible = true
        m.GridScreen.setFocus(true)

    else if m.LogoutButtonDialogVisible = true
        m.dialogbg_rect.visible = false
        m.LogoutButtonDialogVisible = false
        m.Gridscreen.visible = true
        m.collapsedMenu.visible = true
        m.GridScreen.setFocus(true)
    end if
end sub



sub showSubscriptionPage()
    ?"showPaymentPage called"

    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.PaymentDescriptionVisibleForHomePage = true
        m.loadingIndicator.visible = false
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisibleForHome = false
        m.continueWatchingDialogVisibleForHome = false
        m.GridScreen.visible = false
        m.collapsedMenu.visible = false
        m.PaymentDescription.videoID = str(m.gridScreen.focusedContent.video_id)
        m.PaymentDescription.observeField("isSubscribed", "OnSubscriptionComplete")
        m.PaymentDescription.visible = true
        m.PaymentDescription.setFocus(true)
        m.GridScreen.setFocus(false)
    else
        showSubscriptionDialog()

    end if
end sub

sub showSubscriptionPageForLive(channelId)
    ?"showPaymentPage called"
    ?channelId
    m.loadingIndicator.visible = false
    showPaymentPage(channelId)
end sub



sub onLiveItemPlayingOnAppLaunch()
    if m.global.screenStackArray.count() = 1
        m.loadingIndicator.visible = true
        callLiveAPI()
    else
        ?"live player called once on app, so do nothing..    :)"
    end if

end sub

sub OnGotoTimeGridScene()
    m.top.goToMyTimeGridScreen = true
end sub

sub OnLiveItemSelected(params)
    m.loadingIndicator.visible = true
    multi_channels_required = getMULTI_CHANNELS_REQUIRED()
    m.liveApi1 = createObject("roSGNode", "LiveFetcher")
    if (multi_channels_required = "true")
        m.liveApi1.channel_id = Str(m.channelId).Trim()
        ?m.liveApi1.channel_id
        ?"kjkj"
    else
        if m.channelId <> invalid
            m.liveApi1.channel_id = m.channelId.Trim()
        else
            m.liveApi1.channel_id = getchannelsid()
        end if
    end if
    m.liveApi1.LiveScheduleRequest = "run"
    m.liveApi1.callFunc("runLiveFetcherTask", "TIMEGRIDSCENE")
    m.liveApi1.observeField("livefetcherResponse", "OnLiveItemSelected1")
end sub

'*************this function is to handle live playing. i.e LIVE direct play from home screen. not to be confused with the "LIVE_EVENT" which will goto seperate show screen
sub OnLiveItemSelected1(focusedRow)
    multi_channels_required = getMULTI_CHANNELS_REQUIRED()
    if (multi_channels_required = "true")
        ' m.top.goToMyTimeGridScreen = true
        content = m.liveApi1.livefetcherResponse[0]


        if content <> invalid and content.show_id <> invalid
            show_id = content.show_id
            ?show_id
        else
            show_id = 0
        end if
        schedule_id = ""
        if content <> invalid and content.id <> invalid
            schedule_id = content.id.Tostr()
        else
            schedule_id = 0

        end if

        video_title = ""
        if content <> invalid and content.video_title <> invalid
            video_title = content.video_title
        end if

        live_link = ""
        if content <> invalid and content.live_link <> invalid
            live_link = content.live_link
        end if


        data = {
            "url": content.live_link,
            "event_id": content.now_playing.id,
            "TITLE": video_title,
            "show_id": show_id.ToStr(),
            "schedule_id": schedule_id.ToStr(),
            "is_from": "TIMEGRIDSCENE"
            "channel_id": m.channelID.ToStr()
        }

        content = CreateObject("roSGNode", "VideoContent")
        content.setFields(data)
        content.addFields({

            "channel_id": m.channelID
        })

        ' playTimeGridLiveVideo(data)
        m.top.goToMainVideoPlayer = data

    else

        liveResponseData = m.liveApi1.livefetcherResponse[0]
        if (liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.title <> invalid) title = liveResponseData.now_playing.title else title = liveResponseData.channel_name
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.id <> invalid then id = liveResponseData.now_playing.id.toStr() else id = 0
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.live_link <> invalid then liveLink = liveResponseData.now_playing.live_link else liveLink = liveResponseData.live_link
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.show_id <> invalid then show_id = liveResponseData.now_playing.show_id else show_id = 0
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.id <> invalid then schedule_id = liveResponseData.now_playing.id else schedule_id = 0
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.description <> invalid then description = liveResponseData.now_playing.description else description = liveResponseData.description


        data = {
            "url": liveLink,
            "event_id": id,
            "TITLE": title,
            "show_id": show_id
            "schedule_id": schedule_id.ToStr()
            "is_from": "NORMAL_LIVENOW_SCENE",
            "channel_id": m.channelID.ToStr()
        }
        m.top.goToMainVideoPlayer = data
    end if
    m.loadingIndicator.visible = false
end sub





sub checkLiveNowSubscriptionForMenuClick()

    if (getSubscriptionRequired() = "true")
        if isGuest() = "true"
            if (getLiveLoginCheck() = "true")
                ' if (getRegisterationMandatory() = "true")
                m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                m.top.gotoLandingScene = true
            else
                callSubCheckAPiForMenuClick(getFastChannelId())
            end if
        else if isGuest() = "false"
            if getMULTI_CHANNELS_REQUIRED() = "true"
                callLiveAPI()
            else
                callSubCheckAPiForMenuClick(getFastChannelId())
            end if
        end if
    else
        if isGuest() = "true"
            ' ifRegisterationMandatoryOrNotForMenuClick() '************** Registeration Mandatory checking
            callLiveAPI()

        else
            callLiveAPI()
        end if
    end if
end sub


sub ifRegisterationMandatoryOrNotForMenuClick()
    if (getLiveLoginCheck() = "true")
        ' if (getRegisterationMandatory() = "true")
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
    else
        callLiveAPI()
    end if
end sub

sub callSubCheckAPiForMenuClick(channelId)
    m.ChannelSubsriptionTask = CreateObject("roSGNode", "ChannelSubsriptionTask")
    m.ChannelSubsriptionTask.channelID = channelId
    m.ChannelSubsriptionTask.observeField("channelSubs", "checkLiveNowSubscription2ForMenuClick")
    m.ChannelSubsriptionTask.callFunc("runChannelSubsriptionTask", "")
end sub


sub checkLiveNowSubscription2ForMenuClick()
    if m.ChannelSubsriptionTask.channelSubs = true
        ?m.ChannelSubsriptionTask.channelSubs
        callLiveAPI()
    else
        showSubscriptionPageForLive(getFastChannelId())
    end if
end sub


'''''''''
' callLiveAPI: this will play the live using
'
'''''''''
sub callLiveAPI()
    multi_channels_required = getMULTI_CHANNELS_REQUIRED()
    if (multi_channels_required = "true")
        m.top.goToMyTimeGridScreen = true
    else
        m.liveApi = createObject("roSGNode", "LiveFetcher")
        m.liveApi.live_channel_id = getchannelsid()
        m.liveApi.LiveScheduleRequest = "run"
        m.liveApi.callFunc("runLiveFetcherTask", "")
        m.liveApi.observeField("livefetcherResponse", "onPlayLive")
    end if
end sub

sub onPlayLive()
    ' if content[0].live_link <> invalid
    '     m.LiveTV.liveUrl = content[0].live_link

    ' else if content.live_url <> invalid
    '     m.LiveTV.liveUrl = content.live_url

    ' end if

    ' m.LiveTV.video_title = content[0].channel_name
    ' m.LiveTV.linear_channel_id = content[0].channel_id
    ' m.LiveTV.start = "start"
    ' m.loadingIndicator.visible = false
    ' ShowScreen(m.LiveTV)
    ' m.LiveTV.setFocus(true)
    content = m.liveApi.livefetcherResponse[0]
    if content <> invalid and content.now_playing <> invalid and content.now_playing.id <> invalid
        schedule_id = content.now_playing.id.ToStr()
        ?"KL"
    else
        schedule_id = ""
    end if
    if content <> invalid and content.now_playing <> invalid and content.now_playing.show_id <> invalid
        show_id = content.now_playing.show_id.ToStr()
    else
        show_id = 0
    end if

    if content <> invalid and content.now_playing <> invalid and content.now_playing.video_title <> invalid
        video_title = content.now_playing.video_title
    else
        video_title = ""
    end if
    if content <> invalid and content.live_link <> invalid
        live_link = content.live_link
    else
        live_link = ""
    end if

    data = {
        "url": live_link,
        "event_id": schedule_id,
        "TITLE": video_title,
        "show_id": show_id,
        "schedule_id": schedule_id
        "is_from": "NORMAL_LIVENOW_SCENE"
        "channel_id": getFastChannelId()
    }
    m.top.goToMainVideoPlayer = data
    m.loadingIndicator.visible = false
end sub


function onGetPurchases(event)
    print "onGetPurchases homescene"
    m.global.channelStore.unobserveField("purchases")
    ?m.global.channelStore.purchases
    ?m.global.channelStore.purchases.GetChildCount()
    ?m.global.channelStore.userData
    purchaseData = event.getData()
    purchaseList = {}
    if purchaseData.GetChildCount() > 0 then
        for index = 0 to purchaseData.GetChildCount() - 1
            purchase = purchaseData.getChild(index)
            purchaseList[purchase.code] = purchase
            'print "purchase "; index; " - purchase= "; purchase
            ?" purchase.inDunning ";purchase.inDunning
            ?" purchase.status ";purchase.status
            if purchase.inDunning = "true" and purchase.status = "Valid" 'In recovery (in 3 - day grace period)
                ?"entered inside homescene"
                request = {}
                request.command = "DoRecovery"
                request.context = { "id": "DoRecovery_1" }
                m.global.channelStore.request = request
                return false
            end if
        end for
    end if

    ' STOP
    '//Subscription status from getAllPurchaseAPI
    ' Subscription state                      "inDunning" "status"
    ' Current                                   false       Valid
    ' In recovery (in 3 - day grace period)     true        Valid
    ' On Hold                                   true        invalid
    ' Canceled                                  false       invalid
end function



function onRequestStatus()
    print "onRequestStatus called homescene"
    ?m.global.channelStore.requestStatus.result
    ?m.global.channelStore.requestStatus.result.recoveryStatus
    ?m.global.channelStore.requestStatus.result.recoveryProducts
    requestStatus = m.global.channelStore.requestStatus
    if requestStatus = invalid
        print "Invalid requestStatus"
        print "DoRecovery failed"
    else if requestStatus.status <> 1
        print "DoRecovery failed: status:", requestStatus.status
    else
        print "command", requestStatus.command
        print "requestStatus.statusMessage", requestStatus.statusMessage
        print "requestStatus.result.recoveryStatus", requestStatus.result.recoveryStatus
        for each product in requestStatus.result.recoveryProducts
            print "productInRecovery:", product
        end for
    end if
end function


sub showPaymentPage(channelId) ' show payment page
    ?"showPaymentPage called"
    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreenForEvent = channelId
    else
        showSubscriptionDialog()
    end if
end sub

sub showSubscriptionDialog()
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = getTextOf("warning")
    dialog.optionsDialog = true
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onSubscriptionRequiredOkButtonselected")
    msg1 = getTextOf("to_avail_this_video")
    msg2 = getTextOf("on_web")
    dialog.message = msg1 + getAppTitle() + msg2
    ' dialog.message = "To avail this video, visit our website.. Please visit " + getAppTitle() + " on the web for help"
    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

sub onSubscriptionRequiredOkButtonselected()
    m.parentScene.dialog.close = true
end sub

sub initialiseTopMenuRowlist(utilityAssoc)

    cIndex = 0
    if IsNotBlank(m.top.GOTO_HOME_AND_LOAD_SMARTHOME)
        setTopMenuSelected(m.top.GOTO_HOME_AND_LOAD_SMARTHOME)
    end if
end sub

function IsNotBlank(value as dynamic) as boolean
    return value <> invalid and value <> ""
end function



function backgroundPosterLength(input)
    for inputValue = 1 to 200
        returnValue = calculateReturn(inputValue)
        if input = inputValue
            return returnValue
        end if
    end for
end function

function calculateReturn(inputValue as integer) as integer
    if inputValue < 1 or inputValue > 200
        return invalid ' Input out of range
    end if
    return 60 + (inputValue - 1) * 9
end function




sub setTopMenuSelected(selectedKey)
    if m.top.visible = false then return
    if selectedKey <> invalid and m.HomeTopMenuRowlist <> invalid and m.HomeTopMenuRowlist.content <> invalid
        rowNode = m.HomeTopMenuRowlist.content.getChild(0)
        if rowNode <> invalid and rowNode.getChildCount() > 0
            for i = 0 to rowNode.getChildCount() - 1
                item = rowNode.getChild(i)
                if item <> invalid and item.vanity_url <> invalid and LCase(item.vanity_url) = LCase(selectedKey)
                    m.HomeTopMenuRowlist.SET_FOCUS = true
                    m.HomeTopMenuRowlist.jumpToRowItem = [0, i]
                    m.HomeTopMenuRowlist.rowItemFocused = [0, i]
                    exit for
                end if
            end for
        end if
    end if
end sub

sub OnTopMenuRowItemSelected()
    if m.global.Live_player <> invalid and m.global.Live_player.getchild(3) <> invalid
        ' ?"OnTopMenuRowItemSelected called: stopping live player if playing "
        m.global.Live_player.getchild(3).control = "stop"
        m.global.Live_player = invalid
    end if

    menuSelected = m.HomeTopMenuRowlist.content.getChild(0).getChild(m.HomeTopMenuRowlist.rowItemSelected[1])
    stopAllPlayers()
    if m.HomeTopMenuRowlist.content.getChild(0).getchildCount() > 0 and m.HomeTopMenuRowlist.content.getChild(0).getChild(m.HomeTopMenuRowlist.rowItemSelected[1]) = invalid
        m.top.goToSearchScreen = true
        return
    end if
    if menuSelected.isSearchIcon = true
        m.top.goToSearchScreen = true
        return
    else if menuSelected.title = "Subscribe"
        m.top.goToSubscriptionListScreen = true
        return
    else
        m.loadingIndicatorBelowTopMenu.visible = true
        m.GridScreen.homeType = menuSelected.vanity_url
    end if
end sub



sub onsetFocusToTopMenu()
    ' Use timer to ensure focus is set after competing calls
    if m.setTopMenuFocusTimer <> invalid
        m.setTopMenuFocusTimer.control = "stop"
    end if

    m.setTopMenuFocusTimer = CreateObject("roSGNode", "Timer")
    m.setTopMenuFocusTimer.duration = 0.1
    m.setTopMenuFocusTimer.repeat = false
    m.setTopMenuFocusTimer.observeField("fire", "onSetTopMenuFocusTimerFired")
    m.setTopMenuFocusTimer.control = "start"
end sub

sub onSetTopMenuFocusTimerFired()
    ?"Setting final focus to top menu"
    m.HomeTopMenuRowlist.SET_FOCUS = true
end sub

sub onGoToHomeAndLoadSmartHome()
    ?"onGoToHomeAndLoadSmartHome called: homescreen"
    targetUrl = m.top.GOTO_HOME_AND_LOAD_SMARTHOME
    stopAllPlayers()
end sub

sub onSetDefaultFocus()
    if m.GridScreen <> invalid then m.GridScreen.setFocus(true)
end sub

sub stopAllPlayers()
    if m.GridScreen <> invalid then m.GridScreen.releasePlayer = true
end sub

sub onDialogRectVisibleChange()
    if m.dialogbg_rect.visible = true
        m.collapsedMenu.visible = false
        m.HomeTopMenuRowlist.visible = false
    else
        m.HomeTopMenuRowlist.visible = true
        m.collapsedMenu.visible = true
    end if
end sub

sub onBannerItemSelected()
    if m.top.selectedBannerItem <> invalid and m.top.selectedBannerItem.checkout_qr <> invalid and m.top.selectedBannerItem.checkout_qr <> ""
        showQrOverlay(m.top.selectedBannerItem.checkout_qr)
    end if
end sub