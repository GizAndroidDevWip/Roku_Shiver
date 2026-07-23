' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    m.top.observeField("visible", "onTopVisibleChange")
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Bold.ttf"
    font.size = 200
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor()
    m.OptionsIcon = m.top.findNode("OptionsIcon")
    m.loadingProgress = m.top.findNode("loading")
    m.loadingProgress.visible = true
    m.LogoutTask = CreateObject("roSGNode", "LogoutTask")
    m.LogoutTask.observeField("LogoutResponse", "OnLogoutResponse")
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogoutResponseAll")
    m.VideoFetcher = CreateObject("roSGNode", "VideoFetcher")
    m.VideoFetcher.observeField("content", "onContentChanged")
    m.VideoFetcher.observeField("LabelContent", "onLabelContentChanged")' label category content
    m.VideoFetcher.observeField("CatBoolean", "onContentEmptyChanged") ' this is main category content
    m.VideoSubscriptionTask = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.PaymentDescription = m.top.findNode("PaymentDescription")
    m.Dialog = m.top.findnode("Dialog")
    m.PanelSet = m.top.findNode("PanelSet")
    m.PanelSet.translation = [-50, 90]
    m.listPanel = m.panelSet.CreateChild("ListPanel")
    m.listPanel.translation = [0, 300]
    m.listPanel.observeField("createNextPanelIndex", "OnCreateNextPanelIndex")
    m.DetailsListPanel = CreateObject("roSGNode", "LabelListPanel")
    m.DetailsListPanel.id = "DetailListPanel"
    m.DetailsListPanel.list.observeField("itemfocused", "OnDetailsListPanelItemFocused")
    m.DetailsListPanel.list.observeField("itemSelected", "OnDetailsListPanelItemSelected")

    m.sceneTitle = m.top.findNode("sceneTitle")
    m.sceneTitle.font.size = 55
    m.sceneTitle.color = getTextColor()

    m.LabelList = CreateObject("roSGNode", "LabelList")
    m.LabelList.font = "font:MediumBoldSystemFont"
    m.LabelList.color = getTextColor()
    m.LabelList.focusedColor = "#FFFFFF"
    m.LabelList.itemSize = "[400,115]"
    m.LabelList.textHorizAlign = "left"
    m.LabelList.font.size = 35
    m.LabelList.focusBitmapBlendColor = getButtonSelectionColor()
    m.LabelList.focusFootprintBlendColor = getButtonSelectionColor()
    m.LabelList.translation = [100, 500]
    m.LabelList.numRows = 7
    m.LabelList.focusedFont = "font:MediumBoldSystemFont"
    m.LabelList.focusedFont.size = m.LabelList.font.size
    m.LabelList.vertFocusAnimationStyle = "floatingFocus"

    m.LabelList.observeField("itemFocused", "OnLabelListSelected")
    m.listPanel.list = m.LabelList
    m.listPanel.appendChild(m.LabelList)
    m.top.backgroundURI = "pkg:/images/background.jpg"
    OptionsList = [{ Title: "Play" }]
    m.top.OptionsContent = ContentList2Node(OptionsList)
    m.screenStack = []
    m.Channel = m.top.findNode("Channel")
    m.MenuIcon = m.top.findNode("OptionsIcon")
    m.RowList = m.top.findNode("RowList")
    m.lbl1 = m.top.findNode("lbl1")
    m.lbl1.color = "#ffffff"
    m.HomeTopMenuRowlist = m.top.getScene().findNode("HomeTopMenuRowlist")
    m.debounceTimer = m.top.findNode("debounceTimer")
    ' m.homescene = CreateObject("roSGNode", "HomeScene")
    m.top.start = "start"
end sub



sub onStarted()
    print "starting all categories"
    if m.top.content = invalid
        m.VideoFetcher.taskType = "CatRequest"
        m.VideoFetcher.callFunc("runVideoFetcherTask", "")

    else
        m.LabelList.setFocus(true)
    end if
end sub



sub onTopVisibleChange()
    if m.top.visible = true
        m.LabelList.setFocus(true)
    end if
end sub




sub ShowScreen(node)
    prev = m.screenStack.peek()
    if prev <> invalid
        prev.visible = false
    end if
    node.visible = true
    node.setFocus(true)
    m.screenStack.push(node)
end sub



sub onContentChanged()
    ?"onContentChanged called"
    ?m.VideoFetcher.Content
    m.loadingProgress.visible = false
    m.top.Content = m.VideoFetcher.Content
    ' m.RowList.setFocus(true)
end sub

