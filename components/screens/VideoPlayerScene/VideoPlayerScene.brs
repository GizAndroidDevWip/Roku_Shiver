sub Init()
    m.loadingIndicator = m.top.findNode("loading")
    if m.loadingIndicator <> invalid and m.loadingIndicator.getChild(0) <> invalid and m.loadingIndicator.getChild(1) <> invalid and m.loadingIndicator.getChild(1).getChild(0) <> invalid and m.loadingIndicator.getChild(1).getChild(0).getChild(0) <> invalid then
        m.loadingIndicator.getChild(0).color = "#000000"
        m.loadingIndicator.getChild(1).getChild(0).getChild(0).blendColor = "#FFFFFF"
    end if
    '
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")
    m.NoButton = m.top.findNode("NoButton")
    m.NoButton.getChild(0).blendColor = getButtonSelectionColor()
    m.YesButton = m.top.findNode("YesButton")
    m.YesButton.getChild(0).blendColor = getButtonSelectionColor()
    m.dialogmessage_label = m.top.findNode("dialogmessage_label")
    m.cancelbutton_Label = m.top.findNode("cancelbutton_Label")
    m.exitbutton_Label = m.top.findNode("exitbutton_Label")
    m.player = m.top.findNode("player")

    m.upnext_poster = m.top.findNode("upnext_poster")
    m.NoButton.ObserveField("buttonSelected", "onDialog_Left_ButtonSelected")
    m.YesButton.ObserveField("buttonSelected", "onDialog_Right_ButtonSelected")
    m.UpNext_rect2 = m.top.findNode("UpNext_rect2")
    m.top.ObserveField("visible", "OnVisibleChange")


    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = "You are no longer Logged in this device. Please Login again to access."


    okTitle = getText("ok") ' Default value


    ' Set "Logout All" button text

    logoutAllTitle = getText("logout_all") ' Default value





    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]

    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")

    m.top.sessionExpiredPopUp = CreateObject("roSGNode", "BackDialog")
    m.top.sessionExpiredPopUp.backgroundUri = "pkg:/images/black.jpg"

    m.top.sessionExpiredPopUp.title = getText("session_expired_message")



    ' m.top.sessionExpiredPopUp.title = "Your session expired. Please login to continue"
    m.top.sessionExpiredPopUp.buttons = ["Ok"]
    m.top.sessionExpiredPopUp.ObserveField("buttonSelected", "OnsessionExpiredClick")


    '**autoplay
    m.upnext_video_name = m.top.findNode("upnext_video_name")
    m.upnext_counter_text = m.top.findNode("upnext_counter_text")
    m.UpNext_rect = m.top.findNode("UpNext_rect")
    m.Upnext_mainTitle = m.top.findNode("Upnext_mainTitle")

    m.Upnext_mainTitle.text = getText("up_next")

    m.Upnext_mainTitle.color = getButtonSelectionColor()
    m.Upnext_mainTitle.font.size = 75
    m.upnextTimer = m.top.findNode("upNextTimer")
    m.upnextTimer.observeField("fire", "onUpNextTimerFire")
    m.parentScene = GetParentScene()



    m.isWatchWithOutAdsDialogRectVisible = false ' dialog box visible flag for watch withoutads
    m.continueWatchingDialogVisible = false 'same dialog box using another flag for continue watching
    m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false ' dialog box visible flag for watch withoutads for autoplay
    m.continueWatchingDialogVisible_ForAutoplay = false ' dialog box visible flag for watch continue watching for autoplay
end sub

sub OnVisibleChange()
    if m.top.visible = false then
        if m.Player <> invalid then m.Player.control = "stop"
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
        playVideo()
    end if
end sub


' This function is called when "m.top.videoListContent" gets the content.
' sets the details to videoplayer

sub runUserSubscriptionTask()
    ?"runUserSubscriptionTask called : VideoPlayerScene"
    m.UserSubscription = CreateObject("roSGNode", "UserSubscription")
    m.UserSubscription.observeField("SubsResponse", "runVideoSubscriptionTask")
    m.UserSubscription.callFunc("runUserSubscription", "")
end sub

sub runVideoSubscriptionTask()
    m.UserSubscription.unobserveField("SubsResponse")
    m.UserSubscription.callFunc("stopUserSubscription", "")
    m.loadingIndicator.visible = true
    m.VideoSubscriptionTask = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.VideoSubscriptionTask.videoID = m.top.videoId
    m.VideoSubscriptionTask.show_id = m.top.show_id
    m.VideoSubscriptionTask.observeField("videoDetailsResponse", "runGetVideoDetailstask")
    m.VideoSubscriptionTask.callFunc("runVideoSubscriptionTask", "")
end sub

sub runGetVideoDetailstask()
    ?"runGetVideoDetailstask called : VideoPlayerScene"
    m.VideoSubscriptionTask.unobserveField("videoDetailsResponse")
    m.VideoSubscriptionTask.callFunc("stopVideoSubscriptionTask", "")
    m.GetVideoDetailsTask = CreateObject("roSGNode", "GetVideoDetailsTask2")
    m.GetVideoDetailsTask.videoID = m.top.videoId
    m.GetVideoDetailsTask.observeField("videoDetailsResponse", "userLoggedInLimitCheck")
    m.GetVideoDetailsTask.callFunc("runGetVideoDetailsTask", m.top.show_id)
end sub



sub userLoggedInLimitCheck()
    m.GetVideoDetailsTask.unobserveField("videoDetailsResponse")
    m.GetVideoDetailsTask.callFunc("stopGetVideoDetailsTask", "")
    m.VODcontent1 = m.VideoSubscriptionTask.videoDetailsResponse
    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubResponse <> invalid and m.VideoSubscriptionTask.userSubResponse.forcibleLogout <> invalid
        forcibleLogout = m.VideoSubscriptionTask.userSubResponse.forcibleLogout
    else
        forcibleLogout = false
    end if

    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubResponse <> invalid and m.VideoSubscriptionTask.userSubResponse.session_expired <> invalid
        session_expired = m.VideoSubscriptionTask.userSubResponse.session_expired
    else
        session_expired = false
    end if


    m.parentScene = GetParentScene()
    if forcibleLogout = true ' user logged in limit - case
        m.parentScene.dialog = m.top.dialogAuthExceed
    else if session_expired = true
        m.parentScene.dialog = m.top.sessionExpiredPopUp
    else
        newPlayLogic()
    end if

    VODcontent = returnTheCurrentFocusedData()
    if VODcontent.video_id <> invalid
        callAutoplayAPI(VODcontent.video_id.ToStr())
    end if
end sub


