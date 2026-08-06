sub ShowSearchScreen()
    m.search = CreateObject("roSGNode", "Search")
    m.search.ObserveField("rowItemSelected", "onGoToShowScreenFromSearchScreen")
    m.search.ObserveField("goToMainVideoPlayer", "OnGotoMainVideoPlayer1")
    m.search.ObserveField("goToLandingScene", "onGoToLandingScenefromfastchannel")

    ?"searchScreenLogic called"
    ShowScreen(m.search)
end sub


sub onGoToLandingScenefromfastchannel()
    reverse_tv_code = getREVERSE_TV_CODE_FLOW()
    if (reverse_tv_code = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub



sub onGoToShowScreenFromSearchScreen(event as object)
    rowlist = event.GetRoSGNode()
    m.selectedIndex = event.GetData()
    rowContent = rowlist.content.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])

    if rowContentItem.categoryType = "SHOWS"
        rowContentItem.addFields({ "itemType": "SHOW" })
        if getBYPASS_SHOW_DETAILS_SCREEN() = "true" and rowContentItem.video_id <> invalid
            showVideoPlayerScene(rowContentItem.video_id, rowContentItem.ai_type, "", true, {})
        else
            ShowShowDetailsScreen(rowContentItem)
        end if

    else if rowContentItem.categoryType = "VIDEOS"
        if getBYPASS_SHOW_DETAILS_SCREEN() = "true" and rowContentItem.video_id <> invalid
            showVideoPlayerScene(rowContentItem.video_id, rowContentItem.ai_type, "", true, {})
        else
            showVideoPlayerScene(rowContentItem.video_id, rowContentItem.ai_type, "", true, {})
        end if


    else if rowContentItem.categoryType = "PODCASTS"
        ShowPlayerPodCastScene(rowContentItem)

    else if rowContentItem.categoryType = "EVENTS"
        showEventDetailScreen(rowContentItem)

    else if rowContentItem.categoryType = "FASTCHANNELS"

    else if rowContentItem.categoryType = "LIVE"
        showVideoPlayerSceneForTimeGridScene(m.search.goToMainVideoPlayer, "URL", "TIMEGRID_SCENE")


    else if rowContentItem.categoryType = "SHORTS"
        if getSHORTS_LOGIN_REQUIRED() = "true" and isGuest() = "true"
            onGoToLandingScenefromsearch()
        else

            playSelectedShortsVideo(rowContentItem.video_id)
        end if
    else if rowContentItem.categoryType = "VERTICAL_SHOW" or rowContentItem.categoryType = "MICRO_DRAMA" or rowContentItem.categoryType = "VERTICAL_SHOWS"  'rowContentItem.categoryType = "VERTICAL_SHOW"
        showMicroDramaScene({ show_id: rowContentItem.show_id
        show_name: rowContentItem.name })
    end if


end sub

sub OnGotoMainVideoPlayer1()
    showVideoPlayerSceneForTimeGridScene(m.search.goToMainVideoPlayer, "URL", "TIMEGRID_SCENE")
end sub

sub goToShow_Or_Videoplayerpage2(rowContentItem)
    if getBYPASS_SHOW_DETAILS_SCREEN() = "true" and rowContentItem.video_id <> invalid
        utilityAssoc = {
        }
        showVideoPlayerScene(rowContentItem.video_id, "", true, utilityAssoc)
    else
        ShowShowDetailsScreen(rowContentItem)
    end if
end sub


sub onGoToLandingScenefromsearch()
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub