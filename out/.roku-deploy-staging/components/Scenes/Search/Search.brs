
function Init()
    ? "[Search] Init"
    m.keyboard = m.top.findNode("Keyboard")
    m.SearchRowlist = m.top.findNode("Grid")
    m.SearchRowlist.rowLabelColor = getTextColor()
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Poppins-Bold.ttf"
    font.size = 24
    font.color = getTextColor()
    m.SearchRowlist.rowLabelFont = font
    m.Show = m.top.findNode("Show")
    m.SearchKeyBoardContainer = m.top.findNode("SearchKeyBoardContainer")
    m.SearchKeyBoardContainer.color = getBackGroundColor()
    m.searchFilterLabelList = m.top.findNode("searchFilterLabelList")
    m.searchFilterLabelList.color = getTextColor()
    m.searchFilterLabelList.focusedColor = getTextColor()
    m.searchFilterLabelList.focusFootprintBlendColor = getTextColor()
    m.searchFilterLabelList.font = "font:MediumSystemFont"
    m.searchFilterLabelList.focusBitmapUri = "pkg:/images/data-back.png"
    m.searchFilterLabelList.itemSize = "[500,50]"
    m.searchFilterLabelList.itemSpacing = "[0,20]"
    m.searchFilterLabelList.textHorizAlign = "left"
    m.searchFilterLabelList.font.size = 28
    m.searchFilterLabelList.focusedFont = "font:MediumBoldSystemFont"
    m.searchFilterLabelList.focusedFont.size = m.searchFilterLabelList.font.size + 10
    m.searchFilterLabelList.observeField("itemSelected", "onSearchFilterLabelListSelected")

    if getCustomFiltersRequired() = "true"
        m.searchFilterLabelList.visible = true
    else
        m.searchFilterLabelList.visible = false
    end if

    m.searchFilterLebellist_rect = m.top.findNode("searchFilterLebellist_rect")
    m.searchFilterLebellist_rect.color = getBackGroundColor()
    m.searchFilterText = m.top.findNode("searchFilterText")
    m.searchFilterText.color = getTextColor()
    m.searchFilterText2 = m.top.findNode("searchFilterText2")
    m.searchFilterText2.color = getTextColor()
    m.searchFilter_subccategory_labellist = m.top.findNode("searchFilter_subccategory_labellist")
    m.searchFilter_subccategory_labellist.focusBitmapBlendColor = getButtonSelectionColor()
    m.searchFilter_subccategory_labellist.focusFootprintBlendColor = getButtonSelectionColor()
    m.searchFilter_subccategory_labellist.color = getTextColor()
    m.searchFilter_subccategory_labellist.focusedColor = "#ffffff"
    m.searchFilter_subccategory_labellist.observeField("itemSelected", "onSearchFilterSubcategoryLabelListSelected")
    m.scrollUpAnimation = m.top.FindNode("scrollup_animation")
    m.scrollDownAnimation = m.top.FindNode("scrolldown_animation")
    m.resultsText = m.top.findNode("resultsText")
    m.keyboard.textEditBox.visible = false
    m.top.observeField("visible", "OnTopVisibilityChange")
    m.videoTitle = m.top.findNode("VideoTitle")
    m.videoTitle.text = ""
    m.videoTitle.font.size = "50"
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackGroundColor()

    m.keyboard.keyColor = "#FFFFFF"
    m.keyboard.focusedKeyColor = "#FFFFFF"
    m.SearchRowlist.focusBitmapUri = "pkg:/images/focus_grid.9.png"
    m.VideoTitle.color = "#ffffff"
    m.keyboard.setFocus(true)
    m.AppBackground.translation = [0, 0]
    m.AppBackground.width = 1920
    m.AppBackground.height = 1080
    m.noResultsFoundLabel = m.top.findNode("lbl1")
    m.noResultsFoundLabel.text = getText("no_results_found")
    m.SearchFilterTask = CreateObject("roSGNode", "SearchFilterTask")
    m.SearchFilterTask.observeField("SearchFilterContent", "onSearchFilterContent")
    m.SearchFilterTask.callFunc("runSearchFilterTask", "")

    m.noResultsFoundLabel.color = "#ffffff"
    m.SearchFetcher = CreateObject("roSGNode", "SearchFetcher")
    m.SearchFetcher.observeField("searchContent", "onContentChanged")
    m.SearchFetcher.observeField("SearchBoolean", "onContentEmptyChanged")
    m.SearchTitleAndSearchString = m.top.findNode("SearchTitleAndSearchString")
    m.SearchTitleAndSearchString.text = getText("search_placeholder")
    m.SearchTitleAndSearchString.color = "#8f8d8d"
    m.searchSuggestionLabelList = m.top.findNode("searchSuggestionLabelList")
    m.searchSuggestionLabelList.observeField("itemSelected", "onSearchSuggestionLabelListSelected")


    m.currentlyScrolledUp = false
    m.searchFilterLabelList.observeField("focusedChild", "onSearchFilterLabelListFocused")
    m.keyboard.observeField("focusedChild", "onKeyboardFocused")

    m.SearchSuggestionFetcherTask = CreateObject("roSGNode", "SearchSuggestionFetcherTask")
    m.SearchSuggestionFetcherTask.observeField("searchSuggestionContent", "OnSearchSuggestionFetcherContent")
    m.searchNowButton = m.top.findNode("searchNowButton")
    m.searchNowButton.observeField("focusedChild", "onSearchNowButtonFocused")
    m.searchNowButton.observeField("buttonSelected", "onSearchNowButtonSelected")
    m.screenStack = []

    m.VideoTitle.color = getTextColor()
    m.noResultsFoundLabel.color = getTextColor()
    m.keyboard.keyColor = getTextColor()
    m.SearchRowlist.focusBitmapBlendColor = getButtonSelectionColor()
    m.SearchRowlist.color = "#000000"

    m.HomeTopMenuRowlist = m.top.getScene().findNode("HomeTopMenuRowlist")
    m.HomeTopMenuRowlist.SearchIconVisibility = false
    runsearchFetcherTask2()
