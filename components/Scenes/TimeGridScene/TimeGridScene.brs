sub init()

    m.mainRectangle = m.top.FindNode("main_rect")
    m.TimeGrid = m.top.findNode("CustomTimeGrid")
    m.jumpToProgramTimer = m.top.findNode("jumpToProgramTimer")
    m.jumpToProgramTimer.ObserveField("fire", "onTimer")
    m.TimeGrid.observeField("programFocused", "OnProgramFocused")
    m.TimeGrid.observeField("channelFocused", "OnChannelFocused")
    m.TimeGrid.observeField("programSelected", "checkLiveNowSubscription")
    m.TimeGridSceneItemLabel = m.top.findNode("TimeGridSceneItem_Label")
    m.messageLabel = m.top.findNode("message_label")
    m.mainTitle = m.top.findNode("mainTitle")
    m.subTitle = m.top.findNode("subTitle")
    m.poster = m.top.findNode("poster")
    m.loading = m.top.findNode("loading")
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = "#000000"
    authenticateapi()
    m.language_Lbl2 = m.top.findNode("language_Lbl2")
    m.languageLblListReact = m.top.findNode("languageLbllist_react")
    m.languageLbl = m.top.findNode("language_Lbl")

    m.onFocusPlayVideoPlayer = invalid
    m.onFocusPlayVideoPlayer = m.top.findNode("onFocusPlayVideoPlayer")
    m.onFocusPlayVideoPlayer.enableUI = false
    m.videoOverlayposter = m.top.findNode("videoOverlayposter")
    m.posterOverlayGradient = m.top.findNode("posterOverlayGradient")
    m.posterOverlayGradient.blendColor = getBackGroundColor1()

    playerSpinner = invalid
    if m.onFocusPlayVideoPlayer <> invalid and m.onFocusPlayVideoPlayer.getChild(1) <> invalid and m.onFocusPlayVideoPlayer.getChild(1).getChild(4) <> invalid
        playerSpinner = m.onFocusPlayVideoPlayer.getchild(1).getchild(4)
    end if

    if playerSpinner <> invalid
        playerSpinner.translation = [
            50, 50
        ]
    else
        m.onFocusPlayVideoPlayer.enableUI = false
    end if

    m.onFocusPlayVideoPlayer.observeField("state", "onFocusPlayVideoPlayerStateChanged")
    m.onFocusPlayVideoPlayer.observeField("visible", "onVideoForTimeGridPlayerVisibleChange")


    
        m.languageLbl.text = getTextOf("select_language")
   

    
        m.language_Lbl2.text = getTextOf("language_selection_subtext")
    


    m.languageLabelist = m.top.findNode("selectLanguage")
    m.languageLabelist.focusBitmapBlendColor = getButtonSelectionColor()
    m.languageLabelist.focusFootprintBlendColor = getButtonSelectionColor()
    m.languageLabelist.observeField("itemSelected", "onLanguageLabelListSelected")
    m.top.observeField("visible", "OnTopVisibilityChange")
    setTimeGridConfigs()
    m.jumpToProgramIndex = -1

    m.ScrollableText = m.top.findNode("ScrollableText")
    m.category_rect = m.top.findNode("category_rect")
    m.categoryLbl = m.top.findNode("categoryLbl")

    m.categoryLbl.text = "Select options for category"
    m.categoryLbl.font.size = 24
    m.selectCategoryRowlist = m.top.findNode("selectCategory")
    m.selectCategoryRowlist.focusBitmapBlendColor = getButtonSelectionColor()
    m.selectCategoryRowlist.focusFootprintBlendColor = getButtonSelectionColor()
    m.selectCategoryRowlist.observeField("rowItemSelected", "onCategoryLabelListSelected")



    m.itemNode = createObject("RoSGNode", "ContentNode")
    m.itemNode.id = "pressStarForcategoryLabelLabelList"
    m.itemNode.title = "Press (*) for categories"

    m.itemNode.HDLISTITEMICONURL = "pkg:/images/down.png"
    m.itemNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/down.png"
    m.pressStarForcategoryLabelLabelList = m.top.findNode("pressStarForcategoryLabelLabelList")
    m.pressStarForcategoryLabelLabelList.focusFootprintBitmapUri = "pkg:/images/img_loginbg1.png"
    m.pressStarForcategoryLabelLabelList.focusBitmapBlendColor = getButtonSelectionColor()
    m.pressStarForcategoryLabelLabelList.focusFootprintBlendColor = getButtonSelectionColor()
    content = createObject("RoSGNode", "ContentNode")
    content.appendChild(m.itemNode)
    m.pressStarForcategoryLabelLabelList.content = content

    m.fullscreenCountdown = 11
    m.fullscreenTimer = m.top.findNode("fullscreenTimer")
    m.videoPlayerContainer = m.top.findNode("videoPlayerContainer")

    'code to place player dynamically based on screen size
    ' rectWidth = 960
    ' rectHeight = 547
    ' screenSize = CreateObject("roDeviceInfo").GetDisplaySize()
    ' screenWidth = screenSize.w
    ' screenHeight = screenSize.h
    ' refX = 960
    ' refY = 0
    ' scaledX = (refX / 1920.0) * screenWidth
    ' scaledY = (refY / 1080.0) * screenHeight
    ' scaledWidth = (rectWidth / 1920.0) * screenWidth
    ' scaledHeight = (rectHeight / 1080.0) * screenHeight
    ' m.videoPlayerContainer.width = scaledWidth
    ' m.videoPlayerContainer.height = scaledHeight
    ' m.videoPlayerContainer.translation = [scaledX, scaledY]
    m.fullscreenTimer.observeField("fire", "onFullscreenTimerTick")
    m.videoTitleBar = m.top.findNode("videoTitleBar")
    m.videoTitleLabel = m.top.findNode("videoTitleLabel")
    m.videoTitleLabel.font.size = 23

    'timer for starting preplayer 1 second later to avoid issue during speed scrolling
    m.debounceTimer = createObject("roSGNode", "Timer")
    m.debounceTimer.duration = 1 ' 1 second
    m.debounceTimer.repeat = false
    m.debounceTimer.observeField("fire", "onDebounceTimerFired")



    if getMULTI_LANGUAGE_REQUIRED() = "true"
        if IsLanguageSettingFirstTime() = "true" and (m.global.langauge_id = invalid or m.global.langauge_id = 0)
            m.languageLblListReact.visible = true
            runMultiLanguageListApiTask()
        else
            runMoreTask()
        end if
    else
        runMoreTask()
    end if
    m.LastFocusedChannelId = -11

