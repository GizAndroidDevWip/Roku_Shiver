sub Init()
    ' createTopMenu()

    ' m.videoPlayer.ObserveField("state", "OnVideoPlayerStateChange")
    ' m.videoPlayer.getchild(1).getchild(11).visible = false
    di = CreateObject("roDeviceInfo")
    ' ?di.GetDrmInfoEx()
    ' ?di.GetDrmInfoEx().PlayReady
    ' ?di.GetDrmInfoEx().Widevine

    m.loadingIndicator = m.top.findNode("loading")
    if m.loadingIndicator <> invalid and m.loadingIndicator.getChild(0) <> invalid and m.loadingIndicator.getChild(1) <> invalid and m.loadingIndicator.getChild(1).getChild(0) <> invalid and m.loadingIndicator.getChild(1).getChild(0).getChild(0) <> invalid then
        m.loadingIndicator.getChild(0).color = "#000000"
        m.loadingIndicator.getChild(1).getChild(0).getChild(0).blendColor = "#FFFFFF"
    end if
end sub

sub OnVisibleChange()
    if m.top.visible = true then
        m.videoPlayer.control = "resume"
    else
        m.videoPlayer.control = "pause"
    end if
end sub

sub playUsingURL()
    if m.top.URL <> invalid and m.top.URL <> ""
        category_names = [""]
        m.selectedVideoItem = CreateObject("RoSGNode", "ContentNode")
        m.selectedVideoItem.addFields({
            video_title: "",
            watched_duration: 0,
            category_name: category_names,
            video_id: ""
        })
        playVideo(m.top.URL)
    end if
end sub
sub taskStateChanged(event as object)
    print "Player : taskStateChanged(), id = "; event.getNode(); ", "; event.getField(); " = "; event.getData()
    state = event.GetData()
    if state = "done" or state = "stop" or state = "finished"
        exitPlayer()
        m.count = 0
        sec = CreateObject("roRegistrySection", "TemplateAuthentication")
        '  if sec.Exists("Autolog")
        '     tok = sec.Read("Autolog")
        '     if tok="notvalid"
        '        exitPlayer()
        '     else
        '         ' m.top.autoplay=true
        '     end if
        '  endif
    else
    end if
end sub
sub exitPlayer()
    ?"exitPlayer called : VideoPlayerScene"
    m.count = 0
    m.videoPlayer.control = "stop"
    m.videoPlayer.visible = false
    m.PlayerTask = invalid
    m.videoPlayer.state = "done"
    ' m.top.autoplay=false
end sub
' This function is called when "m.top.videoListContent" gets the content.
' sets the details to videoplayer

sub runGetVideoDetailstask()
    ?"runGetVideoDetailstask called : VideoPlayerScene"
    m.GetVideoDetailsTask = CreateObject("roSGNode", "GetVideoDetailsTask")
    m.GetVideoDetailsTask.videoID = m.top.videoId
    m.GetVideoDetailsTask.observeField("videoDetailsResponse", "gotVideoContent")
    m.GetVideoDetailsTask.callFunc("runGetVideoDetailsTask", "")
end sub


sub gotVideoContent()
    m.videoListContent = m.GetVideoDetailsTask.videoDetailsResponse
    if m.videoListContent <> invalid then
        m.selectedVideoItem = m.videoListContent
        if m.selectedVideoItem.video_id <> invalid and m.selectedVideoItem.video_name <> invalid
            playVideo(m.selectedVideoItem.video_name) ' passing video url
        end if
    end if
end sub

function OnkeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "back"
            if m.video <> invalid and m.video.visible = true
                m.video.control = "stop"
                m.top.closeAndgoToHomeScene = true
                return true
            end if

            if IsNotNull(m.videoPlayer) then m.videoPlayer.control = "stop"
            if IsNotNull(m.Timer) then m.Timer.control = "stop"
            handled = false

        else if key = "up"
        end if
    end if
    return handled
end function
' This function is called for every 5 seconds.
' this is called for calling videoplayer events



function strReplace(basestr as string, oldsub as string, newsub as string) as string
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
        newstr = newstr + newsub
        i = i + Len(oldsub)
    end while
    return newstr
end function


