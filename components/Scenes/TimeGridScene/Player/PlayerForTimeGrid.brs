'*********************************************************************
'** (c) 2016-2017 Roku, Inc.  All content herein is protected by U.S.
'** copyright and other applicable intellectual property laws and may
'** not be copied without the express permission of Roku, Inc., which
'** reserves all rights.  Reuse of any of this content for any purpose
'** without the permission of Roku, Inc. is strictly prohibited.
'*********************************************************************

' Player

sub init()
    ?"init called : Player.brs ...."
    m.video = m.top.findNode("Video")
    pressupLabelInitialise()
    languageLabelistInitialise()
    m.count = 0


    ' m.videoPlayer.retrievingBarVisibilityAuto = true
    ' m.VideoEventTask = CreateObject("roSGNode", "VideoEventTask")
    m.Timer = m.top.findNode("Timer")
    m.top.ObserveField("visible", "onVisibleChange")
    m.RowList = m.top.findNode("RowList")
    m.RowList.observeField("RowItemFocused", "OnRowItemFocused")
    m.RowList.setFocus(true)
    m.RowList.rowLabelFont.size = "24"
    m.count = 0
    m.AdTimer = m.top.findNode("AdTimer")
    m.RowList = m.top.findNode("RowList")
    m.BottomBar = m.top.findNode("BottomBar")
    m.ShowBar = m.top.findNode("ShowBar")
    m.HideBar = m.top.findNode("HideBar")
    m.Hint = m.top.findNode("Hint")
    m.scheduleRowListHideTimer = m.top.findNode("scheduleRowListHideTimer")
    m.scheduleRowListHideTimer.observeField("fire", "hideScheduleRowList")
    m.Hint.text = getText("press_up_down_for_live_tv_guide")
    m.Hint.visible = false
    m.Hint.font.size = 20
    m.scheduleTimer = m.top.findNode("scheduleTimer")
    m.AdTimer = m.top.findNode("AdTimer")
    m.Timer.observeField("fire", "hideHintAndScheduleRowlist")
    m.AdTimer.observeField("fire", "change")
    m.scheduleTimer.observeField("fire", "OnscheduleTimer")
    m.playing = m.top.findNode("playing")
    m.live = m.top.findNode("live")
    m.next = m.top.findNode("next")
    m.title = m.top.findNode("title")
    onStarted()
end sub

'***when manually started or stopped the palyer
sub controlChanged()
    m.languageLabelist.content = parseLanguageLabelist(m.top.content.audio_languages)
    m.languageLbllist_react.visible = false
    
    if(m.count = 0)
        m.count = 1
        'handle orders by the parent/owner
        control = m.top.control
        if control = "play" then
            if getAdRequired() = "false"
                m.top.skipAd = true
            end if
            playContent()
        else if control = "stop" then
            exitPlayer()
        end if
    end if
end sub


sub OnItemFocused()
    selectedrowItemFocused = m.rowOptionList.rowItemFocused
    selectedIndex = m.rowOptionList.itemFocused ' get position of focused item


    row = m.rowOptionList.content.GetChild(selectedrowItemFocused[0]) ' get all items of row
    item = row.GetChild(selectedrowItemFocused[1]) ' get focused item

    '    if m.selectedOptions[row.title] = item.productoption_value then
    '        m.selectedOptions.Delete(row.title)
    '    else
    '        m.selectedOptions[row.title] = item.productoption_value
    '    end if
    m.selectedOptions[row.title] = item.productoption_value
end sub


sub playContent()
    ?m.top.schedulecontent
    ?" m.top.schedulecontentwwq"
    ?"playContent called"
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.video.visible = false
        startMessageTimer()
        m.PlayerTaskForTimeGrid = CreateObject("roSGNode", "PlayerTaskForTimeGrid")
        m.PlayerTaskForTimeGrid.observeField("state", "taskStateChanged")
        m.PlayerTaskForTimeGrid.observeField("isFinished", "onPlayerStateChanged")
        m.PlayerTaskForTimeGrid.video = m.video
        m.PlayerTaskForTimeGrid.skipAd = true'm.top.skipAd 'setting skipAd value to PlayerTaskForTimeGrid
        m.PlayerTaskForTimeGrid.watched_duration = m.top.watched_duration 'setting watched_duration value to PlayerTaskForTimeGrid
        m.PlayerTaskForTimeGrid.control = "RUN"

        ' m.top.visibility = true
    end if

end sub

