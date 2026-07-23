

sub init()
    m.video = m.top.findnode("Video")
    m.video_shrink_animation = m.top.findnode("video_shrink_animation")
    m.video_expand_animation = m.top.findnode("video_expand_animation")
    languageLabelistInitialise()
    initialisePlayerBottomPopup()
    resolutionLabelistInitialise()
    initialiseComments()
    speedLabelistInitialise()
    m.count = 0
end sub

sub controlChanged()
    if m.top.content <> invalid and m.top.content.audio_languages <> invalid and m.top.content.audio_languages.count() > 0
        m.languageLabelist.content = parseLanguageLabelist(m.top.content.audio_languages)
        m.playerMenuContent.appendChild(m.languageNode)
    end if
    if m.top.content <> invalid and m.top.content.resolutions_parsed <> invalid and m.top.content.resolutions_parsed.count() > 0
        m.resolutionLabelist.content = m.top.content.resolutions_parsed
        m.playerMenuContent.appendChild(m.multiResolutionNode)
    end if
    m.languageLbllist_react.visible = false
    if(m.count = 0)
        m.count = 1
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
    selectedIndex = m.rowOptionList.itemFocused 

    row = m.rowOptionList.content.GetChild(selectedrowItemFocused[0]) 
    item = row.GetChild(selectedrowItemFocused[1])
    m.selectedOptions[row.title] = item.productoption_value
end sub


sub playContent()

    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.video.visible = false

        di = CreateObject("roDeviceInfo")
        screenSize = m.top.GetScene().currentDesignResolution
        if screenSize <> invalid and screenSize.DoesExist("width") and screenSize.DoesExist("height")
            ?"Device Resolution:"; screenSize.width; "x"; screenSize.height

            m.video.translation = [0, 0]
            m.video.width = screenSize.width
            m.video.height = screenSize.height
            ?"ddc"
        else
            m.video.width = 1920
            m.video.height = 1080
        end if
        m.PlayerTask = CreateObject("roSGNode", "PlayerTask")
        m.PlayerTask.observeField("state", "taskStateChanged")
        m.PlayerTask.observeField("isFinished", "onPlayerStateChanged")
        m.PlayerTask.video = m.video
        m.PlayerTask.skipAd = m.top.skipAd 
        m.PlayerTask.watched_duration = m.top.watched_duration
        m.PlayerTask.ai_type = m.video.content.ai_type
        m.PlayerTask.video_type = m.video.content.video_type
        m.PlayerTask.show_id_playlist = m.video.content.show_id_playlist

        m.PlayerTask.control = "RUN"
        m.comments.video_id = m.video.content.video_id
        m.player_overlay_rect.visible = false
        m.buttonsRowlist.visible = true
        if m.video.content.show_id <> invalid
            callSimilarShows(m.video.content.show_id)
        end if

        if m.top.watched_duration > 0 then m.playerMenuContent.insertChild(m.startOverNode, 0)
        if m.video.content["videoDetailsResponse"] <> invalid and m.video.content["videoDetailsResponse"]["go_ads_free"] <> invalid and m.video.content["videoDetailsResponse"]["go_ads_free"] = true
            m.playerMenuContent.insertChild(m.goAdsFreeNode, 0)
        end if

    end if
end sub


sub exitPlayer()
    ?"exitPlayer called"
    m.count = 0

    if m.video <> invalid
        m.video.control = "stop"
        m.video.content = invalid
        m.video.visible = false
    end if

    if m.PlayerTask <> invalid
        m.PlayerTask.control = "STOP" 
        m.PlayerTask = invalid
    end if

    m.top.state = "done"
    m.player_overlay_rect.visible = false
    
    m.comments.visible = false
    m.top.visibility = false
end sub

sub taskStateChanged(event1 as object)
    print "Player : taskStateChanged(), id = "; event1.getNode(); ", "; event1.getField(); " = "; event1.getData()
    state = event1.GetData()
    m.top.playerState = m.video.state
    if state = "done" or state = "stop" or state = "finished"

        if m.video.content <> invalid and m.video.content.video_type <> invalid and m.video.content.video_type = "playlist"
            exitPlayer()
            m.count = 0
            m.player_overlay_rect.visible = false
            m.buttonsRowlist.visible = false
            m.overlayRowlist.setFocus(true)

        else
            exitPlayer()
            m.count = 0
            m.player_overlay_rect.visible = true
            m.buttonsRowlist.visible = false
            m.overlayRowlist.setFocus(true)
        end if
    end if
