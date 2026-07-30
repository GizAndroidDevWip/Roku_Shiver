

sub init()
    ?"init called : Player.brs ...."
    m.video = m.top.findNode("VideoPlayer")
    m.video.observeField("state", "onVideoPlayerStateChanged")
    m.playerOverlayPoster = m.top.findNode("playerOverlayPoster")
    m.CornerRoundedforHomeScene = m.top.findNode("CornerRoundedforHomeScene")
    m.CornerRoundedforHomeScene.blendColor = getBackGroundColor()
    m.slideUp = m.top.findNode("slideUp")
    m.slideDown = m.top.findNode("slideDown")
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")
    m.buttonsRowlist = m.top.findNode("buttonsRowlist")
    m.buttonsRowlist.observeField("RowItemSelected", "onbuttonsRowlistItemSelected")

    m.label = m.top.findNode("label")
    m.label.font.size = 50

    m.PlayerTask = CreateObject("roSGNode", "PlayerTaskForShorts")
    m.PlayerTask.observeField("state", "taskStateChanged")
    m.PlayerTask.observeField("isFinished", "onPlayerStateChanged")



    m.moreEpisodesNode = createObject("RoSGNode", "ContentNode")
    m.moreEpisodesNode.id = "MORE_EPISODES"

    m.moreEpisodesNode.title = getText("episodes")

    m.moreEpisodesNode.addField("FHDItemWidth", "float", false)
    m.moreEpisodesNode.addFields({ "isIconNode": true })
    m.moreEpisodesNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.moreEpisodesNode.HDLISTITEMICONURL = "pkg:/images/more_image.png"
        m.moreEpisodesNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/more_image.png"
    end if
    m.moreEpisodesNode.blendColor = getTextColor()


    m.detailsNode = createObject("RoSGNode", "ContentNode")
    m.detailsNode.id = "GOTO_MICRO_DRAMA_DETAILS_PAGE"

    m.detailsNode.title = getText("details")

    m.detailsNode.addField("FHDItemWidth", "float", false)
    m.detailsNode.addFields({ "isIconNode": true })
    m.detailsNode.FHDItemWidth = 70
    if not getTheme() = "LIGHT"
        m.detailsNode.HDLISTITEMICONURL = "pkg:/images/more_image.png"
        m.detailsNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/more_image.png"
    end if
    m.detailsNode.blendColor = getTextColor()



    m._playerMenuContent = CreateObject("roSGNode", "ContentNode")
    m.playerMenuContent = CreateObject("roSGNode", "ContentNode")
    m._playerMenuContent.appendChild(m.playerMenuContent)
    m.playerMenuContent.appendChild(m.moreEpisodesNode)
    m.playerMenuContent.appendChild(m.detailsNode)

    m.buttonsRowlist.content = m._playerMenuContent


    m.SubscribeOverlay = m.top.findNode("SubscribeOverlay")
    m.episode_title = m.top.findNode("episode_title")
    m.episode_title.font.size = 60
    m.episode_title.color = getButtonSelectionColor()
    m.sub_overlay_title = m.top.findNode("sub_overlay_title")
    m.sub_overlay_desc = m.top.findNode("sub_overlay_desc")
    m.bgPoster = m.top.findNode("bgPoster")
    m.subscribeText = m.top.findNode("subscribeText")
    m.subscribeButton = m.top.findNode("subscribeButton")

    m.CoinSubscriptionsList = m.top.findNode("CoinSubscriptionsList")
    m.CoinSubscriptionsList.observeField("itemSelected", "onCoinSubscriptionItemSelected")
end sub

'***when manually started or stopped the palyer
sub controlChanged()
    ?"controlChanged called"
    ?m.top.control
    ?m.top.content

    control = m.top.control
    if control = "play" then
        playContent()
    else if control = "stop" then
        exitPlayer()
    end if
end sub

sub playContent()
    ?"playContent calledfsdfdsfsdfsdf"
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.video.visible = true
        m.dialogbg_rect.visible = true
        m.label.text = content.title
        m.label.visible = true
        if m.video.content.streamformat = "NONE" then m.video.content.streamformat = "m3u8"

        m.playerOverlayPoster.uri = content.hdposterurl
        m.playerOverlayPoster.visible = true
        m.PlayerTask.video = m.video
        m.PlayerTask.skipAd = m.top.skipAd 'setting skipAd value to playertask
        m.PlayerTask.watched_duration = m.top.watched_duration 'setting watched_duration value to playertask
        m.PlayerTask.control = "STOP"
        m.PlayerTask.control = "RUN"
        ' m.bgPoster.uri = content.logo
        ?m.video.content
        ?"m.video.content"
        ?m.video.state
        ?m.video
    end if
end sub