function playLogic()
    videoSubscriptionCount = m.VideoSubscriptionTask.videoSubIDSCount
    free_video = m.VideoSubscriptionTask.videoDetailsResponse.free_video
    VODcontent = returnTheCurrentFocusedData()
    watched_duration = VODcontent.watched_duration

    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubResponse <> invalid and m.VideoSubscriptionTask.userSubResponse.data <> invalid and m.VideoSubscriptionTask.userSubResponse.data.Count() <> invalid and m.VideoSubscriptionTask.userSubResponse.data.Count() > 0
        usersubcount = m.VideoSubscriptionTask.userSubResponse.data.Count()
    else
        usersubcount = 0
    end if
    if videoSubscriptionCount = 0
        if getRegisterationMandatory() = "true"
            if isGuest() = "true" ' go to login
                goToLandingScene()
            else if getAdRequired() = "true" ' play video with ads
                if usersubcount > 0
                    m.skipAd = true
                else
                    m.skipAd = false
                end if
                continueWatchingLogic(watched_duration)
            else ' playvideo
                m.skipAd = true
                continueWatchingLogic(watched_duration)
            end if
        else if getAdRequired() = "true" ' play video with ads
            m.skipAd = false
            continueWatchingLogic(watched_duration)
        else 'play video
            m.skipAd = true
            continueWatchingLogic(watched_duration)
        end if
    else if videoSubscriptionCount > 0 and free_video = true ' watch without ads
        if m.VideoSubscriptionTask.videoSubs = true ' play video
            m.skipAd = true
            continueWatchingLogic(watched_duration)
        else ' / SHOW "Watch with Ads?" POPUP
            ' showWatchwithoutAdsPopup()
        end if
    else 'video has subscriptions
        if m.VideoSubscriptionTask.videoSubs = true ' play video
            m.skipAd = true
            continueWatchingLogic(watched_duration)
        else if isGuest() = "true" ' go to login
            goToLandingScene()
        else ' go to subscription screen
            goToSubscriptionListingScene()
        end if
    end if
end function


function newPlayLogic()
    videoDetailsResponse = m.GetVideoDetailsTask.videoDetailsResponse
    if videoDetailsResponse <> invalid
        if videoDetailsResponse.success = false
            if videoDetailsResponse.responseCode <> invalid and videoDetailsResponse.responseCode = 401
                goToLandingScene()
            else if videoDetailsResponse.responseCode <> invalid and videoDetailsResponse.responseCode = 403
                if videoDetailsResponse["checkout_qr"] <> invalid and videoDetailsResponse["checkout_qr"] <> ""
                    showQrOverlay(videoDetailsResponse["checkout_qr"])
                    return true
                end if
                goToSubscriptionListingScene()
            end if
        else if videoDetailsResponse.success = true
            continueWatchingLogic(videoDetailsResponse.watched_duration)
        end if
    else

    end if
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



sub gotVideoContent()
    m.videoListContent = m.GetVideoDetailsTask.videoDetailsResponse
    if m.videoListContent <> invalid then
        m.selectedVideoItem = m.videoListContent
        if m.selectedVideoItem.video_id <> invalid and m.selectedVideoItem.video_name <> invalid
            playVideo() ' passing video url
        end if
    end if
end sub