end sub

'***this is used for autoplay in show page
sub onPlayerStateChanged()
    ?m.PlayerTask.isFinished
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        ?"Key pressed: Player"; key

        if key = "back"
            if m.languageLbllist_react.visible = true
                m.languageLbllist_react.visible = false
                m.video.visible = true
                m.video.setFocus(true)
            else if m.resolutionLbllist_rect.visible = true
                m.resolutionLbllist_rect.visible = false
                m.video.visible = true
                m.video.setFocus(true)
            else if m.speedLbllist_rect.visible = true
                m.speedLbllist_rect.visible = false
                m.video.visible = true
                m.video.setFocus(true)
            else if m.comments.visible = true
                m.comments.visible = false
                m.video.setFocus(true)
            else if m.player_overlay_rect.visible = true
                m.player_overlay_rect.visible = false
                m.player_overlay_hide_animation.control = "start"
                m.video.setFocus(true)
            else
                m.top.playerState = "back_pressed"
                exitPlayer()
            end if

        else if key = "up"
            if (m.speedLabelist.hasFocus() = true or m.resolutionLabelist.hasFocus() = true or m.languageLabelist.hasFocus() = true)
                ' do nothing
            else if m.player_overlay_rect.visible = false
                m.player_overlay_rect.visible = true
                if m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)

                else if m.buttonsRowlist.visible = false and m.video.content.video_type <> invalid and m.video.content.video_type = "playlist"
                    m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)

                else
                    m.overlayRowlist.setFocus(true)
                end if
            else if m.player_overlay_rect.visible = true and m.buttonsRowlist.hasFocus() = true
                m.player_overlay_rect.visible = false
                m.video.setFocus(true)
            else if m.player_overlay_rect.visible = true and m.overlayRowlist.hasFocus() = true
                if m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)
                else
                    m.player_overlay_rect.visible = false
                    m.video.setFocus(true)
                end if


            else if m.player_overlay_rect.visible = true and m.video.content.video_type <> invalid and m.video.content.video_type = "playlist"
                m.player_overlay_rect.visible = false

                if m.buttonsRowlist.visible = false
                    m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)
                else
                    m.overlayRowlist.setFocus(true)
                end if


            else
                m.player_overlay_rect.visible = false
                m.video.setFocus(true)
            end if

        else if key = "ok"
            if not m.player_overlay_rect.visible = true
                m.player_overlay_rect.visible = true
                m.buttonsRowlist.setFocus(true)
            end if

        else if key = "down"
            if m.player_overlay_rect.visible = true and m.buttonsRowlist.hasFocus() = true
                if m.overlayRowlist.content <> invalid and m.overlayRowlist.content.getchildcount() > 0
                    m.overlayRowlist.setFocus(true)
                else if (m.speedLabelist.hasFocus() = true or m.resolutionLabelist.hasFocus() = true or m.languageLabelist.hasFocus() = true)
                else
                    m.player_overlay_rect.visible = false
                    m.video.setFocus(true)
                end if


            else if m.player_overlay_rect.visible = true and m.overlayRowlist.hasFocus() = true
               
            else if (m.speedLabelist.hasFocus() = true or m.resolutionLabelist.hasFocus() = true or m.languageLabelist.hasFocus() = true)
               
            else if m.player_overlay_rect.visible = true and m.video.content.video_type <> invalid and m.video.content.video_type = "playlist"
                if m.buttonsRowlist.visible = false
                    m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)
                end if

            else
                m.player_overlay_rect.visible = true
                if m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)

                else if m.buttonsRowlist.visible = false and m.video.content.video_type <> invalid and m.video.content.video_type = "playlist"
                    m.buttonsRowlist.visible = true
                    m.buttonsRowlist.setFocus(true)

                else
                    m.overlayRowlist.setFocus(true)
              
                end if
            end if
        end if
    else
        if key = "OK"
            if not m.player_overlay_rect.visible = true and m.video.visible = true and m.comments.visible = false
                m.player_overlay_rect.visible = true
                m.buttonsRowlist.setFocus(true)
            else
                m.player_overlay_rect.visible = false
                if m.comments.visible = false and m.resolutionLbllist_rect.visible = false and m.speedLbllist_rect.visible = false and m.languageLbllist_react.visible = false
                    m.video.setFocus(true)
                end if
            end if
        end if
    end if
    return true
