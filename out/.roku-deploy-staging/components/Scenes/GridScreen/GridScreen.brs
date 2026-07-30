
function Init()
    m.EventFetcher = CreateObject("roSGNode", "EventFetcher")
    m.top.observeField("focusedChild", "OnFocusedChildChange")
    m.top.observeField("visible", "onVisibleChange")
    m.rowList = m.top.findNode("RowList")
    m.rowList.observeField("rowItemFocused", "OnrowItemFocused")
    m.rowList.ObserveField("itemUnfocused", "OnItemUnFocused")
    m.rowList.focusBitmapBlendColor = getButtonSelectionColor()
    m.rowList.rowLabelColor = getTextColor()
    m.description = m.top.findNode("Description")
    m.background = m.top.findNode("Background")
    ' m.trailerPlayer = m.top.findNode("videoPlayer")
    m.gradientOverlayForBackgroundPlayer = m.top.findNode("gradientOverlayForBackgroundPlayer")
    m.gradientOverlayForBackgroundPlayer.blendColor = getBackGroundColor()
    m.Hud = m.top.findNode("Hud")
    m.Hint = m.top.findNode("Hint")
    m.trailerTimer = m.top.findNode("trailerTimer")
    m.trailerTimer.ObserveField("fire", "onTrailerTimerFired")
    m.playing = m.top.findNode("playing")
    m.Hint2 = m.top.findNode("Hint2")
    m.count = 0
    m.top.itemComponentName = "customitemhome"
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Poppins-Bold.ttf"
    font.size = 24
    font.color = getTextColor()
    m.rowList.rowLabelFont = font

    m.Title = m.top.findNode("Title")
    m.Title.color = getTextColor()
    m.imageTitlePoster = m.top.findNode("imageTitlePoster")
    ' m.imageTitlePoster.observeField("loadStatus", "onImageTitlePosterLoadStatusChanged")
    m.MetaDataContainer = m.top.findNode("MetaDataContainer")

    m.year = m.top.findNode("year")
    m.duration = m.top.findNode("duration")
    m.Description = m.top.findNode("Description")
    m.synopsis = m.top.findNode("resolution")
    if getTheme2() = "LIGHT" then m.synopsis.color = "#000000" else m.synopsis.color = "#cccccc"

    if getTextColor() = "#ffffff" then ' White text when not selected
        m.Description.color = "#cccccc"
    else
        m.Description.color = getTextColor()
    end if
    m.category_name = m.top.findNode("category_name")
    m.category_name.color = getTextColor()
    m.director = m.top.findNode("director")

    m.homePlayMoreInfoLabelList_container = m.top.findNode("homePlayMoreInfoLabelList_container")
    m.homePlayMoreInfoLabelList = m.top.findNode("homePlayMoreInfoLabelList")
    m.homePlayMoreInfoLabelList.ObserveField("itemSelected", "onHomePlayMoreInfoLabelListItemSelected")
    m.homePlayMoreInfoLabelList.focusBitmapBlendColor = "#FFFFFF"
    m.homePlayMoreInfoLabelList.focusFootprintBlendColor = "#FFFFFF"
    m.homePlayMoreInfoLabelList.Font = "font:MediumBoldSystemFont"
    m.homePlayMoreInfoLabelList.font.size = 25
    m.homePlayMoreInfoLabelList.focusedFont = m.homePlayMoreInfoLabelList.font
    m.homePlayMoreInfoLabelList.focusedFont.size = m.homePlayMoreInfoLabelList.font.size
    ' m.homePlayMoreInfoLabelList.textHorizAlign = "center"
    ' m.homePlayMoreInfoLabelList.textVertAlign = "center"
    ' m.homePlayMoreInfoLabelList.focusFootprintBitmapUri = "pkg:/images/img_itemcatbg.png"
    ' m.homePlayMoreInfoLabelList.focusBitmapUri = "pkg:/images/img_itemcatbg_selected.png"
    m.homePlayMoreInfoLabelList.vertFocusAnimationStyle = "floatingfocus"

    m.homePlayMoreInfoLabelList.focusBitmapUri = "pkg:/images/img_newbg.9.png"
    m.homePlayMoreInfoLabelList.focusFootprintBitmapUri = "pkg:/images/img_newbg.9.png"
    m.homePlayMoreInfoLabelList.focusFootprintBlendColor = "#2b2b2b"
    m.homePlayMoreInfoLabelList.textHorizAlign = "center"

    m.textMeasurerLabel = createObject("roSGNode", "Label")
    m.top.observeField("homeType", "loadHome")
    m.loadingIndicator = m.top.findNode("loading")
    m.valu = 0
    m.focusBitmapUri = m.top.findNode("focusBitmapUri")
    m.bannerContainer = m.top.findNode("bannerContainer")
    m.bannerPoster = m.top.findNode("BannerPoster")
    m.bannerPoster.visible = true
    m.bannerPoster_Bottom_gradient = m.top.findNode("bannerPoster_Bottom_gradient")
    m.bannerPoster_Bottom_gradient.blendColor = getBackGroundColor()
    m.bannerDots = m.top.findNode("bannerDots")

    m.zoomInWidth = m.top.findNode("zoomInWidth")
    m.calledOnce = true
    m.offsetCountForLazyLoading = 10
    m.keyPressed = "NA"
    m.autoBannerScrollTimer = m.top.findNode("autoBannerScrollTimer")
    m.autoBannerScrollTimer.ObserveField("fire", "OnautoBannerScrollTimerCalled")
    m.MetaDataContainerLayoutGroup = m.top.findNode("MetaDataContainerLayoutGroup")

    m.homeEnLargeAnimation = m.top.findNode("homeEnLargeAnimation")
    m.homeShrinkAnimation = m.top.findNode("homeShrinkAnimation")
    m.fadeInAnim = m.top.findNode("fadeInAnim")

    m.homePlayMoreInfoLabelList.observeField("focusedChild", "onFocusChanged")
    m.rowList.observeField("focusedChild", "onFocusChanged")
    m.top.lastFocusedNode = "homePlayMoreInfoLabelList"

    createMetaDataAnims()
    m.currentBannerShowingIndex = -1
    m.isHomeEnlargedNow = false
end function



function loadHome()

    print "loadHome() called: gridscreen"
    m.PlayerTaskLive = invalid
    if m.trailerPlayer <> invalid
        m.trailerPlayer.control = "stop"
        m.trailerPlayer = invalid
    end if
    m.homeShrinkAnimation.control = "start"
    sec = CreateObject("roRegistrySection", getAppKey()) ' checking whether guest inorer to show continuw watching
    m.HomeListApiTask = CreateObject("roSGNode", "HomeListApiTask")
    ' m.HomeListApiTask.ObserveField("HomeListApiTaskListStatus", "OnHomeListApiTaskListContent")
    m.HomeListApiTask.observeField("HomeListApiTaskListStatus", "onSetDataToRowList")
    m.HomeListApiTask.observeField("HomeListApiTaskAdditionalRows", "onAppendAdditionalRows")
    m.HomeListApiTask.callFunc("runHomeListApiTask", m.top.homeType)
    if m.global.Live_player <> invalid and m.global.Live_player.getchild(3) <> invalid
        m.global.Live_player.getchild(3).control = "stop" ' stopping the live player in homebanner when going to other pages
        m.global.Live_player = invalid
        ' ?"loadHome"
        ' ?m.global.Live_player
        ' ?"loadHome 2"
    end if
end function