sub exitPlayer()
    m.video.control = "stop"
    m.video.visible = false
    ' m.PlayerTask = invalid
    m.top.state = "done"
    m.top.visibility = false
    m.PlayerTask.control = "STOP"
end sub

sub taskStateChanged(event1 as object)
    ' ?"taskStateChanged called ";m.video.state
    state = event1.GetData()
    m.top.playerState = m.video.state'm.top.getchild(0).state '***bringing the playerstate status to player from playertask
    if state = "done" or state = "stop" or state = "finished"
        exitPlayer()
        sec = CreateObject("roRegistrySection", getAppKey())
    end if
end sub


'***this is used for autoplay in show page
sub onPlayerStateChanged()
    ' m.top.playerState = "stop" or m.top.playerState = "finished" or m.top.playerState = "back_pressed"
    m.top.closethispage = "true"
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not IsNotNull2(m.top.content) and not key = "back" and m.SubscribeOverlay.visible <> true then return true
    ' if isNotNull2(m.CoinSubscriptionsList) and m.CoinSubscriptionsList.isInFocusChain() and not key = "back" and not key = "OK" then return true
    if press
        if key = "back"
            m.video.visible = true
            m.video.setFocus(true)
            m.top.playerState = "back_pressed"
            exitPlayer()

        else if key = "up"
            ' if m.top.content <> invalid and m.top.content.is_previous_video_subscribed <> invalid and m.top.content.is_previous_video_subscribed <> false
            '     m.playerOverlayPoster.visible = true
            '     m.slideDown.control = "start"
            '     return false
            ' end if
            return false
        else if key = "down"
            ' if m.top.content <> invalid and m.top.content.is_next_video_subscribed <> invalid and m.top.content.is_next_video_subscribed <> false
            '     m.slideUp.control = "start"
            '     m.playerOverlayPoster.visible = true
            '     return false
            ' end if
            return false
        else if key = "right"
            if m.buttonsRowlist.hasFocus() = false and m.SubscribeOverlay.visible = false
                m.buttonsRowlist.setFocus(true)
                return true
            else if m.SubscribeOverlay.visible = true and m.SubscribeOverlay.isInFocusChain()
                m.buttonsRowlist.setFocus(true)
                return true
            end if
            return false
        else if key = "left"
            if m.buttonsRowlist.hasFocus() = true and m.SubscribeOverlay.visible = false
                m.buttonsRowlist.setFocus(false)
                m.video.setFocus(true)
            else if m.SubscribeOverlay.visible = true and m.CoinSubscriptionsList.content.getChildCount() > 0 and m.buttonsRowlist.isInFocusChain()
                m.CoinSubscriptionsList.setFocus(true)
            end if
            return false
        else if key = "OK"
            if m.SubscribeOverlay.visible = true
                m.top.menuButtonSelected = "BUNDLE_SUBSCRIPTION_OVERLAY"
            end if
        end if
    else
        if key = "OK"
            ' if m.buttonsRowlist.hasFocus() = false
            '     m.buttonsRowlist.setFocus(true)
            ' end if

            return false
        else if key = "right"
            if m.buttonsRowlist.hasFocus() = false and m.SubscribeOverlay.visible = false
                m.buttonsRowlist.setFocus(true)
            end if
            return false
        else if key = "left"
            if m.buttonsRowlist.hasFocus() = true
                m.video.setFocus(true)
            end if
            return false
        end if
    end if
    return true
end function


sub onVideoPlayerStateChanged()
    ' ?"onVideoPlayerStateChanged called: playerforMicroDrama.brs"
    ' ?m.video.state
    ' ?"is_last_video ";m.video.is_last_video
    if m.video.state = "playing"
        m.playerOverlayPoster.visible = false
        m.playerOverlayPoster.uri = ""
    else if m.video.state = "finished"
        m.top.playerState = "finished"
        ' if m.top.content <> invalid and m.top.content.is_next_video_subscribed <> invalid and m.top.content.is_next_video_subscribed  = false then return
        ' playContent()
    end if
end sub

sub onbuttonsRowlistItemSelected()
    ?"onbuttonsRowlistItemSelected called"
    m.CoinSubscriptionsList.content = m.top.CoinSubscriptionContent
    ' if m.SubscribeOverlay.visible = true
    '     m.top.menuButtonSelected = "SUBSCRIBE_OVERLAY"
    '     return
    ' end if
    if m.buttonsRowlist.content <> invalid and m.buttonsRowlist.content.getchild(0) <> invalid and m.buttonsRowlist.RowItemSelected <> invalid and m.buttonsRowlist.RowItemSelected[0] <> invalid and m.buttonsRowlist.content.getchild(0).getChild(m.buttonsRowlist.RowItemSelected[0]) <> invalid then
        m.top.menuButtonSelected = m.buttonsRowlist.content.getchild(0).getChild(m.buttonsRowlist.RowItemSelected[1]).id
        exitPlayer()
    end if
