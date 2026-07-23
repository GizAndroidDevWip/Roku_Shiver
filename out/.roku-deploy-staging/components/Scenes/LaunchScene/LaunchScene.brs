function init()
    ?"djhgsjdhgas called2222"
    m.pubIdTask = CreateObject("roSGNode", "PubIdTask")
    m.pubIdTask.callFunc("runPubIdTask", "")
    m.pubIdTask.observeField("PubIdResponse", "OnPubIdresponse")
    m.onceGuestRegisterCalled = 0
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("publish", "Template")
    sec.Flush()
    m.LaunchCheck = createObject("roSGNode", "LaunchCheck")
    m.LaunchCheck.observeField("LaunchResponse", "onLaunchResponse")
    m.top.ObserveField("visible", "onTopVisibleChange")
    m.loading = m.top.findNode("loading")
    m.loading.visible = false
    m.messageDialog = m.top.findNode("messageDialog")
    m.messageDialog_rect = m.top.findNode("messageDialog_rect")
    m.secondSplashScreenImage = m.top.findNode("secondSplashScreen")
    m.secondSplashScreenImage.uri = "pkg:/images/logos/BHD LOGO_Face Of APP_1920X1080.png"
    m.secondSplashScreenImage.visible = true
    m.top.setFocus(true)
    setSessionId()
    setSplashVideo()

end function

sub OnPubIdresponse()
    if m.global.DEEPLINK_PARAMS <> invalid and m.global.DEEPLINK_PARAMS.contentId <> invalid
        if m.global.DEEPLINK_PARAMS.contentId = "12345678987654321" or m.global.DEEPLINK_PARAMS.contentId = "12345678987654320"
            m.top.signalBeacon("AppLaunchComplete")
            m.top.closethispage = "true"
            m.top.gotoPlayDeepLinkVideo = true
            return
        end if
    end if

    if getHasIPInfoData() = "true"
        authenticateapi()
    else
        m.ipInfoTask = CreateObject("roSGNode", "IpInfoTask")
        m.ipInfoTask.callFunc("runIpInfoTask", "")
        m.ipInfoTask.observeField("IpInfoResponse", "authenticateapi")
    end if
end sub


sub authenticateapi()
    m.AuthenticateApi = CreateObject("roSGNode", "AuthenticateApi")
    m.AuthenticateApi.observeField("authenticateApiTaskListcontent", "checkandNavigate")
    m.AuthenticateApi.callFunc("runauthenticateApiTask", "")
end sub


sub checkandNavigate()

    if getIntialPage() = "LOGIN"

        if IsAppOpeningFirstTime() = "true"
            setIsAppOpeningFirstTime("true")
            callGuestRegister2()

        else
            if isGuest() = "true" '*****isloggedAlready
                callGuestRegister2()
            else
                m.top.closethispage = "true"
                m.top.goToHomeScene = true

            end if
        end if
    else if getIntialPage() = "HOME" or getIntialPage() = "LANDING" or getIntialPage() = "LIVE"

        if IsAppOpeningFirstTime() = "true"

            callGuestRegister()
            setIsAppOpeningFirstTime("true")
        else

            m.top.closethispage = "true"
            m.top.goToHomeScene = true
        end if
    end if
end sub


function setSplashVideo() as void
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = "pkg:/images/logos/Splash_video.mp4"
    videoContent.streamformat = "mp4"
    m.video = m.top.findNode("splashVideo")
    m.video.visible = true
    m.video.setFocus(true)
    m.video.content = videoContent
    m.video.control = "play"
    m.video.observeField("state", "onVideoStateChange")
end function

sub onVideoStateChange()
    if m.video.state = "error"
        print "--- PLAYBACK ERROR ---"
        print "Error Code: "; m.video.errorCode
        print "Error Message: "; m.video.errorMsg
        ' m.secondSplashScreenImage.visible = true
    else if m.video.state = "finished"
        m.video.visible = false
        m.loading.visible = true
    end if
end sub


sub onTopVisibleChange()
    if m.top.visible = true
        m.pubIdTask = CreateObject("roSGNode", "PubIdTask")
        m.pubIdTask.callFunc("runPubIdTask", "")
        m.pubIdTask.observeField("PubIdResponse", "OnPubIdresponse")
        m.onceGuestRegisterCalled = 0
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("publish", "Template")
        sec.Flush()
        m.LaunchCheck = createObject("roSGNode", "LaunchCheck")
        m.LaunchCheck.observeField("LaunchResponse", "onLaunchResponse")
    end if
end sub


sub callGetPurchaseApi()
    ?"callGetPurchaseApi called"
    ' checkandNavigate()
    m.global.channelStore.command = "getAllPurchases"
    m.global.channelStore.ObserveField("purchases", "OnGetPurchases")
end sub


sub OnIpInfoResponsee()
    ?"OnIpInfoResponse called"

    if m.onceGuestRegisterCalled = 1
        if checkLogin() <> invalid
        else
            m.GuestFetcher.callFunc("runGuestFetcher", "")
            m.onceGuestRegisterCalled = 0
        end if
    end if
    m.onceGuestRegisterCalled++
end sub


sub callGuestRegister()
    ?"callGuestRegister Called"
    m.GuestFetcher = CreateObject("roSGNode", "GuestFetcher")
    m.GuestFetcher.observeField("GuestResponse", "OnGuestResponse")
    m.GuestFetcher.callFunc("runGuestFetcher", "")
end sub