end sub


sub onLanguageLabelListSelected()
    m.MultiLanguageUserUpdateTask = CreateObject("roSGNode", "MultiLanguageUserUpdateTask")
    languageselected = m.languageLabelist.content.getChild(m.languageLabelist.itemSelected).language_id
    m.MultiLanguageUserUpdateTask.observeField("MultiLanguageUserUpdateApiTaskListStatus", "ResponseUpdateStatus")
    m.MultiLanguageUserUpdateTask.callFunc("runMultiLanguageUserUpdateApiTask", languageselected)
end sub

sub ResponseUpdateStatus()
    ' m.loadingIndicator.visible = true
    m.languageLblListReact.visible = false
    ' m.GridScreen.startLoading = "stacxxxxdart"
    runMoreTask()
    setIsLanguageSettingFirstTime("updated")
    authenticateapi()
    ?"setLanguageSelected(m.global.short_code)dsd"
    ?m.global.short_code
    ?"m.global.short_code"
    setLanguageSelected(m.languageLabelist.content.getChild(m.languageLabelist.itemSelected).TITLE)
    ?"o"
    ' setLanguageSelected(m.global.short_code)
end sub


sub authenticateapi()

    m.AuthenticateApi = CreateObject("roSGNode", "AuthenticateApi")
    m.AuthenticateApi.observeField("authenticateApiTaskListcontent", "ResponseStatus1")
    m.AuthenticateApi.callFunc("runauthenticateApiTask", "")

end sub



sub runMoreTask()
    m.jumpToProgramTimer.control = "stop"
    m.jumpToProgramTimer.control = "start"
    m.TimeGridApiTask = CreateObject("roSGNode", "TimeGridApiTask")
    m.TimeGridApiTask.observeField("TimeGridApiTaskContent", "onContentChanged")
    m.TimeGridApiTask.callFunc("runTimeGridApiTask", "")
    m.loading.visible = true
end sub

sub onTimer()
    if not m.jumpToProgramIndex = -1
        m.jumpToProgramTimer.control = "stop"
        m.TimeGrid.jumpToProgram = m.jumpToProgramIndex 'this is done like this to avoid an issue - jumpToProgram is not working inside inonContentChanged function
    end if
end sub

sub runMultiLanguageListApiTask()
    print " runMultiLanguageListApiTask called"
    ' m.loadingIndicator.visible = true
    m.MultiLanguageListApiTask = CreateObject("roSGNode", "MultiLanguageListApiTask")
    m.MultiLanguageListApiTask.observeField("MultiLanguageListApiTaskContent", "onResponse")
    m.MultiLanguageListApiTask.callFunc("runMultiLanguageListApiTask", "")
end sub

