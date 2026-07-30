sub init()
    m.top.setFocus(true)
    m.currentPlayingIndex = 0
    m.currentPlayingIndexForEpisodeNumber = 0
    m.loading = m.top.findNode("loading")
    m.loading.visible = true
    m.mainVideoDataList = CreateObject("RoSGNode", "ContentNode")
    m.episodesBoxRowlist = m.top.findNode("episodesBoxRowlist")
    m.episodesBoxRowlist.observeField("RowItemSelected", "onbuttonsRowlistItemSelected")
    m.episodesBoxContainer = m.top.findNode("episodesBoxContainer")
    m.episodesBoxContainer.blendColor = getBackGroundColor1()
    m.episodesTitle = m.top.findNode("episodesTitle")
    m.episodesTitle.font.size = 60
    m.top.observeField("visible", "onSceneVisibleChange")
end sub

sub onSceneVisibleChange()
    ?"onSceneVisibleChange called: "; m.top.visible
    if m.top.visible = true
        if m.Player <> invalid
            onPageEnter()
            ' m.Player.setFocus(true)
        end if
    end if
end sub

' sub playSelectedShortsVideo() 'call ShortsDetailsTask
'     m.shortsDetailsTask = CreateObject("roSGNode", "ShortsDetailsTask")
'     m.shortsDetailsTask.observeField("shortsDetailsResponse", "addSelctedVideoToMainVideoDataList")
'     m.shortsDetailsTask.shortsID = m.top.playSelectedShortsVideo
'     m.shortsDetailsTask.callFunc("runShortsDetailsTask", "")
' end sub



' sub addSelctedVideoToMainVideoDataList() ' add one ShortsDetailsTask data/ selected video data to mainVideoDataList's 0th position and then proceed the rest normally
'     shortsDetailsResponse = m.shortsDetailsTask.shortsDetailsResponse
'     existingDataListCount = m.mainVideoDataList.getchildcount()

'     childDataNode = m.mainVideoDataList.createChild("ContentNode")
'     childDataNode.url = shortsDetailsResponse.url
'     childDataNode.title = shortsDetailsResponse.title
'     childDataNode.hdposterurl = shortsDetailsResponse.thumbnail
'     childDataNode.addFields({
'         "nodeIndex": existingDataListCount
'         "video_id": shortsDetailsResponse.video_id.ToStr()
'         "video_time": shortsDetailsResponse.video_time.ToStr()
'     })
'     callMicroDramaApi()
' end sub

sub callMicroDramaApi()
    m.MicroDramaApiTask = CreateObject("roSGNode", "MicroDramaApiTask")
    m.MicroDramaApiTask.observeField("MicroDramaApiTaskListStatus", "onSetData")
    m.MicroDramaApiTask.observeField("logInOrSubscribeStatus", "checkLoginCheck")
    m.MicroDramaApiTask.callFunc("stopMicroDramaApiTask")
    m.MicroDramaApiTask.callFunc("runMicroDramaApiTask", m.top.show_id)
end sub

sub onSetData()
    content = m.MicroDramaApiTask
    existingDataListCount = m.mainVideoDataList.getchildcount()
    resumeIndex = -1
    resumeVideoId = invalid



    if m.top.playSelectedShortsVideo <> invalid and m.top.playSelectedShortsVideo <> 0
        resumeVideoId = m.top.playSelectedShortsVideo ' when video is seldcted from any place like show details page , this logic works
    else if content <> invalid and content.MicroDramaApiTaskContent <> invalid and content.MicroDramaApiTaskContent.resume_video_id <> invalid and content.MicroDramaApiTaskContent.resume_video_id <> 0
        resumeVideoId = content.MicroDramaApiTaskContent.resume_video_id
    end if

    if content <> invalid and content.MicroDramaApiTaskContent <> invalid and content.MicroDramaApiTaskContent.data <> invalid and not content.MicroDramaApiTaskContent.data.count() = 0
        data = content.MicroDramaApiTaskContent.data
        for i = 0 to data.count() - 1
            showAds = false
            if ((existingDataListCount + i + 1) mod 4) = 0 'showing ad after every 4th video
                showAds = true
            end if
            childDataNode = m.mainVideoDataList.createChild("ContentNode")
            childDataNode.url = data[i].url ' "https://gizmeon.s.llnwi.net/wasabi/vod/PUB-50030/202405301717060253/playlist~480p.m3u8"
            childDataNode.title = data[i].title
            item = data[i]
            childDataNode.addFields({
                nodeIndex: existingDataListCount + i
                video_id: doNullCheck(item, "video_id", "").ToStr()
                video_time: doNullCheck(item, "video_time", "").ToStr()
                is_subscribed: doNullCheck(item, "subscribed", false)
                episode_number: doNullCheck(item, "episode_number", 0)
                like_count: doNullCheck(item, "like_count", 0)
                liked: doNullCheck(item, "liked", false)
                vanity_url: doNullCheck(item, "vanity_url", "")
                subscriptions: doNullCheck(item, "subscriptions", {})
                video_duration_seconds: doNullCheck(item, "video_duration_seconds", 0)
                subtitles: item.subtitles
                need_to_show_ads: showAds 'setting need_to_show_ads field
                is_last_video: (i = data.count() - 1) 'setting is_last_video field
                iswatchOnceSubscribed: false 'setting watchOnceSubscribed field
            })

            try
                if resumeVideoId <> invalid and data[i].video_id <> invalid and data[i].video_id.ToStr() = resumeVideoId.ToStr()
                    resumeIndex = existingDataListCount + i
                end if
            catch e
                resumeIndex = 0
            end try
        end for
    end if
    initializeEpisodeBoxRowList(content.MicroDramaApiTaskContent.data)
    if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchildcount() > 0
        if resumeIndex >= 0 and m.mainVideoDataList.getchild(resumeIndex) <> invalid
            playVideo(m.mainVideoDataList.getchild(resumeIndex))
        else
            playVideo(m.mainVideoDataList.getchild(0))
        end if
    end if

