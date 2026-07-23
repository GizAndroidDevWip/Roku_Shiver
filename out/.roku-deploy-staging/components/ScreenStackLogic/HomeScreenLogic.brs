sub showHomeScene(utilityAssoc as object)

    ' Set global flag before creating HomeScene so Init() knows about category content
    if utilityAssoc <> invalid and utilityAssoc.count() > 0 and utilityAssoc.key <> invalid and utilityAssoc.key <> ""
        m.top.getScene().SMARTHOME_SELECTED = utilityAssoc.key
    end if

    m.homeScene = CreateObject("roSGNode", "HomeScene")
    m.homeScene.ObserveField("appExit", "OnAppExit")
    m.homeScene.ObserveField("goToShortsScreen", "onGoToShortcreen")
    m.homeScene.ObserveField("goToNewCategoryScreen", "onGoToNewCategoryScreen")
    m.homeScene.ObserveField("goToCategoryScreen", "onGoToAllCategoryScreen")
    m.homeScene.ObserveField("goToSearchScreen", "onGoToSearchScreen")
    m.homeScene.ObserveField("goToMyListScreen", "onGoToMyListScreen")
    ' m.homeScene.ObserveField("goToShowScreen", "onGoToShowScreen")
    m.homeScene.ObserveField("rowItemSelected", "onGoToShowScreen")
    m.homeScene.ObserveField("goToSubscriptionListScreen", "onGoToPaymentDescriptionScree")
    m.homeScene.ObserveField("gotoLandingScene", "onGoToLandingScene4")
    m.homeScene.ObserveField("goToPaymentDescriptionScreen", "onGoToPaymentDescriptionScreen")
    m.homeScene.ObserveField("goToSplashScreen", "OngoToSplashScreen")
    m.homeScene.ObserveField("goToPodcastScene", "OnGoToPlayerPodcastScene")
    m.homeScene.ObserveField("closeThisScreen", "OncloseThisScreen")
    m.homeScene.ObserveField("closeAllScreen", "closeAllAcreens")
    m.homeScene.ObserveField("goToLandingSceneAndCloseAllScreens", "OnGoToLandingSceneAndCloseAllScreens")
    m.homeScene.ObserveField("goToShowMoreScene", "OnGoToShowMoreScene3")
    m.homeScene.ObserveField("goToMyTimeGridScreen", "onGoToTimeGridScreen")
    m.homeScene.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenForEvent3")
    m.homeScene.ObserveField("goToMainVideoPlayer", "OnGotoMainVideoPlayer2")
    m.homeScene.ObserveField("goToVideoPlayerScene", "onGoToVideoPlayerScene")
    m.homeScene.ObserveField("playSelectedShortsVideo", "playSelectedShorts_Video")
    m.homeScene.ObserveField("onDeepLinkLaunchedGotoShowScene", "onGoToshowSceneUsingDeepLink")
    m.homeScene.ObserveField("goToCalendarScene", "onGoToCalendarScene")
    m.homeScene.ObserveField("selectedBannerItem", "onBannerItemSelected")
    m.homeScene.ObserveField("goToSubscriptionListScreenForAppSubscription", "onGoToSubscriptionListScreenForAppSubscription")
    m.homeScene.ObserveField("gotoHomeScenen", "gotoHomeScenen2")
    m.homeScene.ObserveField("closethispage", "ClosethisPagefromhome")
    m.homeScene.ObserveField("goToMyAccountScreen", "onGoToMyAccountScreen")


    ? "m.homeScene"
    ShowScreen(m.homeScene)

end sub

sub ClosethisPagefromhome()
    CloseScreen(m.homeScene)

end sub

sub gotoHomeScenen2()
    showHomeScene({})
end sub
sub onGoToSubscriptionListScreenForAppSubscription()
    SubscriptionListScreenForApp()

end sub


sub playSelectedShorts_Video()
    playSelectedShortsVideo(m.homeScene.playSelectedShortsVideo)
end sub

sub OnAppExit()
    appExitFunc()
end sub

sub onGoToCategoryScreen()
    ?"category page called"
    ShowCategoryScene()
end sub

sub onGoToAllCategoryScreen()
    ?"category page called"
    ShowAllCategoryScreen()
end sub

sub onGoToNewCategoryScreen()
    ShowCategoryScene()

end sub

sub onGoToSearchScreen()
    ?"search screen called"
    ShowSearchScreen()
end sub

sub onGoToMyListScreen()
    ?"myList screen called"
    ShowMyListScreen()
end sub

sub onGoToTimeGridScreen()
    ?"time grid screen called"
    showTimeGridScene()
end sub

sub onGoToShortcreen()
    showShortsScene()
end sub

sub closeAllAcreens()
    CloseAllScreen()
end sub


sub onGoToPaymentDescriptionScreen()
    ' videoSubscriptionListScreen()
end sub