sub onResponse()
    ?m.MultiLanguageListApiTask.MultiLanguageListApiTaskContent
    m.languageLabelist.content = m.MultiLanguageListApiTask.MultiLanguageListApiTaskContent
    m.languageLabelist.setFocus(true)

    for i = 0 to m.languageLabelist.content.getChildCount() - 1
        if m.languageLabelist.content.getChild(i).title = getLanguageSelected() '********code to set select previously selected language
            m.languageLabelist.jumpToItem = i
        end if
    end for
    ' m.loadingIndicator.visible = false
end sub

sub onContentChanged()
    if m.TimeGridApiTask.responseDataTimeGridApiTaskList <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data.categories <> invalid
        if m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data.categories.Count() = 0
            m.pressStarForcategoryLabelLabelList.visible = false
            ?"visibiltyfalse"
        else
            ?"visibiltytrue"
            m.pressStarForcategoryLabelLabelList.visible = false
        end if
    else

    end if

    ?"onContentChanged called"
    m.TimeGridApiTask.callFunc("stopTimeGridApiTask", "")
    m.loading.visible = false
    m.selectCategoryRowlist.setFocus(false)
    m.TimeGrid.setFocus(true)
    initialiseCategoryRowlist()
    if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getchildCount() <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getchildCount() <> 0
        m.TimeGrid.content = m.TimeGridApiTask.TimeGridApiTaskContent
        if m.TimeGridApiTask.responseDataTimeGridApiTaskList <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data.number_of_days <> invalid
            m.TimeGrid.maxDays = m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data.number_of_days
        end if
        m.messageLabel.visible = false

        if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getchild(0) <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getchild(0).getchildcount() <> invalid
            for i = 0 to m.TimeGridApiTask.TimeGridApiTaskContent.getchild(0).getchildcount() - 1
                if m.TimeGridApiTask.TimeGridApiTaskContent.getchild(0).getchild(i) <> invalid
                    content = m.TimeGridApiTask.TimeGridApiTaskContent.getchild(0).getchild(i)
                    curentItemStartTime = content.PLAYSTART
                    curentItemEndTime = content.PLAYDURATION + curentItemStartTime

                    if curentItemStartTime < getCurrentTimeInSeconds() and curentItemEndTime > getCurrentTimeInSeconds()
                        m.jumpToProgramIndex = i
                        return
                    end if
                end if
            end for
        end if


    else
        m.TimeGridSceneItemLabel.visible = false
        m.TimeGrid.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"
    end if

end sub


sub OnTopVisibilityChange()
    if m.top.visible = true
        ?"OnTopVisibilityChange called true"
        m.TimeGrid.setFocus(true)
    else
        ?"OnTopVisibilityChange called false"
    end if
    m.debounceTimer.control = "stop"
    m.onFocusPlayVideoPlayer.control = "stop"
    m.fullscreenTimer.control = "stop"
end sub


function OnkeyEvent(key, press) as boolean

    result = false
    if press
        if key = "back"
            m.debounceTimer.control = "stop"
            m.onFocusPlayVideoPlayer.control = "stop"
            m.fullscreenTimer.control = "stop"
            if m.languageLblListReact.visible = true
                runMoreTask()
                m.languageLblListReact.visible = false
                m.loading.visible = true
                m.TimeGrid.visible = true
                m.TimeGridSceneItemLabel.visible = true
                m.TimeGrid.setFocus(true)
                result = true
            else
                m.TimeGrid.setFocus(true)
            end if
        else if key = "down"
            if m.selectCategoryRowlist.hasFocus() = true
                m.TimeGrid.setFocus(true)
            end if
        else if key = "OK"
        end if
    end if
    return result
end function



' this function gets the parent node in the list
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

function getCurrentTimeInSeconds()
    ' ?"getCurrentTimeInSeconds called"
    date = CreateObject("roDateTime")
    ' date.ToLocalTime()
    dateInEpoch = date.AsSeconds()
    ?dateInEpoch
    return dateInEpoch
end function

function getTodaysDate()
    date = CreateObject("roDateTime")
    return date.GetDayOfMonth()
end function

function getTodaysHours()
    date = CreateObject("roDateTime")
    return date.GetHours()
end function

function getTodaysSecondsFromMidNight()
    date = CreateObject("roDateTime")
    date.ToLocalTime()
    hours = date.GetHours()
    hoursInSeconds = hours * 3600

    minutes = date.GetMinutes()
    minutesInSeconds = minutes * 60

    secondsInCurrentMinute = date.GetSeconds()

    todaysSecondsFromMidNight = hoursInSeconds + minutesInSeconds + secondsInCurrentMinute
    return todaysSecondsFromMidNight
end function