end sub

sub setFocusToSpecificNodeChanged()
    ?"setFocusToSpecificNodeChanged called"
    if m.top.setFocusToSpecificNode = "VIDEO_PLAYER"
        m.video.setFocus(true)
    else if m.top.setFocusToSpecificNode = "BUTTONS_ROWLIST"
        m.buttonsRowlist.setFocus(true)
    end if
end sub

sub onShowSubscribeOverlayChanged()
    ?"onShowSubscribeOverlayChanged called"
    loadSubscriptionsFromJson(m.top.CoinSubscriptionContent)
    if IsNotNull2(m.top.playerContentThatWeResets) and IsNotBlank2(m.top.playerContentThatWeResets.title)
        m.episode_title.text = getTextOf("episode") + " - " + m.top.playerContentThatWeResets.title
    else
        m.episode_title.text = ""
    end if
    m.sub_overlay_title.text = getText("choose_subscription")

    ' m.sub_overlay_title.text = getText("choose_subscription")
    m.sub_overlay_desc.text = getText("choose_how_to_watch")
    if m.top.showSubscribeOverlay = true
        m.SubscribeOverlay.visible = true
        if IsNotNull2(m.top.playerContentThatWeResets) then m.label.text = m.top.playerContentThatWeResets.title
    else
        m.SubscribeOverlay.visible = false
    end if
end sub

sub loadSubscriptionsFromJson(subscriptionData as object)
    m.CoinSubscriptionsList.setFocus(true)


    if subscriptionData <> invalid

        ' Create the root container
        rootNode = CreateObject("roSGNode", "ContentNode")

        for each item in subscriptionData
            option = rootNode.CreateChild("ContentNode")

            ' Map basic fields directly from JSON
            option.title = item.button_name
            option.description = item.description

            ' Add a custom field to store the item type/ID for your click handlers later
            option.addFields({
                "consumptionType": item.consumption_type,
                "type": item.type,
                "videoId": item.video_id,
                "checkout_qr": item.checkout_qr
            })

            ' Dynamically assign graphics and colors based on the data type
            if item.consumption_type = "UNLOCK"
                option.addFields({
                    "HDPosterUrl": "pkg:/images/icons/lock2.png",
                    "shortDescriptionLine1": item.tokens_required.ToStr(),
                    "backgroundBlendColor": "#FFFFFF",
                    "iconBgBlendColor": "#da4c59",
                    "showArrow": false
                })

            else if item.consumption_type = "PER_VIEW"
                option.addFields({
                    "HDPosterUrl": "pkg:/images/icons/eye.png",
                    "shortDescriptionLine1": item.tokens_required.ToStr(),
                    "backgroundBlendColor": "#FFFFFF",
                    "iconBgBlendColor": "#f8b321",
                    "showArrow": false
                })

            else if item.type = "subscription" or item.button_name = "Go Premium"
                option.addFields({
                    "HDPosterUrl": "pkg:/images/icons/crown.png",
                    "shortDescriptionLine1": "",
                    "backgroundBlendColor": "#EE4B2B",
                    "iconBgBlendColor": "#E84C57",
                    "showArrow": true
                })
            else
                option.addFields({
                    "HDPosterUrl": "pkg:/images/icons/lock2.png",
                    "shortDescriptionLine1": item.tokens_required.ToStr(),
                    "backgroundBlendColor": "#FFFFFF",
                    "iconBgBlendColor": "#da4c59",
                    "showArrow": false
                })
            end if
        end for

        ' Assign the dynamic tree to the MarkupGrid
        m.CoinSubscriptionsList.content = rootNode
    end if
end sub

sub onCoinSubscriptionItemSelected()
    ?"onCoinSubscriptionItemSelected called"
    if m.CoinSubscriptionsList.itemSelected <> invalid and m.CoinSubscriptionsList.content <> invalid and m.CoinSubscriptionsList.content.getChild(m.CoinSubscriptionsList.itemSelected) <> invalid then
        selectedItem = m.CoinSubscriptionsList.content.getChild(m.CoinSubscriptionsList.itemSelected)
        m.top.selectedSubscription = {
            "type": selectedItem.type,
            "videoId": selectedItem.video_id
        }
        m.top.menuButtonSelected = "SUBSCRIBE_OVERLAY_ITEM"
        exitPlayer()
    end if
end sub

sub onSetFocusToCoinListing()
    ?"onSetFocusToCoinListing called"
    if m.top.setFocusToCoinListing = true
        m.CoinSubscriptionsList.setFocus(true)
    end if
end sub