sub onSetDataToRowList() ' dynamic thumbnail orientation
    OnreleasePlayer()
    if getThumbnailOrientaion() = "LANDSCAPE"
        rowHeights = [290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290]
        rowItemSize = [[320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180]]
    else if getThumbnailOrientaion() = "PORTRAIT"
        rowHeights = [400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400]
        rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
    end if


    rowItemSpacing = [[25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15], [25, 15]]
    focusXOffset = [[110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110], [110]]

    m.rowList.rowHeights = rowHeights
    m.rowList.rowItemSize = rowItemSize
    m.rowList.rowItemSpacing = rowItemSpacing
    m.rowList.focusXOffset = focusXOffset


    if m.HomeListApiTask.HomeListApiTaskContent <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChildCount() <> invalid


        for i = 0 to m.HomeListApiTask.HomeListApiTaskContent.getChildCount() - 1
            if m.HomeListApiTask.HomeListApiTaskContent.getChild(i) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0).itemType <> invalid
                itemType = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0).itemType
            else
                itemType = ""
            end if
            if m.HomeListApiTask.HomeListApiTaskContent.getChild(i) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0).categoryType <> invalid
                categoryType = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0).categoryType
            else
                categoryType = ""
            end if

            if m.HomeListApiTask.HomeListApiTaskContent.getChild(i) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).visible_items_count <> invalid
                visible_items_count = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).visible_items_count
            else
                visible_items_count = -1
            end if

            if m.HomeListApiTask.HomeListApiTaskContent.getChild(i) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0).thumbnail_orientation <> invalid
                thumbnail_orientation = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0).thumbnail_orientation
            else
                thumbnail_orientation = getThumbnailOrientaion() '"LANDSCAPE"    'getthumbnail_orientation()
            end if



            usableWidth = 1920 - 70

            if visible_items_count = 3
                itemWidth = int(usableWidth / 3.3)
                itemHeight = int(itemWidth * 9 / 16)
                rowheightsFromConfig = itemHeight + 90
                rowItemSizeFromConfig = [itemWidth, itemHeight]

            else if visible_items_count = 3.5
                itemWidth = int(usableWidth / 3.8)
                itemHeight = int(itemWidth * 9 / 16)
                rowheightsFromConfig = itemHeight + 90
                rowItemSizeFromConfig = [itemWidth, itemHeight]

            else if visible_items_count = 4
                itemWidth = int(usableWidth / 4.5)
                itemHeight = int(itemWidth * 9 / 16)
                rowheightsFromConfig = itemHeight + 90
                rowItemSizeFromConfig = [itemWidth, itemHeight]

            else if visible_items_count = 4.5
                itemWidth = int(usableWidth / 5)
                itemHeight = int(itemWidth * 9 / 16)
                rowheightsFromConfig = itemHeight + 90
                rowItemSizeFromConfig = [itemWidth, itemHeight]

            else if visible_items_count = 5
                itemWidth = int(usableWidth / 5.7)
                itemHeight = int(itemWidth * 9 / 16)
                rowheightsFromConfig = itemHeight + 90
                rowItemSizeFromConfig = [itemWidth, itemHeight]

            else
                itemWidth = int(usableWidth / 5.7)
                itemHeight = int(itemWidth * 9 / 16)
                rowheightsFromConfig = itemHeight + 90
                rowItemSizeFromConfig = [itemWidth, itemHeight]
            end if


            if thumbnail_orientation <> invalid
                if thumbnail_orientation = "PORTRAIT"
                    rowHeights.SetEntry(i, 440)
                    rowItemSize.SetEntry(i, [250, 375])
                else if thumbnail_orientation = "LANDSCAPE" or thumbnail_orientation = "RECTANGLE"
                    if categoryType = "TOP_TRENDING"
                        rowheightsFromConfig = 197 + 90
                        rowItemSizeFromConfig = [350, 197]
                    end if
                    rowHeights.SetEntry(i, rowheightsFromConfig)
                    rowItemSize.SetEntry(i, rowItemSizeFromConfig)
                else if thumbnail_orientation = "SQUARE" or thumbnail_orientation = "ROUND"
                    rowHeights.SetEntry(i, 390)
                    rowItemSize.SetEntry(i, [300, 300])
                    ' rowItemSize.SetEntry(i, [360, 203])
                end if
                m.rowList.rowHeights = rowHeights
                m.rowList.rowItemSize = rowItemSize
            end if

            ' if categoryType = "LIVE"
            '     rowHeights.SetEntry(i, 700)
            '     m.rowList.rowHeights = rowHeights
            '     rowItemSize.SetEntry(i, [1700, 669])
            '     m.rowList.rowItemSize = rowItemSize
            '     m.bannerCount = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChildCount()
            ' end if


            if categoryType = "FEATURED"
                rowHeights.SetEntry(i, 340)
                m.rowList.rowHeights = rowHeights
                rowItemSize.SetEntry(i, [500, 281])
                m.rowList.rowItemSize = rowItemSize
                m.bannerCount = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChildCount()
                ' rowHeights.SetEntry(i, 880)
                ' m.rowList.rowHeights = rowHeights
                ' rowItemSize.SetEntry(i, [1700, 850])
                ' m.rowList.rowItemSize = rowItemSize
                ' m.bannerCount = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChildCount()
            end if


            if itemType = "FILM_OF_THE_WEEK" <> invalid
                if itemType = "FILM_OF_THE_WEEK"
                    ' rowHeights.SetEntry(i, 330)
                    rowHeights.SetEntry(i, 976)
                    m.rowList.rowHeights = rowHeights
                    rowItemSize.SetEntry(i, [1700, 956])
                    m.rowList.rowItemSize = rowItemSize
                end if
            end if

            ' if itemType="FILM_OF_THE_WEEK"<>invalid
            '     if itemType = "FILM_OF_THE_WEEK"
            '         ' rowHeights.SetEntry(i, 330)
            '          rowHeights.SetEntry(i, 976)
            '         m.rowList.rowHeights = rowHeights
            '         rowItemSize.SetEntry(i, [1700, 956])
            '         m.rowList.rowItemSize = rowItemSize
            '     end if
            ' end if

            if itemType = "SCHEDULE" <> invalid
                if itemType = "SCHEDULE"
                    ' rowHeights.SetEntry(i, 330)
                    rowHeights.SetEntry(i, 400)
                    m.rowList.rowHeights = rowHeights
                    rowItemSize.SetEntry(i, [200, 300])
                    m.rowList.rowItemSize = rowItemSize
                end if
            end if

            ' if categoryType = "GENRES" <> invalid
            '     if m.HomeListApiTask.HomeListApiTaskContent.getChild(i) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getChild(0).item_shape <> invalid
            '         item_shape = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0).item_shape
            '     else
            '         item_shape = "RECTANGLE"
            '     end if
            '     if categoryType = "GENRES"
            '         rowHeights.SetEntry(i, 290)
            '         m.rowList.rowHeights = rowHeights
            '         if item_shape = "SQUARE" or item_shape = "ROUND"
            '             rowItemSize.SetEntry(i, [300, 300])
            '         else if item_shape = "RECTANGLE"
            '             rowItemSize.SetEntry(i, [300, 200])
            '         end if
            '         m.rowList.rowItemSize = rowItemSize
            '     end if
            ' end if


            if categoryType <> invalid
                if categoryType = "TOP_TRENDING"
                    rowItemSpacing.SetEntry(i, [200, 15])
                    m.rowList.rowItemSpacing = rowItemSpacing
                    focusXOffset.SetEntry(i, 230)
                    m.rowList.focusXOffset = focusXOffset
                end if
            end if

            if itemType = "PODCAST" <> invalid
                if itemType = "PODCAST"
                    ' rowHeights.SetEntry(i, 330)
                    rowHeights.SetEntry(i, 300)
                    m.rowList.rowHeights = rowHeights
                    rowItemSize.SetEntry(i, [320, 180])
                    m.rowList.rowItemSize = rowItemSize
                end if
            end if

            if categoryType <> invalid
                if categoryType = "SHORTS"
                    rowItemSize.SetEntry(i, [200, 356])
                    m.rowList.rowItemSize = rowItemSize
                    rowHeights.SetEntry(i, 436)
                    m.rowList.rowHeights = rowHeights
                end if
            end if




            if (itemType = "LIVE" or itemType = "LIVE_EVENT") and m.HomeListApiTask <> invalid and m.HomeListApiTask.HomeListApiTaskContent <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0) <> invalid and m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0).live_link <> invalid
                m.live_link = m.HomeListApiTask.HomeListApiTaskContent.getChild(i).getchild(0).live_link
            end if
        end for
        lazyLoadingFunctionOffline(m.HomeListApiTask.HomeListApiTaskContent)
        ' m.rowList.content = m.HomeListApiTask.HomeListApiTaskContent
        ' firstItemInTheResponse = m.HomeListApiTask.HomeListApiTaskContent.getChild(0).getChild(0).itemType

        ' if firstItemInTheResponse = "LIVE" or firstItemInTheResponse = "LIVE_EVENT"
        '     m.top.liveLinkIfLiveVideoAvailable = m.HomeListApiTask.HomeListApiTaskContent.getChild(0).getChild(0).live_link
        ' else
        '     m.top.liveLinkIfLiveVideoAvailable = invalid
        ' end if

        ' if isFromDeepLinking() <> invalid and isFromDeepLinking() <> ""
        '     m.top.onDeepLinkLaunchedGotoShowScene = isFromDeepLinking()
        '     setIsFromDeepLinking("")
        '     return
        ' end if
        if m.global.DEEPLINK_PARAMS <> invalid
            m.top.onDeepLinkLaunchedGotoShowScene = "TRIGGER!!"
            return
        end if

        if getIntialPage() = "LIVE"
            if getMULTI_CHANNELS_REQUIRED() = "true"
                m.top.goToTimeGridScene = true
            else
                m.top.liveLinkIfLiveVideoAvailable = true'm.live_link
            end if
        else
            m.top.liveLinkIfLiveVideoAvailable = invalid

        end if
    end if

    if m.HomeListApiTask.HomeListApiTaskContent <> invalid and m.HomeListApiTask.HomeListApiTaskContent.featuredRowNode <> invalid and m.HomeListApiTask.HomeListApiTaskContent.featuredRowNode.getchild(0) <> invalid
        m.currentBannerShowingIndex = 0
        m.homePlayMoreInfoLabelList.visible = true
        childCount = m.HomeListApiTask.HomeListApiTaskContent.featuredRowNode.getchild(0).getChildCount()
        m.bannerData = m.HomeListApiTask.HomeListApiTaskContent.featuredRowNode.getchild(0).getChildren(childCount, 0)
        m.autoBannerScrollTimer.control = "stop"
        m.autoBannerScrollTimer.control = "start"

        m.homePlayMoreInfoLabelList.setFocus(true)
        if m.top.categorynodefocus = true
            m.homePlayMoreInfoLabelList.setFocus(false)
            m.top.setFocusToTopMenu = true
            m.top.categorynodefocus = false
            ?"ddd"
        end if
        m.rowlist.setFocus(false)
        setupBannerDots()
        showBanner(m.currentBannerShowingIndex)
    else
        m.homePlayMoreInfoLabelList.visible = false
        clearBannerData()
        m.rowList.setFocus(true)
        m.homePlayMoreInfoLabelList.setFocus(false)
        m.bannerData = invalid
        stopAutobannerScroll()
    end if
    m.loadingIndicator.visible = false