end function


function changeVideoTrack()
    ?"changeVideoTrack called : player"
    m.languageLbllist_react.visible = false
    m.count = 0
    m.video.control = "stop"
    m.PlayerTask = invalid

    m.top.content.URL = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_name
    m.top.content.video_id = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_id
    m.top.content.title = m.top.content.audio_languages[m.languageLabelist.itemSelected].video_title
    m.top.content.language_id = m.top.content.audio_languages[m.languageLabelist.itemSelected].language_id
    content = m.top.content
    if content <> invalid then
        m.video.content = content

        m.PlayerTask = CreateObject("roSGNode", "PlayerTask")
        m.PlayerTask.isTrackChange = true
        m.PlayerTask.observeField("state", "taskStateChanged")
        m.PlayerTask.observeField("isFinished", "onPlayerStateChanged")
        m.PlayerTask.video = m.video
        m.PlayerTask.skipAd = m.top.skipAd 
        m.PlayerTask.watched_duration = m.top.watched_duration
        m.PlayerTask.control = "RUN"
    end if

    m.video.visible = true
    m.resolutionLabelist.visible = false
end function



function parseLanguageLabelist(audio_languages)
    ParentContentNode = CreateObject("RoSGNode", "ContentNode")

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

    return ParentContentNode
end function

function onLanguageLabelListSelected()

end function

sub languageLabelistInitialise()
    m.languageLbl = m.top.findNode("language_Lbl")
    m.languageLbllist_react = m.top.findNode("languageLbllist_react")
    m.languageLabelist = m.top.findNode("selectLanguage")
    m.languageLabelist.focusBitmapBlendColor = getButtonSelectionColor()
    m.languageLabelist.focusFootprintBlendColor = getButtonSelectionColor()
    m.languageLabelist.observeField("itemSelected", "changeVideoTrack")
end sub


sub initialiseComments()
    m.comments = m.top.CreateChild("Comments")
    m.comments.observeField("closeComments", "onCommentsClosed")
    m.comments.translation = [1920 - m.comments.getchild(0).width, 0]
    m.comments.visible = false
end sub


sub resolutionLabelistInitialise()
    m.resolutionLbllist_rect = m.top.findNode("resolutionLbllist_rect")
    m.resolutionLbllist_rect.visible = false
    m.resolutionLbl = m.top.findNode("resolution_Lbl")
    m.resolutionLabelist = m.top.findNode("resolution_labellist")
    m.resolutionLabelist.focusBitmapBlendColor = getButtonSelectionColor()
    m.resolutionLabelist.focusFootprintBlendColor = getButtonSelectionColor()
    m.resolutionLabelist.observeField("itemSelected", "changeResolutionTrack")
end sub


function changeResolutionTrack()
    if m.top.content <> invalid and m.top.content.resolutions_parsed <> invalid and m.resolutionLabelist.itemSelected <> invalid and m.top.content.resolutions_parsed.getchild(m.resolutionLabelist.itemSelected) <> invalid and m.top.content.resolutions_parsed.getchild(m.resolutionLabelist.itemSelected).url <> invalid
        m.video.control = "stop"
        m.PlayerTask = invalid
        m.top.content.URL = m.top.content.resolutions_parsed.getchild(m.resolutionLabelist.itemSelected).url
        content = m.top.content
        if content <> invalid then
            m.video.content = content
            m.PlayerTask = CreateObject("roSGNode", "PlayerTask")
            m.PlayerTask.isTrackChange = true
            m.PlayerTask.observeField("state", "taskStateChanged")
            m.PlayerTask.observeField("isFinished", "onPlayerStateChanged")
            m.PlayerTask.video = m.video
            m.PlayerTask.skipAd = m.top.skipAd 
            m.PlayerTask.watched_duration = m.video.position 
            m.PlayerTask.control = "RUN"
        end if
    end if
    m.video.visible = true
    m.resolutionLbllist_rect.visible = false
