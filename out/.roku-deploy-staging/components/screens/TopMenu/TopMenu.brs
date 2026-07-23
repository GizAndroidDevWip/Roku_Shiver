' components/TopMenu.brs
sub init()
    m.rowList = m.top.findNode("HomeTopMenuRowlist")
    m.top_gradient = m.top.findNode("top_gradient")
    m.textMeasurerLabel = createObject("roSGNode", "Label")
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Medium.ttf"
    font.size = 25
    m.textMeasurerLabel.font = font
    initialiseTopMenuRowlist()
end sub

sub onSetFocus()
    if m.rowList <> invalid and m.rowList.content <> invalid
        ' Check if the first row exists
        firstRow = m.rowList.content.getChild(0)
        if firstRow <> invalid and firstRow.getChildCount() > 2
            m.rowList.setFocus(true)
        end if
    end if
end sub

sub initialiseTopMenuRowlist()
    m.rowList.content = invalid
    m.top_gradient.blendColor = getBackGroundColor()
    cIndex = 0
    BaseContentNode = CreateObject("RoSGNode", "ContentNode")
    ParentContentNode = CreateObject("RoSGNode", "ContentNode")

    ' --- Track utility existence safely ---
    utilityNodeExists = false


    ' --- Add SMART_HOME_PAGES ---
    for each itemAA in m.global.SMART_HOME_PAGES
        itemContentNode = CreateObject("RoSGNode", "ContentNode")
        itemContentNode.title = itemAA.title

        itemContentNode.addFields({
            "index": cIndex,
            "isSelectedNow": false,
            "lastFocused": false,
            "page_id": itemAA.page_id,
            "vanity_url": itemAA.vanity_url,
            "type": itemAA.type,
            "isSearchIcon": false
        })

        itemContentNode.addField("FHDItemWidth", "float", false)
        itemContentNode.FHDItemWidth = backgroundPosterLength(itemAA.title)

        ParentContentNode.appendChild(itemContentNode)
        cIndex = cIndex + 1
    end for

    if ParentContentNode.getChildCount() = 0 then return

    ' --- Add Subscription Node ---

    if IsNotBlank2(getSubscriptionRequired()) and getSubscriptionRequired() = "true" then
        if IsNotBlank2(getIsUserSubscribed()) and getIsUserSubscribed() = "false" then
            ' --- Add Subscription Node ---
            subscriptionNode = CreateObject("RoSGNode", "ContentNode")
            subscriptionNode.title = getText("subscribe")

            subscriptionNode.addFields({
                "index": cIndex,
                "isSelectedNow": false,
                "lastFocused": false,
                "page_id": "subscription_page_id",
                "vanity_url": "subscribe",
                "type": "subscription",
                "isSearchIcon": false
            })

            subscriptionNode.addField("FHDItemWidth", "float", false)
            subscriptionNode.FHDItemWidth = backgroundPosterLength(subscriptionNode.title)


            ParentContentNode.appendChild(subscriptionNode)
            cIndex = cIndex + 1
        end if
    end if



    ' --- Add Search Node ---
    m.searchNode = CreateObject("RoSGNode", "ContentNode")
    m.searchNode.title = getText("search")
    m.searchNode.id = "search_node"

    m.searchNode.addFields({
        "index": cIndex,
        "isSelectedNow": false,
        "lastFocused": false,
        "page_id": "search_page_id",
        "vanity_url": "searchIcon",
        "type": "search",
        "isSearchIcon": true
    })

    m.searchNode.addField("FHDItemWidth", "float", false)
    m.searchNode.FHDItemWidth = 40

    if ParentContentNode.getChildCount() > 0 then
        ParentContentNode.appendChild(m.searchNode)
    end if


    ' --- Attach to Base Node ---
    BaseContentNode.appendChild(ParentContentNode)


    ' --- Assign to RowList and Set Focus ---
    if BaseContentNode <> invalid and BaseContentNode.getChild(0) <> invalid and BaseContentNode.getChild(0).getChildCount() > 0

        m.rowList.content = BaseContentNode
        m.rowList.visible = true



        ' if Utility node exists
        if utilityNodeExists = true
            m.rowList.jumpToRowItem = [0, 0]
            m.rowList.rowItemFocused = [0, 0]
            m.rowList.setFocus(true)
            m.GridScreen.categorynodefocus = true
        end if

    else
        m.rowList.visible = false
    end if
end sub

function backgroundPosterLength(input)
    m.textMeasurerLabel.text = input
    textWidth = m.textMeasurerLabel.boundingRect().width ' boundingRect() gives you the width and height of the rendered text
    return textWidth + 35 ' Adding some padding to the width for better aesthetics
end function

' function backgroundPosterLength2(input)
'     for inputValue = 1 to 200
'         returnValue = calculateReturn(inputValue)
'         if input = inputValue
'             return returnValue
'         end if
'     end for
'     ' return 60 + (input - 1) * 9
' end function

' function calculateReturn(inputValue as integer) as integer
'     if inputValue < 1 or inputValue > 200
'         return invalid ' Input out of range
'     end if
'     return 75 + (inputValue - 1) * 9
' end function

sub updateSearchIconVisibility()
    if m.top.content = invalid then return
    parentContent = m.top.content.getchild(0)
    if parentContent = invalid then return

    searchNodeIndex = -1
    for i = 0 to parentContent.getChildCount() - 1
        child = parentContent.getChild(i)
        if child.id = "search_node"
            searchNodeIndex = i
            exit for
        end if
    end for

    shouldShow = m.top.SearchIconVisibility

    ' Remove if it exists but shouldn't
    if not shouldShow and searchNodeIndex <> -1
        parentContent.removeChildIndex(searchNodeIndex)

        ' Add if it's missing but should be there
    else if shouldShow and searchNodeIndex = -1
        ' searchNode = CreateObject("RoSGNode", "ContentNode")
        ' searchNode.id = "search_node"
        ' searchNode.title = "search"
        ' searchNode.addFields({
        '     "isSearchIcon": true,
        '     "vanity_url": "searchIcon",
        '     "FHDItemWidth": 40
        ' })
        parentContent.appendChild(m.searchNode)
    end if
end sub

sub onRowItemFocusedChange()
    if m.rowList <> invalid and m.top.rowItemFocused <> invalid
        m.rowList.rowItemSelected = m.top.rowItemFocused
    end if
end sub

sub onJumpedToRowItem()
    if m.rowList <> invalid and m.top.jumpToRowItem <> invalid
        m.rowList.jumpToRowItem = m.top.jumpToRowItem
    end if
end sub