end sub



function doNullCheck(obj as object, key as string, def)

    if obj <> invalid and obj[key] <> invalid
        return obj[key]
    end if
    return def
end function


sub ShowInfoDialog(text)
    dialog = createObject("roSGNode", "Dialog")
    dialog.optionsDialog = true
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onInfoDialogOkButtonselected")
    dialog.message = text

    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

sub onInfoDialogOkButtonselected()
    m.parentScene.dialog.close = true
    if m.mainVideoDataList.getchild(m.currentPlayingIndex) <> invalid then
        goToSubscriptionListingScene(m.mainVideoDataList.getchild(m.currentPlayingIndex).video_id)
    end if
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

function OnkeyEvent(key, press) as boolean
    result = false
    if isNotNull2(m.Player) and m.Player.showSubscribeOverlay = true and key <> "up" and key <> "down" then return true ' BLOCK SCROLL when subscription overlay is visible
    if IsNotNull2(m.qrOverlay) and m.qrOverlay.visible = true then return true
    if press

        if m.episodesBoxRowlist.hasFocus() = true and not key = "back"
            return false ' Let the rowlist handle the key event
        end if

        ' if m.Player <> invalid and m.Player.showSubscribeOverlay = true
        '     if key = "OK" and m.mainVideoDataList <> invalid and m.currentPlayingIndex <> invalid
        '         node = m.mainVideoDataList.getChild(m.currentPlayingIndex)
        '         if node <> invalid then goToSubscriptionListingScene(node.video_id)
        '     end if

        '     return false ' Let the player handle the key event
        ' end if
        if key = "up"
            prevIndex = m.currentPlayingIndex - 1 ' blocking if previous is not subsribed. else play the previous vdideo
            prevNode = invalid
            if m.mainVideoDataList <> invalid and prevIndex >= 0 and prevIndex < m.mainVideoDataList.getChildCount()
                prevNode = m.mainVideoDataList.getChild(prevIndex)

                if prevNode <> invalid
                    ' if prevNode.is_subscribed = false
                    '     ?"Previous content is not subscribed, cannot play"
                    '     return true ' BLOCK SCROLL
                    ' end if
                    playVideo(prevNode)
                end if
            end if

        else if key = "down"

            nextIndex = m.currentPlayingIndex + 1 ' blocking if next is not subsribed. else play the next vdideo
            nextNode = invalid
            if m.mainVideoDataList <> invalid and nextIndex < m.mainVideoDataList.getChildCount()
                nextNode = m.mainVideoDataList.getChild(nextIndex)

                if nextNode <> invalid
                    ' if nextNode.is_subscribed = false
                    '     ?"Next content is not subscribed, cannot play"
                    '     return true ' BLOCK SCROLL
                    ' end if

                    playVideo(nextNode)
                end if
            end if
        else if key = "right"
            if m.Player <> invalid
                m.Player.setFocusToSpecificNode = "BUTTONS_ROWLIST"
            end if

        else if key = "back"
            if (m.Player <> invalid) and (m.Player.playerState = "stop" or m.Player.playerState = "finished" or m.Player.playerState = "back_pressed")
                m.top.closethispage = "true"
            end if
            if m.episodesBoxContainer.visible = true
                m.episodesBoxContainer.visible = false
                onPageEnter()
                if IsNotNull2(m.Player) then m.Player.setFocus(true)
                result = true ' BLOCK SCROLL
            end if
        else if key = "OK"
            ' if m.Player.showSubscribeOverlay = true
            '     ' if m.mainVideoDataList <> invalid and m.currentPlayingIndex <> invalid and m.mainVideoDataList.getchild(m.currentPlayingIndex) <> invalid and m.mainVideoDataList.getchild(m.currentPlayingIndex).video_id <> invalid then goToSubscriptionListingScene(m.mainVideoDataList.getchild(m.currentPlayingIndex).video_id)
            ' end if
        end if
    else
    end if
    return result