end function


sub speedLabelistInitialise()
    m.speedLbllist_rect = m.top.findNode("speedLbllist_rect")
    m.speedLbllist_rect.visible = false
    m.speedLbl = m.top.findNode("speed_Lbl")
    m.speedLabelist = m.top.findNode("speed_labellist")
    m.speedLabelist.focusBitmapBlendColor = getButtonSelectionColor()
    m.speedLabelist.focusFootprintBlendColor = getButtonSelectionColor()
    m.speedLabelist.observeField("itemSelected", "changeSpeedTrack")

    speedOptions = [
        { title: "0.25x", value: 0.25, id: "0.25x" },
        { title: "0.5x", value: 0.5, id: "0.5x" },
        { title: "0.75x", value: 0.75, id: "0.75x" },
        { title: "Normal", value: 1.0, id: "Normal" },
        { title: "1.25x", value: 1.25, id: "1.25x" },
        { title: "1.5x", value: 1.5, id: "1.5x" },
        { title: "1.75x", value: 1.75, id: "1.75x" },
        { title: "2x", value: 2.0, id: "2x" }
    ]

    speedContentNode = CreateObject("RoSGNode", "ContentNode")
    for each speedOption in speedOptions
        itemContentNode = CreateObject("RoSGNode", "ContentNode")
        itemContentNode.title = speedOption.title
        itemContentNode.id = speedOption.id
        itemContentNode.addFields({
            value: speedOption.value
        })
        speedContentNode.appendChild(itemContentNode)
    end for

    m.speedLabelist.content = speedContentNode
end sub

sub changeSpeedTrack()
    selectedSpeed = m.speedLabelist.content.getChild(m.speedLabelist.itemSelected).value

    m.video.playbackSpeed = selectedSpeed
    m.video.control = "stop"
    m.PlayerTask = invalid
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.PlayerTask = CreateObject("roSGNode", "PlayerTask")
        m.PlayerTask.isTrackChange = true
        m.PlayerTask.observeField("state", "taskStateChanged")
        m.PlayerTask.observeField("isFinished", "onPlayerStateChanged")
        m.PlayerTask.video = m.video
        m.PlayerTask.skipAd = m.top.skipAd 
        m.PlayerTask.watched_duration = m.video.position 
        m.PlayerTask.control = "RUN"
    end if
    m.video.visible = true
    m.speedLbllist_rect.visible = false
end sub




function onCommentsClosed()
    ?"onCommentsClosed called"
    m.comments.visible = false
    m.video_expand_animation.control = "start"
    m.video.setFocus(true)