sub setTimeGridConfigs()
    ' ?"setTimeGridConfigs called"
    m.TimeGrid.focusBitmapUri = "pkg:/images/img_newbg.9.png"
    m.TimeGrid.focusBitmapBlendColor = "#0047AB"'"#4bc8c8"'getButtonSelectionColor() '#102eab
    m.TimeGrid.nowBarBitmapUri = "pkg:/images/nowBarBitmapUri.9.png"
    m.TimeGrid.nowBarBlendColor = "#4bc8c8"'"#2e6498"
    m.TimeGrid.focusBitmapUri = "pkg:/images/img_newbg.9.png"
    m.TimeGrid.focusFootprintBitmapUri = "pkg:/images/img_newbg.9.png"
    m.TimeGrid.programBackgroundBitmapUri = "pkg:/images/img_newbg_default.9.png"

    m.TimeGrid.programTitleFont = "font:smallestSystemFont"
    m.TimeGrid.timeLabelFont = "font:smallestSystemFont"

    timeInSecondsUptoTodayMorningTwelveAM = getCurrentTimeInSeconds() - getTodaysSecondsFromMidNight()
    m.TimeGrid.contentStartTime = getLast30MinWindowInSeconds()

end sub

function OnProgramFocused()
    focusedContent = invalid
    if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGrid.programFocusedDetails <> invalid and m.TimeGrid.programFocusedDetails.focusChannelIndex <> invalid and m.TimeGrid.programFocused <> invalid
        focusedChannel = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.programFocusedDetails.focusChannelIndex)
        if focusedChannel <> invalid and focusedChannel.getChild(m.TimeGrid.programFocused) <> invalid
            focusedContent = focusedChannel.getChild(m.TimeGrid.programFocused)
        end if
    end if
    focusedRowContent = ""
    if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGrid.programFocusedDetails <> invalid and m.TimeGrid.programFocusedDetails.focusChannelIndex <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.programFocusedDetails.focusChannelIndex) <> invalid
        focusedRowContent = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.programFocusedDetails.focusChannelIndex)
    end if

    if focusedContent <> invalid and focusedContent.TITLE <> invalid
        m.mainTitle.text = focusedContent.title2
    else
        m.mainTitle.text = ""
    end if
    if focusedContent <> invalid and focusedContent.text <> invalid
        m.subTitle.text = focusedContent.text
    else
        m.subTitle.text = ""
    end if

    m.fullscreenCountdown = 11
    m.videoTitleBar.visible = true
    if not m.LastFocusedChannelId.ToStr() = focusedRowContent.id
        m.videoTitleBar.visible = false
        if (focusedContent.hdposterurl <> invalid and focusedContent.hdposterurl <> "")
            m.videoOverlayposter.uri = focusedRowContent.HDSMALLICONURL
            m.poster.uri = focusedContent.hdposterurl
        else
            m.videoOverlayposter.uri = focusedRowContent.HDSMALLICONURL
            m.poster.uri = focusedRowContent.HDSMALLICONURL
        end if
        m.LastFocusedChannelId = focusedRowContent.id
    end if

end function



sub OnChannelFocused()

    m.videoOverlayposter.visible = true
    ' timer for preview player
    if m.debounceTimer.control = "start"
        m.debounceTimer.control = "stop"
    end if
    m.debounceTimer.control = "start"
end sub

sub onDebounceTimerFired()
    runFastChannelApiTask2()
end sub

sub runFastChannelApiTask()
    m.LiveFetcher = CreateObject("roSGNode", "LiveFetcher")
    m.LiveFetcher.observeField("livefetcherResponse", "playLiveVideo")
    if m.TimeGrid.content <> invalid and m.TimeGrid.content.getchild(m.TimeGrid.channelFocused) <> invalid and m.TimeGrid.content.getchild(m.TimeGrid.channelFocused).id <> invalid
        m.channelID = m.TimeGrid.content.getchild(m.TimeGrid.channelFocused).id
    else
        m.channelID = getFastChannelId()
    end if
    m.LiveFetcher.channel_id = m.channelID
    m.LiveFetcher.callFunc("runLiveFetcherTask", "TIMEGRIDSCENE")
end sub