end function

sub onContentEmptyChanged()
    if(m.SearchFetcher.SearchBoolean = true) then

        m.noResultsFoundLabel.visible = true

    else
        m.noResultsFoundLabel.visible = false

    end if

end sub



function onSearchStringChanged()
    m.noResultsFoundLabel.visible = false
    m.SearchRowlist.visible = false
    if Len(m.top.SearchString) > 80 then
        limit = Mid(m.top.SearchString, 0, 10)
        m.top.SearchString = limit
    else
        if not m.keyboard.textEditBox.text = ""
            m.SearchTitleAndSearchString.color = getTextColor()
            m.SearchTitleAndSearchString.text = "  " + m.top.SearchString
        else
            m.SearchTitleAndSearchString.color = "#8f8d8d"
            m.SearchTitleAndSearchString.text = getText("search_placeholder")

        end if
        ?"m.top.SearchString printed in between these arrows >>" + m.top.SearchString + "<<"

        m.searchSuggestionLabelList.visible = false
        runsearchFetcherTask2()

    end if
end function



function onContentChanged()
    if getThumbnailOrientaion() = "LANDSCAPE"
        rowHeights = [287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 287, 320]
        rowItemSize = [[350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197], [350, 197]]
    else if getThumbnailOrientaion() = "PORTRAIT"
        rowHeights = [440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 440, 450]
        rowItemSize = [[250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375], [250, 375]]
    end if

    m.SearchRowlist.rowHeights = rowHeights
    m.SearchRowlist.rowItemSize = rowItemSize
    if m.SearchFetcher.searchContent <> invalid and m.SearchFetcher.searchContent.getChildCount() <> invalid and m.SearchFetcher.searchContent.getChildCount() <> 0
        for i = 0 to m.SearchFetcher.searchContent.getChildCount() - 1
            if m.SearchFetcher.searchContent <> invalid and m.SearchFetcher.searchContent.getChild(0) <> invalid and m.SearchFetcher.searchContent.getChild(0).getchild(i) <> invalid and m.SearchFetcher.searchContent.getChild(0).getchild(i).categoryType <> invalid
                categoryType = m.SearchFetcher.searchContent.getChild(i).getchild(0).categoryType
            else
                categoryType = ""
            end if


            if categoryType <> invalid
                if categoryType = "SHORTS"
                    rowHeights.SetEntry(i, 456)
                    m.SearchRowlist.rowHeights = rowHeights
                    rowItemSize.SetEntry(i, [200, 356])
                    m.SearchRowlist.rowItemSize = rowItemSize
                end if
            end if

            if categoryType = "PODCASTS" <> invalid
                if categoryType = "PODCASTS"
                    rowHeights.SetEntry(i, 320)

                    m.SearchRowlist.rowHeights = rowHeights
                    rowItemSize.SetEntry(i, [350, 197])
                    m.SearchRowlist.rowItemSize = rowItemSize
                end if
            end if
        end for
    else
        m.top.content = m.SearchFetcher.searchContent
        m.SearchRowlist.visible = false
        if m.top.searchString <> "" then m.noResultsFoundLabel.visible = true
    end if

    if m.SearchFetcher.searchContent <> invalid and m.SearchFetcher.searchContent.getChild(0) <> invalid and m.SearchFetcher.searchContent.getChild(0).getChildCount() <> 0
        ' if m.top.searchString = ""
        '     m.SearchFetcher.searchContent.getchild(0).title = ""
        ' end if
        m.top.content = m.SearchFetcher.searchContent
        m.SearchRowlist.visible = true

    else
        m.top.content = m.SearchFetcher.searchContent
        m.SearchRowlist.visible = false
        if m.top.searchString <> "" then m.noResultsFoundLabel.visible = true

    end if