end function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function initialisePlayerBottomPopup()
    m.player_overlay_rect = m.top.findNode("player_overlay_rect")
    m.player_overlay_rect.observeField("visible", "onPlayerOverlayRectVisibleChanged")
    m.buttonsRowlist = m.top.findNode("buttonsRowlist")
    m.buttonsRowlist.observeField("RowItemSelected", "onbuttonsRowlistItemSelected")
    m.overlayRowlist = m.top.findnode("overlayRowlist")
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Poppins-Bold.ttf"
    font.size = 24
    font.color = getTextColor()
    m.overlayRowlist.rowLabelFont = font
    m.overlayRowlist.color = "#FFFFFF"
    m.overlayRowlist.focusBitmapBlendColor = "#FFFFFF"
    m.overlayRowlist.rowLabelColor = "#FFFFFF"
    m.overlayRowlist.observeField("RowItemSelected", "onOverlayRowlistRowItemSelected")
    m.player_overlay_open_animation = m.top.findnode("player_overlay_open_animation")
    m.player_overlay_hide_animation = m.top.findnode("player_overlay_hide_animation")

    m.playNextnode = createObject("RoSGNode", "ContentNode")
    m.playNextnode.id = "Play_next"
    m.playNextnode.title = "Play next"
 
    m.playNextnode.addField("FHDItemWidth", "float", false)
    m.playNextnode.addFields({ "isIconNode": true })
    m.playNextnode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.playNextnode.HDLISTITEMICONURL = "pkg:/images/icons/play_next.png"
        m.playNextnode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/play_next.png"
    end if
    m.playNextnode.blendColor = getTextColor()

    m.playPreviousNode = createObject("RoSGNode", "ContentNode")
    m.playPreviousNode.id = "Play_previous"
    
        m.playPreviousNode.title = "Play Previous"

    m.playPreviousNode.addField("FHDItemWidth", "float", false)
    m.playPreviousNode.addFields({ "isIconNode": true })
    m.playPreviousNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.playPreviousNode.HDLISTITEMICONURL = "pkg:/images/icons/play_previous.png"
        m.playPreviousNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/play_previous.png"
    end if
    m.playPreviousNode.blendColor = getTextColor()



    m.startOverNode = createObject("RoSGNode", "ContentNode")
    m.startOverNode.id = "START_OVER"
    
        m.startOverNode.title =getText("start_over")
  
    if not getTheme() = "LIGHT"
        m.startOverNode.HDLISTITEMICONURL = "pkg:/images/icons/startOver.png"
        m.startOverNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/startOver.png"
    end if
    m.startOverNode.addField("FHDItemWidth", "float", false)
    m.startOverNode.addFields({ "isIconNode": true, "watched_duration": 0 })
    m.startOverNode.FHDItemWidth = 70



    m.languageNode = createObject("RoSGNode", "ContentNode")
    m.languageNode.id = "Language"
    
        m.languageNode.title =getText("select_language")
   
    m.languageNode.addField("FHDItemWidth", "float", false)
    m.languageNode.addFields({ "isIconNode": true })
    m.languageNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.languageNode.HDLISTITEMICONURL = "pkg:/images/icons/Language.png"
        m.languageNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/global.png"
    end if
    m.languageNode.blendColor = getTextColor()



    m.multiResolutionNode = createObject("RoSGNode", "ContentNode")
    m.multiResolutionNode.id = "MultiResolution"
   
        m.multiResolutionNode.title = "Resolution"

    m.multiResolutionNode.addField("FHDItemWidth", "float", false)
    m.multiResolutionNode.addFields({ "isIconNode": true })
    m.multiResolutionNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.multiResolutionNode.HDLISTITEMICONURL = "pkg:/images/icons/hd_icon.png"
        m.multiResolutionNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/hd_icon.png"
    end if
    m.multiResolutionNode.blendColor = getTextColor()


    commentsNode = createObject("RoSGNode", "ContentNode")
    commentsNode.id = "Comments"
    
        commentsNode.title = getText("comments")

    commentsNode.addField("FHDItemWidth", "float", false)
    commentsNode.addFields({ "isIconNode": true })
    commentsNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        commentsNode.HDLISTITEMICONURL = "pkg:/images/icons/comment.png"
        commentsNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/comment.png"
    end if
    commentsNode.blendColor = getTextColor()



    speedNode = createObject("RoSGNode", "ContentNode")
    speedNode.id = "Speed"
    
        speedNode.title = "Speed"
   
    speedNode.addField("FHDItemWidth", "float", false)
    speedNode.addFields({ "isIconNode": true })
    speedNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        speedNode.HDLISTITEMICONURL = "pkg:/images/icons/clock.png"
        speedNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/clock.png"
    end if
    speedNode.blendColor = getTextColor()


    m.goAdsFreeNode = createObject("RoSGNode", "ContentNode")
    m.goAdsFreeNode.id = "go_ads_free"
   
        m.goAdsFreeNode.title = getText("go_ads_free")
   
    m.goAdsFreeNode.addField("FHDItemWidth", "float", false)
    m.goAdsFreeNode.addFields({ "isIconNode": false })
    m.goAdsFreeNode.FHDItemWidth = backgroundPosterLength(Len(m.goAdsFreeNode.title))
    if not getTheme() = "LIGHT"
        m.goAdsFreeNode.HDLISTITEMICONURL = "pkg:/images/icons/ad_free.png"
        m.goAdsFreeNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/ad_free.png"
    end if
    m.goAdsFreeNode.blendColor = getTextColor()


    m.watchedNode = createObject("RoSGNode", "ContentNode")
    m.watchedNode.id = "Watched"
    m.watchedNode.addField("FHDItemWidth", "float", false)
    m.watchedNode.addFields({ "isIconNode": true })
    m.watchedNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.watchedNode.HDLISTITEMICONURL = "pkg:/images/icons/eye.png"
        m.watchedNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/eye.png"
    end if
    m.watchedNode.blendColor = getTextColor()


    m.unwatchedNode = createObject("RoSGNode", "ContentNode")
    m.unwatchedNode.id = "Unwatched"
    m.unwatchedNode.addField("FHDItemWidth", "float", false)
    m.unwatchedNode.addFields({ "isIconNode": true })
    m.unwatchedNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.unwatchedNode.HDLISTITEMICONURL = "pkg:/images/icons/eye_crossed.png"
        m.unwatchedNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/eye_crossed.png"
    end if
    m.unwatchedNode.blendColor = getTextColor()


    m._playerMenuContent = CreateObject("roSGNode", "ContentNode")
    m.playerMenuContent = CreateObject("roSGNode", "ContentNode")
    m._playerMenuContent.appendChild(m.playerMenuContent)

    if getCommentsRequired() = "true"
        m.playerMenuContent.appendChild(commentsNode)
    else
        ?"no comment icon added"
    end if
  
    m.playerMenuContent.appendChild(speedNode)
    m.buttonsRowlist.content = m._playerMenuContent
    
end function

function onbuttonsRowlistItemSelected()
    ?"onbuttonsRowlistItemSelected called : player"
    
    selectedItemId = m.buttonsRowlist.content.getchild(0).getchild(m.buttonsRowlist.RowItemselected[1]).id
    if selectedItemId = "Comments"
        m.comments.visible = true
        m.video_shrink_animation.control = "start"
        m.buttonsRowlist.setFocus(true)
        m.comments.aquireFocus = true
    else if selectedItemId = "Language"
        if m.languageLabelist.content.getchildcount() > 0
            showLanguageLabelist()
        end if
    else if selectedItemId = "Play_next"
        if m.overlayRowlist.content <> invalid and m.overlayRowlist.content.getChild(0) <> invalid and m.overlayRowlist.content.getChild(0).getChild(0) <> invalid and m.overlayRowlist.content.getChild(0).getChild(0).video_id <> invalid
            exitPlayer()
       
            currentVideoId = m.video.content.video_id
            for i = 0 to m.overlayRowlist.content.getChild(0).getChildCount() - 1
                if m.overlayRowlist.content.getChild(0).getChild(i).video_id = currentVideoId and i + 1 < m.overlayRowlist.content.getChild(0).getChildCount()
                    m.top.new_videoId = m.overlayRowlist.content.getChild(0).getChild(i + 1).video_id
                    exit for
                end if
            end for
            ?"ddf"
        end if
    else if selectedItemId = "Play_previous"
        if m.top.previous_videoId <> invalid and m.top.previous_videoId <> ""
            exitPlayer()
            currentVideoId = m.video.content.video_id
            ?currentVideoId
            ?"currentVideoIdss"
            for i = 0 to m.overlayRowlist.content.getChild(0).getChildCount() - 1
                if m.overlayRowlist.content.getChild(0).getChild(i).video_id = currentVideoId and i - 1 >= 0
                    m.top.previous_videoId = m.overlayRowlist.content.getChild(0).getChild(i - 1).video_id
                    ?m.top.previous_videoId
                    ?"m.top.previous_videoIdeewew"
                    m.top.new_videoId = m.top.previous_videoId
                    exit for
                end if
            end for


        end if
    else if selectedItemId = "MultiResolution"
        if m.resolutionLabelist.content.getchildcount() > 1
            m.resolutionLbllist_rect.visible = true
            m.resolutionLabelist.setFocus(true)
        end if
    else if selectedItemId = "Speed"
        m.speedLbllist_rect.visible = true
        m.speedLabelist.setFocus(true)
    else if selectedItemId = "START_OVER"
        m.video.seek = 0
        ?"start_over clicked"
    else if selectedItemId = "Watched"
        m.MarkCompletedTask = CreateObject("roSGNode", "MarkCompletedTask")
        m.MarkCompletedTask.isCompletedBoolean = true
        m.MarkCompletedTask.calendarId = m.top.content.calendarId
        m.MarkCompletedTask.observeField("completedContent", "onCompletedContent")
        m.MarkCompletedTask.callFunc("runMarkCompletedTask", "")

    else if selectedItemId = "go_ads_free"
        m.top.action_command = "GO_ADS_FREE"
        exitPlayer()

    else if selectedItemId = "Unwatched"

    end if
   