sub OnChangeContent()

    if m.ContentListPanel <> invalid and m.top.content.getChildCount() > 0
        for i = 0 to m.top.content.getChildCount() - 1

            if m.top.content <> invalid and m.top.content.getChild(i) <> invalid and m.top.content.getChild(i).getChild(0) <> invalid and m.top.content.getChild(i).getChild(0).thumbnail_orientation <> invalid
                thumbnail_orientation = m.top.content.getChild(i).getChild(0).thumbnail_orientation
            else
                thumbnail_orientation = getThumbnailOrientaion()

            end if


            if getThumbnailOrientaion() = "LANDSCAPE"
                rowHeights = [321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 321, 290]
                rowItemSize = [[422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231], [422, 231]]
                numrows = 4
            else if getThumbnailOrientaion() = "PORTRAIT"
                rowHeights = [440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 400]
                rowItemSize = [[250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375]]
                numrows = 3
            end if


            rowItemSpacing = [[32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15], [32, 15]]
            focusXOffset = [[110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110]]

        end for
        m.ContentListPanel.categoryRowlist.rowHeights = rowHeights
        m.ContentListPanel.categoryRowlist.rowItemSize = rowItemSize
        m.ContentListPanel.categoryRowlist.rowItemSpacing = rowItemSpacing
        m.ContentListPanel.categoryRowlist.focusXOffset = focusXOffset
        m.ContentListPanel.categoryRowlist.numRows = numRows


        for i = 0 to m.top.content.getChildCount() - 1 ' ######### orientation change
            thumbnail_orientation = "LANDSCAPE"
            if m.top.content <> invalid and m.top.content.getChild(i) <> invalid and m.top.content.getChild(i).getChild(0) <> invalid and m.top.content.getChild(i).getChild(0).thumbnail_orientation <> invalid
                thumbnail_orientation = m.top.content.getChild(i).getChild(0).thumbnail_orientation
            end if

            if thumbnail_orientation <> invalid
                if thumbnail_orientation = "PORTRAIT"
                    rowHeights.SetEntry(i, 440)
                    rowItemSize.SetEntry(i, [250, 375])
                else if thumbnail_orientation = "LANDSCAPE"
                    rowHeights.SetEntry(i, 321)
                    rowItemSize.SetEntry(i, [422, 231])
                end if
                m.ContentListPanel.categoryRowlist.rowHeights = rowHeights
                m.ContentListPanel.categoryRowlist.rowItemSize = rowItemSize
            end if
        end for
        m.ContentListPanel.categoryRowlist.content = m.top.content
        ?"l"
        if m.ContentListPanel <> invalid and m.ContentListPanel.categoryRowlist <> invalid and m.ContentListPanel.categoryRowlist.content <> invalid and m.ContentListPanel.categoryRowlist.content.getChildCount() <> invalid and m.ContentListPanel.categoryRowlist.content.getChildCount() <> 0
            m.lbl1.visible = false
        else
            m.lbl1.visible = true
        end if
    end if
end sub


sub onLabelContentChanged()
    m.top.LabelContent = m.VideoFetcher.LabelContent
end sub



sub onContentEmptyChanged()
    print "onContentEmptyChanged"
    if(m.VideoFetcher.CatBoolean = true) then
        m.lbl1.visible = true
    else
        m.lbl1.visible = false
    end if
end sub


sub OnLabelListSelected()
    ' If timer is running, ignore the click
    if m.debounceTimer.control = "start" then return
    
    ' Start cool-down timer immediately
    m.debounceTimer.control = "start"

    focusedItem = m.LabelList.content.getChild(m.LabelList.itemFocused)
    if focusedItem <> invalid
        ?"OnLabelListSelected called: " + focusedItem.title
        m.VideoFetcher.ContentRequest = focusedItem.key
        m.VideoFetcher.taskType = "ContentRequest"
        m.VideoFetcher.callFunc("runVideoFetcherTask", "")
    end if
end sub



sub OnChangeLabelContent()
    print "OnChangeLabelContent called"
    m.LabelList.content = m.top.LabelContent
    m.loadingProgress.visible = false
    m.LabelList.setFocus(true)
end sub



sub OnChangeOptionsContent()
    m.DetailsListPanel.list.content = m.top.OptionsContent
end sub





sub OnCreateNextPanelIndex()
    print "OnCreateNextPanelIndex called"
    m.ContentListPanel = CreateObject("roSGNode", "MarkupListPanel")
    if m.ContentListPanel = invalid then return
    list = m.ContentListPanel.categoryRowlist
    list.translation = [0, 65]
    list.itemSize = [1080, 1080]
    list.color = getTextColor()
    list.focusBitmapBlendColor = getButtonSelectionColor()
    list.observeField("rowItemFocused", "OnContentListPanelItemFocused")
    list.observeField("rowItemSelected", "OnDetailsListPanelItemSelected")
    m.listPanel.nextPanel = m.ContentListPanel
    if m.top.content <> invalid
        ' m.ContentListPanel.categoryRowlist.content = m.top.content
    end if