sub exitPlayer()
    m.count = 0
    m.video.control = "stop"
    m.video.visible = false
    m.PlayerTaskForTimeGrid = invalid
    m.top.state = "done"
    m.top.visibility = false
end sub

' sub exitPlayer() 'new exit player with more robust resource cleanup and task termination - need to call this in future
'     ?"exitPlayer called"
'     m.count = 0

'     if m.video <> invalid
'         ' 1. Stop playback
'         m.video.control = "stop"
'         ' 2. Release the content reference (Crucial for clearing the buffer)
'         m.video.content = invalid
'         ' 3. Explicitly release the player resource
'         m.video.visible = false
'     end if

'     ' 4. Kill the Task node
'     if m.PlayerTaskForTimeGrid <> invalid
'         m.PlayerTaskForTimeGrid.control = "STOP" ' Ensure your PlayerTask handles this to exit its loop
'         m.PlayerTaskForTimeGrid = invalid
'     end if

'     m.top.state = "done"

'     m.top.visibility = false
' end sub

sub taskStateChanged(event as object)
    print "Player : taskStateChanged(), id = "; event.getNode(); ", "; event.getField(); " = "; event.getData()
    state = event.GetData()
    ?state
    ?m.video.state
    m.top.playerState = m.video.state'm.top.getchild(0).state '***bringing the playerstate status to player from PlayerTaskForTimeGrid
    if state = "done" or state = "stop" or state = "finished"
        exitPlayer()
        m.count = 0
        sec = CreateObject("roRegistrySection", getAppKey())
    end if
end sub


'***this is used for autoplay in show page
sub onPlayerStateChanged()
    ' m.top.playerState = m.PlayerTaskForTimeGrid.playerState'***bringing the playerstate status to player from PlayerTaskForTimeGrid
    ?"onPlayerStateChanged called : player"
    ?m.PlayerTaskForTimeGrid.isFinished
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "back"
            if m.video.state = "none" 'or m.video.state = "buffering" - buffering back was disabled for an issue
                return true
            end if
            if m.languageLbllist_react.visible = true
                m.languageLbllist_react.visible = false
                m.video.visible = true
                m.video.setFocus(true)
            else
                m.top.playerState = "back_pressed"
                exitPlayer()
            end if

        else if key = "up" or key = "down"
            if m.BottomBar.translation[1] = 1080 ' currently hidden (y=1080)
                showScheduleRowlist()
            else if m.BottomBar.translation[1] = 650 ' currently visible (y=650)
                hideHintAndScheduleRowlist()
            end if
            handled = true
        end if
    end if
    return true
end function

function changeVideoTrack()

    m.count = 0
    m.video.control = "stop"
    m.PlayerTaskForTimeGrid = invalid
    '***********setting the data to the player once we change the multiple language
    m.top.content.URL = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_name
    m.top.content.video_id = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_id
    m.top.content.title = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_title
    m.top.content.language_id = m.top.content.audio_languages[m.languageLabelist.itemSelected].language_id
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        ' m.video.visible = falsex

        m.PlayerTaskForTimeGrid = CreateObject("roSGNode", "PlayerTaskForTimeGrid")
        m.PlayerTaskForTimeGrid.observeField("state", "taskStateChanged")
        m.PlayerTaskForTimeGrid.observeField("isFinished", "onPlayerStateChanged")
        m.PlayerTaskForTimeGrid.video = m.video
        m.PlayerTaskForTimeGrid.skipAd = m.top.skipAd 'setting skipAd value to PlayerTaskForTimeGrid
        m.PlayerTaskForTimeGrid.watched_duration = m.top.watched_duration 'setting watched_duration value to PlayerTaskForTimeGrid
        m.PlayerTaskForTimeGrid.control = "RUN"
    end if

    m.video.visible = true
    m.languageLbllist_react.visible = false
    updateLanguageSlected(m.top.content.audio_languages[m.languageLabelist.itemSelected].language_id)
end function


'************parses the multilanguage labels and set data to the labellist
function parseLanguageLabelist(audio_languages)
    ParentContentNode = CreateObject("RoSGNode", "ContentNode")

    if audio_languages <> invalid
        for each itemAA in audio_languages

            itemContentNode = CreateObject("RoSGNode", "ContentNode")
            itemContentNode.title = itemAA.language_name
            itemContentNode.addFields({
                "language_id": itemAA.language_id,
                "video_id": itemAA.video_id,
                "video_name": itemAA.video_name
            })
            ParentContentNode.appendChild(itemContentNode)
        end for
    end if

    return ParentContentNode