end function

function onCompletedContent()
    if m.MarkCompletedTask.completedContent = true
       
    else

    end if
end function

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

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub callSimilarShows(currentVideoId)
    ?"callSimilarShows called"
    m.similarShowsTask = CreateObject("roSGNode", "SimilarShows")
    m.similarShowsTask.observeField("similarShowsApiListContent", "onSimilarShowsResponse")
    m.similarShowsTask.show_id = currentVideoId
    m.similarShowsTask.callFunc("runSimilarShowsTask", "")
end sub

sub onSimilarShowsResponse()
    m.similarShowsTask.callFunc("stopSimilarShowsTask", "")
    m.similarShowsTask.unobserveField("similarShowsApiListContent")
    if m.similarShowsTask.similarShowsApiListContent <> invalid
        ' ?"m.similarShowsTask.similarShowsApiListContentfdffd: ";m.similarShowsTask.similarShowsApiListContent
        m.overlayRowlist.content = m.similarShowsTask.similarShowsApiListContent
        if m.video.content <> invalid and m.video.content.video_id <> invalid
            callGetRelatedPlaylists(m.video.content.video_id)
        end if
    end if
end sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Function: callGetRelatedPlaylists
' Summary: Initiates a task to fetch related playlists for a given video ID and sets up an observer for the response.
' Parameters:
'   videoId - The ID of the video for which related playlists are to be fetched.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub callGetRelatedPlaylists(videoId)
    ?"344kjkjkkj"
    m.getVideoDetailsTask = CreateObject("roSGNode", "GetVideoDetailsTask")
    m.getVideoDetailsTask.observeField("playListVideosParsed", "onVideoDetailsResponse")
    m.getVideoDetailsTask.videoID = videoId
    m.getVideoDetailsTask.callFunc("runGetVideoDetailsTask", m.video.content.show_id_playlist)
end sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Function: onVideoDetailsResponse
' Summary: Handles the response from the GetVideoDetailsTask, stops the task, and updates the overlay row list with the
'          fetched playlist videos if available.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub onVideoDetailsResponse()
    m.getVideoDetailsTask.callFunc("stopGetVideoDetailsTask", "")
    m.getVideoDetailsTask.unobserveField("playListVideosParsed")
    if m.getVideoDetailsTask.videoDetailsResponse <> invalid
        ?"m.getVideoDetailsTask.playListVideosParsed.getchildcount(): ";m.getVideoDetailsTask.playListVideosParsed.getchildcount()
        if m.getVideoDetailsTask.playListVideosParsed <> invalid and m.getVideoDetailsTask.playListVideosParsed.getchildcount() > 0
            m.overlayRowlist.content.insertChild(m.getVideoDetailsTask.playListVideosParsed.getChild(0), 0)
            m.playerMenuContent.insertChild(m.playNextnode, 0)
            if m.top.previous_videoId <> invalid and m.top.previous_videoId <> ""
                m.playerMenuContent.insertChild(m.playPreviousNode, 0)
            end if
        end if
        ' if m.getVideoDetailsTask.resolutions_parsed <> invalid and m.getVideoDetailsTask.resolutions_parsed.getchildcount() > 0
        '     m.resolutionLabelist.content = m.getVideoDetailsTask.resolutions_parsed
        ' end if
    else
    end if
end sub

' Handles the selection of an item in the overlay row list
sub onOverlayRowlistRowItemSelected()
    selectedItem = m.overlayRowlist.content.getChild(m.overlayRowlist.rowItemSelected[0]).getChild(m.overlayRowlist.rowItemSelected[1])
    if selectedItem.itemType = "videos"
        exitPlayer()
        m.top.new_videoId = selectedItem.video_id.ToStr()
    else if selectedItem.itemType = "shows"
        m.top.stop_upNext_timer = true
        m.loading = m.top.CreateChild("Loading")
        m.loading.visible = true
        callGetShowDetailsApi(selectedItem.show_id.ToStr())
    end if
