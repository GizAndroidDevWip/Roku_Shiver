sub ShowAllCategoryScreen()
    m.AllCategory = CreateObject("roSGNode", "AllCategory")
    m.AllCategory.ObserveField("goToShowDetailsScreen", "onGoToShowScreenFromAllCategoryScreen")
    m.AllCategory.ObserveField("goToVideoPlayerScene", "onGoToVideoPlayerScene1")
    ShowScreen(m.AllCategory)
end sub

sub onGoToShowScreenFromAllCategoryScreen(event1 as object)
    rowlist = event1.GetRoSGNode()
    m.selectedIndex = event1.GetData()
    rowContent = rowlist.content.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])
    if rowContentItem.itemType = "VERTICAL_SHOW"
        showMicroDramaScene({ show_id: rowContentItem.show_id
        show_name: rowContentItem.title})
    else
        ShowShowDetailsScreen(rowContentItem)
    end if
end sub

sub onGoToVideoPlayerScene1(event1 as object)
    rowlist = event1.GetRoSGNode()
    m.selectedIndex = event1.GetData()
    rowContent = rowlist.content.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])
    ai_type = ""
    if rowContentItem.ai_type <> invalid and rowContentItem.ai_type <> ""
        ai_type = rowContentItem.ai_type
    end if
    utilityAssoc = {
    }
    showVideoPlayerScene(rowContentItem.video_id,rowContentItem.show_id, ai_type, true, utilityAssoc)
end sub