function playLiveVideo()
    m.onFocusPlayVideoPlayer.control = "stop"
    m.debounceTimer.control = "stop"
    if m.TimeGrid.content <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused) <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused) <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused).PLAYSTART <> invalid
        curentItemSelectedTime = m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused).PLAYSTART
    else
        curentItemSelectedTime = invalid
    end if
    if curentItemSelectedTime <> invalid and m.TimeGrid.content <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused) <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused) <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused).PLAYDURATION <> invalid
        curentItemEndTime = m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused).PLAYDURATION * 1000 + curentItemSelectedTime
    else
        curentItemEndTime = invalid
    end if
    if m.LiveFetcher.livefetcherResponse <> invalid and m.LiveFetcher.livefetcherResponse[0] <> invalid and m.LiveFetcher.livefetcherResponse[0].now_playing <> invalid
        nowPlayingContent = m.LiveFetcher.livefetcherResponse[0].now_playing
    else
        nowPlayingContent = invalid
    end if
    content = m.LiveFetcher.livefetcherResponse[0]


    if curentItemEndTime <> invalid and curentItemSelectedTime <> invalid 'and curentItemSelectedTime < getCurrentTimeInSeconds() and curentItemEndTime > getCurrentTimeInSeconds()
        focusedContent = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused)
        focusedChildContent = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).getchild(m.TimeGrid.programFocused)
        m.top.id = focusedContent.id

        if nowPlayingContent <> invalid and nowPlayingContent.show_id <> invalid
            show_id = nowPlayingContent.show_id
        else
            show_id = 0
        end if
        schedule_id = ""
        if nowPlayingContent <> invalid and nowPlayingContent.id <> invalid
            schedule_id = nowPlayingContent.id.Tostr()
        end if

        video_title = ""
        if nowPlayingContent <> invalid and nowPlayingContent.video_title <> invalid
            video_title = nowPlayingContent.video_title
        end if

        live_link = ""
        if content <> invalid and content.live_link <> invalid
            live_link = content.live_link
        end if

        data = {

            "url": live_link,
            "show_id": show_id.ToStr(),
            "TITLE": video_title,
            "schedule_id": schedule_id,
            "channel_id": m.channelID,
            "is_from": "TIMEGRIDSCENE"
        }

        content = CreateObject("roSGNode", "VideoContent")
        content.setFields(data)
        content.addFields({

            "channel_id": m.channelID
        })


        if m.top.visible = true
            m.top.goToMainVideoPlayer = data
        end if

    else

        focusedContent = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused)
        m.top.id = focusedContent.id
        if content <> invalid
            if content.now_playing <> invalid and content.now_playing.show_id <> invalid
                show_id = content.now_playing.show_id
            else
                show_id = 0
            end if
        end if
        if nowPlayingContent <> invalid and nowPlayingContent.video_title <> invalid
            video_title = nowPlayingContent.video_title
        else
            video_title = ""
        end if
        if nowPlayingContent <> invalid and nowPlayingContent.id <> invalid
            id = nowPlayingContent.id
        else
            id = 0
        end if
        if focusedContent <> invalid and focusedContent.live_link <> invalid
            live_link = focusedContent.live_link
        else
            if content <> invalid and content.live_link <> invalid
                live_link = content.live_link
            end if
        end if
        data = {
            "url": live_link,
            "show_id": show_id.ToStr(),
            "TITLE": video_title,
            "schedule_id": id.Tostr()
            "channel_id": m.channelID,
            "is_from": "TIMEGRIDSCENE"
        }
        m.top.goToMainVideoPlayer = data
        ' else

    end if
    m.loading.visible = false
end function


sub checkLiveNowSubscription()
    m.videoTitleLabel.text = ""
    m.videoTitleBar.visible = false
    m.onFocusPlayVideoPlayer.control = "stop"
    m.fullscreenTimer.control = "stop"
    if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused) <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).id <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).getchild(m.TimeGrid.programFocused) <> invalid
        m.channel_id = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).id
    else
        m.channel_id = getFastChannelId()
    end if
    if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused) <> invalid 'and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).getchild(m.TimeGrid.programFocused) <> invalid
        if (getSubscriptionRequired() = "true")
            ' m.TimeGrid.unObserveField("programSelected")
            if isGuest() = "true"
                if (getLiveLoginCheck() = "true")
                    ' if (getRegisterationMandatory() = "true")
                    ' m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                    ' m.top.gotoLandingScene = true
                    callSubCheckAPi(m.channel_id) ' no subscrop
                else
                    callSubCheckAPi(m.channel_id) ' no subscrop
                end if
            else if isGuest() = "false"
                callSubCheckAPi(m.channel_id)
            end if
        else
            if isGuest() = "true"
                ' ifRegisterationMandatoryOrNot() '************** Registeration Mandatory checking
                runFastChannelApiTask()
            else
                runFastChannelApiTask()
            end if
        end if
    end if

end sub

sub callSubCheckAPi(channel_id)
    m.loading.visible = true
    m.ChannelSubsriptionTask = CreateObject("roSGNode", "ChannelSubsriptionTask")
    m.ChannelSubsriptionTask.channelID = channel_id
    m.ChannelSubsriptionTask.observeField("channelSubs", "checkLiveNowSubscription2")
    m.ChannelSubsriptionTask.callFunc("runChannelSubsriptionTask", "")
end sub
' Registerartion Mandatory checking
sub ifRegisterationMandatoryOrNot()
    if (getLiveLoginCheck() = "true")
        ' if (getRegisterationMandatory() = "true")
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
    else
        runFastChannelApiTask()
    end if
end sub