end function

function onLanguageLabelListSelected()

end function

'''''''''
' OnSixSecondsFinished:
' this function will show the multiple language label
'''''''''
sub OnSixSecondsFinished()

    ?"OnSixSecondsFinished called"
    m.multiple_language_label.visible = true
end sub


'''''''''
' OnElevenSecondsFinished:
'  this function will hide the multiple language label
'''''''''
sub OnElevenSecondsFinished()
    ?"OnSixSecondsFinished called"
    m.multiple_language_label.visible = false
end sub


'''''''''
' pressupLabelInitialise:
' this willinitialise timer, multiple_language_label
'''''''''
sub pressupLabelInitialise()
    m.makeVisibleTimer = m.top.findNode("makeVisibleTimer")
    m.makeVisibleTimer.ObserveField("Fire", "OnSixSecondsFinished")
    m.makeHideTimer = m.top.findNode("makeHideTimer")
    m.makeHideTimer.ObserveField("Fire", "OnElevenSecondsFinished")
    m.multiple_language_label = m.top.CreateChild("Label")


    m.multiple_language_label.text = getText("press_up_to_select_multiple_languages")







    m.multiple_language_label.color = "#666666"
    m.multiple_language_label.translation = [1342, 995]
    m.multiple_language_label.width = 560
    m.multiple_language_label.font = "font:SmallestSystemFont"
    m.multiple_language_label.height = 100
    m.multiple_language_label.visible = false
end sub

'''''''''
' startMessageTimer: starts both of the timers
'
'''''''''
sub startMessageTimer()
    if m.languageLabelist.content.getchildcount() > 1
        m.multiple_language_label.visible = false
        m.makeVisibleTimer.control = "start"
        m.makeHideTimer.control = "start"
    end if
end sub

'''''''''
' languageLabelistInitialise: initialise the languageLabelist
'
'''''''''
sub languageLabelistInitialise()
    m.languageLbl = m.top.findNode("language_Lbl")
    m.languageLbllist_react = m.top.findNode("languageLbllist_react")
    m.languageLabelist = m.top.findNode("selectLanguage")
    m.languageLabelist.focusBitmapBlendColor = getButtonSelectionColor()
    m.languageLabelist.focusFootprintBlendColor = getButtonSelectionColor()
    m.languageLabelist.observeField("itemSelected", "changeVideoTrack")
end sub


'''''''''
' updateLanguageSlected: this function updates the selected language to server. to let the server know we have selectedthis language for next autoplay video to be palyed in the same language.
'
' @param {dynamic} language_id
'''''''''
sub updateLanguageSlected(language_id)
    m.MultiLanguageUserUpdateTask = CreateObject("roSGNode", "MultiLanguageUserUpdateTask")
    languageselected = language_id
    m.MultiLanguageUserUpdateTask.observeField("MultiLanguageUserUpdateApiTaskListStatus", "ResponseUpdateStatus")
    m.MultiLanguageUserUpdateTask.callFunc("runMultiLanguageUserUpdateApiTask", languageselected)
end sub

sub ResponseUpdateStatus()
    ?"ResponseUpdateStatus called"
    m.top.VIDEO_LANGUAGE_CHANGED = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_id
end sub

'''''''''
' showLanguageLabelist: show the languagelabellist when up presses , also set the langugae aelected.
'
'''''''''
sub showLanguageLabelist()
    m.video.visible = false
    m.languageLbllist_react.visible = true
    m.languageLabelist.setFocus(true)
    for i = 0 to m.languageLabelist.content.getchildcount() - 1
        if m.languageLabelist.content.getchild(i).language_id = m.top.content.language_id
            m.languageLabelist.jumpToItem = i
        end if
    end for
end sub

'scheduleguide

sub change()
    m.global.Adtracker = 0
end sub

sub hideHintAndScheduleRowlist()
    ' ?"hideHintAndScheduleRowlist called"
    m.Hint.visible = false
    m.playing.visible = false
    m.HideBar.control = "start"
end sub

sub showScheduleRowlist()
    ' ?"showScheduleRowlist called"
    if m.top.content.is_from = "NORMAL_LIVENOW_SCENE"
        if m.LoadTask.content <> invalid and m.LoadTask.content.getChild(0) <> invalid and m.LoadTask.content.getChild(0).getChildCount() > 0
            m.Hint.visible = false
            m.playing.visible = true
            ' m.Timer.control = "start"
            m.ShowBar.control = "start"
            m.RowList.setFocus(true)
            m.scheduleRowListHideTimer.control = "start"
        end if
    end if