sub playVideo()
    ' Check if we are still the active, visible screen
    if m.top.visible = false or not m.top.hasFocus() then
        return
    end if
    VODcontent = returnTheCurrentFocusedData()
    if m.VODcontent1 <> invalid and m.VODcontent1.checkout_qr <> invalid and m.VODcontent1.checkout_qr <> ""
        if isGuest() = "true"
            gotoLandingScene() ' if guest go to login page
            return
        end if
        showQrOverlay(m.VODcontent1.checkout_qr)
        return
    end if

    if IsNotNull2(m.VODcontent1.parental_pin_required) and m.VODcontent1.parental_pin_required = true
        if isGuest() = "true"
            gotoLandingScene() ' if guest go to login page
            return
        end if

        sec = CreateObject("roRegistrySection", getAppKey())
        if not sec.Exists("PARENTAL_PIN")
            print "A PIN is already saved: " ; sec.Read("PARENTAL_PIN")
            ManagePinPadDialog()
            return
        end if
    end if

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

    videoContent = {
        streamFormat: VODcontent.streamFormat,
        ' titleSeason: m.GetVideoDetailsTask.videoDetailsResponse.video_title,
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: m.GetVideoDetailsTask.videoDetailsResponse.video_title,
        url: m.GetVideoDetailsTask.videoDetailsResponse.video_name,
        categories: categoriesWithComma'VODcontent.categories
        nielsenProgramId: "CBAA", 'String identifying content /program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: VODcontent.video_duration
    }
    ' videoContent.ClosedCaptions = True
    subtitle_config = m.GetVideoDetailsTask.videoDetailsResponse.subtitles

    SubtitleTracks = []
    for each item in m.GetVideoDetailsTask.videoDetailsResponse.subtitles
        subtitleItem = {}
        subtitleItem.Language = item.language_name
        subtitleItem.Description = item.short_code
        subtitleItem.TrackName = item.subtitle_url
        SubtitleTracks.push(subtitleItem)
    end for

    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)

    if m.GetVideoDetailsTask.videoDetailsResponse.video_type <> invalid
        m.video_type = m.GetVideoDetailsTask.videoDetailsResponse.video_type
    else
        m.video_type = ""

    end if

    content.addFields({
        "is_live": "0",
        "audio_languages": m.GetVideoDetailsTask.videoDetailsResponse.audio_languages,
        "resolutions_parsed": m.GetVideoDetailsTask.resolutions_parsed,
        "category": categoriesWithComma,
        "video_id": m.GetVideoDetailsTask.videoDetailsResponse.video_id,
        "categoriesWithComma": categoriesWithComma,
        "show_id": VODcontent.show_id,
        "ai_type": m.top.ai_type,
        "video_type": m.video_type,
        "show_id_playlist": m.top.show_id,
        "calendarId": m.top.calendarId,
        "waterMark": VODcontent.watermark,
        "videoDetailsResponse": m.GetVideoDetailsTask.videoDetailsResponse,
        "video_time": m.GetVideoDetailsTask.videoDetailsResponse.video_time
    })

    finalAdURL = ""
    if m.GetVideoDetailsTask <> invalid and m.GetVideoDetailsTask.videoDetailsResponse <> invalid and m.GetVideoDetailsTask.videoDetailsResponse.ad_link <> invalid
        finalAdURL = formatAdURL(m.GetVideoDetailsTask.videoDetailsResponse.ad_link)
        ?"finalAdURL printed: "
        ? "********************"
        ? finalAdURL
        ? "********************"
    end if
    content.ad_url = finalAdURL.EncodeUri()
    if subtitle_config <> invalid
        content.ClosedCaptions = True
        content.globalCaptionMode = "On"
        content.HDBranded = True
        content.IsHD = True
        content.SubtitleConfig = subtitle_config
        content.SubtitleTracks = SubtitleTracks
        content.SubtitleTrack = SubtitleTracks
    end if

    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("VIDEO_LANGUAGE_CHANGED", "OnVideoLangugageChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
        m.Player.observeField("new_videoId", "newVideoClicked")
        m.Player.observeField("you_may_also_like_show_id", "YoumayAlsoLikeShowId")
        m.Player.observeField("stop_upNext_timer", "onStopupNextTimer")
        m.Player.observeField("action_command", "onActionCommandChange")
    end if
    m.Player.content = content
    ' ?m.Player.content.video_type

    m.Player.visible = true
    m.Player.setFocus(true)

    if m.top.isStartOverButtonClicked <> invalid and m.top.isStartOverButtonClicked = true
        m.Player.watched_duration = 0
    else
        m.Player.watched_duration = m.watched_duration 'setting watched_duration
    end if

    if m.skipAd = true
        m.Player.skipAd = true
    else
        m.Player.skipAd = false
    end if

    m.Player.control = "play"
    m.Player.observeField("visibility", "onPlayerVisibleChange")
    if m.top.previous_videoId <> invalid and m.top.previous_videoId <> ""
        m.Player.previous_videoId = m.top.previous_videoId
    end if
end sub

function newVideoClicked()
    youmayid = m.Player.you_may_also_like_show_id
    if m.Player <> invalid and m.Player.new_videoId <> invalid
        m.upnextTimer.control = "stop"
        newVideoId = m.Player.new_videoId
        m.Player = invalid
        m.top.showid_2 = youmayid
        m.top.reloadvideoPlayerScene = newVideoId
        m.top.reloadvideoPlayerScene2 = youmayid
    end if
end function



function YoumayAlsoLikeShowId()
    you_may_also_like_show_id = m.Player.you_may_also_like_show_id
    m.top.showid_2 = you_may_also_like_show_id

end function



function onStopupNextTimer()

    m.upnextTimer.control = "stop"
end function



function onVideoVisibleChange()
    ?"onVideoVisibleChange called : VideoPlayerScene"
    ?m.Player.visible
end function

function onActionCommandChange()
    if m.Player.action_command <> invalid
        if m.Player.action_command = "GO_ADS_FREE"
            m.top.isGoadsFreeclicked = true
            goToSubscriptionListingScene()
        end if
    end if
end function



sub showWatchwithoutAdsPopup()
    ?"showWatchwithoutAdsPopup called"


    m.dialogmessage_label.text = getText("watch_with_ads")




    m.cancelbutton_Label.text = getText("continue")



    m.exitbutton_Label.text = getText("subscribe")



    m.dialogbg_rect.visible = true
    m.isWatchWithOutAdsDialogRectVisible = true
    m.YesButton.setFocus(true)
    m.loadingIndicator.visible = false
end sub

sub continueWatchingLogic(watched_duration)
    ?"continueWatchingLogic called"
    VODcontent = returnTheCurrentFocusedData()
    if watched_duration <> invalid
        if watched_duration > 0
            ?"VODcontent.watched_duration > 0 ";watched_duration
            ' if m.top.needToShowContinueWatchingDialog = true
            '     showContinueWatchingDialog()
            ' else
            ' end if
        else
            ?"VODcontent.watched_duration > 0 else"
            ' playvideo()
        end if
        m.watched_duration = VODcontent.watched_duration
        playvideo()
    end if
end sub


sub showContinueWatchingDialog()
    ?"showContinueWatchingDialog called"

    m.dialogmessage_label.text = getText("continue_watching")

    ' m.dialogmessage_label.text = "Continue Watching?"

    m.cancelbutton_Label.text = getText("resume")



    ' m.cancelbutton_Label.text = "Resume"

    m.exitbutton_Label.text = getText("play_from_beginning")


    m.dialogbg_rect.visible = true
    m.continueWatchingDialogVisible = true
    m.isWatchWithOutAdsDialogRectVisible = false
    m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false
    m.NoButton.setFocus(true)
    m.loadingIndicator.visible = false
end sub


sub showContinueWatchingDialogForAutoplay()
    ?"showContinueWatchingDialogForAutoplay called"

    m.dialogmessage_label.text = getText("continue_watching")




    ' m.dialogmessage_label.text = "Continue Watching?"


    m.cancelbutton_Label.text = getText("resume")

    ' m.cancelbutton_Label.text = "Resume"



    m.exitbutton_Label.text = getText("start_over")


    ' m.exitbutton_Label.text = "Start Over"
    m.dialogbg_rect.visible = true
    m.continueWatchingDialogVisible_ForAutoplay = true
    m.continueWatchingDialogVisible = false
    m.isWatchWithOutAdsDialogRectVisible = false
    m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false
    m.NoButton.setFocus(true)
    m.loadingIndicator.visible = false
end sub


sub onDialog_Left_ButtonSelected()
    VODcontent = returnTheCurrentFocusedData()
    m.loadingIndicator.visible = true

    if m.isWatchWithOutAdsDialogRectVisible = true
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false
        m.continueWatchingDialogVisible = false'
        if getRegisterationMandatory() = "true"
            if isGuest() = "true"
                goToLandingScene()
                return
            else if getAdRequired() = "true" 'play video with ads
                m.skipAd = false
            else 'play video
                m.skipAd = true
            end if
        else if getAdRequired() = "true" 'play video with ads
            m.skipAd = false
        else 'play video
            m.skipAd = true
        end if

        watched_duration = 0
        if VODcontent <> invalid and VODcontent.watched_duration <> invalid
            watched_duration = VODcontent.watched_duration
        end if
        continueWatchingLogic(watched_duration)


    else if m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true
        ?"onDialog_Left_ButtonSelected: 2"
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false
        m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false
        m.continueWatchingDialogVisible = false'
        if getRegisterationMandatory() = "true"
            if isGuest() = "true"
                goToLandingScene()
                return
            else if getAdRequired() = "true" 'play video with ads
                m.skipAd = false
            else 'play video
                m.skipAd = true
            end if
        else if getAdRequired() = "true" 'play video with ads
            m.skipAd = false
        else 'play video
            m.skipAd = true
        end if
        watched_duration1 = 0
        if m.GetVideoDetailsTaskForAutoPlay <> invalid and m.GetVideoDetailsTaskForAutoPlay.watched_duration <> invalid
            watched_duration1 = m.GetVideoDetailsTaskForAutoPlay.watched_duration
        end if
        continueWatchingLogicForAutoplay(watched_duration1)


    else if m.continueWatchingDialogVisible = true ' this is resume case when resume button is pressed
        ?"onDialog_Left_ButtonSelected: 3"
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false '******this is resume case************
        m.continueWatchingDialogVisible = false'
        m.watched_duration = VODcontent.watched_duration ' setting watched_duration
        playvideo() ' start over button selected


    else if m.continueWatchingDialogVisible_ForAutoplay = true
        ?"onDialog_Left_ButtonSelected: 4"
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false '******this is resume case************
        m.continueWatchingDialogVisible = false'
        m.watched_duration = VODcontent.watched_duration ' setting watched_duration to autoplay function
        autoPlayVideo2() ' start over button selected
    end if
end sub



sub onDialog_Right_ButtonSelected()

    if m.isWatchWithOutAdsDialogRectVisible = true
        ?"onDialog_Right_ButtonSelected: 1"
        if isGuest() = "true"
            goToLandingScene()
        else
            m.dialogbg_rect.visible = false
            m.loadingIndicator.visible = false
            VODcontent = returnTheCurrentFocusedData()
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            showPaymentPage(VODcontent.video_id)
            ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
        end if


    else if m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true
        ?"onDialog_Right_ButtonSelected: 2"
        if isGuest() = "true"
            goToLandingScene()
        else
            m.dialogbg_rect.visible = false
            m.loadingIndicator.visible = false
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            showPaymentPage(VODcontent.video_id)
            ' m.top.goToPaymentDescriptionScreen = m.autoplayVideoId
        end if
        m.isWatchWithOutAdsDialogRectVisible = false
        m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false
        m.continueWatchingDialogVisible = false'


    else if m.continueWatchingDialogVisible = true ' this is start over case when start over button is pressed
        ?"onDialog_Right_ButtonSelected: 3"
        m.loadingIndicator.visible = true
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false
        m.continueWatchingDialogVisible = false'
        m.watched_duration = 0
        playvideo() ' continue watching clicked


    else if m.continueWatchingDialogVisible_ForAutoplay = true ' this is start over case when start over button is pressed
        ?"onDialog_Right_ButtonSelected: 4"
        m.loadingIndicator.visible = true
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false
        m.continueWatchingDialogVisible_ForAutoplay = false'
        m.watched_duration = 0
        autoPlayVideo2() ' continue watching clicked
    end if
end sub

sub showPaymentPage(videoId) ' show payment page
    ?"showPaymentPage called"
    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreen = videoId
    else
        showSubscriptionDialog()
    end if

    ' VODcontent = returnTheCurrentFocusedData()
    ' m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
    'showSubscriptionDialog()
end sub

sub showSubscriptionDialog()
    dialog = createObject("roSGNode", "Dialog")
    ' dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"


    dialog.title = getText("warning")

    ' dialog.title = "Currently unavailable!"
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onSubscriptionRequiredOkButtonselected")



    msg1 = getText("to_avail_this_video")



    msg2 = getText("on_web")




    dialog.message = msg1 + getAppTitle() + msg2
    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
    ' dialog.optionsDialog = true
    ' dialog.message = "To avail this video, visit our website.. Please visit " + getAppTitle() + " on the web for help"
    ' m.top.dialog = dialog
    ' m.parentScene.dialog = dialog
end sub

sub onSubscriptionRequiredOkButtonselected()
    m.parentScene.dialog.close = true
end sub


sub goToLandingScene()
    m.loadingIndicator.visible = false
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.top.gotoLandingScene = true
    m.dialogbg_rect.visible = false
    m.isWatchWithOutAdsDialogRectVisible = false
    m.continueWatchingDialogVisible = false'
end sub

sub goToSubscriptionListingScene()
    m.loadingIndicator.visible = false
    VODcontent = returnTheCurrentFocusedData()
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
    showPaymentPage(VODcontent.video_id)
    m.dialogbg_rect.visible = false
    m.isWatchWithOutAdsDialogRectVisible = false
    m.continueWatchingDialogVisible = false
end sub






'#############################_________________________AUTOPLAY___________________________________________________________________________________________________________________________________
'******this method called after one video finished, this is for autoplaying next video
function PlayerStateChanged()
    if invalid <> m.Player and invalid <> m.Player.playerState
        if m.Player.playerState = "finished" 'or m.Player.playerState = "stopped"
            if m.AutoplayData2 <> invalid

                if m.GetVideoDetailsTask.videoDetailsResponse <> invalid and m.GetVideoDetailsTask.videoDetailsResponse.video_type <> invalid and m.GetVideoDetailsTask.videoDetailsResponse.video_type = "playlist"

                    m.loadingIndicator.visible = true
                    m.UpNext_rect.visible = false
                    m.UpNext_rect2.visible = false
                    ' m.upnext_video_name.text = m.AutoplayData2.videoDetailsResponse.video_title
                    ' m.upnext_poster.uri = m.AutoplayData2.videoDetailsResponse.thumbnail_350_200
                    ' m.upNextTimerCount = 5
                    m.upnextTimer.control = "stop"
                    newPlayLogicForAutoplay()
                else
                    m.loadingIndicator.visible = false
                    m.UpNext_rect.visible = true
                    m.upnext_video_name.text = m.AutoplayData2.videoDetailsResponse.video_title
                    m.upnext_poster.uri = m.AutoplayData2.videoDetailsResponse.thumbnail_350_200
                    m.upNextTimerCount = 5
                    m.upnextTimer.control = "start" ' autoplay starts


                end if

            end if
        else if m.Player.playerState = "back_pressed" or m.Player.playerState = "" or m.Player.playerState = "stop" or m.Player.playerState = "done" or m.Player.playerState = "none" or m.Player.playerState = "error" or m.Player.playerState = "stopped"
            m.UpNext_rect.visible = false
            '   m.Player.control = "stop"
            ' m.upnextTimer.control = "stop"
            ' m.Player = invalid
            m.loadingIndicator.visible = false
            m.top.closethispage = true
        end if
        if m.Player <> invalid and m.Player.state = "change_video_track"
            ' ' m.Player.control = "stop"
            ' m.Player.content.url = "https://gizmeon.mdc.akamaized.net/PUB-50054/202307311690796936/playlist.m3u8"
            ' m.Player.control = "play"
        else

        end if
    end if

end function

sub onUpNextTimerFire()
    m.upNextTimerCount = m.upNextTimerCount - 1
    ?"onUpNextTimerFire called :" m.upNextTimerCount
    if m.upNextTimerCount = 0
        m.upnextTimer.control = "stop"
        m.upNextTimerCount = 5
        m.UpNext_rect.visible = false
        m.loadingIndicator.visible = true
        m.Player.upnext_screen_finished_showing = true
        newPlayLogicForAutoplay()
    end if
    m.upnext_counter_text.text = "Next in... " + m.upNextTimerCount.ToStr()
end sub


'''''''''
' OnVideoLangugageChanged: this is used to call autoplay api agin so that the autoplay video follows the selected language
'
' @param {dynamic} params - video id of the newly selected video
'''''''''
function OnVideoLangugageChanged()
    callAutoplayAPI(m.Player.VIDEO_LANGUAGE_CHANGED)
end function

'*****
sub callAutoplayAPI(video_id) '## calls autoplay api
    m.AutoPlayAPiTask = CreateObject("roSGNode", "AutoPlayAPiTask")
    m.AutoPlayAPiTask.observeField("AutoPlayAPiTaskContent", "OnAutoPlayAPiTaskContent")
    ?m.top.show_id
    ?"m.top.show_idsaswwe"
    m.AutoPlayAPiTask.callFunc("runAutoPlayAPiTask", video_id, m.top.show_id)
    ?"xx"
end sub

sub OnAutoPlayAPiTaskContent() '## saves autoplay data to m.AutoplayData
    ?"OnAutoPlayAPiTaskContent called"
    if m.AutoPlayAPiTask <> invalid and m.AutoPlayAPiTask.AutoPlayAPiTaskContent <> invalid and m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data <> invalid
        m.AutoplayData = m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data
        if m.AutoplayData.show_id <> invalid
            m.top.show_id = m.AutoplayData.show_id
            ? m.top.show_id
            ?"m.top.show_id673456223"
        end if
        getVideoDetailsAPIForAutoPlay(m.AutoplayData.video_id.ToStr())
    else

    end if
end sub



sub getVideoDetailsAPIForAutoPlay(video_id as string) '## calls videodetail api of autoplay video
    m.GetVideoDetailsTaskForAutoPlay = CreateObject("roSGNode", "GetVideoDetailsTask2")
    m.VideoSubscriptionTask.show_id = m.top.show_id
    m.GetVideoDetailsTaskForAutoPlay.videoID = video_id
    m.autoplayVideoId = video_id
    m.GetVideoDetailsTaskForAutoPlay.observeField("videoDetailsResponse", "getVideoSubscriptionTaskAPIForAutoPlay")
    m.GetVideoDetailsTaskForAutoPlay.callFunc("runGetVideoDetailsTask", m.top.show_id)
end sub

sub getVideoSubscriptionTaskAPIForAutoPlay() '## calls VideoSubscriptionTask api of autoplay video
    m.VideoSubscriptionTaskForAutoPlay = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.VideoSubscriptionTask.show_id = m.top.show_id
    m.VideoSubscriptionTaskForAutoPlay.videoID = m.autoplayVideoId
    ?m.autoplayVideoId
    m.VideoSubscriptionTaskForAutoPlay.observeField("videoDetailsResponse", "OngetVideoDetailsAPIForAutoPlay")
    m.VideoSubscriptionTaskForAutoPlay.callFunc("runVideoSubscriptionTask", m.top.show_id)
end sub

function OngetVideoDetailsAPIForAutoPlay() '## saves videodetails data to m.AutoplayData2
    ?"OngetVideoDetailsAPIForAutoPlay calledddd"
    m.AutoplayData2 = m.GetVideoDetailsTaskForAutoPlay
end function

function playLogicForAutoplay()
    ?"playLogicForAutoplay called"
    videoSubscriptionCount = m.VideoSubscriptionTaskForAutoPlay.videoSubIDSCount
    free_video = m.VideoSubscriptionTaskForAutoPlay.videoDetailsResponse.free_video
    VODcontent = returnTheCurrentFocusedData()
    watched_duration = VODcontent.watched_duration

    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubResponse <> invalid and m.VideoSubscriptionTask.userSubResponse.data <> invalid and m.VideoSubscriptionTask.userSubResponse.data.Count() <> invalid and m.VideoSubscriptionTask.userSubResponse.data.Count() > 0
        usersubcount = m.VideoSubscriptionTask.userSubResponse.data.Count()
    else
        usersubcount = 0
    end if

    if videoSubscriptionCount = 0
        if getRegisterationMandatory() = "true"
            if isGuest() = "true" ' go to login
                m.UpNext_rect.visible = false
                m.loadingIndicator.visible = false
                m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                showLoginDialog_ForAutoPlay()
            else if getAdRequired() = "true" ' play video with ads
                if usersubcount > 0
                    m.skipAd = true
                else
                    m.skipAd = false
                end if
                continueWatchingLogicForAutoplay(watched_duration)


            else ' play video
                m.skipAd = true
                continueWatchingLogicForAutoplay(watched_duration)
            end if
        else if getAdRequired() = "true" ' play video with ads
            m.skipAd = false
            continueWatchingLogicForAutoplay(watched_duration)
        else 'play video
            m.skipAd = true
            continueWatchingLogicForAutoplay(watched_duration)
        end if
    else if videoSubscriptionCount > 0 and free_video = true ' watch without ads
        if m.VideoSubscriptionTaskForAutoPlay.videoSubs = true ' play video
            m.skipAd = true
            continueWatchingLogicForAutoplay(watched_duration)
        else ' / SHOW "Watch with Ads?" POPUP
            showWatchwithoutAdsPopupForAutoplay()

        end if
    else 'video has subscriptions
        if m.VideoSubscriptionTaskForAutoPlay.videoSubs = true ' play video
            m.skipAd = true
            continueWatchingLogicForAutoplay(watched_duration)
        else if isGuest() = "true" ' go to login
            m.UpNext_rect.visible = false
            m.loadingIndicator.visible = false
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            showLoginDialog_ForAutoPlay()
        else ' go to subscription screen
            m.UpNext_rect.visible = false
            m.loadingIndicator.visible = false
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            showSubscriptionPageDialog_ForAutoplay()
        end if
    end if
end function


function autoPlayVideo2()' this is the play function for autoplay
    if m.top.visible = false
        ?"Blocking playVideo because scene is no longer active"
        return true
    end if

    if m.AutoplayData2 <> invalid and m.AutoplayData2.videoDetailsResponse <> invalid and m.AutoplayData2.videoDetailsResponse.checkout_qr <> invalid and m.AutoplayData2.videoDetailsResponse.checkout_qr <> ""
        if isGuest() = "true"
            gotoLandingScene() ' if guest go to login page
            return true
        end if
        showQrOverlay(m.AutoplayData2.videoDetailsResponse.checkout_qr)
        return true
    end if

    m.count = 1
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
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    macroChannelID = getchannelsid().Trim()
    macroVideoID = m.AutoplayData.video_id.toStr().Trim()
    if m.AutoplayData2.videoDetailsResponse <> invalid and m.AutoplayData2.videoDetailsResponse.video_duration <> invalid
        macroDurations = m.AutoplayData2.videoDetailsResponse.video_duration.toStr().Trim()

    else
        macroDurations = ""
    end if
    ' macroDuration = macroDurations.toInt() * 60
    macroDuration = macroDurations.toInt()
    macrouserID = getUserIdana().Trim()
    macrvideoID = m.AutoplayData.video_id.toStr().Trim()
    macrotitle = m.AutoplayData2.videoDetailsResponse.video_title
    m.uidana = getUserIdana()

    categories = []
    if m.AutoplayData2 <> invalid and m.AutoplayData2.videoDetailsResponse <> invalid and m.AutoplayData2.videoDetailsResponse.categories <> invalid
        categories = m.AutoplayData2.videoDetailsResponse.categories
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

    if m.AutoplayData2.videoDetailsResponse.season <> invalid
        season = m.AutoplayData2.videoDetailsResponse.season
    else
        season = ""
    end if
    if m.AutoplayData2.videoDetailsResponse.video_order <> invalid
        video_order = m.AutoplayData2.videoDetailsResponse.video_order
    else
        video_order = ""
    end if
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("videoID", m.AutoplayData.video_id.toStr().Trim())
    sec.Write("videoTITLE", m.AutoplayData2.videoDetailsResponse.video_title)
    sec.Write("channelID", getchannelsid())
    sec.Write("category", categoriesWithComma.Trim())
    sec.Flush()


    if getCountrycode() = "EU"
        consent = "1"
        GDPR = "1"
    else
        consent = "0"
        GDPR = "0"
    end if

    dt = CreateObject("roDateTime")
    timestamp = dt.AsSeconds().ToStr()
    timeStampPre = dt.AsSeconds()
    timeStampMilliSeconds = (timeStampPre.ToStr() + "000")

    if m.AutoplayData2.videoDetailsResponse <> invalid and m.AutoplayData2.videoDetailsResponse.ad_link <> invalid
        adUURRLL = m.AutoplayData2.videoDetailsResponse.ad_link
    else
        adUURRLL = ""
    end if

    if m.AutoplayData2 <> invalid and m.AutoplayData2.videoDetailsResponse <> invalid and m.AutoplayData2.videoDetailsResponse.video_name <> invalid
        video_url = m.AutoplayData2.videoDetailsResponse.video_name
    else
        video_url = ""
    end if


    finalAdURL = ""
    if adUURRLL <> invalid

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
        temp20 = strReplace(temp19, "[KEYWORDS]", categoriesWithComma.Trim().Escape())
        temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle().Escape())
        temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
        temp23 = strReplace(temp22, "[CITY]", getCity().Escape())
        temp24 = strReplace(temp23, "[SHOW_ID]", m.AutoplayData2.videoDetailsResponse.show_id.toStr().Trim())
        temp25 = strReplace(temp24, "[CATEGORIES]", categoriesWithComma.Escape())
        temp26 = strReplace(temp25, "[CONTENT_TITLE]", m.AutoplayData2.videoDetailsResponse.video_title.Trim().Escape())
        temp27 = strReplace(temp26, "[VIDEO_TITLE]", m.AutoplayData2.videoDetailsResponse.video_title.Trim().Escape())
        temp28 = strReplace(temp27, "[VIDEO_URL]", video_url)
        temp29 = strReplace(temp28, "[CHANNEL_NAME]", getAppTitle().Escape())
        temp30 = strReplace(temp29, "[AUTOPLAY]", "0")
        temp31 = strReplace(temp30, "[MUTE]", "0")
        temp32 = strReplace(temp31, "[DEVICE_IFA]", di.GetRIDA())
        temp33 = strReplace(temp32, "[OS]", "rokuos")
        temp34 = strReplace(temp33, "[OS_VERSION]", di.GetOSVersion().major)
        temp35 = strReplace(temp34, "[ISP]", getIsp().Escape())
        temp36 = strReplace(temp35, "[DEVICE_BRAND_NAME]", "roku")
        temp37 = strReplace(temp36, "[LMT]", "0")
        temp38 = strReplace(temp37, "[SEASON]", season.ToStr().Trim().Escape())
        temp39 = strReplace(temp38, "[EPISODE]", video_order.ToStr().Trim().Escape())
        temp40 = strReplace(temp39, "[SERIES]", m.AutoplayData2.videoDetailsResponse.video_title.Escape())
        temp41 = strReplace(temp40, "[PRODUCER]", "".Trim().Escape())
        temp42 = strReplace(temp41, "[IS_LIVE]", "0")
        temp43 = strReplace(temp42, "[RATING]", "".Trim().Escape())
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
        temp56 = strReplace(temp55, "[DESCRIPTION]", m.AutoplayData2.videoDetailsResponse.video_description.Escape())
        temp57 = strReplace(temp56, "[APPID]", getappId())
        temp58 = strReplace(temp57, "[US_PRIVACY]", "")
        finalAdURL = strReplace(temp58, "[DURATION]", Str(macroDuration).Trim())
    end if

    ?"finalAdURL printed: "
    ? "********************"
    ? finalAdURL
    ? "********************"

    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse.video_title,
        url: m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse.video_name,
        categories: categoriesWithComma
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: m.AutoplayData2.videoDetailsResponse.video_duration.toStr().Trim()
    }
    ' videoContent.ClosedCaptions = True
    subtitle_config = m.AutoplayData2.videoDetailsResponse.subtitles

    SubtitleTracks = []
    for each item in m.AutoplayData2.videoDetailsResponse.subtitles
        subtitleItem = {}
        subtitleItem.Language = item.language_name
        subtitleItem.Description = item.short_code
        subtitleItem.TrackName = item.subtitle_url
        SubtitleTracks.push(subtitleItem)
    end for

    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    audio_languages = invalid
    if m.AutoplayData2.videoDetailsResponse.audio_languages <> invalid
        audio_languages = m.AutoplayData2.videoDetailsResponse.audio_languages
    end if

    show_id = ""
    if m.AutoplayData2 <> invalid and m.AutoplayData2.videoDetailsResponse <> invalid and m.AutoplayData2.videoDetailsResponse.show_id <> invalid
        show_id = m.AutoplayData2.videoDetailsResponse.show_id.toStr().Trim()
    end if

    content.addFields({
        "is_live": "0",
        "audio_languages": audio_languages,
        "category": categoriesWithComma,
        "video_id": macroVideoID.Trim(),
        "categoriesWithComma": categoriesWithComma,
        "show_id": show_id,
        "ai_type": m.top.ai_type,
        "video_type": m.video_type,
        "show_id_playlist": m.top.show_id,
        "video_time": m.AutoplayData2.videoDetailsResponse.video_time


    })
    content.ad_url = finalAdURL.EncodeUri()
    if subtitle_config <> invalid
        content.ClosedCaptions = True
        content.globalCaptionMode = "On"
        content.HDBranded = True
        content.IsHD = True
        content.SubtitleConfig = subtitle_config
        content.SubtitleTracks = SubtitleTracks
        content.SubtitleTrack = SubtitleTracks
    end if

    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
        m.Player.observeField("new_videoId", "newVideoClicked")
        m.Player.observeField("stop_upNext_timer", "onStopupNextTimer")
        m.Player.observeField("action_command", "onActionCommandChange")
    end if
    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.watched_duration = m.watched_duration 'setting watched_duration

    if m.skipAd = true
        m.Player.skipAd = true
    else
        m.Player.skipAd = false
    end if
    m.Player.control = "play"
    m.Player.observeField("visibility", "onPlayerVisibleChange")
    callAutoplayAPI(macroVideoID)