end sub

sub callGetShowDetailsApi(showId)
    m.getShowDetailsTask = CreateObject("roSGNode", "GetShowDetailsTask")
    m.getShowDetailsTask.observeField("showDetailsResponse", "onShowDetailsResponse")
    m.getShowDetailsTask.showID = showId
    m.getShowDetailsTask.callFunc("runGetShowDetailsTask", "")
end sub

'/**
' * Handles the response from the show details task.
' * Stops the show details task and unobserves the "showDetailsResponse" field.
' * If the response is valid and contains a valid video ID, exits the player and sets the new video ID.
' */
sub onShowDetailsResponse()
    m.getShowDetailsTask.callFunc("stopGetShowDetailsTask", "")
    m.getShowDetailsTask.unobserveField("showDetailsResponse")

    if m.getShowDetailsTask.showDetailsResponse <> invalid
        selectedItem = m.overlayRowlist.content.getChild(m.overlayRowlist.rowItemSelected[0]).getChild(m.overlayRowlist.rowItemSelected[1])
        m.top.you_may_also_like_show_id = selectedItem.show_id.ToStr()
        ? m.top.you_may_also_like_show_id
        ?" m.top.you_may_also_like_show_id"
        if m.getShowDetailsTask <> invalid and m.getShowDetailsTask.showDetailsResponse <> invalid and m.getShowDetailsTask.showDetailsResponse.videos <> invalid and m.getShowDetailsTask.showDetailsResponse.videos[0] <> invalid and m.getShowDetailsTask.showDetailsResponse.videos[0].videos <> invalid and m.getShowDetailsTask.showDetailsResponse.videos[0].videos[0] <> invalid and m.getShowDetailsTask.showDetailsResponse.videos[0].videos[0].video_id <> invalid
            exitPlayer()
            m.top.new_videoId = m.getShowDetailsTask.showDetailsResponse.videos[0].videos[0].video_id
        else if m.getShowDetailsTask <> invalid and m.getShowDetailsTask.showDetailsResponse <> invalid and m.getShowDetailsTask.showDetailsResponse.videos <> invalid and m.getShowDetailsTask.showDetailsResponse.videos[0] <> invalid and m.getShowDetailsTask.showDetailsResponse.videos[0].video_id <> invalid
            exitPlayer()
            m.top.new_videoId = m.getShowDetailsTask.showDetailsResponse.videos[0].video_id
        end if
    else
    end if
end sub

'/**
' * This function is called when the dialog showing time occurs.
' * It hides various UI elements such as player overlay, comments, speed label list,
' * language label list, and resolution label list. It also starts the player overlay
' * hide animation and clears the content of the overlay row list.
' */
sub onUpnextScreenFinishedShowing()
    ?"onUpnextScreenFinishedShowing called"
    m.player_overlay_rect.visible = false
    m.comments.visible = false
    m.speedLbllist_rect.visible = false
    m.languageLbllist_react.visible = false
    m.resolutionLbllist_rect.visible = false
    ' m.player_overlay_hide_animation.control = "start"
    m.overlayRowlist.content = invalid
end sub

sub onPlayerOverlayRectVisibleChanged()
    if m.player_overlay_rect.visible = true then
        m.player_overlay_open_animation.control = "start"
        ' Start a timer for 5 seconds
        if m.overlayHideTimer = invalid then
            m.overlayHideTimer = CreateObject("roSGNode", "Timer")
            m.overlayHideTimer.duration = 5
            m.overlayHideTimer.observeField("fire", "onOverlayHideTimerFired")
        end if
        m.overlayHideTimer.control = "start"
    else
        m.player_overlay_hide_animation.control = "start"
        ' Stop the timer if overlay is hidden manually
        if m.overlayHideTimer <> invalid then
            m.overlayHideTimer.control = "stop"
        end if
    end if
end sub

sub onOverlayHideTimerFired()
    ' Only hide if neither overlayRowlist nor buttonsRowlist has focus
    if (m.overlayRowlist.hasFocus() <> true and m.buttonsRowlist.hasFocus() <> true) then
        m.player_overlay_rect.visible = false
    end if
end sub

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
    return 60 + (inputValue - 1) * 18
end function