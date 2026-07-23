sub ShowCategoryScene()
    m.CategoryScene = CreateObject("roSGNode", "CategoryScene")
    ' m.CategoryScene.ObserveField("rowItemSelected", "onGoToShowScreenFromAllCategoryScreen1")
    m.CategoryScene.ObserveField("goToCategoryListingPage", "GoToCategoryListingpage")
    m.CategoryScene.ObserveField("goToHomeScene", "OnGoToHomeSceneFromCategory")

    '  m.CategoryScene.ObserveField("goToVideoPlayerScene", "onGoToVideoPlayerScene1")
    ShowScreen(m.CategoryScene)
end sub


sub OnGoToHomeSceneFromCategory()
    RowFocusedContent = m.CategoryScene.goToHomeScene

    if m.CategoryScene.goToHomeScene.key <> invalid then
        key = m.CategoryScene.goToHomeScene.key
    else
        key = " "
    end if
    if m.CategoryScene.goToHomeScene.type <> invalid
        categorytype = m.CategoryScene.goToHomeScene.type
    else
        categorytype = " "
    end if

    if m.CategoryScene.goToHomeScene.title <> invalid
        title = m.CategoryScene.goToHomeScene.title
    else
        title = " "
    end if

    utilityAssoc = {
        key: key
        categorytype: categorytype
        type: "SMART_HOME"
        title: title

    }
    ?utilityAssoc
    ?"utilityAssocsas"
    ' showSmartHome(utilityAssoc)
    showHomeScene(utilityAssoc)

end sub

sub GoToCategoryListingpage()
    RowFocusedContent = m.CategoryScene.goToCategoryListingPage

    if m.CategoryScene.goToCategoryListingPage.key <> invalid then
        key = m.CategoryScene.goToCategoryListingPage.key
    else
        key = " "
    end if
    if m.CategoryScene.goToCategoryListingPage.type <> invalid
        categorytype = m.CategoryScene.goToCategoryListingPage.type
    else
        categorytype = " "
    end if

    utilityAssoc = {
        key: key
        categorytype: categorytype
    }

    CategoryListingScene(utilityAssoc)
end sub

sub onGoToShowScreenFromAllCategoryScreen1(event as object)

    scene = event.GetRoSGNode()
    m.selectedIndex = event.GetData()
    rowContent = scene.rowlist_content.GetChild(m.selectedIndex[0])
    rowContentItem = rowContent.getChild(m.selectedIndex[1])

    utilityAssoc = {
        id: rowContentItem.key,
        tagType: rowContentItem.type,
        title: rowContentItem.title 
    }
    ShowShowMoreScene(utilityAssoc)
end sub