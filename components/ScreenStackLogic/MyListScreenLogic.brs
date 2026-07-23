sub ShowMyListScreen()
    m.myList = CreateObject("roSGNode", "MyListScene")
    m.myList.ObserveField("gotoLandingScene","onGoToLandingScene")
    m.myList.ObserveField("rowItemSelected", "onGoToShowScreenFromMyListScreen")
    ?"MyListScreenLogic called"
    ShowScreen(m.myList)
end sub

sub onGoToShowScreenFromMyListScreen(event1 as object)
    ?"onGoToShowScreenFromMyListScreen screen called"
    rowlist = event1.GetRoSGNode()
    m.selectedIndex = event1.GetData()
    rowContent = rowlist.content.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])
    if getBYPASS_SHOW_DETAILS_SCREEN() = "true" and rowContentItem.video_id<>invalid
        utilityAssoc = {
        }
        showVideoPlayerScene(rowContentItem.video_id, "", true, utilityAssoc)
    else
        ShowShowDetailsScreen(rowContentItem)
    end if
end sub