end sub


sub onAppendAdditionalRows()
    additionalRows = m.HomeListApiTask.HomeListApiTaskAdditionalRows
    if additionalRows = invalid or additionalRows.getChildCount() = 0 then return

    ' 1. Create fresh local array buffers populated with current settings
    rowHeights = []
    rowItemSize = []
    rowItemSpacing = []
    focusXOffset = []

    if m.rowList.rowHeights <> invalid then rowHeights.Append(m.rowList.rowHeights)
    if m.rowList.rowItemSize <> invalid then rowItemSize.Append(m.rowList.rowItemSize)
    if m.rowList.rowItemSpacing <> invalid then rowItemSpacing.Append(m.rowList.rowItemSpacing)
    if m.rowList.focusXOffset <> invalid then focusXOffset.Append(m.rowList.focusXOffset)

    currentUICount = m.rowList.content.getChildCount()
    newRowsCount = additionalRows.getChildCount()

    ' 2. Detach and clone active content root node to prevent dynamic UI rendering conflicts
    detachedContent = CreateObject("RoSGNode", "ContentNode")
    for i = 0 to currentUICount - 1
        detachedContent.appendChild(m.rowList.content.getChild(0))
    end for

    for i = 0 to newRowsCount - 1
        rowNode = additionalRows.getChild(0)
        if rowNode <> invalid
            globalIndex = currentUICount + i

            ' Read row properties safely
            itemType = ""
            categoryType = ""
            if rowNode.getChild(0) <> invalid
                if rowNode.getChild(0).itemType <> invalid then itemType = rowNode.getChild(0).itemType
                if rowNode.getChild(0).categoryType <> invalid then categoryType = rowNode.getChild(0).categoryType
            end if

            if rowNode.visible_items_count <> invalid
                visible_items_count = rowNode.visible_items_count
            else
                visible_items_count = -1
            end if

            if rowNode.getChild(0) <> invalid and rowNode.getChild(0).thumbnail_orientation <> invalid
                thumbnail_orientation = rowNode.getChild(0).thumbnail_orientation
            else
                thumbnail_orientation = getThumbnailOrientaion()
            end if

            ' Standard display resolution calculations
            usableWidth = 1920 - 70
            if visible_items_count = 3
                itemWidth = int(usableWidth / 3.3)
            else if visible_items_count = 3.5
                itemWidth = int(usableWidth / 3.8)
            else if visible_items_count = 4
                itemWidth = int(usableWidth / 4.5)
            else if visible_items_count = 4.5
                itemWidth = int(usableWidth / 5)
            else if visible_items_count = 5
                itemWidth = int(usableWidth / 5.7)
            else
                itemWidth = int(usableWidth / 5.7)
            end if
            itemHeight = int(itemWidth * 9 / 16)

            rowheightsFromConfig = itemHeight + 90
            rowItemSizeFromConfig = [itemWidth, itemHeight]

            ' Layout fallback metric configurations
            targetHeight = 290
            targetSize = [320, 180]

            if thumbnail_orientation = "PORTRAIT"
                targetHeight = 440
                targetSize = [250, 375]
            else if thumbnail_orientation = "LANDSCAPE" or thumbnail_orientation = "RECTANGLE"
                if categoryType = "TOP_TRENDING"
                    rowheightsFromConfig = 197 + 90
                    rowItemSizeFromConfig = [350, 197]
                end if
                targetHeight = rowheightsFromConfig
                targetSize = rowItemSizeFromConfig
            else if thumbnail_orientation = "SQUARE" or thumbnail_orientation = "ROUND"
                targetHeight = 390
                targetSize = [300, 300]
            end if

            if categoryType = "FEATURED"
                targetHeight = 340
                targetSize = [500, 281]
            end if

            if itemType = "FILM_OF_THE_WEEK"
                targetHeight = 976
                targetSize = [1700, 956]
            end if

            if itemType = "SCHEDULE"
                targetHeight = 400
                targetSize = [200, 300]
            end if

            if itemType = "PODCAST"
                targetHeight = 300
                targetSize = [320, 180]
            end if

            if categoryType = "SHORTS"
                targetSize = [200, 356]
                targetHeight = 436
            end if

            if categoryType = "TOP_TRENDING"
                targetSpacing = [200, 15]
                targetFocusOffset = [230]
            else
                targetSpacing = [25, 15]
                targetFocusOffset = [110]
            end if

            ' 3. Apply styles safely to exact array positions via SetEntry
            rowHeights.SetEntry(globalIndex, targetHeight)
            rowItemSize.SetEntry(globalIndex, targetSize)
            rowItemSpacing.SetEntry(globalIndex, targetSpacing)
            focusXOffset.SetEntry(globalIndex, targetFocusOffset)

            detachedContent.appendChild(rowNode)
        end if
    end for

    ' 4. Atomic layout assignment step to update the UI instantly without blinking
    m.rowList.rowHeights = rowHeights
    m.rowList.rowItemSize = rowItemSize
    m.rowList.rowItemSpacing = rowItemSpacing
    m.rowList.focusXOffset = focusXOffset

    m.rowList.content = detachedContent

    lazyLoadingFunctionOffline(m.rowList.content)