sub onGoToLandingScene4()
    reverse_tv_code = getREVERSE_TV_CODE_FLOW()
    if (reverse_tv_code = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub

sub OnGoToLandingSceneAndCloseAllScreens()
    CloseAllScreen()
    reverse_tv_code = getREVERSE_TV_CODE_FLOW()
    if (reverse_tv_code = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub


sub onGoToShowScreen(event as object)
    ?"onGoToShowScreen called"
    rowlist = event.GetRoSGNode()
    m.selectedIndex = event.GetData()
    rowContent = rowlist.gridContent.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])

    if rowContentItem.checkout_qr <> invalid and rowContentItem.checkout_qr <> ""
        return
    end if

    if rowContentItem.itemType = "SHOW" 'and rowContentItem.EVENT_ID = invalid
        goToShow_Or_Videoplayerpage(rowContentItem)

    else if rowContentItem.itemType = "SCHEDULE"

    else if rowContentItem.itemType = "LIVE"
        'do nothing here

    else if rowContentItem.itemType = "FASTCHANNEL"
        'do nothing here, will reload home from gridscreen
    else if rowContentItem.itemType = "NEWS"
        ' goToShow_Or_Videoplayerpage(rowContentItem)
    else if rowContentItem.itemType = "UPCOMING_EVENT" or rowContentItem.itemType = "LIVE_EVENT" 'or rowContentItem.itemType = "ENDED_EVENT" 'or  rowContentItem.categoryType = "ENDED_EVENTS"

        showEventDetailScreen(rowContentItem)
        ' ShowShowPageForUpcomingEventScreenStackLogicScreen(rowContentItem)
        ' else if rowContentItem.itemType = "LIVE_EVENT"
        '     showEventDetailScreen(rowContentItem)
        ' ShowShowPageForLiveEventScreenStackLogicScreen(rowContentItem)
    else if rowContentItem.itemType = "CONTINUE_WATCHING"
        ' goToShow_Or_Videoplayerpage(rowContentItem)
    else if rowContentItem.itemType = "PODCAST"
        ShowPlayerPodCastScene(rowContentItem)

    else if rowContentItem.itemType = "SHORTS"
        'do nothing here

    else if rowContentItem.itemType = "VERTICAL_SHOW"
        showMicroDramaScene({ show_id: rowContentItem.show_id
        show_name: rowContentItem.name })

    else if rowContentItem.itemType = "BANNER" '**************banner can come as LIVE_EVENT or UPCOMING_EVENT , so redirecting here based on event type
        goToShow_Or_Videoplayerpage(rowContentItem)

    else if rowContentItem.itemType = "SCHEDULE"
        if rowContentItem.event_type = invalid
            goToShow_Or_Videoplayerpage(rowContentItem)
        else if rowContentItem.event_type = "LIVE_EVENT"
            ShowShowPageForLiveEventScreenStackLogicScreen(rowContentItem)
        else if rowContentItem.event_type = "UPCOMING_EVENT"
            ShowShowPageForUpcomingEventScreenStackLogicScreen(rowContentItem)
        end if
    else if rowContentItem.itemType = "SHOW_MORE_ITEM"
        utilityAssoc = {
            id: rowContent["rawCategoryItem"]["key"],
            key: rowContent["rawCategoryItem"]["key"],
            tagType: rowContent["rawCategoryItem"]["type"],
            title: rowContent["title"]
        }
        ShowShowMoreScene(utilityAssoc)
        jumpToFirstIndexInRowlist()

    else if rowContentItem.itemType = "GENRE"
        utilityAssoc = {
            id: rowContentItem.key,
            tagType: "GENRE",
            title: rowContentItem.name
        }
        ShowShowMoreScene(utilityAssoc)

    else if rowContentItem.itemType = "SMART_HOME"
        'do nothing here, will reload home from gridscreen
    else if rowContentItem.itemType = "FASTCHANNEL"
    else
        goToShow_Or_Videoplayerpage(rowContentItem)
    end if

end sub

sub goToShow_Or_Videoplayerpage(rowContentItem)
    if rowContentItem.video_id <> invalid
        utilityAssoc = {
        }
        showVideoPlayerScene(rowContentItem.video_id, rowContentItem.ai_type, "", false, utilityAssoc)
    else
        ShowShowDetailsScreen(rowContentItem)
    end if
end sub

sub onGoToPaymentDescriptionScree()
    paramsAssoc = { "videoId": "" } 'for listing all subscription options in payment description screen without passing specific video id
    videoSubscriptionListScreen(paramsAssoc)
end sub

sub OngoToSplashScreen()
    showLaunchScene()
end sub

sub OncloseThisScreen()
    CloseScreen(m.homeScene)
end sub

sub onGoToMyAccountScreen()
    ShowMyAccountScreen()
end sub

sub OnGoToPodcastScene()
    ?"OnGoToPodcastScene called"
    showPodcastScreen()
end sub