end sub

sub hideScheduleRowList()
    m.scheduleRowListHideTimer.control = "stop"
    if m.BottomBar.translation[1] = 650
        hideHintAndScheduleRowlist()
    end if
end sub




sub rowListContentChanged()
    m.RowList.content = m.LoadTask.content
    if m.count = 0
        m.Video.content = m.RowList.content.getChild(0).getChild(0)
        m.Video.control = "play"
        m.count = 1
    end if
end sub

sub onStarted()
    m.LoadTask = createObject("roSGNode", "ScheduleFetcher")
    m.LoadTask.linear_channel_id = m.top.linear_channel_id
    m.LoadTask.ScheduleRequest = "run"
    m.LoadTask.callFunc("runScheduleFetcherTask", "")
    m.LoadTask.observeField("content", "onContentChanged")
end sub

sub onContentChanged()
    ?"onContentChanged called  : live tv"
    ' if m.LoadTask.content <> invalid and m.LoadTask.content.count() <> invalid and m.LoadTask.content.getchildcount() = 1
    '     m.BottomBar.visible = false
    '     m.Video.setFocus(true)
    ' end if



    if m.LoadTask.content <> invalid and m.LoadTask.content.getChild(0) <> invalid and m.LoadTask.content.getChild(0).getChildCount() > 0
        m.RowList.content = m.LoadTask.content
        m.Hint.visible = m.top.content.is_from = "NORMAL_LIVENOW_SCENE"
    else
        m.Hint.visible = false
    end if


    if getThumbnailOrientaion() = "LANDSCAPE"
        rowHeights = [290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290]
        rowItemSize = [[340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191], [340, 191]]
        m.RowList.translation = [240, 120]
    else if getThumbnailOrientaion() = "PORTRAIT"
        rowHeights = [400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400]
        rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
        m.RowList.translation = [240, 20]
    end if

    m.RowList.rowHeights = rowHeights
    m.RowList.rowItemSize = rowItemSize
    ' m.RowList.observeField("rowItemFocused", "ChannelFocus")

    ' if m.RowList.content <> invalid and m.RowList.content.getChild(0) <> invalid and m.RowList.content.getChild(0).getChild(0) <> invalid
    '     m.Video.content = m.RowList.content.getChild(0).getChild(0)
    ' end if

    if m.PlayerTaskForTimeGrid <> invalid and m.LoadTask <> invalid and m.LoadTask.content <> invalid
        m.PlayerTaskForTimeGrid.scheduletask = m.LoadTask.content
    end if

    ' m.PlayerTaskForTimeGrid.scheduletask=m.LoadTask.content
    ' ?m.PlayerTaskForTimeGrid.scheduletask
    ' ?type(m.PlayerTaskForTimeGrid.scheduletask)
    ' ?type(m.LoadTask.content)
    ' ?"m.PlayerTaskForTimeGrid.scheduletask"
    ' ' m.top.schedulecontent=m.LoadTask.content
    ' ?m.LoadTask.content
    ' ?"m.LoadTask.content323"
    ' ?m.top.schedulecontent
    ' ?"m.top.schedulecontent"
    m.LoadTask.callFunc("stopScheduleFetcherTask", "")
    ' m.scheduleTimer.control = "start" ' starting timer for calling  live and live guide api every minute

end sub



sub OnscheduleTimer() 'calling schedule and live api every 1 minute

    if m.LoadTask <> invalid
        m.LoadTask.callFunc("stopScheduleFetcherTask", "")
    end if

    m.LoadTask = createObject("roSGNode", "ScheduleFetcher")
    m.LoadTask.ScheduleRequest = "run"
    m.LoadTask.callFunc("runScheduleFetcherTask", "")
    m.LoadTask.observeField("content", "onScheduleFetcherCalled")
end sub

sub onScheduleFetcherCalled() 'liveguide:  setting video title and refreshing liveguide rowlist every 1 minute
    m.playing.text = "Now Playing: " + chr(10) + m.LoadTask.video_title
    m.RowList.content = m.LoadTask.content
end sub


sub OnRowItemFocused()
    m.scheduleRowListHideTimer.control = "stop"
    m.scheduleRowListHideTimer.control = "start"
end sub