end function

sub showLoginDialog_ForAutoPlay()
    ?"showLoginDialog_ForAutoPlay called"
    m.top.loginDialog = CreateObject("roSGNode", "BackDialog")
    m.top.loginDialog.backgroundUri = "pkg:/images/black.jpg"
    m.top.loginDialog.title = "Please login to continue autoplay!"
    m.top.loginDialog.buttons = ["Ok", "Cancel"]
    m.top.loginDialog.ObserveField("buttonSelected", "OnLoginDialogClicked")
    m.parentScene = GetParentScene()
    m.parentScene.dialog = m.top.loginDialog
end sub

sub showSubscriptionPageDialog_ForAutoplay()
    ?"showSubscriptionPageDialog_ForAutoplay called"
    m.top.subscriptionDialog = CreateObject("roSGNode", "BackDialog")
    m.top.subscriptionDialog.backgroundUri = "pkg:/images/black.jpg"
    m.top.subscriptionDialog.title = "Please subscribe to continue autoplay!"
    m.top.subscriptionDialog.buttons = ["Ok", "Cancel"]
    m.top.subscriptionDialog.ObserveField("buttonSelected", "OnSubscriptionPageDialogClicked")
    m.parentScene = GetParentScene()
    m.parentScene.dialog = m.top.subscriptionDialog