sub checkLiveNowSubscription2()
    m.TimeGrid.unObserveField("programSelected")
    m.TimeGrid.observeField("programSelected", "checkLiveNowSubscription")
    ?"checkLiveNowSubscription2 called"
    ?m.ChannelSubsriptionTask.channelSubs
    if m.ChannelSubsriptionTask.channelSubs = true
        ?"checkLiveNowSubscription2"
        runFastChannelApiTask()
    else
        ?"checkLiveNowSubscription2222"
        m.loading.visible = false
        m.top.goToPaymentDescriptionScreenForEvent = m.channel_id
    end if
end sub

function getchannelsid() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("channelsids")
        ChannelId = sec.Read("channelsids")
        return ChannelId
    end if
end function

function getAppKey() as object
    return m.global.APP_KEY
end function



function getFastChannelId() as string
    data = CreateObject("roRegistrySection", getAppKey())
    if data.Exists("FAST_CHANNEL_ID")
        output = data.Read("FAST_CHANNEL_ID")
        return output
    else
        return "0"
    end if
end function


sub onCategoryLabelListSelected()
    ?"onCategoryLabelListSelected called"
    ? m.TimeGridApiTask.TimeGridApiTaskContent
    currentSelectedCategoryNode = m.selectCategoryRowlist.content.getchild(0).getChild(m.selectCategoryRowlist.rowItemSelected[1])
    id = currentSelectedCategoryNode.id
    m.category_id = id
    ParentContentNode = CreateObject("RoSGNode", "ContentNode")

    copyvariable2 = m.TimeGridApiTask.TimeGridApiTaskContentCOPY.clone(true)

    for i = 0 to m.TimeGridApiTask.TimeGridApiTaskContentCOPY.getChildCount() - 1
        contentNode = copyvariable2.getChild(i).clone(true)
        ' if contentNode <> invalid
        categories = contentNode.categories

        for j = 0 to categories.Count() - 1
            category = categories[j]
            categoryId = category.category_id

            if categoryId = m.category_id.toInt() then
                ? "Match found! Category ID: " + categoryId.toStr()
                ParentContentNode.appendChild(contentNode)
            else
                ?"hkdajshd"
            end if
        end for
        ' end if

    end for
    ?ParentContentNode
    m.TimeGridApiTask.TimeGridApiTaskContent = ParentContentNode
    if m.selectCategoryRowlist <> invalid and m.selectCategoryRowlist.content <> invalid and m.selectCategoryRowlist.content.getChild(m.selectCategoryRowlist.rowItemSelected[1]) <> invalid and m.selectCategoryRowlist.content.getChild(m.selectCategoryRowlist.rowItemSelected[1]).title <> invalid and m.selectCategoryRowlist.content.getChild(m.selectCategoryRowlist.rowItemSelected[1]).title <> ""
        m.itemNode.title = m.selectCategoryRowlist.content.getChild(m.selectCategoryRowlist.rowItemSelected[1]).title
    end if
    m.selectCategoryRowlist.content.getchild(0).getChild(m.selectCategoryRowlist.rowItemSelected[1]).isSelectedNow = true

    rowIndex = 0
    colIndex = m.selectCategoryRowlist.rowItemSelected[1]
    rowNode = m.selectCategoryRowlist.content.getChild(rowIndex)
    ' Loop through all items in this row
    for idx = 0 to rowNode.getChildCount() - 1
        itemNode = rowNode.getChild(idx)

        ' Skip the one that was clicked
        if idx <> colIndex then
            itemNode.isSelectedNow = false
        else
            itemNode.isSelectedNow = true
        end if
    end for

end sub


sub initialiseCategoryRowlist()
    m.category_rect.visible = true

    cIndex = -1
    BaseContentNode = CreateObject("RoSGNode", "ContentNode")
    ParentContentNode = CreateObject("RoSGNode", "ContentNode")
    if m.TimeGridApiTask <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data <> invalid and m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data.categories <> invalid
        for each itemAA in m.TimeGridApiTask.responseDataTimeGridApiTaskList.data.data.categories
            itemContentNode = CreateObject("RoSGNode", "ContentNode")
            itemContentNode.title = itemAA.category_name
            itemContentNode.id = itemAA.category_id
            isSelectedNow = false
            cIndex = cIndex + 1
            if cIndex = 0
                isSelectedNow = true ' for initially all seected case
            end if
            itemContentNode.addFields({
                "index": cIndex,
                "isSelectedNow": isSelectedNow,
                "lastFocused": false
            })
            ParentContentNode.appendChild(itemContentNode)
        end for
        BaseContentNode.appendChild(ParentContentNode)

        ' m.selectCategoryRowlist.setFocus(true)
        m.selectCategoryRowlist.content = BaseContentNode
    end if
    ' m.selectCategoryRowlist.jumpToItem = m.selectCategoryRowlist.itemSelected
end sub