end function

sub checkLoginCheck()
    m.MicroDramaApiTask.callFunc("stopMicroDramaApiTask")
    if m.MicroDramaApiTask <> invalid and m.MicroDramaApiTask.logInOrSubscribeStatus <> invalid and m.MicroDramaApiTask.logInOrSubscribeStatus <> "" and m.MicroDramaApiTask.logInOrSubscribeStatus = "LOGIN"
        goToLandingScene()
        return
    end if
end sub

sub playVideo(inputContent)
    ?"dhkasjhajshd playVideo called with inputContent: "; inputContent
    if m.Player <> invalid
        m.Player.control = "stop"
        m.Player.showSubscribeOverlay = false
    end if
    m.currentPlayingIndex = inputContent.nodeIndex
    if inputContent = invalid
        return
    end if
    if m.MicroDramaApiTask <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent <> invalid
        if m.MicroDramaApiTask.MicroDramaApiTaskContent.is_logged_in <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.is_logged_in = false
            goToLandingScene()
            return
        end if

        if m.MicroDramaApiTask.MicroDramaApiTaskContent <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.logInOrSubscribeStatus <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.logInOrSubscribeStatus <> "" and m.MicroDramaApiTask.MicroDramaApiTaskContent.logInOrSubscribeStatus = "SUBSCRIBE"
            goToSubscriptionListingScene(inputContent.video_id)
        else if m.MicroDramaApiTask.MicroDramaApiTaskContent <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.logInOrSubscribeStatus <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.logInOrSubscribeStatus <> "" and m.MicroDramaApiTask.MicroDramaApiTaskContent.logInOrSubscribeStatus = "LOGIN"
            goToLandingScene()
            return
        end if
    end if

    if m.Player = invalid
        m.Player = m.top.CreateChild("PlayerForMicroDrama")
        m.Player.unObserveField("playerState")
        m.Player.unObserveField("menuButtonSelected")
        m.Player.unObserveField("visible")
        m.Player.unObserveField("selectedSubscription")
        m.Player.observeField("playerState", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
        m.Player.observeField("menuButtonSelected", "onMenuButtonSelected")
        m.Player.observeField("selectedSubscription", "onSelectedSubscriptionChange")
    end if

    if getSubscriptionRequired() = "true" then
        if inputContent <> invalid then
            isSubscribed = invalid
            if (inputContent.is_subscribed <> invalid)
                isSubscribed = inputContent.is_subscribed
            end if
            isLocked = invalid
            if (inputContent.isLocked <> invalid)
                isLocked = inputContent.isLocked
            end if

            if(IsNotNull2(isSubscribed) and (isSubscribed = false)) or (IsNotNull2(isLocked) and isLocked = true)
                if isguest() = "true" then
                    goToLandingScene()
                    return
                end if
                m.loading.visible = false
                ' ShowInfoDialog("Subscribe to watch this content.") testchange

                currentBalanceStr = getCurrentCoinBalance()
                currentBalance = currentBalanceStr.ToInt()
                if m.Player <> invalid
                    m.Player.playerContentThatWeResets = inputContent 'setting this field to reset player content when user comes back from subscription flow without subscribing
                    if inputContent.iswatchOnceSubscribed = true then
                        ?"Video already played with watch once subscription, dont need to reduce coins until next time"

                    else if IsNotNull2(inputContent.subscriptions) and inputContent.subscriptions.count() > 1 then 'show subscription options overlay if more than 1 subscription options are available for that content
                        m.Player.CoinSubscriptionContent = inputContent.subscriptions
                        m.Player.showSubscribeOverlay = true
                        return

                    else if IsNotNull2(inputContent.subscriptions) and IsNotNull2(inputContent.subscriptions[0].tokens_required) and inputContent.subscriptions.count() = 1 and currentBalance >= inputContent.subscriptions[0].tokens_required and inputContent.subscriptions[0].type <> "subscription" then
                        if inputContent <> invalid and inputContent.subscriptions <> invalid and inputContent.subscriptions[0] <> invalid 'subscription has only 1 item and that is bundle then play video and handle coins reduce logic
                            if inputContent.iswatchOnceSubscribed = false

                                reduceCoinsBalanceAfterPlaying(inputContent)
                            else
                                ?"Video already played with watch once subscription, dont need to reduce coins until next time"
                            end if
                        end if
                    else 'subscription has only one item and type is subscription - show subscription overlay
                        m.Player.CoinSubscriptionContent = inputContent.subscriptions
                        m.Player.showSubscribeOverlay = true
                        return
                    end if
                    m.Player.control = "stop"
                    m.Player.setFocus(true)
                end if
            else
                if m.Player <> invalid then m.Player.showSubscribeOverlay = false
            end if
        end if
    end if

    if m.Player <> invalid then m.Player.control = "stop"
    m.loading.visible = false



    m.currentPlayingIndexForEpisodeNumber = inputContent.episode_number
    ' NEXT
    nextNode_is_subscribed = true
    if m.mainVideoDataList <> invalid and m.mainVideoDataList.getChildCount() > 0 then
        if m.currentPlayingIndex <> invalid and (m.currentPlayingIndex + 1) < m.mainVideoDataList.getChildCount() then
            nextNode = m.mainVideoDataList.getChild(m.currentPlayingIndex + 1)
            if nextNode <> invalid then
                nextNode_is_subscribed = nextNode.is_subscribed
            end if
        end if
    end if

    ' PREVIOUS
    previousNode_is_subscribed = true
    if m.mainVideoDataList <> invalid and m.mainVideoDataList.getChildCount() > 0 then
        if m.currentPlayingIndex <> invalid and (m.currentPlayingIndex - 1) >= 0 then
            prevNode = m.mainVideoDataList.getChild(m.currentPlayingIndex - 1)
            if prevNode <> invalid then
                previousNode_is_subscribed = prevNode.is_subscribed
            end if
        end if
    end if
    ' m.playerOverlayPoster.uri = "https://gizmeon.mdc.akamaized.net/thumbnails/event/1717413318435.jpg"'inputContent.hdposterurl
    ' m.playerOverlayPoster.visible = true
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: inputContent.title,
        id: "",
        url: inputContent.url,
        ' url:"https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"'
        ad_url: "" '"https://devtools.web.roku.com/samples/sample.xml"
        ' ad_url: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=&ve=101",
        categories: "",
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }

    subtitle_config = inputContent.subtitles

    SubtitleTracks = []
    for each item in inputContent.subtitles
        subtitleItem = {}
        subtitleItem.Language = item.language_name
        subtitleItem.Description = item.short_code
        subtitleItem.TrackName = item.subtitle_url
        SubtitleTracks.push(subtitleItem)
    end for


    if(m.MicroDramaApiTask <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.show <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.show.logo <> invalid) then logo = m.MicroDramaApiTask.MicroDramaApiTaskContent.show.logo


    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "hdposterurl": inputContent.hdposterurl,
        "video_time": inputContent.video_time,
        "video_id": inputContent.video_id.ToStr(),
        "is_subscribed": inputContent.is_subscribed,
        "is_next_video_subscribed": nextNode_is_subscribed,
        "is_previous_video_subscribed": previousNode_is_subscribed,
        "is_live": "0" 'not live
        "logo": logo,
        "itemData": inputContent ' Pass the entire inputContent for further use
    })
    content.ClosedCaptions = true
    content.globalCaptionMode = "On"
    content.HDBranded = true
    content.IsHD = true

    if subtitle_config <> invalid
        content.ClosedCaptions = True
        content.globalCaptionMode = "On"
        content.HDBranded = True
        content.IsHD = True
        content.SubtitleConfig = subtitle_config
        content.SubtitleTracks = SubtitleTracks
        content.SubtitleTrack = SubtitleTracks
    end if

    m.Player.content = content
    m.Player.visible = true
    m.Player.skipAd = false
    m.Player.setFocus(true)
    m.Player.control = "play"
    ' m.Player.getchild(0).getchild(0).getchild(1).getchild(6).translation = [-500, 0]
    player = m.Player
    ' if player <> invalid and player.getChildCount() > 0
    '     c0 = player.getChild(0)
    '     if c0 <> invalid and c0.getChildCount() > 0
    '         c1 = c0.getChild(0)
    '         if c1 <> invalid and c1.getChildCount() > 1
    '             c2 = c1.getChild(1)
    '             if c2 <> invalid and c2.getChildCount() > 6
    '                 c3 = c2.getChild(6)
    '                 if c3 <> invalid
    '                     c3.translation = [-500, 0]
    '                 end if
    '             end if
    '         end if
    '     end if
    ' end if


    ' if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchildcount() <> invalid and inputContent.nodeIndex <> invalid and m.mainVideoDataList.getchildcount() - 3 = inputContent.nodeIndex
    '     callMicroDramaApi2()
    ' end if

    node = m.episodesBoxContainer
    parent = node.getParent()

    if parent <> invalid
        parent.removeChild(node)
        m.top.appendChild(node) 'adds it to top (front)
    end if