end sub

sub showWatchwithoutAdsPopupForAutoplay()
    ?"showWatchwithoutAdsPopupForAutoplay for autoplay"

    m.dialogmessage_label.text = getText("watch_with_ads")




    m.cancelbutton_Label.text = getText("continue")




    m.exitbutton_Label.text = getText("subscribe")


    ' m.exitbutton_Label.text = "Subscribe"
    m.dialogbg_rect.visible = true
    m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true
    m.loadingIndicator.visible = false
    m.YesButton.setFocus(true)
end sub


sub continueWatchingLogicForAutoplay(watched_duration)
    ?"continueWatchingLogicForAutoplay called"
    if watched_duration <> invalid
        if watched_duration > 0
            ' showContinueWatchingDialogForAutoplay()
        else
        end if
        autoPlayVideo2()
    end if
end sub

sub OnLoginDialogClicked()
    if m.top.loginDialog.buttonSelected = 0
        m.parentScene.dialog.close = true
        goToLandingScene()
    else if m.top.loginDialog.buttonSelected = 1
        m.parentScene.dialog.close = true
        m.loadingIndicator.visible = false
        m.top.closethispage = true
    end if
end sub

sub OnSubscriptionPageDialogClicked()
    if m.top.subscriptionDialog.buttonSelected = 0
        m.parentScene.dialog.close = true
        goToSubscriptionListingSceneForautoplay()
    else if m.top.subscriptionDialog.buttonSelected = 1
        m.parentScene.dialog.close = true
        m.loadingIndicator.visible = false
        m.top.closethispage = true
    end if
