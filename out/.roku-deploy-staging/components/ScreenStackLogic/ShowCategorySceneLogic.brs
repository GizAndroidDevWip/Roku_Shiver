sub CategoryListingScene(utilityAssoc as object)
    m.CategoryListing = CreateObject("roSGNode", "CategoryListing")
    m.CategoryListing.ObserveField("rowItemSelected", "onGoToDetailScreenFromCategory")
    m.CategoryListing.key = utilityAssoc.key
    m.CategoryListing.type = utilityAssoc.type
    ShowScreen(m.CategoryListing)
end sub



sub onGoToDetailScreenFromCategory(event1 as object)

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

    if rowContentItem.video_id <> invalid and rowContentItem.video_id <> ""
        showVideoPlayerScene(rowContentItem.video_id, rowContentItem.show_id, ai_type, true, utilityAssoc)

    else
        ShowShowDetailsScreen(rowContentItem)

    end if
end sub