end sub

sub PlayerStateChanged()

    ?"PlayerStateChanged: microdramascene"; m.Player.playerState
    if m.Player.playerState = "playing"

    else if m.Player.playerState = "stop"or m.Player.playerState = "back_pressed"
        m.top.closethispage = "true"

    else if m.Player.playerState = "finished" ' or m.Player.playerState = "stopped"
        ' Play next video in the list
        if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchild(m.currentPlayingIndex + 1) <> invalid
            nextNode = m.mainVideoDataList.getchild(m.currentPlayingIndex + 1)
            ' if nextNode.is_subscribed = false
            '     ?"Next content is not subscribed  cannot play"
            '     return
            ' end if
            playVideo(nextNode)
        else
            if m.MicroDramaApiTask <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent <> invalid and m.MicroDramaApiTask.MicroDramaApiTaskContent.next_show_id <> invalid
                m.mainVideoDataList.removeChildrenIndex(m.mainVideoDataList.getChildCount(), 0)
                m.Player.control = "stop"
                m.top.show_id = m.MicroDramaApiTask.MicroDramaApiTaskContent.next_show_id
            end if
        end if

    end if
end sub



' sub callMicroDramaApi2()
'     m.microDramaApiTask2 = CreateObject("roSGNode", "MicroDramaApiTask")
'     m.MicroDramaApiTask2.observeField("MicroDramaApiTaskListStatus", "onAddData")
'     m.MicroDramaApiTask2.callFunc("runMicroDramaApiTask", m.top.show_id)
' end sub