end sub

sub goToSubscriptionListingSceneForautoplay()
    m.loadingIndicator.visible = false
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    ' m.top.goToPaymentDescriptionScreen = m.autoplayVideoId
    showPaymentPage(m.autoplayVideoId)
end sub




sub exitPlayer()
    m.count = 0
    m.video.control = "stop"
    m.video.visible = false
    m.PlayerTask = invalid
    m.top.state = "done"
    m.top.visibility = false
end sub




function OnkeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if m.qrOverlay <> invalid and m.qrOverlay.isInFocusChain() then return true
        if key = "back"
            if m.pinDialog <> invalid and m.pinDialog.isInFocusChain()
                m.top.closethispage = true
                return true
            end if
            if m.Player <> invalid
                ?m.Player.playerState
                m.Player.control = "stop"
            end if
            handled = false
        else if key = "right"
            if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true or m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or m.continueWatchingDialogVisible_ForAutoplay = true
                m.YesButton.setFocus(true)
                handled = true
            end if
        else if key = "left"
            if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true or m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or m.continueWatchingDialogVisible_ForAutoplay = true
                m.NoButton.setFocus(true)
                handled = true
            end if
        else if key = "up"
        end if
    else
        if key = "back"
            if m.pinDialog <> invalid and m.pinDialog.isInFocusChain()
                m.top.closethispage = true
                return true
            end if
        end if
    end if
    return handled
