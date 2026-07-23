sub init()
    m.mainRectangle = m.top.FindNode("main_rect")
    m.CategorySceneRowlist = m.top.findNode("CategorySceneRowlist")
    m.sceneTitle = m.top.findNode("sceneTitle")
    m.sceneTitle.font.size = 55
    m.CategorySceneRowlist.color = getTextColor()
    m.CategorySceneRowlist.rowLabelColor = getTextColor()
    m.CategorySceneRowlist.showRowLabel = false
    m.CategorySceneRowlist.focusBitmapBlendColor = getButtonSelectionColor()
    m.messageLabel = m.top.findNode("message_label")
    m.messageLabel.color = getTextColor()
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor1()

    m.top.observeField("visible", "OnTopVisibilityChange")
    m.HomeTopMenuRowlist = m.top.getScene().findNode("HomeTopMenuRowlist")
    m.top.start = "start"
end sub

sub onStarted()
    print "starting all categories"
    if m.top.content = invalid
        m.VideoFetcher = CreateObject("roSGNode", "VideoFetcher")
        m.VideoFetcher.observeField("CategoryListingParsing", "onContentChanged")'
        m.VideoFetcher.taskType = "CatRequest"
        m.VideoFetcher.callFunc("runVideoFetcherTask", "")

    else
        m.LabelList.setFocus(true)
    end if
end sub

sub onLabelContentChanged()

    m.top.LabelContent = m.VideoFetcher.LabelContent

    ?"dd"
end sub


sub onContentChanged()

    if m.global.MENU_FOR_SMART_HOME_PAGES <> invalid and m.global.MENU_FOR_SMART_HOME_PAGES = "true" then

        m.sceneTitle.text = "Channels"
    else
        m.sceneTitle.text = "Categories"
    end if
   
    list = m.VideoFetcher.CategoryListingParsing
    m.CategorySceneRowlist.content = list
    m.CategorySceneRowlist.setFocus(true)
    m.CategorySceneRowlist.observeField("rowItemSelected", "OnRowItemFocused")

end sub

sub OnRowItemFocused()
    
    focusedIndexPath = m.CategorySceneRowlist.rowItemFocused

   
    if focusedIndexPath <> invalid and focusedIndexPath.count() = 2

      
        mainContent = m.CategorySceneRowlist.content

        if mainContent <> invalid
        
            rowIndex = focusedIndexPath[0]
            rowNode = mainContent.getChild(rowIndex)

            if rowNode <> invalid
              
                itemIndex = focusedIndexPath[1]
                itemContent = rowNode.getChild(itemIndex)

                
                if itemContent <> invalid and itemContent.key <> invalid
                    categoryKey = itemContent.key
                    ?"Focused item's key is: "; categoryKey

                    m.top.selectedCategoryKey = categoryKey
                    ?m.VideoFetcher.CategoryListingParsing
                    m.top.content = m.VideoFetcher.CategoryListingParsing

                    itemFocused = m.top.itemFocused
                    if itemFocused.Count() = 2 then
                        focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])

                        if focusedContent <> invalid and focusedContent.type <> invalid and focusedContent.type = "SMART_HOME" then
                            m.top.goToHomeScene = focusedContent
                          
                        else
                        
                            m.top.goToCategoryListingPage = focusedContent

                        end if

                    end if

                end if
            end if
        end if
    end if

end sub



sub OnTopVisibilityChange()
    if m.top.visible = true
        m.CategorySceneRowlist.setFocus(true)
    end if
end sub


function OnkeyEvent(key, press) as boolean

    result = false
    if press

        if m.HomeTopMenuRowlist.isInFocusChain() 
            if key = "right" or key = "left"
                return true
            else if key = "down"
                m.CategorySceneRowlist.setFocus(true)
                return true
            end if
        else if key = "up" and m.CategorySceneRowlist.hasFocus()
            m.HomeTopMenuRowlist.SET_FOCUS = true
            return true
        end if

    end if
    return result
end function



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

function restructureContentForRowList(flatContent as object, itemsPerRow as integer) as object
    if flatContent = invalid or flatContent.getChildCount() = 0
        return invalid
    end if

    structuredContent = createObject("roSGNode", "ContentNode")

    rowNode = structuredContent.createChild("ContentNode")
    rowNode.title = "Categories" 
    for i = 0 to flatContent.getChildCount() - 1
  
        if rowNode.getChildCount() = itemsPerRow
            rowNode = structuredContent.createChild("ContentNode")
        
        end if
      item = flatContent.getChild(i)
    rowNode.appendChild(item)
    end for

    return structuredContent
end function

sub onSetDefaultFocus()
    m.CategorySceneRowlist.setFocus(true)
end sub