' sub onAddData()
'     content = m.MicroDramaApiTask2
'     existingDataListCount = m.mainVideoDataList.getchildcount()
'     if content <> invalid and content.MicroDramaApiTaskContent <> invalid and not content.MicroDramaApiTaskContent.count() = 0
'         data = content.MicroDramaApiTaskContent
'         for i = 0 to data.count() - 1
'             childDataNode = CreateObject("RoSGNode", "ContentNode")
'             childDataNode.url = data[i].url ' "https://gizmeon.s.llnwi.net/wasabi/vod/PUB-50030/202405301717060253/playlist~480p.m3u8"
'             childDataNode.title = data[i].title
'             childDataNode.hdposterurl = data[i].thumbnail
'             childDataNode.addFields({
'                 "nodeIndex": existingDataListCount + i
'                 "video_id": data[i].video_id.ToStr()
'                 "video_time": data[i].video_time.ToStr()

'             })
'             m.mainVideoDataList.appendChild(childDataNode)
'         end for
'     end if
'     ?"hdajfjahgjfhdgjfd";existingDataListCount
' end sub

sub onMenuButtonSelected()
    ?"onMenuButtonSelected called: "; m.top.menuButtonSelected
    if m.Player <> invalid then m.Player.control = "stop"
    if m.Player.menuButtonSelected = "MORE_EPISODES"
        updateEpisodeActiveByEpisodeNumber(m.currentPlayingIndexForEpisodeNumber, true)
        m.episodesBoxContainer.visible = true
        m.episodesBoxRowlist.setFocus(true)

    else if m.Player.menuButtonSelected = "GOTO_MICRO_DRAMA_DETAILS_PAGE"
        m.top.goToShowDetailsPage = {
            show_id: m.top.show_id
            show_name: m.top.show_name
            itemType: "MICRO_DRAMA"
        }
    else if m.Player.menuButtonSelected = "SUBSCRIBE_OVERLAY"
        if m.mainVideoDataList.getchild(m.currentPlayingIndex) <> invalid then
            goToSubscriptionListingScene(m.mainVideoDataList.getchild(m.currentPlayingIndex).video_id)
        end if
    else if m.Player.menuButtonSelected = "BUNDLE_SUBSCRIPTION_OVERLAY"
        coinSubscriptionList = m.Player.findNode("CoinSubscriptionsList")

        selectedIndex = invalid
        if coinSubscriptionList <> invalid and coinSubscriptionList.itemSelected <> invalid
            selectedIndex = coinSubscriptionList.itemSelected
        end if

        ' if coinSubscriptionList <> invalid and coinSubscriptionList.content <> invalid and selectedIndex <> invalid and selectedIndex >= 0 and selectedIndex < coinSubscriptionList.content.getChildCount() and coinSubscriptionList.content.getChild(selectedIndex) <> invalid and coinSubscriptionList.content.getChild(selectedIndex).type <> invalid and coinSubscriptionList.content.getChild(selectedIndex).type = "subscription" and coinSubscriptionList.content.getChild(selectedIndex).id <> invalid
        '     gotosubscriptionListingScene(coinSubscriptionList.content.getChild(selectedIndex).id)
        ' else if coinSubscriptionList <> invalid and coinSubscriptionList.content <> invalid and selectedIndex <> invalid and selectedIndex >= 0 and selectedIndex < coinSubscriptionList.content.getChildCount() and coinSubscriptionList.content.getChild(selectedIndex) <> invalid and coinSubscriptionList.content.getChild(selectedIndex).type <> invalid and coinSubscriptionList.content.getChild(selectedIndex).type = "bundle"
        '     showQrOverlay("pkg:/images/QR_Image.png")
        ' end if

        ' create code for if coinSubscriptionList.content.getChild(selectedIndex) has checkout_qr then show QR code for that subscription else go to subscription listing page for that subscription
        if coinSubscriptionList <> invalid and coinSubscriptionList.content <> invalid and selectedIndex <> invalid and selectedIndex >= 0 and selectedIndex < coinSubscriptionList.content.getChildCount() and coinSubscriptionList.content.getChild(selectedIndex) <> invalid
            selectedItem = coinSubscriptionList.content.getChild(selectedIndex)
            if selectedItem.type <> invalid and selectedItem.type = "subscription"
                if selectedItem.checkout_qr <> invalid and selectedItem.checkout_qr <> ""
                    showQrOverlay(selectedItem)
                else
                    if selectedItem.videoId <> invalid then goToSubscriptionListingScene(selectedItem.videoId) else gotoSubscriptionListingScene("")
                end if
            else if selectedItem.type <> invalid and selectedItem.type = "bundle"
                currentBalanceStr = getCurrentCoinBalance()
                if (currentBalanceStr <> invalid) then currentBalance = currentBalanceStr.ToInt() else currentBalance = 0

                ' Extract the required tokens safely
                tokensRequired = 0
                playerResets = m.Player.playerContentThatWeResets

                ' Extract the required tokens
                tokensRequired = 0
                if m.Player.playerContentThatWeResets <> invalid and m.Player.playerContentThatWeResets.subscriptions <> invalid and m.Player.playerContentThatWeResets.subscriptions[0] <> invalid
                    tokensRequiredStr = m.Player.playerContentThatWeResets.subscriptions[0].tokens_required
                    if tokensRequiredStr <> invalid
                        tokensRequired = tokensRequiredStr
                    end if
                end if

                ' Handle consumption logic
                consumptionType = selectedItem.consumptionType
                if consumptionType = "PER_VIEW" or consumptionType = "UNLOCK"
                    if currentBalance < tokensRequired
                        showQrOverlay(selectedItem)
                    else
                        reduceCoinsBalanceAfterPlaying(playerResets)
                        playVideo(playerResets)
                    end if
                end if
            end if
        end if
    end if
    onPageExit()
end sub

sub initializeEpisodeBoxRowList(list)
    ?"initializeEpisodeBoxRowList called"
    ParentNode = CreateObject("RoSGNode", "ContentNode")
    itemsPerRow = 8
    total = list.Count()

    for i = 0 to total - 1 step itemsPerRow

        RowNode = CreateObject("RoSGNode", "ContentNode")
        for j = i to i + itemsPerRow - 1
            if j >= total then exit for ' ✅ Safety check
            data = list[j]
            ChildNode = CreateObject("RoSGNode", "ContentNode")

            ChildNode.addFields({
                video_id: doNullCheck(data, "video_id", "")
                title: doNullCheck(data, "title", "")
                synopsis: doNullCheck(data, "synopsis", "")
                vanity_url: doNullCheck(data, "vanity_url", "")
                url: doNullCheck(data, "url", "")
                duration: doNullCheck(data, "video_duration_seconds", 0)
                subscriptions: doNullCheck(data, "subscriptions", {})
                video_duration_seconds: doNullCheck(data, "video_duration_seconds", 0)
                video_time: doNullCheck(data, "video_time", "")
                episode_number: doNullCheck(data, "episode_number", 0)
                isLocked: not doNullCheck(data, "subscribed", false)
                isActive: (j = m.currentPlayingIndex)
                graphIcon: "pkg:/images/graph.png"
                activeGradient: "pkg:/images/red_gradient.png"
                nodeIndex: doNullCheck(data, "episode_number", 0)
                is_last_video: (i = list.count() - 1) 'setting is_last_video field
                iswatchOnceSubscribed: false 'setting watchOnceSubscribed field
            })

            RowNode.appendChild(ChildNode)
        end for
        ParentNode.appendChild(RowNode)
    end for
    m.episodesBoxRowlist.content = ParentNode
    ' m.episodesBoxRowlist.setFocus(true)
    m.episodesBoxContainer.visible = false

    if m.MicroDramaApiTask <> invalid and m.MicroDramaApiTask["MicroDramaApiTaskContent"] <> invalid and m.MicroDramaApiTask["MicroDramaApiTaskContent"]["show"] <> invalid and m.MicroDramaApiTask["MicroDramaApiTaskContent"]["show"]["show_name"] <> invalid
        m.episodesTitle.text = m.MicroDramaApiTask["MicroDramaApiTaskContent"]["show"]["show_name"]
    else
        m.episodesTitle.text = m.top.show_name
    end if

end sub

sub onbuttonsRowlistItemSelected()
    m.episodesBoxContainer.visible = false
    if m.mainVideoDataList <> invalid and m.episodesBoxRowlist <> invalid and m.episodesBoxRowlist.RowItemSelected <> invalid and m.episodesBoxRowlist.RowItemSelected[1] <> invalid and m.mainVideoDataList.getchild(m.episodesBoxRowlist.RowItemSelected[1]) <> invalid then
        ' nodeIndex = m.episodesBoxRowlist.content.getchild(m.episodesBoxRowlist.RowItemSelected[0]).getchild(m.episodesBoxRowlist.RowItemSelected[1]).nodeindex
        ' playVideo(m.mainVideoDataList.getchild(nodeIndex))
             playVideo(m.episodesBoxRowlist.content.getchild(m.episodesBoxRowlist.RowItemSelected[0]).getchild(m.episodesBoxRowlist.RowItemSelected[1]))
    end if