sub playVideo(URL)
    ?"playVideoFunction called : VideoPlayerScene"
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: m.selectedVideoItem.video_title,
        id: m.selectedVideoItem.video_id,
        url: URL, '"https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
        categories: m.selectedVideoItem.category_name[0],
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "is_live": 1,
    "show_id": m.selectedVideoItem.show_id })
    content.ClosedCaptions = true
    content.globalCaptionMode = "On"
    content.HDBranded = true
    content.IsHD = true
    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if
    m.Player.content = content
    m.Player.watched_duration = m.selectedVideoItem.watched_duration
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.control = "play"
    m.loadingIndicator.visible = false
end sub


function onVideoVisibleChange()
    ?"onVideoVisibleChange called : VideoPlayerScene"
    ?m.Player.visible
end function


function PlayerStateChanged(params)
    ?"PlayerStateChanged called : MainVideoPlayer ";m.Player.state
    if m.Player.state = "done"
        m.top.closethispage = true
    end if
end function












function playTimeGridLive()
    playTimeGridLiveVideo(m.top.timeGridSceneInputData)
end function

sub playTimeGridLiveVideo(timeGridSceneInputData)
    ?"playVideoFunction called : VideoPlayerForTimeGridScene"
    videoContent = {
        channel_id: timeGridSceneInputData.channel_id,
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: timeGridSceneInputData.title,
        id: timeGridSceneInputData.data,
        url: timeGridSceneInputData.URL, '"https://epg.provider.plex.tv/library/parts/5e20b730f2f8d5003d739db7-5f0ff262d71dcb00449ec015.m3u8?X-Plex-Session-Identifier=y75hbmqm7cpch5u2ho42sjvu&X-Plex-Product=Plex%20Web&X-Plex-Version=4.122.0&X-Plex-Client-Identifier=m5qurtm6cggg1j9rbld98o4t&X-Plex-Platform=Chrome&X-Plex-Platform-Version=120.0&X-Plex-Features=external-media%2Cindirect-media%2Chub-style-list&X-Plex-Model=hosted&X-Plex-Device=Windows&X-Plex-Device-Name=Chrome&X-Plex-Device-Screen-Resolution=1536x695%2C1536x864&X-Plex-Token=2t8GyRGDf-Cos5NxGk7j&X-Plex-Language=en&Accept-Language=en&X-Plex-Session-Id=e0f1dcad-8853-438e-84f9-c6fa0fc45939"'timeGridSceneInputData.URL, '"https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
        categories: "",
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "is_live": "1",
        "channel_id": timeGridSceneInputData.channel_id,
        "show_id": timeGridSceneInputData.show_id.ToStr(),
        "schedule_id": timeGridSceneInputData.schedule_id,
        "is_from": timeGridSceneInputData.is_from
    })
    content.ClosedCaptions = true
    content.globalCaptionMode = "On"
    content.HDBranded = true
    content.IsHD = true
    if m.PlayerForTimeGrid = invalid:
        m.PlayerForTimeGrid = m.top.CreateChild("PlayerForTimeGrid")
        m.PlayerForTimeGrid.observeField("state", "PlayerForTimeGridStateChanged")
        m.PlayerForTimeGrid.observeField("visible", "onVideoForTimeGridPlayerVisibleChange")
    end if
    m.PlayerForTimeGrid.content = content
    m.PlayerForTimeGrid.watched_duration = 0
    m.PlayerForTimeGrid.visible = true
    m.PlayerForTimeGrid.skipAd = true
    m.PlayerForTimeGrid.setFocus(true)
    m.PlayerForTimeGrid.control = "play"
    m.loadingIndicator.visible = false
end sub

function PlayerForTimeGridStateChanged()
    ?"PlayerForTimeGridStateChanged called : VideoPlayerScene ";m.PlayerForTimeGrid.state
    if m.PlayerForTimeGrid.state = "done"
        ?"onVideoForTimeGridPlayerVisibleChange called222"
        m.top.closethispage = true
    end if
end function


function onVideoForTimeGridPlayerVisibleChange(params)
    ?"onVideoForTimeGridPlayerVisibleChange called"
    ?m.PlayerForTimeGrid.state

end function









'new LIVE logic.
sub checkLiveNowSubscriptionForMenuClick()

    if (getSubscriptionRequired() = "true")
        if isGuest() = "true"
            if (getLiveLoginCheck() = "true")
                ' if (getRegisterationMandatory() = "true")
                m.loadingIndicator.visible = false
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