end function



sub change()

end sub



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
    m.LogoutTask = CreateObject("roSGNode", "LogoutTask")
    m.LogoutTask.observeField("LogoutResponse", "logoutAndGoToLandingScene")
    m.LogoutTask.callFunc("runLogoutTask", "")
end sub

sub logoutAndGoToLandingScene()
    ?"logoutAndGoToLandingScene called"
    if GetParentScene() = invalid then
        return
    end if
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1
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
end sub

function returnTheCurrentFocusedData()
    return m.GetVideoDetailsTask.videoDetailsResponse
end function


function formatAdURL(adUURRLL)
    VODcontent = returnTheCurrentFocusedData()
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
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()

    macroVideoID = ""
    if VODcontent <> invalid and VODcontent.video_id <> invalid
        macroVideoID = Str(VODcontent.video_id).Trim()
    end if
    macroDurations = ""
    if VODcontent <> invalid and VODcontent.video_duration <> invalid
        macroDurations = VODcontent.video_duration.Trim()
    end if
    macroDuration = macroDurations.toInt()
    macrouserID = ""
    if getUserIdana() <> invalid and getUserIdana() <> ""
        macrouserID = getUserIdana().Trim()
    end if

    video_id = ""
    if VODcontent <> invalid and VODcontent.video_id <> invalid
        video_id = VODcontent.video_id.ToStr().Trim()
    end if

    title = ""
    if VODcontent <> invalid and VODcontent.title <> invalid
        title = VODcontent.title.Trim()
    end if

    macroChannelID = ""
    if getchannelsid() <> invalid and getchannelsid() <> ""
        macroChannelID = getchannelsid().Trim()
    end if

    macrvideoID = video_id
    macrotitle = title
    m.uidana = getUserIdana()

    keywords = ""
    if VODcontent <> invalid and VODcontent.TITLESEASON <> invalid
        keywords = VODcontent.TITLESEASON.Trim()
    end if
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("videoID", video_id)
    sec.Write("videoTITLE", macrotitle)
    sec.Write("channelID", macroChannelID)
    sec.Write("category", keywords)
    sec.Flush()

    if getCountrycode() = "EU"
        consent = "1"
        GDPR = "1"
    else
        consent = "0"
        GDPR = "0"
    end if

    dt = CreateObject("roDateTime")
    timestamp = dt.AsSeconds().ToStr()
    timeStampPre = dt.AsSeconds()
    timeStampMilliSeconds = (timeStampPre.ToStr() + "000")

    categories_id = ""
    if VODcontent <> invalid and VODcontent.categories_id <> invalid
        categories_id = VODcontent.categories_id
    end if


    show_id = ""
    if VODcontent <> invalid and VODcontent.show_id <> invalid
        show_id = VODcontent.show_id.ToStr().Trim()
    end if

    categoriesWithComma = ""
    if VODcontent.categories <> invalid
        for i = 0 to VODcontent.categories.Count() - 1
            if VODcontent.categories[i] <> invalid and VODcontent.categories[i].category_name <> invalid
                if categoriesWithComma <> ""
                    categoriesWithComma = categoriesWithComma + "," + VODcontent.categories[i].category_name
                else
                    categoriesWithComma = categoriesWithComma + VODcontent.categories[i].category_name
                end if
            end if
        end for
    end if
    categories = categoriesWithComma

    title = ""
    if VODcontent <> invalid and VODcontent.video_title <> invalid
        title = VODcontent.video_title.Trim()
    end if

    URL = ""
    if VODcontent <> invalid and VODcontent.video_name <> invalid
        URL = VODcontent.video_name.Trim()
    end if

    season = ""
    if VODcontent <> invalid and VODcontent.season <> invalid
        season = VODcontent.season.ToStr()
    end if

    video_order = ""
    if VODcontent <> invalid and VODcontent.video_order <> invalid
        video_order = VODcontent.video_order.ToStr()
    end if

    producer = ""
    if VODcontent <> invalid and VODcontent.producer <> invalid
        producer = VODcontent.producer.Trim()
    end if

    maturity_name = ""
    if VODcontent <> invalid and VODcontent.maturity_name <> invalid
        maturity_name = VODcontent.maturity_name.Trim()
    end if

    DESCRIPTION = ""
    if VODcontent <> invalid and VODcontent.DESCRIPTION <> invalid
        DESCRIPTION = VODcontent.DESCRIPTION
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
    temp20 = strReplace(temp19, "[KEYWORDS]", keywords.Escape())
    temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle().Escape())
    temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
    temp23 = strReplace(temp22, "[CITY]", getCity().Escape())
    temp24 = strReplace(temp23, "[SHOW_ID]", show_id.Escape())
    temp25 = strReplace(temp24, "[CATEGORIES]", categories.Escape())
    temp26 = strReplace(temp25, "[CONTENT_TITLE]", title.Escape())
    temp27 = strReplace(temp26, "[VIDEO_TITLE]", title.Escape())
    temp28 = strReplace(temp27, "[VIDEO_URL]", URL)
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
    temp40 = strReplace(temp39, "[SERIES]", keywords.Escape())
    temp41 = strReplace(temp40, "[PRODUCER]", producer.Escape())
    temp42 = strReplace(temp41, "[IS_LIVE]", "0")
    temp43 = strReplace(temp42, "[RATING]", maturity_name.Escape())
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
    temp56 = strReplace(temp55, "[DESCRIPTION]", DESCRIPTION.Escape())
    temp57 = strReplace(temp56, "[APPID]", getappId())
    temp58 = strReplace(temp57, "[US_PRIVACY]", "")
    temp59 = strReplace(temp58, "[DURATION]", Str(macroDuration).Trim())
    finalAdURL = strReplace(temp59, "[CATEGORY_ID]", categories_id)
    return finalAdURL