end sub



sub OnContentListPanelItemFocused()
    print "oncontentlistpanelitemfocused called"
    if m.ContentListPanel = invalid then return
    list = m.ContentListPanel.categoryRowlist
    itemFocused = list.rowItemFocused

    if itemFocused.Count() = 2 then
        focusedContent = m.top.Content.getChild(itemFocused[0]).getChild(itemFocused[1])
        print focusedContent

        if focusedContent <> invalid then
            m.top.VODcontent = focusedContent
        end if
    end if
end sub



sub OnDetailsListPanelItemFocused()
end sub



sub OnDetailsListPanelItemSelected()
    m.ContentListPanel.categoryRowlist.setFocus(true)

    rowList = m.ContentListPanel.categoryRowlist
    if getBYPASS_SHOW_DETAILS_SCREEN() = "true" and rowList <> invalid and rowList.content <> invalid and rowList.rowItemSelected <> invalid then
        rowIndex = rowList.rowItemSelected[0]
        itemIndex = rowList.rowItemSelected[1]
        rowNode = rowList.content.getChild(rowIndex)
        itemNode = invalid
        if rowNode <> invalid then itemNode = rowNode.getChild(itemIndex)

        if itemNode <> invalid and itemNode.video_id <> invalid and itemNode.video_id <> "" then
            m.top.goToVideoPlayerScene = rowList.rowItemSelected ' passing rowItemSelected value to logic class
        else
            m.top.goToShowDetailsScreen = rowList.rowItemSelected ' passing rowItemSelected value to logic class
        end if
    else
        m.top.goToShowDetailsScreen = rowList.rowItemSelected ' passing rowItemSelected value to logic class
    end if
end sub



function onKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press then
        if m.HomeTopMenuRowlist.isInFocusChain() 'HomeTopMenuRowlist key handling
            if key = "right" or key = "left"
                return true
            else if key = "down"
                m.LabelList.setFocus(true)
                return true
            end if
        else if key = "up" and m.LabelList.isInFocusChain() or key = "up" and m.ContentListPanel.categoryRowlist.hasFocus()
            m.HomeTopMenuRowlist.SET_FOCUS = true
            return true
        end if

        if key = "back" then
            print "backpressed"
            '  m.homescene.backToHomeSceneNotifier = "show"
            if m.PaymentDescription.visible = true
                m.PaymentDescription.visible = false
                m.OptionsIcon.visible = true
                m.ContentListPanel.visible = true
                m.LabelList.visible = true
                m.LabelList.setFocus(true)
                result = true
            end if

            if m.Channel.visible = true
                m.Channel.visible = false
                m.LabelList.setFocus(true)
                result = true
            end if



        else if key = "right"
            if not m.ContentListPanel.categoryRowlist.hasFocus()
                m.LabelList.SetFocus(true)
            end if

        else if key = "options" then
            if m.PaymentDescription.visible = false

                result = true

            else
                result = true
            end if

        end if
    else if key = "back" and m.dialog.visible then
        m.Dialog.visible = false
        m.focusedNode.SetFocus(true)
        result = true
    end if
    return result
end function



function strReplace(basestr as string, oldsub as string, newsub as string) as string

    newstr = ""

    i = 1
    while i <= Len(basestr)
        x = Instr(i, basestr, oldsub)
        if x = 0 then
            newstr = newstr + Mid(basestr, i)
            exit while
        end if

        if x > i then
            newstr = newstr + Mid(basestr, i, x - i)
            i = x
        end if

        newstr = newstr + newsub
        i = i + Len(oldsub)
    end while

    return newstr
end function



sub onVisibleChange()
    print "onVisibleChange called"
end sub



sub onVisibleSearchChange()

end sub



sub DeleteRegistry()
    print "Starting Delete Registry"
    m.LogoutTask.callFunc("runLogoutTask", "")
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1
            print "Deleting " section + ":" key
            RegistrySection.Delete(key)
        end for
        RegistrySection.flush()
    end for
    print i.toStr() " Registry Keys Deleted"
    m.top.logout = true
end sub



sub DeleteRegistryAll()
    print "Starting Delete Registry"
    m.LogoutTaskAll.callFunc("runLogoutTask", "")
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1
            print "Deleting " section + ":" key
            RegistrySection.Delete(key)
        end for
        RegistrySection.flush()
    end for
    print i.toStr() " Registry Keys Deleted"
    m.top.logoutall = true
end sub


sub onSetDefaultFocus()
    m.LabelList.setFocus(true)
end sub

