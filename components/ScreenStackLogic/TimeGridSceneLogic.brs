sub showTimeGridScene()
    ?"showTimeGridScene called"
    m.TimeGrid = CreateObject("roSGNode", "TimeGridScene")
    m.TimeGrid.ObserveField("goToMainVideoPlayer", "OnGotoMainVideoPlayer")
    m.TimeGrid.ObserveField("goToPaymentDescriptionScreenForEvent", "onGoToPaymentDescriptionScreenForEvent4")
    m.TimeGrid.ObserveField("gotolandingscene", "OnGoToLandingSceneFromTimeGrid")
    ShowScreen(m.TimeGrid)
end sub


sub onGoToDetailScreenFromTimeGrid(clickEvent as object)
    ' rowlist = clickEvent.GetRoSGNode()
    ' m.selectedIndex = clickEvent.GetData()
    ' rowContent = rowlist.content.GetChild(m.selectedIndex[0])
    ' rowContentItem = rowContent.getChild(m.selectedIndex[1])
    ' if rowContentItem.categoryType = "SHOWS"
    '     ShowShowDetailsScreen(rowContentItem)

    ' else if rowContentItem.categoryType = "VIDEOS"
    '     showVideoDetailScene(rowContentItem.video_id)
    ' end if
end sub


sub OnGotoMainVideoPlayer(params)
    ?"fsjfhksjdfhksjdf OnGotoMainVideoPlayer called"
    showVideoPlayerSceneForTimeGridScene(m.TimeGrid.goToMainVideoPlayer, "URL", "TIMEGRID_SCENE")
end sub

sub onGoToPaymentDescriptionScreenForEvent4()
    videoSubscriptionListScreenForTimeGrid(m.TimeGrid.goToPaymentDescriptionScreenForEvent)
end sub

sub OnGoToLandingSceneFromTimeGrid()
    if (getREVERSE_TV_CODE_FLOW() = "true")
        showTvCodeScreen()
    else
        showLogicChooseScreen()
    end if
end sub