end sub

function checkAndResumePlayer() as boolean
    if m.Player <> invalid
        videoPlayer = m.Player.findNode("VideoPlayer")
        if videoPlayer <> invalid and videoPlayer.content <> invalid
            currentPosition = videoPlayer.position
            playerState = videoPlayer.state

            ' Check if there's meaningful playback data
            if currentPosition > 0 and playerState <> "error" and playerState <> "finished"
                ' Store resume data before leaving page
                m.resumePosition = currentPosition
                m.resumeContent = videoPlayer.content
                return true
            end if
        end if
    end if
    return false
end function

function resumePlayerOnReturn() as void
    if m.resumePosition <> invalid and m.resumeContent <> invalid and m.Player <> invalid
        videoPlayer = m.Player.findNode("VideoPlayer")
        if videoPlayer <> invalid
            if m.mainVideoDataList.getChild(m.currentPlayingIndex) <> invalid and m.mainVideoDataList.getChild(m.currentPlayingIndex).is_subscribed <> invalid and m.mainVideoDataList.getChild(m.currentPlayingIndex).is_subscribed = true or m.mainVideoDataList.getChild(m.currentPlayingIndex).iswatchOnceSubscribed <> invalid and m.mainVideoDataList.getChild(m.currentPlayingIndex).iswatchOnceSubscribed = true
                ' Set content and resume position
                videoPlayer.content = m.resumeContent
                videoPlayer.seek = m.resumePosition
                videoPlayer.visible = true
                videoPlayer.control = "play"
                ' Clear resume data
                m.resumePosition = invalid
                m.resumeContent = invalid
                m.Player.showSubscribeOverlay = false
            else
                m.Player.showSubscribeOverlay = true
            end if
        end if
    else if IsNotNull2(m.Player) and IsNotNull2(m.Player.menuButtonSelected) and m.Player.menuButtonSelected = "SUBSCRIBE_OVERLAY"
        m.Player.showSubscribeOverlay = true
    else if IsNotNull2(m.Player) and IsNotNull2(m.Player.menuButtonSelected) and m.Player.menuButtonSelected = "BUNDLE_SUBSCRIPTION_OVERLAY"
        m.Player.setFocusToCoinListing = true
    end if
end function

function onPageExit() as void
    ' Call this when leaving the page
    hasData = checkAndResumePlayer()
    if hasData then
        print "VideoPlayer data saved for resume"
    end if
end function

function onPageEnter() as void
    ' Call this when returning to the page
    resumePlayerOnReturn()
end function

function updateEpisodeActiveByEpisodeNumber(episodeNumber as integer, isActive as boolean) as void
    if m.episodesBoxRowlist = invalid or m.episodesBoxRowlist.content = invalid then
        return
    end if

    parentContent = m.episodesBoxRowlist.content

    ' Single loop: Reset all and set target in one pass
    for rowIndex = 0 to parentContent.getChildCount() - 1
        rowNode = parentContent.getChild(rowIndex)
        if rowNode <> invalid then
            for colIndex = 0 to rowNode.getChildCount() - 1
                childNode = rowNode.getChild(colIndex)
                if childNode <> invalid then
                    ' Set isActive based on episode match and desired state
                    if childNode.episode_number = (episodeNumber) and isActive then
                        childNode.isActive = true
                        ?" updateEpisodeActiveByEpisodeNumber:  Activated episode " episodeNumber.ToStr()
                        m.episodesBoxRowlist.jumpToRowItem = [rowIndex, colIndex]
                    else
                        childNode.isActive = false
                    end if
                end if
            end for
        end if
    end for
end function

sub goToLandingScene()
    m.loading.visible = false
    m.top.gotoLandingScene = true
end sub


sub goToSubscriptionListingScene(videoId as string)
    m.loading.visible = false
    if m.Player <> invalid
        m.Player.control = "stop"
    end if
    m.top.goToPaymentDescriptionScreen = videoId
end sub

sub onSelectedSubscriptionChange()
    ?"onSelectedSubscriptionChange called: "; m.Player.selectedSubscription
    if m.Player.selectedSubscription <> invalid and m.Player.selectedSubscription.count() > 0
        subscription = m.Player.selectedSubscription[0]
        if subscription.type = "subscription" and subscription.subscribed = true
            ' User has successfully subscribed, resume playback
            m.Player.showSubscribeOverlay = false
            if m.Player <> invalid then m.Player.control = "play"
        else if subscription.type = "subscription" and subscription.subscribed = false
            ' Subscription was not successful, show overlay again or handle accordingly
            m.Player.showSubscribeOverlay = true
        end if
    end if