end sub

sub setupBannerDots()
    contentNode = createObject("roSGNode", "ContentNode")
    contentNode2 = createObject("roSGNode", "ContentNode")
    for i = 0 to m.bannerData.count() - 1
        dotNode = createObject("roSGNode", "ContentNode")
        dotNode.title = "dot_" + i.toStr()
        ' give each dot some initial field (could be color, title, anything you define in DotItem)
        dotNode.addFields({ color: "0x888888FF" })
        contentNode.appendChild(dotNode)
    end for
    contentNode2.appendChild(contentNode)

    m.bannerDots.content = contentNode2
end sub




sub OnFocusedChildChange()
    ' ? "OnFocusedChildChange: gridscreen"
    m.rowList.currFocusRow = 1
    if m.top.isInFocusChain() and not m.rowList.hasFocus() then
        if m.top.lastFocusedNode = "homePlayMoreInfoLabelList"
            if m.homePlayMoreInfoLabelList.visible = true
                m.homePlayMoreInfoLabelList.setFocus(true)
                if m.top.categorynodefocus = true
                    m.homePlayMoreInfoLabelList.setFocus(false)
                    m.top.setFocusToTopMenu = true
                    m.top.categorynodefocus = false
                    ?"dxxc"
                end if
            else
                m.rowList.setFocus(true)
            end if
        else if m.top.lastFocusedNode = "rowList"
            m.rowList.setFocus(true)
        else
            m.rowList.setFocus(true)
        end if
    end if
end sub


sub OnItemUnFocused()
    itemFocused = m.top.itemFocused
    focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
    ' if (m.top.rowUnfocused = 1 and m.keyPressed = "UP")
    '     m.top.focusBitmapUri = ""
    ' else if focusedContent.itemType = "BANNER" or focusedContent.itemType = "FILM_OF_THE_WEEK"
    '     m.top.focusBitmapUri = ""
    ' else
    '     m.top.focusBitmapUri = ""
    ' end if
    ' m.top.focusBitmapUri = ""

    ' itemFocused = m.top.itemFocused
    ' if m.top.content <> invalid and m.top.content.getChild(itemFocused[0]) <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]) <> invalid
    '     focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
    '     if (m.top.rowUnfocused = 1 and m.keyPressed = "UP")
    '         m.top.focusBitmapUri = ""
    '     else if focusedContent.itemType = "BANNER" or focusedContent.itemType = "FILM_OF_THE_WEEK"
    '         m.top.focusBitmapUri = ""
    '     else
    '         m.top.focusBitmapUri = ""
    '     end if
    '     m.top.focusBitmapUri = ""
    ' end if
end sub

function OnkeyEvent(key, press) as boolean
    if press
        if key = "left"
            m.keyPressed = "LEFT"
            if m.homePlayMoreInfoLabelList.hasFocus() = true and m.bannerData <> invalid
                if m.currentBannerShowingIndex > 0
                    m.currentBannerShowingIndex--
                    showBanner(m.currentBannerShowingIndex)
                    playMetaDataAnim("out")
                    return true
                end if
            end if

        else if key = "right"
            m.keyPressed = "RIGHT"

            if m.homePlayMoreInfoLabelList.hasFocus() = true and m.bannerData <> invalid
                if m.currentBannerShowingIndex < m.bannerData.count() - 1
                    m.currentBannerShowingIndex++
                else
                    m.currentBannerShowingIndex = 0 ' loop at right end
                end if
                showBanner(m.currentBannerShowingIndex)
                playMetaDataAnim("in")
                return true
            end if

        else if key = "up"
            m.keyPressed = "UP"
            if m.rowlist.hasFocus()
                if m.homePlayMoreInfoLabelList.visible = true
                    m.homePlayMoreInfoLabelList.setFocus(true)
                    if m.top.categorynodefocus = true
                        m.homePlayMoreInfoLabelList.setFocus(false)
                        m.top.setFocusToTopMenu = true
                        m.top.categorynodefocus = false
                        ?"xxssd"
                    end if

                    return true
                else

                end if
            else if m.homePlayMoreInfoLabelList.hasFocus() = true
                ?"uiiier"
                stopAutobannerScroll()
            end if

        else if key = "down"
            m.keyPressed = "DOWN"
            m.rowList.setFocus(true)
        end if
    end if
end function





sub OnRowItemFocused()
    ? "OnRowItemFocused"
    lazyLoadingFunctionOfflineForRowAddition()
    triggerTrailerTimer()
    m.fadeInAnim.control = "start"

    m.zoomInWidth.control = "start"
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()
    itemFocused = m.top.itemFocused
    m.loadingIndicator.visible = false
    m.top.focusedRow = itemFocused
    focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])

    if m.bannerPoster <> invalid and m.top.content <> invalid and m.top.content.getChild(itemFocused[0]) <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]) <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]).hero_image <> invalid
        m.bannerPoster.uri = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]).hero_image
        ?m.bannerPoster.uri
        ?"mbanner1"
    else if m.bannerPoster <> invalid and m.top.content <> invalid and m.top.content.getChild(itemFocused[0]) <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]) <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]).HDBACKGROUNDIMAGEURL <> invalid
        m.bannerPoster.uri = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]).HDBACKGROUNDIMAGEURL
        ?m.bannerPoster.uri
        ?"banner2"
    end if
    if m.top <> invalid and m.top.content <> invalid and itemFocused <> invalid and itemFocused[0] <> invalid and m.top.content.getChild(itemFocused[0]) <> invalid and itemFocused[1] <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]) <> invalid and m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1]).type = "GENRE" and m.bannerPoster <> invalid then m.bannerPoster.uri = ""
    ' IMAGE_TITLE_BANNER = false
    ' if IMAGE_TITLE_BANNER = true
    if focusedContent.image_title <> invalid and focusedContent.image_title <> ""
        m.imageTitlePoster.uri = focusedContent.image_title
        m.imageTitlePoster.visible = true
        m.Title.visible = false
    else
        m.imageTitlePoster.visible = false
        m.Title.visible = true
        m.Title.text = focusedContent.title
    end if
    ' else
    '     m.imageTitlePoster.visible = false
    '     m.Title.text = focusedContent.title
    '     m.Title.visible = true
    ' end if
    if focusedContent.year <> invalid
        m.year.visible = false
        m.year.text = focusedContent.year
    else
        m.year.visible = false
    end if

    if focusedContent.resolution <> invalid
        if m.year.visible = false
            m.Duration.translation = [210, 220]
            m.duration.text = "•   " + focusedContent.resolution.toStr()

        else
            m.Duration.translation = [150, 220]
            m.duration.text = focusedContent.resolution.toStr()
        end if
    else
        m.duration.text = ""
    end if

    if focusedContent.synopsis <> invalid
        m.synopsis.text = focusedContent.synopsis.toStr()
    else
        m.synopsis.text = ""
    end if


    values = []
    if focusedContent.rating <> invalid and focusedContent.rating <> "" then values.push(focusedContent.rating)
    if focusedContent.show_cast <> invalid and focusedContent.show_cast <> "" then values.push(focusedContent.show_cast)
    if focusedContent.duration_text <> invalid and focusedContent.duration_text <> "" then values.push(focusedContent.duration_text)

    result = ""
    if values.Count() > 0
        result = values[0]
        for i = 1 to values.Count() - 1
            result = result + " • " + values[i]
        end for
        m.category_name.text = result
        m.synopsis.translation = [120, 279]
        m.Title.translation = [0, 0]
    else
        m.category_name.text = ""
        m.synopsis.translation = m.category_name.translation
        m.Title.translation = [100, 100]
    end if

    if m.category_name.text <> invalid and m.category_name.text <> ""
        m.imageTitlePoster.translation = [m.imageTitlePoster.translation[0], 170]
    else
        m.imageTitlePoster.translation = [m.imageTitlePoster.translation[0], 210]
    end if


    focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
    if focusedContent <> invalid then
        m.top.focusedContent = focusedContent
    end if


    '****************live handling when changing focus from live to other rows***************'
    if focusedContent.type <> invalid and focusedContent.type = "LIVE"
        if m.PlayerForTimeGrid = invalid
            callLiveApi(focusedContent)
        else if m.PlayerForTimeGrid.state = "done"
            m.PlayerForTimeGrid = invalid
            callLiveApi(focusedContent)
        else if m.PlayerForTimeGrid <> invalid and m.PlayerForTimeGrid.state <> "play"
            m.PlayerForTimeGrid.control = "play"
            m.PlayerForTimeGrid.visible = true
        end if
    else
        if m.global.Live_player <> invalid and m.global.Live_player.getchild(3) <> invalid
            m.global.Live_player.getchild(3).control = "stop" ' stopping the live player in homebanner when going to other pages
            m.global.Live_player = invalid
        end if
    end if
    setMetaDataContainerLayoutGroupSpacings()