function getLast30MinWindowInSeconds() as integer
    date = CreateObject("roDateTime")
    currentSeconds = date.AsSeconds()

    ' Get minutes and seconds
    minutes = date.GetMinutes()
    seconds = date.GetSeconds()

    ' Remove extra minutes and seconds to go back to last 30-min mark
    delta = (minutes mod 30) * 60 + seconds
    lastWindowEpoch = currentSeconds - delta

    return lastWindowEpoch
end function







'focus player play
sub onFocusPlayTimeGridLiveVideo(timeGridSceneInputData)
    m.onFocusPlayVideoPlayer.visible = true
    m.fullscreenCountdown = 11
    m.fullscreenTimer.control = "stop"
    m.fullscreenTimer.control = "start"
    ?"playVideoFunction called : VideoonFocusPlayVideoPlayerScene"
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: "",
        url: timeGridSceneInputData.live_link, '"https://epg.provider.plex.tv/library/parts/5e20b730f2f8d5003d739db7-5f0ff262d71dcb00449ec015.m3u8?X-Plex-Session-Identifier=y75hbmqm7cpch5u2ho42sjvu&X-Plex-Product=Plex%20Web&X-Plex-Version=4.122.0&X-Plex-Client-Identifier=m5qurtm6cggg1j9rbld98o4t&X-Plex-Platform=Chrome&X-Plex-Platform-Version=120.0&X-Plex-Features=external-media%2Cindirect-media%2Chub-style-list&X-Plex-Model=hosted&X-Plex-Device=Windows&X-Plex-Device-Name=Chrome&X-Plex-Device-Screen-Resolution=1536x695%2C1536x864&X-Plex-Token=2t8GyRGDf-Cos5NxGk7j&X-Plex-Language=en&Accept-Language=en&X-Plex-Session-Id=e0f1dcad-8853-438e-84f9-c6fa0fc45939"'timeGridSceneInputData.URL, '"https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
        categories: "",
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.ClosedCaptions = false
    content.globalCaptionMode = "Off"
    content.HDBranded = true
    content.IsHD = true
    m.onFocusPlayVideoPlayer.content = content
    m.onFocusPlayVideoPlayer.visible = true
    m.onFocusPlayVideoPlayer.control = "play"
    m.onFocusPlayVideoPlayer.setFocus(false)
end sub

function onFocusPlayVideoPlayerStateChanged()
    if m.onFocusPlayVideoPlayer.state = "buffering"
        m.videoOverlayposter.visible = true
    else if m.onFocusPlayVideoPlayer.state = "playing"
        m.videoOverlayposter.visible = false
    else if m.onFocusPlayVideoPlayer.state = "stopped"
        m.videoOverlayposter.visible = true
    end if
    ?"onVideoVisibleChange called : VideoPlayerScene ";m.onFocusPlayVideoPlayer.state
    ?m.videoOverlayposter.visible
end function


sub onFullscreenTimerTick()
    if m.onFocusPlayVideoPlayer.state = "playing"
        if m.fullscreenCountdown > 0
            m.videoPlayerContainer.visible = true
            m.fullscreenCountdown = m.fullscreenCountdown - 1
            m.videoTitleLabel.text = "Fullscreen in " + m.fullscreenCountdown.ToStr() + " seconds"
            if m.top.visible = false
                ?"djaskjdh777"
                m.onFocusPlayVideoPlayer.control = "stop"
            end if
            m.videoTitleBar.visible = true
            if m.fullscreenCountdown = 0
                m.videoTitleLabel.text = ""
                m.videoTitleBar.visible = false
                m.onFocusPlayVideoPlayer.control = "stop"
                m.fullscreenTimer.control = "stop"
                m.fullscreenCountdown = 31
                if m.top.visible = true
                    checkLiveNowSubscription()
                end if
            end if
        end if
    end if
end sub

sub goToMainVideoPlayer()
    if m.TimeGrid.content <> invalid and m.TimeGrid.channelFocused <> invalid and m.TimeGrid.programFocused <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused) <> invalid and m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused) <> invalid
        focusedChannel = m.TimeGrid.content.getChild(m.TimeGrid.channelFocused)
        focusedItem = m.TimeGrid.content.getChild(m.TimeGrid.channelFocused).getChild(m.TimeGrid.programFocused)
        data = {

            "url": focusedChannel.live_link,
            "show_id": "",
            "TITLE": focusedItem.title,
            "schedule_id": focusedItem.schedule_id,
            "channel_id": focusedChannel.id,
            "is_from": "TIMEGRIDSCENE"
        }
        if m.top.visible = true
            m.top.goToMainVideoPlayer = data
        end if
    end if
end sub


