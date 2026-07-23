sub init()


    m.mainRectangle = m.top.FindNode("main_rect")
    m.showMoreItemLabel = m.top.findNode("showMoreItem_Label")
    m.showMoreItemLabel.font.size = 55
    m.showMoreItemLabel.color = getTextColor()
    m.messageLabel = m.top.findNode("message_label")
    m.messageLabel.color = getTextColor()
    m.loading = m.top.findNode("loading")
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor1()
    m.top.observeField("visible", "OnTopVisibilityChange")
    m.ShowMoreRowlist = m.top.findNode("showMoreItemDemand")
    m.ShowMoreRowlist.color = getTextColor()
    m.ShowMoreRowlist.focusedColor = getTextColor()
    m.ShowMoreRowlist.focusBitmapBlendColor = getButtonSelectionColor()
    m.ShowMoreRowlist.rowLabelColor = getTextColor()
end sub


'''''''''
' runMoreTask: this is normal tags category page listing functions
'
'''''''''
sub runMoreTask()
    if m.top.tagType <> invalid and m.top.tagType <> ""
        if m.top.tagType = "CAST" or m.top.tagType = "CREW" or m.top.tagType = "TAGS"
            m.SearchFetcher = CreateObject("roSGNode", "SearchFetcherForShowMore")
            m.SearchFetcher.observeField("searchContent", "onContentChanged")
            m.SearchFetcher.searchType = m.top.tagType
            m.SearchFetcher.SearchRequest = m.top.tagName '+ "&type=" + m.top.tagType.Escape() '***********type of category listing joined here :  cast / tags / crew
            'm.SearchFetcher.SearchRequest = m.top.tagName.Escape() + "&type=" + m.top.tagType.Escape()
            m.SearchFetcher.callFunc("runSearchFetcherTask", "")
            m.loading.visible = true
        else
            m.SearchFetcher = CreateObject("roSGNode", "SearchFetcherForShowMore")
            m.SearchFetcher.observeField("searchContent", "onContentChanged")
            m.SearchFetcher.searchType = m.top.tagType
            m.SearchFetcher.SearchRequest = m.top.tagName '+ "&type=" + m.top.tagType.Escape() '***********type of category listing joined here :  cast / tags / crew
            'm.SearchFetcher.SearchRequest = m.top.tagName.Escape() + "&type=" + m.top.tagType.Escape()
            m.SearchFetcher.callFunc("runSearchFetcherTask", "")
            m.loading.visible = true
        end if
    end if
end sub



sub onContentChanged()
    ?"onContentChanged called"

    ' 1. Initial Null Checks
    if m.SearchFetcher = invalid or m.SearchFetcher.searchContent = invalid
        m.showMoreItemLabel.visible = false
        m.ShowMoreRowlist.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"
        m.loading.visible = false
        return
    end if

    content = m.SearchFetcher.searchContent
    childCount = content.getChildCount()

    if childCount = 0
        m.showMoreItemLabel.visible = false
        m.ShowMoreRowlist.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"
        m.loading.visible = false
        return
    end if

    ' 2. Setup Base Arrays
    rowHeights = []
    rowItemSize = []
    rowItemSpacing = []
    focusXOffset = []

    ' 3. Loop through content to set dynamic sizes
    for i = 0 to childCount - 1
        child = content.getChild(i)

        ' Default logic for spacing and offset
        rowItemSpacing.Push([25, 15])
        focusXOffset.Push([110])

        ' Determine orientation (checking child or global default)
        orientation = getThumbnailOrientaion()
        if child <> invalid and child.getChild(0) <> invalid and child.getChild(0).thumbnail_orientation <> invalid
            orientation = child.getChild(0).thumbnail_orientation
        end if

        ' Apply Portrait vs Landscape logic
        if orientation = "PORTRAIT"
            rowHeights.Push(400)
            rowItemSize.Push([220, 330])
            numrows = 2
        else ' Default to LANDSCAPE
            rowHeights.Push(250)
            rowItemSize.Push([320, 180])
            numrows = 3
        end if
    end for

    ' 4. Assign properties to ShowMoreRowlist
    m.ShowMoreRowlist.rowHeights = rowHeights
    m.ShowMoreRowlist.rowItemSize = rowItemSize
    m.ShowMoreRowlist.rowItemSpacing = rowItemSpacing
    m.ShowMoreRowlist.focusXOffset = focusXOffset
    m.ShowMoreRowlist.numRows = numrows

    ' 5. UI Updates
    m.top.content = content

    if m.top.title <> invalid and m.top.title <> ""
        m.showMoreItemLabel.text = m.top.title
    else
        m.showMoreItemLabel.text = m.top.tagName
    end if

    m.messageLabel.visible = false
    m.showMoreItemLabel.visible = true
    m.ShowMoreRowlist.visible = true
    m.loading.visible = false
    m.ShowMoreRowlist.setFocus(true)