end sub

sub setMetaDataContainerLayoutGroupSpacings()
    container = m.MetaDataContainerLayoutGroup
    currentSpacings = container.itemSpacings

    ' Define configuration arrays for both states
    ' Index:         0,   1,   2,   3
    normalSpacings = [10, 10, 25, -23]
    fallbackSpacings = [-30, -40, -30, -60]

    for i = 0 to 3
        child = container.GetChild(i)

        ' Null check the child and ensure the field exists before reading it
        if child <> invalid and child.HasField("text") and IsNotBlank2(child.text)
            currentSpacings[i] = normalSpacings[i]
        else if child.visible = true and child.id = "homePlayMoreInfoLabelList_container"
            currentSpacings[i] = normalSpacings[i]
        else
            currentSpacings[i] = fallbackSpacings[i]
        end if
    end for

    container.itemSpacings = currentSpacings
end sub

sub triggerTrailerTimer()
    if m.trailerPlayer <> invalid then m.trailerPlayer.control = "stop"
    m.trailerTimer.control = "stop"
    m.trailerTimer.control = "start"
end sub

sub onTrailerTimerFired()
    VODContent = invalid
    if m.rowlist.hasFocus() = true and m.RowList <> invalid and m.RowList.content <> invalid and m.RowList.rowItemFocused <> invalid and m.RowList.rowItemFocused.count() > 0 and m.RowList.content.getChild(m.RowList.rowItemFocused[0]) <> invalid and m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1]) <> invalid and m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1]).trailerUrl <> invalid
        VODContent = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    else if m.homePlayMoreInfoLabelList.hasFocus() = true and m.bannerData <> invalid and m.bannerData[m.currentBannerShowingIndex] <> invalid
        VODContent = m.bannerData[m.currentBannerShowingIndex]
    end if
    if VODContent <> invalid and VODContent.show_trailer <> invalid and VODContent.show_trailer = true and VODContent.trailerUrl <> invalid and VODContent.trailerUrl <> ""
        if not VODContent.itemType = "FEATURED" and not VODContent.itemType = "GENRE" and not VODContent.itemType = "TOP_TRENDING" and not VODContent.itemType = "CONTINUE_WATCHING" and not VODContent.itemType = "SCHEDULE"
            videoContent = createObject("RoSGNode", "ContentNode")
            videoContent.url = VODContent.trailerUrl'"https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8" '"https://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8" 'VODContent.trailerUrl '
            videoContent.title = ""
            videoContent.unObserveField("state")
            videoContent.streamformat = "m3u8"
            sec = CreateObject("roRegistrySection", getAppKey2())
            if m.trailerPlayer = invalid
                m.trailerPlayer = createObject("roSGNode", "Video")
                m.trailerPlayer.id = "trailerPlayer"
                m.trailerPlayer.enableUI = false
                ' m.trailerPlayer.playbackSpeed = 2.0
                m.trailerPlayer.width = m.bannerPoster.width
                m.trailerPlayer.height = m.bannerPoster.height
                m.trailerPlayer.translation = [0, 0]
                if m.bannerContainer.getChildCount() > 1
                    m.bannerContainer.removeChild(1)
                end if
                m.bannerContainer.insertChild(m.trailerPlayer, 1)
            end if
            m.trailerPlayer.content = videoContent
            if sec.Exists("tokplayy")
                tok = sec.Read("tokplayy")
                m.trailerPlayer.AddHeader("token", tok)
            end if
            m.trailerPlayer.control = "play"
            m.trailerPlayer.enableUI = false
            m.trailerPlayer.unObserveField("state")
            m.trailerPlayer.observeField("state", "onVideoPlayerStateChanged")
            m.trailerPlayer.observeField("visible", "onVideoPlayerVisibilityChanged")
        end if
    end if
end sub

sub OnreleasePlayer()
    if m.trailerPlayer <> invalid
        ?"OnreleasePlayer called33eew"
        m.trailerPlayer.control = "pause"
        m.trailerPlayer.content = invalid

        m.trailerPlayer.visible = false
        ' sleep(50)
        m.trailerPlayer.control = "stop"
        m.top.removeChild(m.trailerPlayer)
        m.trailerPlayer = invalid

        ?"67e5345rty"
        stopAutobannerScroll()
    end if
end sub

sub onVideoPlayerStateChanged()
    if m.trailerPlayer <> invalid
        if m.trailerPlayer.state = "playing"
            m.bannerPoster.visible = false
            m.trailerPlayer.visible = true
        else if m.trailerPlayer.state = "buffering"
            m.bannerPoster.visible = false
            m.trailerPlayer.visible = true
        else if m.trailerPlayer.state = "paused"
            m.bannerPoster.visible = true
            m.trailerPlayer.visible = false
        else if m.trailerPlayer.state = "stopped"
            m.bannerPoster.visible = true
            m.trailerPlayer.visible = false
        else if m.trailerPlayer.state = "finished"
            m.bannerPoster.visible = true
            m.trailerPlayer.visible = false
        end if
    end if
end sub

sub onVideoPlayerVisibilityChanged()
    if m.trailerPlayer.visible = false
        m.trailerPlayer.control = "stop"
    end if
end sub

function setVideo()
    ?"setvideo called"
    videoContent = createObject("RoSGNode", "ContentNode")
    VODcontent = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    m.PlayerTaskLive = CreateObject("roSGNode", "PlayerTaskLive")
    m.PlayerTaskLive.observeField("state", "onTaskStateUpdated")
    if VODcontent.ssai_flag = true
        videoContent = {
            ad_pod_url: VODcontent.ad_pod_url,
            title: "true",
            url: Str(VODcontent.channel_id).Trim(),
            categories: VODcontent.url
        }
    else
        videoContent = {
            ad_pod_url: VODcontent.ad_pod_url,
            title: "false",
            url: Str(VODcontent.channel_id).Trim(),
            categories: VODcontent.url
        }
    end if
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    m.video = m.top.findNode("Video1")
    m.video.content = content
    m.video.notificationInterval = 1
    m.PlayerTaskLive.videos = m.video
    m.PlayerTaskLive.control = "RUN"
end function