sub runFastChannelApiTask2()
    if m.LiveFetcher <> invalid
        if m.LiveFetcher.control <> invalid and m.LiveFetcher.control = "RUN"
            m.LiveFetcher.callFunc("stopLiveFetcherTask", "")
        end if
    else
        m.LiveFetcher = CreateObject("roSGNode", "LiveFetcher")
    end if
    m.LiveFetcher.unObserveField("livefetcherResponse")
    m.LiveFetcher.observeField("livefetcherResponse", "checkLiveNowSubscriptionForPreviewPlayer")
    if m.TimeGrid.content <> invalid and m.TimeGrid.content.getchild(m.TimeGrid.channelFocused) <> invalid and m.TimeGrid.content.getchild(m.TimeGrid.channelFocused).id <> invalid
        m.channelID = m.TimeGrid.content.getchild(m.TimeGrid.channelFocused).id
    else
        m.channelID = getFastChannelId()
    end if
    m.LiveFetcher.channel_id = m.channelID
    m.LiveFetcher.callFunc("runLiveFetcherTask", "TIMEGRIDSCENE")
end sub


'programFocused-previewsubscription
sub checkLiveNowSubscriptionForPreviewPlayer()
    ?"checkLiveNowSubscriptionForPreviewPlayer called"
    if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused) <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).id <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).getchild(m.TimeGrid.programFocused) <> invalid
        m.channel_id = m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).id
    else
        m.channel_id = getFastChannelId()
    end if


    if m.LiveFetcher.livefetcherResponse <> invalid and m.LiveFetcher.livefetcherResponse.count() > 0
        focusedRowContent = m.LiveFetcher.livefetcherResponse[0]

        if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused) <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.channelFocused).getchild(m.TimeGrid.programFocused) <> invalid
            if (getSubscriptionRequired() = "true")
                ' m.TimeGrid.unObserveField("programSelected")
                if isGuest() = "true"
                    if (getLiveLoginCheck() = "true")
                        ' if (getRegisterationMandatory() = "true")
                        callSubCheckAPiForPreviewPlayer(m.channel_id) ' no subscrop
                    else
                        callSubCheckAPiForPreviewPlayer(m.channel_id) ' no subscrop
                    end if
                else if isGuest() = "false"
                    callSubCheckAPiForPreviewPlayer(m.channel_id)
                end if
            else
                if isGuest() = "true"
                    if (getLiveLoginCheck() = "true")
                        ' if (getRegisterationMandatory() = "true")

                        if focusedRowContent <> invalid
                            onFocusPlayTimeGridLiveVideo(focusedRowContent)
                        end if
                    else
                        if focusedRowContent <> invalid
                            onFocusPlayTimeGridLiveVideo(focusedRowContent)
                        end if
                    end if '************** Registeration Mandatory checking

                else
                    if focusedRowContent <> invalid
                        onFocusPlayTimeGridLiveVideo(focusedRowContent)
                    end if
                end if
            end if
        end if
    end if
end sub

sub callSubCheckAPiForPreviewPlayer(channel_id)
    m.ChannelSubsriptionTask2 = CreateObject("roSGNode", "ChannelSubsriptionTask")
    m.ChannelSubsriptionTask2.channelID = channel_id
    m.ChannelSubsriptionTask2.observeField("channelSubs", "checkLiveNowSubscription2ForPreviewPlayer")
    m.ChannelSubsriptionTask2.callFunc("runChannelSubsriptionTask", "")
end sub

sub checkLiveNowSubscription2ForPreviewPlayer()
    ?"dahgjdhgsgdjahgsjdgh333 ";m.ChannelSubsriptionTask2.channelSubs
    if m.ChannelSubsriptionTask2.channelSubs = true
        ?"checkLiveNowSubscription2"
        focusedContent = invalid
        if m.TimeGridApiTask.TimeGridApiTaskContent <> invalid and m.TimeGrid.programFocusedDetails <> invalid and m.TimeGrid.programFocusedDetails.focusChannelIndex <> invalid and m.TimeGridApiTask.TimeGridApiTaskContent.getChild(m.TimeGrid.programFocusedDetails.focusChannelIndex) <> invalid
            if m.LiveFetcher.livefetcherResponse <> invalid and m.LiveFetcher.livefetcherResponse.count() > 0
                focusedRowContent = m.LiveFetcher.livefetcherResponse[0]
                onFocusPlayTimeGridLiveVideo(focusedRowContent)
            end if
        end if
    else if m.ChannelSubsriptionTask2.channelSubs = false
        ?"checkLiveNowSubscription2222 need to subscribe text"
        m.onFocusPlayVideoPlayer.visible = false
        m.videoTitleLabel.text = "Subscription Required to watch the preview"
        m.videoTitleBar.visible = true
    end if
end sub

sub onChangeFocusNotify()
    ?"onChangeFocusNotify called"
    m.selectCategoryRowlist.setFocus(true)
end sub