end sub

sub showQrOverlay(selectedItem)
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
    ' m.qrOverlay.unobserveField("closeLabelListSelectedItem")
    ' m.qrOverlay.ObserveField("closeLabelListSelectedItem", "onQrOverlayCloseLabelListSelectedItem")
    ' 2. Set the fields programmatically
    m.qrOverlay.id = "myQrOverlay"
    m.qrOverlay.buttonsArray = [getTextOf("refresh"), getTextOf("Cancel")]
    m.qrOverlay.titleLabel = selectedItem.title
    ' m.qrOverlay.text = ""
    ' m.qrOverlay.description1 = ""
    ' m.qrOverlay.description2 = ""
    ' m.qrOverlay.description3 = ""
    m.qrOverlay.qrUrl = selectedItem.checkout_qr

    ' 3. Manage visibility and focus
    m.qrOverlay.visible = true
    m.qrOverlay.setFocus(true)
end sub

' sub onQrOverlayCloseLabelListSelectedItem()
'     if m.qrOverlay.closeLabelListSelectedItem = getTextOf("cancel")
'         if m.qrOverlay <> invalid
'             m.qrOverlay.visible = false
'             m.qrOverlay.setFocus(false)
'             m.top.removeChild(m.qrOverlay)
'             m.qrOverlay = invalid
'             m.Player.setFocusToCoinListing = true
'         end if
'     else if m.qrOverlay.closeLabelListSelectedItem = getTextOf("refresh")
'         m.qrOverlay.visible = false
'         m.qrOverlay.setFocus(false)
'         if m.Player <> invalid then m.Player.showSubscribeOverlay = false
'         callMicroDramaApi()
'     end if
' end sub

sub onQrOverlayClose()
    if m.qrOverlay <> invalid
        m.qrOverlay.visible = false
        m.qrOverlay.setFocus(false)
        m.top.removeChild(m.qrOverlay)
        m.qrOverlay = invalid
        m.Player.setFocusToCoinListing = true
    end if
end sub

sub onQrOverlayRefreshRequested()
    m.qrOverlay.visible = false
    m.qrOverlay.setFocus(false)
    if m.Player <> invalid then m.Player.showSubscribeOverlay = false
    callMicroDramaApi()
end sub

sub reduceCoinsBalanceAfterPlaying(inputContent)
    ?"reduceCoinsBalanceAfterPlaying called for video_id: "; inputContent

    if isNotNull2(m.Player) then m.Player.showSubscribeOverlay = false
    inputContent.iswatchOnceSubscribed = true
    updateNodeByIndex(inputContent.nodeindex)
    selectedSubscriptionIndex = 0
    if m.Player <> invalid
        listNode = m.Player.findNode("CoinSubscriptionsList")
        if listNode <> invalid and listNode.itemSelected <> invalid
            selectedSubscriptionIndex = listNode.itemSelected
        end if
    end if
    m.MicroDramaApiTask.callFunc("stopMicroDramaApiTask")
    m.MicroDramaApiTask.updateCoinsUsageAssoc = {
        video_id: inputContent.video_id,
        consumption_type: inputContent.subscriptions[selectedSubscriptionIndex].consumption_type }
    m.MicroDramaApiTask.callFunc("runUpdateCoinsUsageApiTask", "")


    ' Get current balance
    currentBalanceStr = getCurrentCoinBalance()
    currentBalance = currentBalanceStr.ToInt()

    ' Extract the required tokens
    tokensRequired = 0
    if inputContent <> invalid and inputContent.subscriptions <> invalid and inputContent.subscriptions[selectedSubscriptionIndex] <> invalid
        tokensRequiredStr = inputContent.subscriptions[selectedSubscriptionIndex].tokens_required
        if tokensRequiredStr <> invalid
            tokensRequired = tokensRequiredStr
        end if
    end if

    ' Calculate new balance (ensure it doesn't go below 0 if that's a requirement)
    newBalance = currentBalance - tokensRequired
    if newBalance < 0 then newBalance = 0

    ' Save the updated balance back as a string
    setCurrentCoinBalance(newBalance.ToStr())
    inputContent.iswatchOnceSubscribed = true
end sub



function updateNodeByIndex(nodeIndex as integer) as boolean
    rowListContent = m.episodesBoxRowlist.content

    if rowListContent = invalid then return false

    numRows = rowListContent.getChildCount()

    for rowIdx = 0 to numRows - 1
        row = rowListContent.getChild(rowIdx)
        if row <> invalid then
            numItems = row.getChildCount()
            for itemIdx = 0 to numItems - 1
                item = row.getChild(itemIdx)
                if item <> invalid then
                    if item.nodeindex = nodeIndex then
                        item.iswatchOnceSubscribed = true
                        item.isLocked = false
                        return true
                    end if
                end if
            end for
        end if
    end for

    return false
end function