'calling lazy loading api for updating rows
sub lazyLoadingFunction()
    if m.rowList.content.getChildCount() - 1 = m.rowList.RowItemFocused[0]
        m.LazyLoadingCategoryTask = CreateObject("roSGNode", "LazyLoadingCategoryTask")
        m.LazyLoadingCategoryTask.ObserveField("LazyLoadingCategoryListStatus", "OnLazyLoadingCategoryContent")
        m.LazyLoadingCategoryTask.offsetCount = m.offsetCountForLazyLoading 'm.RowList.content.getChildCount()
        m.LazyLoadingCategoryTask.callFunc("runLazyLoadingCategory", "")
    end if



    if not m.rowList.content.getChild(m.rowList.rowItemFocused[0]).getChildCount() < 6 ' if category has only few visible items
        if m.rowList.content.getChild(m.rowList.rowItemFocused[0]).getChildCount() - 1 = m.rowList.rowItemFocused[1]
            m.LazyLoadingSubCategoryTask = CreateObject("roSGNode", "LazyLoadingSubCategoryTask")
            m.LazyLoadingSubCategoryTask.ObserveField("LazyLoadingSubCategoryListStatus", "OnLazyLoadingSubCategoryContent")
            m.LazyLoadingSubCategoryTask.currentRowWhichNeedsToUpdate = m.RowList.RowItemFocused[0]
            m.LazyLoadingSubCategoryTask.offsetCount = m.rowList.RowItemFocused[1]
            m.LazyLoadingSubCategoryTask.currentCategoryIdWhichNeedsToUpdate = m.RowList.content.getChild(m.rowList.RowItemFocused[0]).categoryId
            m.LazyLoadingSubCategoryTask.callFunc("runLazyLoadingSubCategory", "")
        end if
    end if
end sub

'lazy loading for updating eacg items in a specific row
sub OnLazyLoadingSubCategoryContent()
    if invalid <> m.LazyLoadingSubCategoryTask.LazyLoadingSubCategoryContent
        'updating each items in a specific row
        for i = 0 to m.LazyLoadingSubCategoryTask.LazyLoadingSubCategoryContent.getChildCount()
            m.rowlist.content.getChild(m.LazyLoadingSubCategoryTask.currentRowWhichNeedsToUpdate).appendChild(m.LazyLoadingSubCategoryTask.LazyLoadingSubCategoryContent.getChild(0))
        end for
    end if
    m.LazyLoadingSubCategoryTask.callFunc("stopLazyLoadingSubCategory", "")
end sub

'lazyloading for updating rows
sub OnLazyLoadingCategoryContent()
    if invalid <> m.LazyLoadingCategoryTask.LazyLoadingCategoryContent

        if m.LazyLoadingCategoryTask.LazyLoadingCategoryContent.getChildCount() <> 0
            m.offsetCountForLazyLoading = m.offsetCountForLazyLoading + 10
        end if

        for i = 0 to m.LazyLoadingCategoryTask.LazyLoadingCategoryContent.getChildCount()
            m.rowlist.content.appendChild(m.LazyLoadingCategoryTask.LazyLoadingCategoryContent.getChild(0))
        end for

    end if
    m.LazyLoadingCategoryTask.callFunc("stopLazyLoadingCategory", "")
end sub





sub change()
    if(m.top.GloBoolean = true) then
        m.EventFetcher.user_id = getUserIdana()
        m.EventFetcher.event_type = "POP03"
        m.EventFetcher.video_id = "0"
        m.EventFetcher.video_title = getchannelname()
        m.EventFetcher.channel_id = getchannelsid()
        m.EventFetcher.category = ""
        m.EventFetcher.callFunc("runEventFetcher", "")
    end if
end sub


sub onVisibleChange()
    ?"onVisibleChange called gridscreen"
    if m.top.visible = true then
        if m.homePlayMoreInfoLabelList.visible = true
            if m.top.lastFocusedNode = "rowList" then return
            m.homePlayMoreInfoLabelList.setFocus(true)
            if m.top.categorynodefocus = true
                m.homePlayMoreInfoLabelList.setFocus(false)
                m.top.setFocusToTopMenu = true
                m.top.categorynodefocus = false
                ?"ssss"
            end if
            m.homeEnLargeAnimation.control = "start"
        else
            m.rowlist.setFocus(true)
        end if
    else
        ?"onVisibleChange called gridscreen111"
        if m.trailerPlayer <> invalid
            m.trailerPlayer.control = "stop"
            ?m.trailerPlayer.control
            ?"kshkdjh"
            ?m.trailerPlayer.state
            m.trailerPlayer.content = invalid
            m.trailerPlayer.visible = false
            m.top.removeChild(m.trailerPlayer)
            m.trailerPlayer = invalid
        end if
        ?"iiuuue"
        stopAutobannerScroll()
        ?"eerrtr"
    end if
end sub

' sub onVisibleChange()


'     if m.top.visible = true then
'         if m.homePlayMoreInfoLabelList.visible = true
'             m.homePlayMoreInfoLabelList.setFocus(true)
'             m.homeEnLargeAnimation.control = "start"


' '
'     else
'         ?"onVisibleChange called gridscreen111"
'         if m.trailerPlayer <> invalid
'             m.trailerPlayer.control = "stop"
'             ?m.trailerPlayer.control
'             ?"kshkdjh"
'             ?m.trailerPlayer.state
'             m.trailerPlayer.content = invalid
'             m.trailerPlayer.visible = false
'             m.top.removeChild(m.trailerPlayer)
'             m.trailerPlayer = invalid
'         end if
'         stopAutobannerScroll()
'     end if
' end sub


'function to autoscroll banner
function OnautoBannerScrollTimerCalled()
    ' ?"OnautoBannerScrollTimerCalled gridscreen "m.currentBannerShowingIndex

    if m.trailerPlayer <> invalid and m.trailerPlayer.state = "playing" then return true
    ' move right, loop at end
    if m.currentBannerShowingIndex <> -1 and m.bannerData <> invalid
        if m.currentBannerShowingIndex < m.bannerData.count() - 1
            m.currentBannerShowingIndex++
        else
            m.currentBannerShowingIndex = 0
        end if
        showBanner(m.currentBannerShowingIndex)
        playMetaDataAnim("in")
    end if
end function




'########lazyloading function offlibe
function lazyLoadingFunctionOffline(HomeListApiTaskContent)
    m.HomeListApiTaskContent = HomeListApiTaskContent
    initialTenthNodes = m.HomeListApiTaskContent.getChildren(10, 0)
    ItemContentNode = CreateObject("RoSGNode", "ContentNode")
    for i = 0 to initialTenthNodes.Count() - 1
        ItemContentNode.appendChild(initialTenthNodes[i])
    end for
    m.rowlist.content = ItemContentNode
    ?"kmk"
end function

' function OnrowItemFocused()



'     ' rowItemSize = m.rowlist.rowItemSize
'     ' rowHeights = m.rowlist.rowHeights
'     ' rowIndex = m.rowList.rowItemFocused[0]
'     ' itemIndex = m.rowList.rowItemFocused[1]

'     ' ' clone current spacing
'     ' spacing = m.rowList.rowItemSpacing

'     ' ' reset old
'     ' if m.prevRowIndex <> invalid
'     '     spacing.SetEntry(m.prevRowIndex, [15, 15])
'     ' end if

'     ' ' inject new spacing for this row
'     ' spacing.SetEntry(rowIndex, [100, 100])

'     ' ' apply back to rowlist
'     ' m.rowList.rowItemSpacing = spacing

'     ' m.prevRowIndex = rowIndex
' end function

function lazyLoadingFunctionOfflineForRowAddition()
    if m.rowList.content.getChildCount() - 1 = m.rowList.RowItemFocused[0]
        HomeListApiTaskContent = m.HomeListApiTaskContent.getChildren(10, 0)
        if HomeListApiTaskContent.Count() <> invalid and HomeListApiTaskContent.Count() <> 0
            ?"dedd"
            for i = 0 to HomeListApiTaskContent.Count() - 1
                if invalid <> HomeListApiTaskContent[i]
                    ?"deseded"
                    m.rowlist.content.appendChild(HomeListApiTaskContent[i])
                    ?"fedfe"
                end if
            end for
        end if
    end if
end function


function lazyLoadingFunctionOfflineForItemsAddition()
    if m.rowList.content.getChild(m.rowList.rowItemFocused[0]).getChildCount() - 1 = m.rowList.RowItemFocused[1]
        HomeListApiTaskContent = m.HomeListApiTaskContent.getChildren(10, 0)
        if HomeListApiTaskContent.Count() <> invalid and HomeListApiTaskContent.Count() <> 0
            for i = 0 to HomeListApiTaskContent.Count() - 1
                if invalid <> HomeListApiTaskContent[i]
                    m.rowlist.content.appendChild(HomeListApiTaskContent[i])
                end if
            end for
        end if
    end if