end function


function newPlayLogicForAutoplay()
    videoDetailsResponse_forAutoplay = m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse
    if videoDetailsResponse_forAutoplay <> invalid
        if videoDetailsResponse_forAutoplay.success = false
            if videoDetailsResponse_forAutoplay.responseCode <> invalid and videoDetailsResponse_forAutoplay.responseCode = 401
                goToLandingScene()
            else if videoDetailsResponse_forAutoplay.responseCode <> invalid and videoDetailsResponse_forAutoplay.responseCode = 403
                goToSubscriptionListingScene()
            end if
        else if videoDetailsResponse_forAutoplay.success = true
            continueWatchingLogicForAutoplay(videoDetailsResponse_forAutoplay.watched_duration)
        end if
    else

    end if
end function

sub showQrOverlay(checkout_qr_url)
    if isGuest() = "true"
        gotoLandingScene() ' if guest go to login page
        return
    end if
    m.qrOverlay = invalid
    m.qrOverlay = m.top.createChild("BigQRComponent")
    m.qrOverlay.unobserveField("closeQROverlay")
    m.qrOverlay.ObserveField("closeQROverlay", "onQrOverlayClose")
    m.qrOverlay.unobserveField("refreshRequested")
    m.qrOverlay.ObserveField("refreshRequested", "onQrOverlayRefreshRequested")
    ' 2. Set the fields programmatically
    m.qrOverlay.id = "myQrOverlay"
    if m.GetVideoDetailsTask <> invalid and m.GetVideoDetailsTask.videoDetailsResponse <> invalid and m.GetVideoDetailsTask.videoDetailsResponse.video_title <> invalid then m.qrOverlay.titleLabel = m.GetVideoDetailsTask.videoDetailsResponse.video_title
    m.qrOverlay.buttonsArray = [getText("refresh"), getText("cancel")] ' Set button titles dynamically based on localization
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
        m.top.closethispage = true
        m.qrOverlay = invalid
    end if
end sub

sub onQrOverlayRefreshRequested()
    m.qrOverlay.visible = false
    m.qrOverlay.setFocus(false)
    if m.top <> invalid and m.top.visible = true
        m.top.setFocus(true)
    end if
    runUserSubscriptionTask()
end sub

sub ManagePinPadDialog()
    m.parentScene = GetParentScene()
    m.pinDialog = CreateObject("roSGNode", "StandardPinPadDialog")
    m.pinDialog.title = getText("parental_pin_required")
    m.pinDialog.buttons = [getText("ok"), getText("cancel")]
    m.pinDialog.ObserveField("buttonSelected", "OnPinPadButtonSelected")
    m.parentScene.dialog = m.pinDialog
end sub

' Callback function handles the click event
sub OnPinPadButtonSelected(event_ as object)
    buttonIndex = event_.GetData()
    scene = m.parentScene ' Adjust based on where your script is running
    dialog = scene.dialog

    if dialog.buttons[buttonIndex] = getText("ok") ' "OK" Button
        pin = dialog.pin ' Retrieve the entered PIN string

        if pin <> "" and pin.Len() = 4 ' Quick validation check
            callParentalPinVerifyApitask({ pin: pin }) ' Call your function to verify the PIN
            dialog.close = true
        else
            scene = m.top.GetScene()
            scene.showCustomDialog = {
                title: "Error",
                message: getText("parental_pin_4_digit_required"),
                buttons: [getText("ok")],
                origin: m.top ' Passing this allows MainScene to talk back to this component
            }
        end if

    else if dialog.buttons[buttonIndex] = getText("cancel") ' "Cancel" Button
        m.top.closethispage = true
        dialog.close = true
    end if
end sub

'create a function to call the parental pin verify api task
sub callParentalPinVerifyApitask(pinData as object)
    m.ParentalPinVerifyTask = CreateObject("roSGNode", "ParentalPinVerifyTask")
    m.ParentalPinVerifyTask.observeField("parentalPinResponse", "onParentalPinVerifyResponse")
    m.ParentalPinVerifyTask.requestBody = pinData
    m.ParentalPinVerifyTask.callFunc("runParentalPinVerifyTask", "")
end sub

sub onParentalPinVerifyResponse()
    ?"onParentalPinVerifyResponse called"
    if m.ParentalPinVerifyTask.parentalPinResponse <> invalid
        if m.ParentalPinVerifyTask.parentalPinResponse.success = true

            pin = ""
            if IsNotNull2(m.ParentalPinVerifyTask.requestBody) and isNotNull2(m.ParentalPinVerifyTask.requestBody.pin) then pin = m.ParentalPinVerifyTask.requestBody.pin else pin = ""

            ' Save to Registry
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("PARENTAL_PIN", pin)
            sec.Flush()

            print "PIN successfully saved to registry!"
            print "Parental Pin Verified Successfully"
            playvideo() ' Call your function to play video after successful verification
        else
            message = ""
            if IsNotNull2(m.ParentalPinVerifyTask.parentalPinResponse) and isNotNull2(m.ParentalPinVerifyTask.parentalPinResponse.message) then message = m.ParentalPinVerifyTask.parentalPinResponse.message else message = getText("parental_pin_verification_failed")
            
            scene = m.top.GetScene()
            scene.showCustomDialog = {
                title: getText("error"),
                message: message,
                buttons: [getText("ok")],
                origin: m.top ' Passing this allows MainScene to talk back to this component
            }
        end if
    end if
end sub


sub OnDialogAction(_event as object)
    result = _event.GetData()
    buttonClicked = result.buttonIndex
    buttonText = result.buttonText

    if buttonText = getText("ok")
        ?"OK button clicked"
        m.parentScene.dialog = m.pinDialog
        return
    end if
end sub
