sub ShowShowMoreScene(utilityAssoc as object)
    m.showMore = CreateObject("roSGNode", "showMore")
    m.showMore.ObserveField("rowItemSelected", "onGoToDetailScreenFromShowMore")

    if utilityAssoc.tagType <> invalid
        m.showMore.tagType = utilityAssoc.tagType
    else if utilityAssoc.type <> invalid
        m.showMore.tagType = utilityAssoc.type
    end if

    if utilityAssoc.id <> invalid
        m.showMore.tagName = utilityAssoc.id
    else
        m.showMore.tagName = utilityAssoc.key
    end if

    m.showMore.title = utilityAssoc.title
    ShowScreen(m.showMore)
end sub



sub onGoToDetailScreenFromShowMore(clickEvent as object)
    rowlist = clickEvent.GetRoSGNode()
    m.selectedIndex = clickEvent.GetData()
    rowContent = rowlist.content.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])


    if rowContentItem.categoryType = "SHOWS"
        ShowShowDetailsScreen(rowContentItem)

    else if rowContentItem.categoryType = "VIDEOS"
        ' showVideoDetailScene(rowContentItem.video_id, "","")
        showVideoPlayerScene(rowContentItem.video_id, rowContentItem.ai_type, "", true, {})
    else if rowContentItem.categoryType = "VERTICAL_SHOW"
        showMicroDramaScene({ show_id: rowContentItem.show_id
        show_name: rowContentItem.name })
    end if
end sub


'******************************************

sub ShowShowMoreSceneForAdditionalDonorContent(id as string)
    ?"showMoreSceneLogic called"
    m.showMore = CreateObject("roSGNode", "showMore")
    m.showMore.ObserveField("rowItemSelected", "onGoToDetailScreenFromShowMore")
    m.showMore.tagNameForAdditionalDonorContent = id
    ShowScreen(m.showMore)
end sub