end function

function onSearchFilterContent()
    m.SearchFilterTask.callFunc("stopSearchFilterTask")
    m.searchFilterLabelList.content = m.SearchFilterTask.searchFilterContent
end function

function onSearchFilterLabelListSelected()
    m.searchFilterLebellist_rect.visible = true
    m.searchFilterText.text = m.searchFilterLabelList.content.getChild(m.searchFilterLabelList.itemSelected).title
    m.searchFilter_subccategory_labellist.content = m.searchFilterLabelList.content.getChild(m.searchFilterLabelList.itemSelected).SubcategoryMainContentNode
    m.searchFilter_subccategory_labellist.setFocus(true)
end function

function onSearchFilterSubcategoryLabelListSelected(params)
    runsearchFetcherTask2()
    m.searchFilterLabelList.setFocus(true)
end function

function runsearchFetcherTask2()
    m.noResultsFoundLabel.visible = false
    if m.searchFilterLabelList.content <> invalid and m.searchFilter_subccategory_labellist.content <> invalid then
        labelChild = m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected)
        subcategoryChild = m.searchFilter_subccategory_labellist.content.getchild(m.searchFilter_subccategory_labellist.itemSelected)

        if labelChild <> invalid and subcategoryChild <> invalid then
            labelChild.option_id_selected_currently = subcategoryChild.option_id
        end if
        if subcategoryChild.title = "All"
            m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected).is_selected = false
            m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected).HDLISTITEMICONURL = invalid
            m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected).HDLISTITEMICONSELECTEDURL = invalid
        else
            m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected).is_selected = true
            m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected).HDLISTITEMICONURL = "pkg:/images/icons/tick.png"
            m.searchFilterLabelList.content.getchild(m.searchFilterLabelList.itemSelected).HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/tick.png"

        end if
    end if

    m.searchFilterLebellist_rect.visible = false
    m.SearchFetcher.SearchRequest = m.keyboard.textEditBox.text
    m.SearchFetcher.searchFilter = getSelectedLabelListItems()
    m.SearchFetcher.callFunc("runSearchFetcherTask", "")
end function

function getSelectedLabelListItems()
    filters = []
    labelListContent = m.searchFilterLabelList.content

    if labelListContent <> invalid and labelListContent.getChildCount() > 0
        for i = 0 to labelListContent.getChildCount() - 1
            item = labelListContent.getChild(i)
            if item.is_selected = true
                filterObj = {
                    filter_id: item.filter_id
                    option_id: item.option_id_selected_currently
                }
                filters.Push(filterObj)
            end if
        end for
    end if
    return filters
end function

function OnRowItemSelected()
    videoid = m.SearchFetcher.searchContent.getChild(0).getChild(0)
    vid = videoid.video_id
    vidurl = videoid.URL
    vidname = videoid.TITLESEASON
    content = m.top.focusedContent
    VODcontent = m.top.focusedContent.user_id
    vid = content.video_id
    vidurl = content.URL
    vidname = content.TITLESEASON
    catename = content.categories


    if(vid <> invalid)
        cat = catename

        if cat <> invalid then
            category = ""
            arrayLength = cat.count()
            lastItem = cat[arrayLength - 1]

            for each item in cat
                if(arrayLength < 2)
                    category = category + item
                else
                    if(item = lastItem)
                        category = category + item
                    else
                        category = category + item + ","
                    end if
                end if
            end for


            catloc = category
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("category", catloc)
            sec.Flush()

            '        end if
        end if

        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("shwid", VODcontent)
        sec.Flush()


        print "ShowScreen(m.Show)"
        m.Show.start = VODcontent
        m.Show.Content = m.top.focusedContent
        m.Show.visible = true
        m.Show.setFocus(true)

    else

        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("shwid", VODcontent)
        sec.Flush()
        m.Show.start = VODcontent
        m.Show.Content = m.top.focusedContent
        m.Show.visible = true
        m.Show.setFocus(true)

    end if