end function

function stopAutobannerScroll()
    if m.autoBannerScrollTimer <> invalid
        m.autoBannerScrollTimer.control = "stop"
    end if
end function

function onHomeEnlargeAnimationCalled()
    ?"onHomeEnlargeAnimationCalled called"
    m.homeEnLargeAnimation.control = "start"
    m.bannerDots.visible = true
    m.isHomeEnlargedNow = true
end function

function onHomeShrinkAnimationCalled()
    ?"onHomeShrinkAnimationCalled called"
    m.homeShrinkAnimation.control = "start"
    m.bannerDots.visible = false
    m.isHomeEnlargedNow = false
end function

sub onFocusChanged()
    if m.homePlayMoreInfoLabelList.hasFocus()
        m.top.lastFocusedNode = "homePlayMoreInfoLabelList"
        if m.isHomeEnlargedNow = false then onHomeEnlargeAnimationCalled()
        m.autoBannerScrollTimer.control = "stop"
        m.autoBannerScrollTimer.control = "start"
        showBanner(m.currentBannerShowingIndex)
        m.homePlayMoreInfoLabelList_container.visible = true
        ?"onFocusChanged 1111"
    else if m.rowList.hasFocus()
        stopAutobannerScroll()
        if m.isHomeEnlargedNow = true then onHomeShrinkAnimationCalled()
        m.top.lastFocusedNode = "rowList"
        m.homePlayMoreInfoLabelList_container.visible = false
        ?"onFocusChanged 2222"
    end if
end sub

sub onHomePlayMoreInfoLabelListItemSelected()
    if m.bannerData <> invalid
        banner = m.bannerData[m.currentBannerShowingIndex]
        selectedItemAssoc = {
            type: banner.type,
            categoryType: banner.categoryType,
            show_id: banner.show_id,
            button_text: banner.button_text,
            checkout_qr: banner.checkout_qr
        }
        OnreleasePlayer()
        m.top.selectedBannerItem = selectedItemAssoc
    end if
end sub


sub createMetaDataAnims()
    yPos = m.MetaDataContainer.translation[1]

    ' --- Slide In Animation ---
    animIn = createObject("roSGNode", "Animation")
    animIn.duration = 0.5
    animIn.easeFunction = "outCubic"

    slideIn = createObject("roSGNode", "Vector2DFieldInterpolator")
    slideIn.fieldToInterp = "MetaDataContainer.translation"
    slideIn.key = [0.0, 1.0]
    slideIn.keyValue = [[80, yPos], [0, yPos]]

    animIn.appendChild(slideIn)

    ' --- Slide Out Animation ---
    animOut = createObject("roSGNode", "Animation")
    animOut.duration = 0.5
    animOut.easeFunction = "outCubic"

    slideOut = createObject("roSGNode", "Vector2DFieldInterpolator")
    slideOut.fieldToInterp = "MetaDataContainer.translation"
    slideOut.key = [0.0, 1.0]
    slideOut.keyValue = [[0, yPos], [80, yPos]]

    animOut.appendChild(slideOut)

    m.top.appendChild(animIn)
    m.top.appendChild(animOut)

    m.metaDataAnimIn = animIn
    m.metaDataAnimOut = animOut
end sub

function showBanner(index)
    if m.bannerData <> invalid and index <> invalid
        m.autoBannerScrollTimer.control = "stop"
        m.autoBannerScrollTimer.control = "start"
        banner = m.bannerData[index]
        m.bannerPoster.uri = banner.HDBACKGROUNDIMAGEURL
        if banner.image_title <> invalid and banner.image_title <> ""
            m.imageTitlePoster.uri = banner.image_title
            ' m.imageTitlePoster.translation = [m.imageTitlePoster.translation[0], m.imageTitlePoster.translation[1] - m.imageTitlePoster.boundingRect().height] ' Adjust Y position based on the image height
            m.imageTitlePoster.visible = true
            m.Title.visible = false
        else
            m.imageTitlePoster.visible = false
            m.Title.visible = true
            m.Title.text = banner.title
        end if
        m.synopsis.text = banner.synopsis


        values = []
        if banner.rating <> invalid and banner.rating <> "" then values.push(banner.rating)
        if banner.show_cast <> invalid and banner.show_cast <> "" then values.push(banner.show_cast)
        if banner.duration_text <> invalid and banner.duration_text <> "" then values.push(banner.duration_text)

        result = ""
        if values.Count() > 0
            result = values[0]
            for i = 1 to values.Count() - 1
                result = result + " • " + values[i]
            end for
            ' m.category_name.text = result
        else
            m.category_name.text = ""
        end if

        m.category_name.text = banner.duration_text

        ' 1. Determine the text to display
        buttonText = banner.button_text
        if buttonText = invalid or buttonText = ""
            buttonText = getTextOf("more_info")
        end if

        setMoreInfoLabelListWidth(buttonText)

        if m.category_name.text <> invalid and m.category_name.text <> ""
            m.imageTitlePoster.translation = [m.imageTitlePoster.translation[0], 170]
        else
            m.imageTitlePoster.translation = [m.imageTitlePoster.translation[0], 210]
        end if

        m.fadeInAnim.control = "start"
        updateDots(index)
        triggerTrailerTimer()
        setMetaDataContainerLayoutGroupSpacings()
    end if
end function

sub setMoreInfoLabelListWidth(buttonText)
    ' 2. Measure the text width
    ' Use a temporary label with the same font/size as your LabelList
    m.textMeasurerLabel.font = m.homePlayMoreInfoLabelList.font ' Ensure fonts match
    m.textMeasurerLabel.text = buttonText

    ' boundingRect() gives you the width and height of the rendered text
    textWidth = m.textMeasurerLabel.boundingRect().width

    ' 4. Apply to the LabelList
    m.homePlayMoreInfoLabelList.itemSize = [textWidth + 30, m.homePlayMoreInfoLabelList.itemSize[1]] ' Keep your preferred height
    m.homePlayMoreInfoLabelList.content.getChild(0).title = buttonText
end sub


sub playMetaDataAnim(direction as string)
    yPos = m.MetaDataContainer.translation[1]
    if direction = "in"
        m.metaDataAnimIn.getchild(0).keyValue = [[80, yPos], [0, yPos]]
        m.metaDataAnimIn.control = "start"
    else if direction = "out"
        m.metaDataAnimOut.getchild(0).keyValue = [[-50, yPos], [0, yPos]]
        m.metaDataAnimOut.control = "start"
    end if
end sub

sub clearBannerData()
    m.imageTitlePoster.uri = ""
    m.category_name.text = ""
    m.Title.text = ""
end sub

' sub updateDots(index as integer) delete this code if no errors are found in dots update logic. 16 03 26
'     if m.bannerData <> invalid and m.bannerDots <> invalid and m.bannerDots.content <> invalid
'         for i = 0 to m.bannerData.count() - 1
'             dot = m.bannerDots.content.getchild(0).getChild(i)
'             if i = index
'                 dot.color = "#FFFFFF" ' active white
'             else
'                 dot.color = "#525252ff" ' inactive gray
'             end if
'         end for
'         m.bannerDots.content = m.bannerDots.content ' force refresh
'     end if
' end sub

sub updateDots(index as integer)
    if m.bannerDots <> invalid and m.bannerDots.content <> invalid
        dotContainer = m.bannerDots.content.getChild(0)

        if dotContainer <> invalid
            ' Loop based on the number of dot children found
            for i = 0 to dotContainer.getChildCount() - 1
                dot = dotContainer.getChild(i)

                if i = index
                    dot.color = "#FFFFFF" ' active white
                else
                    dot.color = "#525252FF" ' inactive gray
                end if
            end for

            ' Force UI refresh
            m.bannerDots.content = m.bannerDots.content
        end if
    end if
end sub