sub OnGoToShowMoreScene3()
    ?"OnGoToShowMoreScene3 called"
    if m.homeScene.goToShowMoreScene <> invalid and m.homeScene.goToShowMoreScene.key <> invalid and m.homeScene.goToShowMoreScene.key = "redeem316"
        key = "additional-donor-content"
    else
        key = m.homeScene.goToShowMoreScene.key
    end if

    utilityAssoc = {
        id: key,
        tagType: m.homeScene.goToShowMoreScene.type,
        title: m.homeScene.goToShowMoreScene.title
    }
    ShowShowMoreScene(utilityAssoc)
end sub

sub goToShowMoreSceneOnTopMenuClick(input)
    utilityAssoc = {
        id: input.id,
        tagType: input.tagType,
        title: input.title
    }
    ShowShowMoreScene(utilityAssoc)
end sub

sub onGoToPaymentDescriptionScreenForEvent3()
    videoSubscriptionListScreenForTimeGrid(m.homeScene.goToPaymentDescriptionScreenForEvent)
end sub

sub OnGotoMainVideoPlayer2()
    showVideoPlayerSceneForTimeGridScene(m.homeScene.goToMainVideoPlayer, "URL", "TIMEGRID_SCENE")
end sub

sub onGoToVideoPlayerScene()
    utilityAssoc = {
    }
    showVideoPlayerScene(m.homeScene.goToVideoPlayerScene.toInt(), m.homeScene.ai_type, "", false, utilityAssoc)
end sub

sub onGoToshowSceneUsingDeepLink()
    params = m.global.DEEPLINK_PARAMS
    idToLoad = invalid

    ' 1. Validate parameters and extract target ID
    if params <> invalid and params.mediaType <> invalid and params.contentid <> invalid
        ?"onGoToshowSceneUsingDeepLink params: " params

        mediaType = params.mediaType
        idToLoad = params.contentid ' Fallback for unhandled media types
        if mediaType = "movie" or mediaType = "series" or mediaType = "season" or mediaType = "episode" or mediaType = "tvspecial" or mediaType = "shortForm" or mediaType = "live"
            idToLoad = params.contentid
        end if
    else
        ' Fallback if params are completely missing
        idToLoad = m.global.DEEPLINK_SHOWID
    end if

    ' 2. Single Node Creation and Screen Launch
    if idToLoad <> invalid
        rowContentItem = createObject("RoSGNode", "ContentNode")
        rowContentItem.addFields({ "show_id": idToLoad })
        ShowShowDetailsScreen(rowContentItem)
    end if
end sub

sub onGoToCalendarScene()
    ?"onGoToCalendarScene called"
    showCalendarViewScene()
end sub

sub onBannerItemSelected()
    selectedBannerItem = m.homeScene.selectedBannerItem
    if selectedBannerItem.checkout_qr <> invalid and selectedBannerItem.checkout_qr <> "" then return
    if selectedBannerItem <> invalid
        if selectedBannerItem.type = "SHOW" or selectedBannerItem.type = "BANNER"
            ShowShowDetailsScreen(selectedBannerItem)
        else if selectedBannerItem.type = "UPCOMING_EVENT" or selectedBannerItem.type = "LIVE_EVENT"
            showEventDetailScreen(selectedBannerItem)
        else if selectedBannerItem.type = "VIDEO"
            utilityAssoc = {
            }
            showVideoPlayerScene(selectedBannerItem.id, "VIDEO", "", false, utilityAssoc)
        else if selectedBannerItem.type = "VERTICAL_SHOW"
            showMicroDramaScene({ show_id: selectedBannerItem.show_id })
        end if

    else

    end if
end sub


sub SubscriptionListScreenForApp()
    m.PaymentDescription = CreateObject("roSGNode", "PaymentDescription")
    m.PaymentDescription.ObserveField("gotoHomeScenen", "onGoToHomeScene")
    m.PaymentDescription.ObserveField("gotoLaunchScene", "onGoToLaunchScene")
    m.PaymentDescription.ObserveField("gotoshowscene", "onGoToShowScene")
    m.PaymentDescription.ObserveField("gotoSubscriptionListScreen", "onGoToSubscriptionListScreen")
    m.PaymentDescription.observeField("isSubscribed", "closeAllAcreens5")

    ?"UYIIU"
    m.PaymentDescription.start = "true"
    'm.PaymentDescription.eventID = eventId
    showScreen(m.PaymentDescription)
end sub


sub jumpToFirstIndexInRowlist()
    gridScreen = m.homeScene.findNode("GridScreen")
    if gridScreen <> invalid
        rowList = gridScreen.findNode("Rowlist")

        ' Check if rowList exists AND if your selection data is valid
        if rowList <> invalid and m.homeScene.rowItemSelected <> invalid and m.homeScene.rowItemSelected.count() > 0
            rowIndex = m.homeScene.rowItemSelected[0]

            ' Final safety check to ensure rowIndex isn't null/invalid
            if rowIndex <> invalid
                rowList.jumpToRowItem = [rowIndex, 0]
            end if
        end if
    end if
end sub