end sub

'***********************this is Additional donor content data
sub runMoreTaskForAdditionalDonorContent()
    m.CategoryVideosListApiTask = CreateObject("roSGNode", "CategoryVideosListApiTask")
    m.CategoryVideosListApiTask.observeField("CategoryVideosListApiTaskContent", "onContentChangedForAdditionalDonorContent")
    m.CategoryVideosListApiTask.key = m.top.tagNameForAdditionalDonorContent
    m.CategoryVideosListApiTask.callFunc("runCategoryVideosListApiTask", "")
    m.loading.visible = true
end sub

sub onContentChangedForAdditionalDonorContent()
    ?"onContentChangedForAdditionalDonorContent called"
    if (m.CategoryVideosListApiTask.CategoryVideosListApiTaskContent <> invalid and m.CategoryVideosListApiTask.CategoryVideosListApiTaskContent.getChildCount() = 0)
        m.showMoreItemLabel.visible = false
        m.ShowMoreRowlist.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"
    else
        m.top.content = m.CategoryVideosListApiTask.CategoryVideosListApiTaskContent
        m.showMoreItemLabel.text = ""
        m.messageLabel.visible = false
    end if
    m.loading.visible = false
    m.ShowMoreRowlist.setFocus(true)
end sub



sub OnTopVisibilityChange()
    if m.top.visible = true
        m.ShowMoreRowlist.setFocus(true)
    end if
end sub


function OnkeyEvent(key, press) as boolean

    result = false
    if press
        ' Check Rowlist and Content exist
        if m.ShowMoreRowlist = invalid or m.ShowMoreRowlist.content = invalid then return false

        currFocus = m.ShowMoreRowlist.rowItemFocused
        ' Check focus array is valid
        if currFocus = invalid or currFocus.Count() < 2 then return false

        currRow = currFocus[0]
        currItem = currFocus[1]
        content = m.ShowMoreRowlist.content
        totalRows = content.getChildCount()

        ' Check current row exists
        rowContent = content.getChild(currRow)
        if rowContent = invalid then return false

        rowCount = rowContent.getChildCount()

        if key = "right"
            if currItem = rowCount - 1
                if currRow < totalRows - 1
                    ' Jump to next row
                    m.ShowMoreRowlist.jumpToRowItem = [currRow + 1, 0]
                    result = true
                else
                    ' Wrap to start of list
                    m.ShowMoreRowlist.jumpToRowItem = [0, 0]
                    result = true
                end if
            end if

        else if key = "left"
            if currItem = 0
                if currRow > 0
                    ' Check previous row exists before getting count
                    prevRowContent = content.getChild(currRow - 1)
                    if prevRowContent <> invalid
                        prevRowCount = prevRowContent.getChildCount()
                        m.ShowMoreRowlist.jumpToRowItem = [currRow - 1, prevRowCount - 1]
                        result = true
                    end if
                end if
            end if

        else if key = "down"
            m.ShowMoreRowlist.setFocus(true)
        end if
    end if
    return result
end function



' this function gets the parent node in the list
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