sub OnGuestResponse()
    user_id = m.GuestFetcher.GuestResponse
    m.GuestFetcher.callFunc("stopGuestFetcher", "")
    if user_id <> "failed"
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("USER_ID", user_id)
        sec.Flush()
        ' if getIntialPage() = "LIVE"
        '     callLiveAPI()
        ' else
        m.top.closethispage = "true"
        m.top.goToHomeScene = true
        ' end if
    else
    end if
end sub

sub callGuestRegister2()
    m.GuestFetcher = CreateObject("roSGNode", "GuestFetcher")
    m.GuestFetcher.observeField("GuestResponse", "OnGuestResponse2")
    m.GuestFetcher.callFunc("runGuestFetcher", "")
end sub

sub OnGuestResponse2()
    m.top.gotoLandingScene = true
end sub

function checkLogin() as dynamic
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

'******live section
sub callLiveAPI()
    multi_channels_required = getMULTI_CHANNELS_REQUIRED()
    if (multi_channels_required = "true")
        m.top.closethispage = "true"
        m.top.goToTimeGridScreen = true
    else
        m.liveApi = createObject("roSGNode", "LiveFetcher")
        m.liveApi.live_channel_id = getchannelsid()
        m.liveApi.LiveScheduleRequest = "run"
        m.liveApi.callFunc("runLiveFetcherTask", "")
        ' m.top.closethispage = "true"
        m.liveApi.observeField("livefetcherResponse", "onPlayLive")
    end if
end sub

sub onPlayLive()
    content = m.liveApi.livefetcherResponse[0]
    if content <> invalid and content.now_playing <> invalid and content.now_playing.id <> invalid
        schedule_id = content.now_playing.id.ToStr()
    else
        schedule_id = ""
    end if
    data = {
        "url": content.live_link,
        "event_id": content.now_playing.id,
        "TITLE": content.now_playing.video_title,
        "schedule_id": content.now_playing.id,
        "show_id": content.now_playing.show_id
        "schedule_id": schedule_id
        "is_from": "NORMAL_LIVENOW_SCENE"
    }
    m.top.closethispage = "true"
    m.top.goToMainVideoPlayer = data
end sub

sub setSessionId()
    di = CreateObject("roDeviceInfo")
    deviceid = di.GetChannelClientId()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    ?"sessionId created"; sessioniddevice + deviceid
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("session", sessioniddevice + deviceid)
    sec.Flush()
end sub

function onGetPurchases(event) ' gets purchses data and decides to show dorecovery flag
    m.global.channelStore.unobserveField("purchases")
    print "onGetPurchases launchscene"
    ?m.global.channelStore.purchases
    ?m.global.channelStore.purchases.GetChildCount()
    ?m.global.channelStore.userData
    ' ?m.global.channelStore.userData.GetChildCount()


    purchaseData = event.getData()
    purchaseList = {}
    if purchaseData.GetChildCount() > 0 then
        for index = 0 to purchaseData.GetChildCount() - 1
            purchase = purchaseData.getChild(index)
            purchaseList[purchase.code] = purchase
            'print "purchase "; index; " - purchase= "; purchase
            ?" purchase.inDunning ";purchase.inDunning
            ?" purchase.status ";purchase.status
            if purchase.inDunning = "true" and purchase.status = "Invalid" ' on Hold case
                m.mNeedtoShowRecocveryDialog = true
                ?"entered inside launchscene"
            end if
        end for
    end if


    if m.mNeedtoShowRecocveryDialog <> invalid and m.mNeedtoShowRecocveryDialog = true
        request = {} 'run recovery dialog
        request.command = "DoRecovery"
        request.context = { "id": "DoRecovery_1" }
        ' request.params = { "recoveryContext": "playback" }
        m.global.channelStore.observeField("requestStatus", "onRequestStatus")
        m.global.channelStore.request = request
        ' m.loading.visible = false
        m.messageDialog_rect.visible = true
        m.messageDialog.text = "Your subscription is on hold. Please update your payment method or contact support!"
    else
        if getUserIdana() <> invalid and getUserIdana() <> ""
            userSubscriptionChecking()
        else
            checkandNavigate()
        end if
    end if
    ' Subscription state                      "inDunning" "status"           'Subscription status from getAllPurchaseAPI
    ' Current                                   false       Valid
    ' In recovery (in 3 - day grace period)     true        Valid
    ' On Hold                                   true        invalid
    ' Canceled                                  false       invalid
end function


function onRequestStatus()
    print "onRequestStatus called launchscene"
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


function userSubscriptionChecking()
    m.UserSubscription = CreateObject("roSGNode", "UserSubscription")
    m.UserSubscription.ObserveField("UserSubResponseData", "OnUserSubResponseData")
    m.UserSubscription.callFunc("runUserSubscription", "")
end function

sub OnUserSubResponseData()
    ?"usersubsccheckingcalled"
    checkandNavigate()
end sub

sub DeleteRegistry()
    print "Starting Delete Registry"
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1
            RegistrySection.Delete(key)
            ' if key <> "templateInstalled" and key <> "templateGuestEvent" and key <> "country_code" and key <> "ippaddress" and key <> "channelsids" and key <> "PubID" and key <> "countrycode" and key <> "channelID" and key <> "MENU_ITEMS_TITLE" and key <> "MENU_ITEMS_ORDER" and key <> "MENU_ITEMS_TYPE"
            '     print "Deleting " section + ":" key
            ' else
            '     ?key + " not deleted"
            ' end if
        end for
        RegistrySection.flush()
    end for
    print i.toStr() " Registry Keys Deleted"
end sub




'api -order need to be follwed
' ip
' config
' authentication
' home