end function

sub OnContentChange()
end sub


sub OnItemFocused()
    itemFocused = m.top.itemFocused
    if itemFocused.Count() = 2 then
        focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
        if focusedContent <> invalid then
            ? "focusedContent: ", focusedContent
            m.top.focusedContent = focusedContent
            print focusedContent.titleseason
        end if
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press then
        if m.HomeTopMenuRowlist.isInFocusChain() 
            if key = "right" or key = "left"
                return true
            else if key = "down"
                m.keyboard.setFocus(true)
                return true
            end if
        else if key = "up" and m.keyboard.isInFocusChain() or key = "up" and m.SearchRowlist.hasFocus()
            m.HomeTopMenuRowlist.SET_FOCUS = true
            return true
        end if


        if key = "down" then

            if getCustomFiltersRequired() = "true"
                if not m.SearchRowlist.hasFocus() and not m.searchFilterLabelList.hasFocus() and not m.searchSuggestionLabelList.hasFocus() and not m.searchFilter_subccategory_labellist.hasFocus()
                    m.searchFilterLabelList.setFocus(true)
                    result = true
                end if
            else
                
            end if


        else if key = "up" then
            if m.SearchRowlist.hasFocus() or m.searchSuggestionLabelList.hasFocus()
                result = true
            else if m.searchFilterLabelList.hasFocus()
                m.keyboard.setFocus(true)
                result = true
            end if

        else if key = "right" then
            if m.searchFilterLebellist_rect.visible = true
                return true
            end if
            if m.SearchRowlist.visible = true
                m.SearchRowlist.setFocus(true)
                result = true
            else if m.searchSuggestionLabelList.visible = true
                m.searchSuggestionLabelList.setFocus(true)

                result = true
            else
                result = true
            end if

        else if key = "left" then
            if m.searchFilterLebellist_rect.visible = true
                return true
            end if
            if m.lastFocusedNode = "SEARCH_FILTER_LABEL_LIST"
                m.searchFilterLabelList.setFocus(true)
                result = true
            else if m.lastFocusedNode = "KEYBOARD"
                m.keyboard.setFocus(true)
                result = true
            end if
        else if key = "options" then
            result = true
        else if key = "back"
            if m.searchFilterLebellist_rect.visible = true
                m.searchFilterLebellist_rect.visible = false
                m.searchFilterLabelList.setFocus(true)
                result = true
            else

            end if
        end if

    else
    end if
    return result
end function

sub OnTopVisibilityChange()
    print "OnTopVisibilityChange"
    if m.top.visible = true
        m.keyboard.setFocus(true)
        m.SearchRowlist.visible = true
    end if
    SearchIconVisibilityOnTopMenu(m.top.visible)
end sub

sub SearchIconVisibilityOnTopMenu(visible)
    if m.top.visible = true
        m.HomeTopMenuRowlist.SearchIconVisibility = false
    else
        m.HomeTopMenuRowlist.SearchIconVisibility = true
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

sub OnSearchSuggestionFetcherContent()
    searchSuggestionCount = m.SearchSuggestionFetcherTask.searchSuggestionContent.getChildCount()
    if searchSuggestionCount <> 1
        m.searchSuggestionLabelList.content = m.SearchSuggestionFetcherTask.searchSuggestionContent
        m.searchSuggestionLabelList.visible = true
    else
        m.searchSuggestionLabelList.content = m.SearchSuggestionFetcherTask.searchSuggestionContent
        m.searchSuggestionLabelList.visible = false
    end if


    m.SearchRowlist.visible = false
end sub

sub onSearchSuggestionLabelListSelected()
    ?"onSearchSuggestionLabelListSelected called"
    m.SearchSuggestionFetcherTask.callFunc("stopSearchSuggestionFetcherTask", "")
    m.searchSuggestionLabelList.visible = false
    selectedText = m.searchSuggestionLabelList.content.getChild(m.searchSuggestionLabelList.itemSelected).title
    m.SearchTitleAndSearchString.text = selectedText
    m.SearchFetcher.SearchRequest = selectedText
    m.SearchFetcher.callFunc("runSearchFetcherTask", "")
