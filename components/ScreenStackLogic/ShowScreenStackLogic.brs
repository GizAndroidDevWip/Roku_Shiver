sub ShowShowDetailsScreen(focusedContent)
    m.show = CreateObject("roSGNode", "Show")
    m.show.observeField("gotoLandingScene", "onGoToLandingScene5")
    m.show.observeField("goToLandingSceneAndCloseAllScreens", "OnGoToLandingSceneAndCloseAllScreens")
    m.show.ObserveField("goToPaymentDescriptionScreen", "onGoToPaymentDescriptionScree2")
    m.show.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenforEvent")
    m.show.ObserveField("rowItemSelected", "onGoToShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo")
    m.show.ObserveField("goToVideoDetailScene", "onGotoVideoDetailScene")
    m.show.ObserveField("goToShowMoreScene", "OnGoToShowMoreScene")
    m.show.ObserveField("close_this_screen", "on_close_show_screen")
    m.show.ObserveField("goToVideoPlayerScene", "onGoToVideoPlayerScene4")
    m.show.ObserveField("GOTO_HOME_AND_LOAD_SMARTHOME", "onGoToHomeAndLoadSmartHome")
    m.show.ObserveField("goToSearchScreen", "onGotoSearchScreen")
    m.show.upcomingEventId = focusedContent.upcomingEventId

    m.show.ai_type = focusedContent.ai_type
    m.show.itemType = focusedContent.itemType

    if focusedContent.show_id <> invalid
        m.show.start = focusedContent.show_id.ToStr()

        if focusedContent.show_id <> invalid
            m.show_id = focusedContent.show_id.ToStr()
        else
            m.show_id = ""
        end if

        ShowScreen(m.show)
    end if
end sub

sub onGoToLandingScreen()
    ?"onGoToLandingScreencalled"
    showLandingScreen()
end sub

sub onGoToLandingScene5()
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub


sub on_close_show_screen()
    CloseScreen(m.show)
end sub

sub onGoToPaymentDescriptionScree2()
    ?"onGoToPaymentDescriptionScree2called"
    '**********below is done to prevent an issue - when we created multiple show instance means
    'goes from one showdetail to another showdetail and so, coming back from one show page does not give the very previous
    'show pages's details, so previous show page data is taken from screenstackarray.
    videoIdOfPeekshowPageInScreenStackArray = m.global.screenStackArray.Peek().goToPaymentDescriptionScreen
    if m.show.isGoadsFreeclicked = true then isGoadsFreeclicked = true else isGoadsFreeclicked = false
    paramsAssoc = {
        "videoId": videoIdOfPeekshowPageInScreenStackArray,
        "isGoadsFreeclicked": isGoadsFreeclicked
    }
    videoSubscriptionListScreen(paramsAssoc)
    m.show.isGoadsFreeclicked = false
end sub

sub onGoToPaymentDescriptionScreenforEvent()
    ?"onGoToPaymentDescriptionScree2called"
    goToPaymentDescriptionScreenForEvent = m.global.screenStackArray.Peek().goToPaymentDescriptionScreenForEvent.Trim()
    videoSubscriptionListScreenForEvent(goToPaymentDescriptionScreenForEvent)
end sub


sub onGoToShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo(event as object)
    rowlistContent = m.show.rowlistContentCopy ' to get the rowlist from node by node from show.xml views stack
    m.selectedIndex = event.GetData()
    rowContent = rowlistContent.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])
    if rowContentItem.itemType = "shows" 'or rowContentItem.itemType = "ott"
        ShowShowDetailsScreen(rowContentItem)
    else if rowContentItem.itemType = "ott" and rowContentItem.issinglevideo <> invalid and rowContentItem.issinglevideo = 3
        CloseScreenWithSceneName("MicroDramaScene")
        showMicroDramaScene({ show_id: rowContentItem.show_id
            selectedVideoId: rowContentItem.video_id
        show_name: rowContentItem.show_name })
    end if
end sub



sub onGotoVideoDetailScene()
    ?"onGotoVideoDetailScene called"
    showVideoDetailScene(m.show.goToVideoDetailScene, "", m.show_id)
end sub

function onGoToShowMoreScene() as void
    ' 1. Validate the source data exists
    if m.show = invalid or m.show.tagsRowlistContent = invalid or m.show.goToShowMoreScene = invalid
        return
    end if

    ' 2. Safely get the row and item nodes
    rowIndex = m.show.goToShowMoreScene[0]
    itemIndex = m.show.goToShowMoreScene[1]

    row = m.show.tagsRowlistContent.getChild(rowIndex)
    if row = invalid then return

    item = row.getChild(itemIndex)
    if item = invalid then return

    ' 3. Proper Roku-style null checks
    tagKey = ""
    if item.key <> invalid and item.key <> ""
        tagKey = item.key
    else if item.title <> invalid and item.title <> ""
        tagKey = item.title
    else if item.id <> invalid and item.id <> ""
        tagKey = item.id
    end if

    tagType = ""
    if item.type <> invalid then tagType = item.type

    tagTitle = ""
    if item.title <> invalid then tagTitle = item.title

    utilityAssoc = {
        key: tagKey,
        type: tagType,
        title: tagTitle
    }

    ShowShowMoreScene(utilityAssoc)
end function



function onGoToVideoPlayerScene4()
    if m.show <> invalid and m.show.DoesExist("ai_type") and m.show.ai_type <> invalid
        ai_type = m.show.ai_type
    else
        ai_type = ""
    end if


    utilityAssoc = {
        "isStartOverButtonClicked": m.show.isStartOverButtonClicked
    }
    if m.show.itemType = "MICRO_DRAMA"
        showMicroDramaScene({ show_id: m.show.start })
    else
        showVideoPlayerScene(m.show.goToVideoPlayerScene.toint(), ai_type.ToStr(), m.show_id, true, utilityAssoc)
    end if
    m.show.isStartOverButtonClicked = false
end function

sub onGoToHomeAndLoadSmartHome()
    ' ?"onGoToHomeAndLoadSmartHome called"
    ' showHomeScene({ GOTO_HOME_AND_LOAD_SMARTHOME: m.show.GOTO_HOME_AND_LOAD_SMARTHOME })
end sub