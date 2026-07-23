sub init()


    m.mainRectangle = m.top.FindNode("main_rect")
    m.CategoryListing = m.top.findNode("CategoryListing")
    m.sceneTitle = m.top.findNode("sceneTitle")
    m.sceneTitle.font.size = 55
    m.sceneTitle.color = getTextColor()
    m.messageLabel = m.top.findNode("message_label")
    m.messageLabel.color = getTextColor()
    ' m.loading = m.top.findNode("loading")
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor1()

    m.top.observeField("visible", "OnTopVisibilityChange")
    m.rowlist = m.top.findNode("CategoryListing")
    m.rowlist.color = getTextColor()
    m.rowlist.focusedColor = getTextColor()
    m.rowlist.focusBitmapBlendColor = getButtonSelectionColor()
    m.rowList.rowLabelColor = getTextColor()
    ' m.top.start = "start"
end sub

sub runMoreTask()
    ? m.top.key
    m.VideoFetcher = CreateObject("roSGNode", "VideoFetcher")
    m.VideoFetcher.observeField("Content", "onContentChanged")
    m.VideoFetcher.taskType = "ContentRequest"
    m.VideoFetcher.ContentRequest = m.top.key
    m.VideoFetcher.callFunc("runVideoFetcherTask", "")

    ?"kl"
end sub

sub onContentChanged()
    m.top.Content = m.VideoFetcher.Content
    ?"kk"
    rowHeights = [240] ' Default initialization
    rowItemSize = [[320, 180]] ' Default initialization
    numRows = 1

    for i = 0 to m.top.content.getChildCount() - 1

        if m.top.content <> invalid and m.top.content.getChild(i) <> invalid and m.top.content.getChild(i).getChild(0) <> invalid and m.top.content.getChild(i).getChild(0).thumbnail_orientation <> invalid
            thumbnail_orientation = m.top.content.getChild(i).getChild(0).thumbnail_orientation
        else
            thumbnail_orientation = getThumbnailOrientaion()

        end if


        if thumbnail_orientation = "LANDSCAPE"
            rowHeights = [240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240]
            rowItemSize = [[320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180]]
            numRows = 4
        else
            thumbnail_orientation = "PORTRAIT"
            rowHeights = [400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400]
            rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
            numRows = 6

        end if
    end for
    ' if getThumbnailOrientaion() = "LANDSCAPE"
    '     rowHeights = [320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320]
    '     rowItemSize = [[320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180]]
    ' else if getThumbnailOrientaion() = "PORTRAIT"
    '     rowHeights = [400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400]
    '     rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
    ' end if

    m.rowList.rowHeights = rowHeights
    m.rowList.rowItemSize = rowItemSize
    m.rowList.numRows = numRows

    for i = 0 to m.top.content.getChildCount() - 1 ' ######### orientation change
        thumbnail_orientation = "LANDSCAPE"
        if m.top.content <> invalid and m.top.content.getChild(i) <> invalid and m.top.content.getChild(i).getChild(0) <> invalid and m.top.content.getChild(i).getChild(0).thumbnail_orientation <> invalid
            thumbnail_orientation = m.top.content.getChild(i).getChild(0).thumbnail_orientation
        end if

        if thumbnail_orientation <> invalid
            if thumbnail_orientation = "PORTRAIT"
                rowHeights.SetEntry(i, 350)
                rowItemSize.SetEntry(i, [200, 300])
            else if thumbnail_orientation = "LANDSCAPE"
                rowHeights.SetEntry(i, 240)
                rowItemSize.SetEntry(i, [320, 180])
            end if
            m.rowList.rowHeights = rowHeights
            m.rowList.rowItemSize = rowItemSize
        end if
    end for

    m.rowList.content = m.top.content

    if m.VideoFetcher.Content <> invalid and m.VideoFetcher.Content.getChildcount() <> invalid and m.VideoFetcher.Content.getChild(1) <> invalid and m.VideoFetcher.Content.getChild(1).getChildCount() = 0
        m.sceneTitle.visible = false
        m.ShowMoreRowlist.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"

    else if (m.VideoFetcher.Content = invalid)
        m.sceneTitle.visible = false
        m.ShowMoreRowlist.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"

    else
        m.top.content = m.VideoFetcher.Content
        m.CategoryListing.content = m.VideoFetcher.Content
        if m.VideoFetcher <> invalid and m.VideoFetcher.Content <> invalid and m.VideoFetcher.Content.title <> invalid then
            m.sceneTitle.text = m.VideoFetcher.Content.title
        end if
        m.messageLabel.visible = false
    end if
    ' m.loading.visible = false
    m.CategoryListing.setFocus(true)
    ?"kl"

    ?"dd"
end sub




sub onContentChangedForAdditionalDonorContent()
    ?"onContentChangedForAdditionalDonorContent called"
    if (m.CategoryVideosListApiTask.CategoryVideosListApiTaskContent <> invalid and m.CategoryVideosListApiTask.CategoryVideosListApiTaskContent.getChildCount() = 0)
        m.sceneTitle.visible = false
        m.ShowMoreRowlist.visible = false
        m.messageLabel.visible = true
        m.messageLabel.text = "No Data Found!"
    else
        m.top.content = m.CategoryVideosListApiTask.CategoryVideosListApiTaskContent
        m.sceneTitle.text = "Additional Donor Content"
        m.messageLabel.visible = false
    end if
    m.loading.visible = false
    m.ShowMoreRowlist.setFocus(true)
end sub



sub OnTopVisibilityChange()
    if m.top.visible = true
        m.CategoryListing.setFocus(true)
    end if
end sub


function OnkeyEvent(key, press) as boolean

    result = false
    if press


        if key = "back"

        else if key = "left"


        else if key = "right"

        else if key = "up"
        else if key = "down"
            ' m.ShowMoreRowlist.setFocus(true)
        else if key = "OK"

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

function restructureContentForRowList(flatContent as object, itemsPerRow as integer) as object
    if flatContent = invalid or flatContent.getChildCount() = 0
        return invalid
    end if

    ' Create the main node that will hold all the rows
    structuredContent = createObject("roSGNode", "ContentNode")

    ' Create the first row node
    rowNode = structuredContent.createChild("ContentNode")
    rowNode.title = "Categories" ' Give the first row a title

    ' Loop through all the flat items
    for i = 0 to flatContent.getChildCount() - 1
        ' If the current row is full, create a new one
        if rowNode.getChildCount() = itemsPerRow
            rowNode = structuredContent.createChild("ContentNode")
            ' You can give subsequent rows titles too if you want
            ' rowNode.title = "More Categories"
        end if

        ' Get the item from the flat list
        item = flatContent.getChild(i)

        ' Add a copy of the item to the current row
        rowNode.appendChild(item)
    end for

    return structuredContent
end function