end sub

sub onSearchNowButtonFocused()
    ?"onSearchNowButtonFocused called"
    m.searchNowButton.focusBitmapUri = "pkg:/images/white_arrow.png"
end sub

sub onSearchNowButtonSelected()
    ?"onSearchNowButtonSelected called"
    m.searchSuggestionLabelList.visible = false
    m.SearchFetcher.SearchRequest = m.keyboard.textEditBox.text
    m.SearchFetcher.callFunc("runSearchFetcherTask", "")
end sub



' ###########################goto timegrid player

sub onRowitemSelected1()
    rowitemSelected = m.SearchRowlist.RowItemSelected
    if m.SearchFetcher.searchContent <> invalid and m.SearchFetcher.searchContent.getChild(rowitemSelected[0]) <> invalid and m.SearchFetcher.searchContent.getChild(rowitemSelected[0]).getchild(rowitemSelected[1]) <> invalid
        if m.SearchFetcher.searchContent.getChild(rowitemSelected[0]).getchild(rowitemSelected[1]).categoryType <> invalid and m.SearchFetcher.searchContent.getChild(rowitemSelected[0]).getchild(rowitemSelected[1]).categoryType = "FASTCHANNELS"

            if isGuest() = "true"
                m.top.goToLandingScene = true
            else
                runFastChannelApiTask(m.SearchFetcher.searchContent.getChild(rowitemSelected[0]).getchild(rowitemSelected[1]))
            end if
        end if
    end if
end sub

sub runFastChannelApiTask(rowContentItem)
    m.LiveFetcher = CreateObject("roSGNode", "LiveFetcher")
    m.LiveFetcher.observeField("livefetcherResponse", "playLiveVideo")
    if rowContentItem.channel_id <> invalid
        m.channelID = rowContentItem.channel_id
    else
        m.channelID = getFastChannelId()
    end if
    m.LiveFetcher.channel_id = m.channelID
    m.LiveFetcher.callFunc("runLiveFetcherTask", "TIMEGRIDSCENE")
end sub

sub playLiveVideo()
    if m.LiveFetcher.livefetcherResponse <> invalid and m.LiveFetcher.livefetcherResponse[0] <> invalid
        if m.LiveFetcher.livefetcherResponse <> invalid and m.LiveFetcher.livefetcherResponse[0] <> invalid and m.LiveFetcher.livefetcherResponse[0].now_playing <> invalid
            nowPlayingContent = m.LiveFetcher.livefetcherResponse[0].now_playing
            content = m.LiveFetcher.livefetcherResponse[0]
        else
            nowPlayingContent = invalid
        end if
    end if


    schedule_id = ""
    if nowPlayingContent <> invalid and nowPlayingContent.id <> invalid
        schedule_id = nowPlayingContent.id.Tostr()
    end if

    video_title = ""
    if nowPlayingContent <> invalid and nowPlayingContent.video_title <> invalid
        video_title = nowPlayingContent.video_title
    end if


    live_link = ""
    if m.LiveFetcher.livefetcherResponse[0] <> invalid and m.LiveFetcher.livefetcherResponse[0].live_link <> invalid
        live_link = m.LiveFetcher.livefetcherResponse[0].live_link
    end if


    if nowPlayingContent <> invalid and nowPlayingContent.show_id <> invalid
        show_id = nowPlayingContent.show_id
    else
        show_id = 0
    end if

    data = {
        "url": live_link,
        "show_id": show_id.ToStr(),
        "TITLE": video_title,
        "schedule_id": schedule_id,
        "channel_id": m.channelID,
        "is_from": "TIMEGRIDSCENE"
    }
    m.top.goToMainVideoPlayer = data
end sub

function onKeyboardFocused()
    m.lastFocusedNode = "KEYBOARD"
    if m.currentlyScrolledUp = true
        m.scrollDownAnimation.control = "start"
        m.currentlyScrolledUp = false
    end if
end function

function onSearchFilterLabelListFocused()
    m.lastFocusedNode = "SEARCH_FILTER_LABEL_LIST"
    if m.currentlyScrolledUp = false
        m.scrollUpAnimation.control = "start"
        m.currentlyScrolledUp = true
    end if
end function

sub onSetDefaultFocus()
    m.keyboard.setFocus(true)
end sub