sub callSubCheckAPiForMenuClick(channelId)
    m.ChannelSubsriptionTask = CreateObject("roSGNode", "ChannelSubsriptionTask")
    m.ChannelSubsriptionTask.channelID = channelId
    m.ChannelSubsriptionTask.observeField("channelSubs", "checkLiveNowSubscription2ForMenuClick")
    m.ChannelSubsriptionTask.callFunc("runChannelSubsriptionTask", "")
end sub


sub checkLiveNowSubscription2ForMenuClick()
    if m.ChannelSubsriptionTask.channelSubs = true
        callLiveAPI()
    else
        showSubscriptionPageForLive(getFastChannelId())
    end if
end sub

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

sub showSubscriptionPageForLive(channelId) ' show subscription  page for continue watching premium rental videos
    ?"showPaymentPage called"
    m.loadingIndicator.visible = false
    ' m.top.goToPaymentDescriptionScreenForEvent = channelId
    showPaymentPage(channelId)
end sub

sub showPaymentPage(channelId) ' show payment page
    ?"showPaymentPage called"
    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.top.goToPaymentDescriptionScreenForEvent = channelId
    else
        showSubscriptionDialog()
    end if
end sub

sub showSubscriptionDialog()
    dialog = createObject("roSGNode", "Dialog")

    ' Set Title
    dialog.title = getText("warning")

    ' Dialog Config
    dialog.optionsDialog = true
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onSubscriptionRequiredOkButtonselected")

    ' Construct Message using helper function
    msg1 = getText("to_avail_this_video")
    msg2 = getText("on_web")

    dialog.message = msg1 + " " + getAppTitle() + " " + msg2

    ' Show Dialog
    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

sub onSubscriptionRequiredOkButtonselected()
    m.parentScene.dialog.close = true
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


sub onPlayLive()

    content = m.liveApi.livefetcherResponse[0]
    now_playing = invalid
    if content <> invalid then now_playing = content.now_playing

    schedule_id = ""
    show_id = 0
    video_title = ""
    live_link = ""

    if now_playing <> invalid
        if now_playing.id <> invalid
            schedule_id = now_playing.id.ToStr()
        end if
        if now_playing.show_id <> invalid then show_id = now_playing.show_id.ToStr()
        if now_playing.video_title <> invalid then video_title = now_playing.video_title
    end if

    if content <> invalid and content.live_link <> invalid then live_link = content.live_link

    data = {
        "url": live_link,
        "event_id": schedule_id,
        "TITLE": video_title,
        "show_id": show_id,
        "schedule_id": schedule_id,
        "is_from": "NORMAL_LIVENOW_SCENE"
        "channel_id": getFastChannelId()
    }
    m.top.timeGridSceneInputData = data
    m.loadingIndicator.visible = false
end sub


function IsNotNull(value as dynamic) as boolean
    return value <> invalid
end function

' this is for passing certification only . where we plays a n online sample m3u8 video directly while deeplinking
sub playDeeplinkVideo()
    if m.top.deepLinkSampleVideo <> invalid and m.top.deepLinkSampleVideo <> ""
        ?"playDeeplinkVideo called : VideoPlayerScene"
        videoContent = createObject("RoSGNode", "ContentNode")
        videoContent.url = m.top.deepLinkSampleVideo
        videoContent.streamformat = "m3u8"
        m.video = m.top.findNode("videoPlayer")
        m.video.visible = true
        m.video.content = videoContent
        m.video.AddHeader("token", getToken())
        m.video.control = "play"
        ' Observe the state field to handle play, pause, and resume
        m.video.observeField("state", "OnVideoPlayerStateChange")
        ' Show player controls
        m.video.enableUI = true
        m.video.setFocus(true)
        m.loadingIndicator.visible = false
    end if
end sub

function getToken()
    url = CreateObject("roUrlTransfer")
    url.SetUrl("https://poppo.tv/proxy/api/GenerateToken")
    url.AddHeader("access-token", getAuthorisationToken())
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    rsp = url.GetToString()
    responseJSON = ParseJSON(rsp)
    m.token = responseJSON.data
    return m.token
end function

function OnVideoPlayerStateChange()
    ?"OnVideoPlayerStateChange called : mainVideoPlayerScene"
    ?"state: "; m.video.state
    if m.video.state = "done" or m.video.state = "stop" or m.video.state = "finished"
        m.top.closethispage = true
    end if
end function