'########################## BANNER ITEMVIEW LIVE PLAY SECTION #################################################

sub callLiveApi(focusedContent)
    m.liveApi = createObject("roSGNode", "LiveFetcher")
    if focusedContent <> invalid and focusedContent.live_channel_id <> invalid then
        m.liveApi.channel_id = focusedContent.live_channel_id.ToStr()
    else
        m.liveApi.channel_id = getchannelsid()
    end if
    m.liveApi.LiveScheduleRequest = "run"
    m.liveApi.callFunc("runLiveFetcherTask", "HOMESCENE_BANNER_PLAY")
    m.liveApi.observeField("livefetcherResponse", "onPlayLive")
end sub

sub onPlayLive()
    if m.liveApi <> invalid and m.liveApi.livefetcherResponse <> invalid and m.liveApi.livefetcherResponse.count() > 0 then
        playLiveVideo(m.liveApi.livefetcherResponse[0])
    end if
end sub

sub playLiveVideo(liveResponseData)
    ?"playVideoFunction called : VideoPlayerForTimeGridScene"
    if liveResponseData <> invalid

        if (liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.title <> invalid) title = liveResponseData.now_playing.title else title = liveResponseData.channel_name
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.id <> invalid then id = liveResponseData.now_playing.id.toStr() else id = 0
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.live_link <> invalid then liveLink = liveResponseData.now_playing.live_link else liveLink = liveResponseData.live_link
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.show_id <> invalid then show_id = liveResponseData.now_playing.show_id else show_id = 0
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.id <> invalid then schedule_id = liveResponseData.now_playing.id else schedule_id = 0
        if liveResponseData <> invalid and liveResponseData.now_playing <> invalid and liveResponseData.now_playing.description <> invalid then description = liveResponseData.now_playing.description else description = liveResponseData.description

        videoContent = {
            channel_id: liveResponseData.channel_id,
            streamFormat: "m3u8",
            titleSeason: "",
            HDBranded: true,
            ClosedCaptions: true,
            IsHD: true,
            title: title,
            id: id.ToStr(),
            url: liveLink'"https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"'liveResponseData.now_playing.live_link, '"https://epg.provider.plex.tv/library/parts/5e20b730f2f8d5003d739db7-5f0ff262d71dcb00449ec015.m3u8?X-Plex-Session-Identifier=y75hbmqm7cpch5u2ho42sjvu&X-Plex-Product=Plex%20Web&X-Plex-Version=4.122.0&X-Plex-Client-Identifier=m5qurtm6cggg1j9rbld98o4t&X-Plex-Platform=Chrome&X-Plex-Platform-Version=120.0&X-Plex-Features=external-media%2Cindirect-media%2Chub-style-list&X-Plex-Model=hosted&X-Plex-Device=Windows&X-Plex-Device-Name=Chrome&X-Plex-Device-Screen-Resolution=1536x695%2C1536x864&X-Plex-Token=2t8GyRGDf-Cos5NxGk7j&X-Plex-Language=en&Accept-Language=en&X-Plex-Session-Id=e0f1dcad-8853-438e-84f9-c6fa0fc45939"'liveResponseData.URL, '  liveLink'liveResponseData.now_playing.live_link, '
            categories: "",
            nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
            nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
            nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        }
        content = CreateObject("roSGNode", "VideoContent")
        content.setFields(videoContent)
        content.addFields({
            "is_live": "1",
            "channel_id": liveResponseData.channel_id,
            "show_id": show_id.Tostr(),
            "schedule_id": schedule_id.toStr(),
            "description": description,
            "is_from": "HOMESCENE_BANNER_PLAY",
            "prevent_setting_focus_on_live_player": true
        })
        content.ClosedCaptions = true
        content.globalCaptionMode = "On"
        content.HDBranded = true
        content.IsHD = true
        if m.PlayerForTimeGrid = invalid:
            m.PlayerForTimeGrid = m.top.CreateChild("PlayerForTimeGrid")
            m.PlayerForTimeGrid.getchild(3).width = m.bannerPoster.width
            m.PlayerForTimeGrid.getchild(3).height = m.bannerPoster.height
            m.PlayerForTimeGrid.getchild(3).enableUI = false
            m.PlayerForTimeGrid.getchild(3).translation = [0, 0]
            m.PlayerForTimeGrid.observeField("state", "PlayerForTimeGridStateChanged")
            m.PlayerForTimeGrid.observeField("visible", "onVideoForTimeGridPlayerVisibleChange")
            m.global.Live_player = m.PlayerForTimeGrid
        end if

        m.PlayerForTimeGrid.width = m.bannerPoster.width
        m.PlayerForTimeGrid.height = m.bannerPoster.height
        m.PlayerForTimeGrid.translation = [0, 0]
        if m.bannerContainer.getChildCount() > 1
            m.bannerContainer.removeChild(1) 'removing if any player node already inserted
        end if
        m.bannerContainer.insertChild(m.PlayerForTimeGrid, 1)

        m.Title.text = title
        m.synopsis.text = description

        m.PlayerForTimeGrid.content = content
        m.PlayerForTimeGrid.watched_duration = 0
        m.PlayerForTimeGrid.visible = true
        m.PlayerForTimeGrid.skipAd = true
        m.PlayerForTimeGrid.control = "play"
        m.rowlist.setFocus(true)
        ?"dsakjdhaskd"
    end if
end sub

function PlayerForTimeGridStateChanged()
    ?"PlayerForTimeGridStateChanged called : VideoPlayerScene ";m.PlayerForTimeGrid.state
    if m.PlayerForTimeGrid.state = "done" or m.PlayerForTimeGrid.state = "stop"
        ?"onVideoForTimeGridPlayerVisibleChange called222"
        m.PlayerForTimeGrid.control = "stop"
    end if

    if m.PlayerForTimeGrid <> invalid
        if m.PlayerForTimeGrid.state = "playing"
            m.bannerPoster.visible = false
            m.PlayerForTimeGrid.visible = true
        else if m.PlayerForTimeGrid.state = "buffering"
            m.bannerPoster.visible = false
            m.PlayerForTimeGrid.visible = true
        else if m.PlayerForTimeGrid.state = "paused"
            m.bannerPoster.visible = true
            m.PlayerForTimeGrid.visible = false
        else if m.PlayerForTimeGrid.state = "stopped"
            m.bannerPoster.visible = true
            m.PlayerForTimeGrid.visible = false
        else if m.PlayerForTimeGrid.state = "finished"
            m.bannerPoster.visible = true
            m.PlayerForTimeGrid.visible = false
        end if
    end if
end function


function onVideoForTimeGridPlayerVisibleChange(params)
    ?"onVideoForTimeGridPlayerVisibleChange called"
    ?m.PlayerForTimeGrid.state

end function


function getLayoutGroupHeight(group as object) as float
    total = 0

    for each child in group.getChildren(-1, 0)
        if child.visible = true
            total = total + child.boundingRect().height
        end if
    end for

    ' add spacing between items
    spacings = group.itemSpacings
    if spacings <> invalid and spacings.count() > 0
        for each s in spacings
            total = total + s
        end for
    end if

    return total
end function

sub onImageTitlePosterLoadStatusChanged(_event as object)
    if m.imageTitlePoster.loadStatus <> "ready" return
    if _event.getData() = "ready"
        w = m.imageTitlePoster.bitmapWidth
        h = m.imageTitlePoster.bitmapHeight

        if w > 0 and h > 0
            fixedW = m.imageTitlePoster.width
            newH = (h / w) * fixedW '194

            m.imageTitlePoster.height = newH

            ' 🔥 IMPORTANT: position image ABOVE bottom content
            bottomY = m.MetaDataContainerLayoutGroup.translation[1] '520
            if m.isHomeEnlargedNow = true then spacing = 50 else spacing = 120
            contentH = getLayoutGroupHeight(m.MetaDataContainerLayoutGroup) '185
            m.imageTitlePoster.translation = [120, bottomY - newH - contentH - spacing]
        end if
    end if
end sub