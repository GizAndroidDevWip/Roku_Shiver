sub init()
    m.ShowFetcher = CreateObject("roSGNode", "ShowFetcher")
    m.ShowFetcher.observeField("showFetcherStatus", "onContentChanged")
    m.ShowFetcher.observeField("rawShowfetcherContent", "onRawContentChanged")
    m.SimilarShows = CreateObject("roSGNode", "SimilarShows")
    m.SimilarShows.observeField("similarShowsApiListContent", "onSimilarShowChanged")
    m.VideoSubscriptionTask = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.Ratings = CreateObject("roSGNode", "Rating")
    m.Ratings.observeField("RatingResponse", "OnRatingResponse")
    m.Ratings.rating = -1
    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    m.count5 = 0
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "logoutAndGoToLandingScene")
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = "You are no longer Logged in this device. Please Login again to access."
    okTitle = getTextOf("ok")
    logoutAllTitle = getTextOf("logout_all") ' Default value
    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")
    m.LogoutTask = CreateObject("roSGNode", "LogoutTask")
    m.LogoutTask.observeField("LogoutResponse", "logoutAndGoToLandingScene")
    m.top.sessionExpiredPopUp = CreateObject("roSGNode", "BackDialog")
    m.top.sessionExpiredPopUp.backgroundUri = "pkg:/images/black.jpg"
    m.top.sessionExpiredPopUp.title = getTextOf("session_expired_message")
    m.top.sessionExpiredPopUp.buttons = ["Ok"]
    m.top.sessionExpiredPopUp.ObserveField("buttonSelected", "OnsessionExpiredClick")

    m.textMeasurer = createObject("roSGNode", "Label")
    font = createObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Medium.ttf"
    font.size = 25
    m.textMeasurer.font = font
    m.textMeasurer.visible = false

    m.show_more_button = m.top.findNode("show_more_button")
    m.show_more_button.observeField("focusedChild", "onshow_more_buttonFocused")
    m.show_more_button.observeField("buttonSelected", "onshow_more_buttonSelected")
    m.show_more_button.getChild(0).blendColor = getButtonSelectionColor()
    m.show_more_button.getChild(1).blendColor = "#313033"
    m.ScrollableText = m.top.findNode("ScrollableText")
    m.show_more_button.textFont.size = "20"
    m.show_more_button.focusedTextFont.size = "20"
    m.show_more_button.visible = false
    m.show_more_button.text = getTextOf("show_more")
    m.descr_rect_color_rect = m.top.findNode("descr_rect_color_rect")
    m.descr_rect = m.top.findNode("descr_rect")
    m.descr_rect_color_rect.color = getBackGroundColor()
    m.screenStack = []
    m.GridScreen = m.top.findNode("GridScreen")
    m.loadingIndicator = m.top.findNode("loading")
    m.AdTimer = m.top.findNode("AdTimer")
    m.Video = m.top.findNode("Video1")
    m.RowList = m.top.findNode("RowList")
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Poppins-Bold.ttf"
    font.size = 24
    font.color = getTextColor()
    m.RowList.rowLabelFont = font
    m.BottomBar = m.top.findNode("BottomBar")
    m.ShowBar = m.top.findNode("ShowBar")
    m.HideBar = m.top.findNode("HideBar")
    m.imageTitlePoster = m.top.findNode("imageTitlePoster")
    m.LabelGroup = m.top.findNode("LabelGroup")
    m.Title1 = m.top.findNode("Title1")
    m.Title1.Font.size = "62"
    m.resolution = m.top.findNode("resolution")
    m.categories = m.top.findNode("categories")
    m.Episode = m.top.findNode("Episode")
    m.descri = m.top.findNode("descri")
    m.desc_more = m.top.findNode("desc_more")
    m.descri_title = m.top.findNode("descri_title")
    m.background = m.top.findNode("Background")
    m.backGroundBannerPoster = m.top.findNode("backGroundBannerPoster")
    m.Year = m.top.findNode("Year")
    m.Duration = m.top.findNode("Duration")
    m.Director = m.top.findNode("Director")
    m.Directedby = m.top.findNode("Directedby")
    m.Timer = m.top.findNode("Timer")
    m.top.Title = m.top.findNode("Title")
    m.cast = m.top.findNode("cast")
    m.rating = m.top.findNode("rating")
    m.years = m.top.findNode("years")
    m.time = m.top.findNode("time")
    m.direct = m.top.findNode("direct")
    m.prod = m.top.findNode("prod")
    m.casting = m.top.findNode("casting")
    m.Timer2 = m.top.findNode("Timer2")
    m.autoThumb = m.top.findNode("autoThumb")
    m.bannerPoster = m.top.findNode("bannerPoster")
    m.bannerPoster1 = m.top.findNode("bannerPoster1")
    m.bannerPoster1.visible = false
    m.gradientOverlayForBackgroundPlayer = m.top.findNode("gradientOverlayForBackgroundPlayer")
    m.name_label = m.top.findNode("name_label")
    m.subscriptionCornerRounded = m.top.findNode("subscriptionCornerRounded")
    m.autoplaylabel = m.top.findNode("autoplaylabel")
    m.autoplaylabel.Font.size = "50"
    m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    m.buttonsLabelList.ObserveField("RowItemSelected", "onButtonsLabelList")
    m.buttonsLabelList.ObserveField("itemFocused", "onButtonsLabelListFocused")
    m.buttonsLabelList.focusBitmapBlendColor = getTextColor()
    initialiseButtonsLabelList()
    m.tagsRowlist = m.top.findNode("tagsRowlist")
    m.tagsRowlist.observeField("RowItemSelected", "onTagsRowItemSelected")
    m.tagsRowlist.color = getTextColor()
    m.tagsRowlist.rowLabelColor = getTextColor()
    m.tagsRowlist.showRowLabel = true
    m.tagsRowlist.focusBitmapBlendColor = getButtonSelectionColor()
    m.tagsRect = m.top.findNode("tagsRect")
    m.TagsBgPoster = m.top.findNode("TagsBgPoster")
    m.TagsBgPoster.blendColor = "#141414"

    m.autoThumb = m.top.findNode("autoThumb")
    m.autoplaylabel = m.top.findNode("autoplaylabel")
    m.autoplaylabel.Font.size = "50"

    m.top.dialogRating = CreateObject("roSGNode", "Dialog")
    m.top.dialogRating.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogRating.title = "Rate This Show Out Of 5"
    m.top.dialogRating.focusBitmapUri = "pkg:/images/star.png"
    m.top.dialogRating.focusedIconUri = "pkg:/images/star.png"
    m.top.dialogRating.iconUri = "pkg:/images/star.png"
    m.top.dialogRating.optionsDialog = true
    m.top.dialogRating.buttons = ["5", "4", "3", "2", "1"]
    m.top.dialogRating.showFocusFootprint = true
    m.top.dialogRating.ObserveField("buttonSelected", "On_dialogRatingSelected")

    m.top.dialogRatingFeed = CreateObject("roSGNode", "Dialog")
    m.top.dialogRatingFeed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogRatingFeed.title = "Thanks For The Feedback!"
    m.top.dialogRatingFeed.buttons = ["OK"]
    m.top.dialogRatingFeed.showFocusFootprint = true
    m.top.dialogRatingFeed.ObserveField("buttonSelected", "On_dialogRatingFeedSelected")

    m.top.dialogRatingFeedError = CreateObject("roSGNode", "Dialog")
    m.top.dialogRatingFeedError.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogRatingFeedError.title = "Something Went Wrong"
    m.top.dialogRatingFeedError.buttons = ["OK"]
    m.top.dialogRatingFeedError.showFocusFootprint = true
    m.top.dialogRatingFeedError.ObserveField("buttonSelected", "On_dialogRatingFeedErrorSelected")
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")
    m.NoButton = m.top.findNode("NoButton")
    m.NoButton.getChild(0).blendColor = getButtonSelectionColor()
    m.YesButton = m.top.findNode("YesButton")
    m.YesButton.getChild(0).blendColor = getButtonSelectionColor()
    m.dialogmessage_label = m.top.findNode("dialogmessage_label")
    m.cancelbutton_Label = m.top.findNode("cancelbutton_Label")
    m.exitbutton_Label = m.top.findNode("exitbutton_Label")
    m.buttonRectangle = m.top.findNode("buttonRectangle")
    m.rectangleForSmallDetails = m.top.findNode("rectangleForSmallDetails")
    m.backGroundVideo = m.top.findNode("backGroundVideo")
    m.subscriptionList = m.top.findNode("subscriptionList")
    m.subscriptionList.ObserveField("visible", "onSubscriptionListVisibleChange")
    m.isWatchWithOutAdsDialogRectVisible = false ' dialog box visible flag for watch withoutads
    m.continueWatchingDialogVisible = false 'same dialog box using another flag for continue watching
    m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false ' dialog box visible flag for watch withoutads for autoplay
    m.continueWatchingDialogVisible_ForAutoplay = false ' dialog box visible flag for watch continue watching for autoplay
    m.subscriptionedUserorNot = false
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.currentUserId = getUserIdana()

    ' animation
    m.mainrectscrollupTimer = m.top.FindNode("mainrectscrollupTimer")
    m.mainrectscrolldownTimer = m.top.FindNode("mainrectscrolldownTimer")
    m.scrollUpAnimation = m.top.FindNode("scrollup_animation")
    m.scrollDownAnimation = m.top.FindNode("scrolldown_animation")
    m.mainrectscrollupTimer.ObserveField("fire", "scrollUpAnimation")
    m.mainrectscrolldownTimer.ObserveField("fire", "scrollDownAnimation")

    m.HomeTopMenuRowlist = m.top.getScene().findNode("HomeTopMenuRowlist")
    m.BrandingLogo = m.top.getScene().findNode("BrandingLogo")

    m.parentScene = GetParentScene()
    m.top.observeField("visible", "onVisibleChange")
    m.rating.color = getTextColor()
    m.years.color = getTextColor()
    m.time.color = getTextColor()
    m.prod.color = getTextColor()
    m.Episode.color = getTextColor()
    m.descri_title.color = getTextColor()
    m.Title1.color = getTextColor()
    m.resolution.color = getTextColor()
    m.categories.color = getTextColor()
    m.descri.color = getTextColor()
    m.casting.color = getTextColor()
    m.cast.color = getTextColor()
    m.direct.color = getTextColor()
    m.Director.color = getTextColor()
    m.Year.color = getTextColor()
    m.Duration.color = getTextColor()
    m.autoplaylabel.color = getTextColor()
    m.dialogmessage_label.color = getTextColor()

    m.buttonsLabelList.color = getTextColor()
    m.buttonsLabelList.focusedColor = "#FFFFFF"
    m.buttonsLabelList.focusFootprintBlendColor = getTextColor()
    m.subscriptionList.color = getTextColor()
    m.RowList.color = getTextColor()
    m.RowList.rowLabelColor = getTextColor()
    m.RowList.focusedColor = getTextColor()
    m.RowList.focusBitmapBlendColor = getButtonSelectionColor()
    m.tagsRowlist.color = getTextColor()


    m.ScrollableText.textColor = getTextColor()
    m.tagsRect.color = getBackGroundColor()
    m.TagsBgPoster.blendColor = getBackGroundColor()

    m.bannerPoster.blendColor = getBackgroundColor1()
    m.gradientOverlayForBackgroundPlayer.blendColor = getBackgroundColor1()
    m.bannerPoster1.blendColor = getBackgroundColor1()

    m.top.isStartOverButtonClicked = false
    m.top.isGoadsFreeclicked = false
end sub

sub onVisibleChange()
    if m.top.visible = true
        if m.buttonsLabelList.visible <> invalid and m.buttonsLabelList.visible
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.buttonsLabelList.visible = false
            onStarted()
            scrollDownAnimation()
            whichNodeToSetFocusBasedOnScreenScrolledStatus()
        end if
    end if

end sub


sub onButtonsLabelList()
    itemSelected = m.buttonsLabelList.RowItemSelected[1]
    idSelected = m.buttonsLabelList.content.getchild(0).getChild(itemSelected).id
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
    if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0) <> invalid
        VODcontent = returnTheCurrentFocusedData()
    end if
    if idSelected = "PLAY"
        onButtonLabelListPlayClicked()
    else if idSelected = "START_OVER"
        m.top.isStartOverButtonClicked = true
        onButtonLabelListPlayClicked()
    else if idSelected = "ADDTOMYLIST"
        OnPlaylist()
    else if idSelected = "GOADSFREE"
        showPaymentPageWhenGoAdsFreeClicked()
    else if idSelected = "SUBSCRIBE"
        playBackGroundvideo("")
        onButtonLabelListPlayClicked()
    else if idSelected = "REMOVEFROMMYLIST"
        OnPlaylistremove()
    else if idSelected = "WATCHTRAILER"
        OnTrailer()
    else if idSelected = "MORE"
        if m.issinglevideo = 1
            if m.top.rowListSingleVideoData <> invalid and m.top.rowListSingleVideoData.getChild(0) <> invalid and m.top.rowListSingleVideoData.getChild(0).TagsContent <> invalid then moreContent = m.top.rowListSingleVideoData.getChild(0).TagsContent
        else
            if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0).TagsContent <> invalid then moreContent = m.ShowFetcher.content.getChild(0).getChild(0).TagsContent
        end if
        setTagsRowlist(moreContent)
    else if idSelected = "LIKE" or idSelected = "DISLIKE"
        if isGuest() = "true"
            goToLandingScene()
        else
            if m.top.start <> invalid
                m.LikeDislikeTask = CreateObject("roSGNode", "LikeDislikeTask")
                m.LikeDislikeTask.observeField("LikeDislikeTaskResult", "onLikeDislikeResponse")
                m.LikeDislikeTask.showId = m.top.start


                if idSelected = "LIKE"
                    if m.liked_flag <> invalid and m.liked_flag = 1
                        m.LikeDislikeTask.action = "LIKE_UNCLICKED"
                    else
                        m.LikeDislikeTask.action = "LIKE_CLICKED"
                    end if
                else if idSelected = "DISLIKE"
                    if m.disliked_flag <> invalid and m.disliked_flag = 1
                        m.LikeDislikeTask.action = "DISLIKE_UNCLICKED"
                    else
                        m.LikeDislikeTask.action = "DISLIKE_CLICKED"
                    end if
                end if
                m.LikeDislikeTask.callFunc("runLikeDislikeTask", "")
            end if
        end if
    end if

end sub


sub onButtonsLabelListFocused()
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
    setShowdetailMatadataForShow()
end sub

sub initialiseButtonsLabelList()
    m.playNow = createObject("RoSGNode", "ContentNode")
    m.playNow.id = "PLAY"
    m.playNow.addField("FHDItemWidth", "float", false)
    m.playNow.addFields({ "isIconNode": false, "watched_percentage": 0 })
    if not getTheme() = "LIGHT"
        m.playNow.HDLISTITEMICONURL = "pkg:/images/playbutton.png"
        m.playNow.HDLISTITEMICONSELECTEDURL = "pkg:/images/playbutton.png"
    end if
    m.playNow.blendColor = getTextColor()
    m.startOverNode = createObject("RoSGNode", "ContentNode")
    m.startOverNode.id = "START_OVER"

    m.startOverNode.title = getTextOf("start_over")

    if not getTheme() = "LIGHT"
        m.startOverNode.HDLISTITEMICONURL = "pkg:/images/icons/startOver.png"
        m.startOverNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/startOver.png"
    end if
    m.startOverNode.addField("FHDItemWidth", "float", false)
    m.startOverNode.addFields({ "isIconNode": true, "watched_percentage": 0 })
    m.startOverNode.FHDItemWidth = 70
    m.AddToMyList = createObject("RoSGNode", "ContentNode")
    m.AddToMyList.id = "ADDTOMYLIST"
    m.AddToMyList.title = getTextOf("add_to_mylist")


    if not getTheme() = "LIGHT"
        m.AddToMyList.HDLISTITEMICONURL = "pkg:/images/plus.png"
        m.AddToMyList.HDLISTITEMICONSELECTEDURL = "pkg:/images/plus.png"
    end if
    m.AddToMyList.addField("FHDItemWidth", "float", false)
    m.AddToMyList.addFields({ "isIconNode": true })
    m.AddToMyList.FHDItemWidth = 70


    m.Subscribe = createObject("RoSGNode", "ContentNode")
    m.Subscribe.id = "SUBSCRIBE"

    m.Subscribe.title = getTextOf("subscribe")

    if not getTheme() = "LIGHT"
        m.Subscribe.HDLISTITEMICONURL = "pkg:/images/premium_icon.png"
        m.Subscribe.HDLISTITEMICONSELECTEDURL = "pkg:/images/premium_icon.png"
    end if
    m.Subscribe.addField("FHDItemWidth", "float", false)
    m.Subscribe.addFields({ "isIconNode": false })
    m.Subscribe.FHDItemWidth = backgroundPosterLength(Len(m.Subscribe.title))


    m.RemoveFromMylist = createObject("RoSGNode", "ContentNode")
    m.RemoveFromMylist.id = "REMOVEFROMMYLIST"

    m.RemoveFromMylist.title = getTextOf("remove_from_mylist")

    if not getTheme() = "LIGHT"
        m.RemoveFromMylist.HDLISTITEMICONSELECTEDURL = "pkg:/images/minus.png"
        m.RemoveFromMylist.HDLISTITEMICONURL = "pkg:/images/minus.png"
    end if
    m.RemoveFromMylist.addField("FHDItemWidth", "float", false)
    m.RemoveFromMylist.addFields({ "isIconNode": true })
    m.RemoveFromMylist.FHDItemWidth = 70


    m.WatchTrailer = createObject("RoSGNode", "ContentNode")
    m.WatchTrailer.id = "WATCHTRAILER"
    m.WatchTrailer.title = getTextOf("watch_trailer")

    m.WatchTrailer.addField("FHDItemWidth", "float", false)
    m.WatchTrailer.addFields({ "isIconNode": true })
    m.WatchTrailer.FHDItemWidth = 70
    m.WatchTrailer.title = "Watch Trailer"
    if not getTheme() = "LIGHT"
        m.WatchTrailer.HDLISTITEMICONURL = "pkg:/images/playbutton2.png"
        m.WatchTrailer.HDLISTITEMICONSELECTEDURL = "pkg:/images/playbutton2.png"
    end if



    m.goAdsFree = createObject("RoSGNode", "ContentNode")
    m.goAdsFree.id = "GOADSFREE"

    m.goAdsFree.title = getTextOf("go_ads_free")

    if not getTheme() = "LIGHT"
        m.goAdsFree.HDLISTITEMICONURL = "pkg:/images/icons/ad_free.png"
        m.goAdsFree.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/ad_free.png"
    end if
    m.goAdsFree.addField("FHDItemWidth", "float", false)
    m.goAdsFree.addFields({ "isIconNode": false })
    m.goAdsFree.FHDItemWidth = backgroundPosterLength(Len(m.goAdsFree.title))


    m.moreButton = createObject("RoSGNode", "ContentNode")
    m.moreButton.id = "MORE"
    m.moreButton.title = getTextOf("more")




    if not getTheme() = "LIGHT"
        m.moreButton.HDLISTITEMICONURL = "pkg:/images/more_image.png"
        m.moreButton.HDLISTITEMICONSELECTEDURL = "pkg:/images/more_image.png"
    end if
    m.moreButton.addField("FHDItemWidth", "float", false)
    m.moreButton.addFields({ "isIconNode": true })
    m.moreButton.FHDItemWidth = 70

    m.likeNode = createObject("RoSGNode", "ContentNode")
    m.likeNode.id = "LIKE"

    m.likeNode.title = getTextOf("like")


    if not getTheme() = "LIGHT"
        m.likeNode.HDLISTITEMICONURL = "pkg:/images/like.png"
        m.likeNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/like.png"
    end if
    m.likeNode.addField("FHDItemWidth", "float", false)
    m.likeNode.addFields({ "isIconNode": true, "ishighlighted": false })
    m.likeNode.FHDItemWidth = 70


    m.disLikeNode = createObject("RoSGNode", "ContentNode")
    m.disLikeNode.id = "DISLIKE"
    m.disLikeNode.title = getTextOf("dislike")


    if not getTheme() = "LIGHT"
        m.disLikeNode.HDLISTITEMICONURL = "pkg:/images/dislike.png"
        m.disLikeNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/dislike.png"
    end if
    m.disLikeNode.addField("FHDItemWidth", "float", false)
    m.disLikeNode.addFields({ "isIconNode": true, "ishighlighted": false })
    m.disLikeNode.FHDItemWidth = 70
end sub

sub addbuttonLabelList(nodes as object)
    parentContent = createObject("RoSGNode", "ContentNode")
    rowContent = createObject("RoSGNode", "ContentNode")
    parentContent.appendChild(rowContent)
    for each node in nodes
        rowContent.appendChild(node)
    end for
    if parentContent <> invalid and parentContent.getChild(0) <> invalid and parentContent.getChild(0).getChild(0) <> invalid and parentContent.getChild(0).getChild(0).isIconNode <> invalid and parentContent.getChild(0).getChild(0).isIconNode = true
        m.buttonsLabelList.focusXOffset = [20, 0, 0, 0, 0] ' to avoid button text of icons being cut if no play button is there
    else
        m.buttonsLabelList.focusXOffset = [0]
    end if
    m.buttonsLabelList.content = parentContent

end sub

function modifyButtonLabelList(newNode as object, index as integer)
    if not (m.ShowFetcher["rawShowfetcherContent"] <> invalid and m.ShowFetcher["rawShowfetcherContent"].hide_play_button = true and newNode.id = "PLAY") ' this  is for coming soon case
        if index >= m.buttonsLabelList.content.getchild(0).GetChildCount()
            m.buttonsLabelList.content.getChild(0).appendChild(newNode)
        else
            if not m.buttonsLabelList.content.getchild(0).getChild(index).id = newNode.id
                m.buttonsLabelList.content.getchild(0).replaceChild(newNode, index)
            end if
        end if
    end if
end function



sub OnPlaylist()
    if isGuest() = "false"
        m.top.playlistAdd = true
        m.top.playlistRemove = false
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("showidlist")
            tok = sec.Read("showidlist")
        else
        end if
        m.playListadd = CreateObject("roSGNode", "playListadd")
        m.playListadd.wflag = "1"
        m.playListadd.showid = tok.ToStr()
        m.playListadd.uid = getUserIdana()
        m.playListadd.observeField("PlaylistResponse", "onPlaylistaddchanged")
        m.playListadd.callFunc("runPlayListAdd", "")
    else
        playBackGroundvideo("")
        m.loadingIndicator.visible = false
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
        m.Video.control = "stop"
    end if
end sub

sub OnTrailer()
    playtrailers()
end sub

sub OnRatingResponse()
    ratingResponse = m.Ratings.RatingResponse
    m.Ratings.callFunc("stopRatingTask", "")
    if ratingResponse = "valid"
        m.parentScene.dialog = m.top.dialogRatingFeed
        ?"m.Ratings.userRating updated"
        ?m.Ratings.rating
    else
        m.parentScene.dialog = m.top.dialogRatingFeedError
    end if
end sub



sub On_dialogRatingSelected()
    GetParentScene()
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("showidlist")
        showid = sec.Read("showidlist")
    else
    end if
    if m.top.dialogRating.buttonSelected = 0 then
        m.Ratings.rating = 5
        m.Ratings.showid = showid
        m.Ratings.callFunc("runRatingTask", "")
    else if m.top.dialogRating.buttonSelected = 1 then
        m.Ratings.rating = 4
        m.Ratings.showid = showid
        m.Ratings.callFunc("runRatingTask", "")
    else if m.top.dialogRating.buttonSelected = 2 then
        m.Ratings.rating = 3
        m.Ratings.showid = showid
        m.Ratings.callFunc("runRatingTask", "")
    else if m.top.dialogRating.buttonSelected = 3 then
        m.Ratings.rating = 2
        m.Ratings.showid = showid
        m.Ratings.callFunc("runRatingTask", "")
    else if m.top.dialogRating.buttonSelected = 4 then
        m.Ratings.rating = 1
        m.Ratings.showid = showid
        m.Ratings.callFunc("runRatingTask", "")
    end if
end sub

sub On_dialogRatingFeedSelected()
    m.parentScene.dialog.close = true
    m.top.ratingBoolean = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
end sub

sub On_dialogRatingFeedErrorSelected()
    m.parentScene.dialog.close = true
end sub

sub OnPlaylistremove()

    m.top.playlistAdd = false
    m.top.playlistRemove = true
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("showidlist")
        tok = sec.Read("showidlist")
    else
    end if
    m.playListadd = CreateObject("roSGNode", "playListadd")
    m.playListadd.wflag = "0"
    m.playListadd.showid = tok.ToStr()
    m.playListadd.uid = getUserIdana()
    m.playListadd.observeField("PlaylistResponse", "onPlaylistaddchangedremove")
    m.playListadd.callFunc("runPlayListAdd", "")
end sub

sub onPlaylistaddchangedremove()
    added = m.playListadd.PlaylistResponse
    index_of_playlist_removal = 0
    for i = 0 to m.buttonsLabelList.content.getChild(0).getChildCount() - 1
        if m.buttonsLabelList.content.getchild(0).getChild(i).id = "REMOVEFROMMYLIST"
            index_of_playlist_removal = i
        end if
    end for
    if(added = "added")
        modifyButtonLabelList(m.RemoveFromMylist, index_of_playlist_removal)
    else
        modifyButtonLabelList(m.AddToMyList, index_of_playlist_removal)
    end if
end sub

sub onPlaylistaddchanged()

    added = m.playListadd.PlaylistResponse
    index_of_playlistAddition = 0
    for i = 0 to m.buttonsLabelList.content.getchild(0).getChildCount() - 1
        if m.buttonsLabelList.content.getchild(0).getChild(i).id = "ADDTOMYLIST"
            index_of_playlistAddition = i
        end if
    end for
    if(added = "added")
        modifyButtonLabelList(m.RemoveFromMylist, index_of_playlistAddition)
    else
        modifyButtonLabelList(m.AddToMyList, index_of_playlistAddition)
    end if
end sub

function playtrailers()
    playBackGroundvideo("")
    m.backGroundVideo.control = "stop"
    m.backGroundVideo.visible = false
    VODcontent = invalid
    if m.ShowFetcher["rawShowfetcherContent"] <> invalid
        VODcontent = m.ShowFetcher["rawShowfetcherContent"]
    end if
    m.background.visible = true
    m.loadingIndicator.visible = true
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        title: VODcontent.show_name + " " + "-" + " " + "Trailer",
        video_time: VODcontent.video_time,
        url: VODcontent.teaser,
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    if m.Playertrailer = invalid:
        m.Playertrailer = m.top.CreateChild("Playertrailer")
        m.Playertrailer.observeField("state", "PlayerStateChangedForTrailer")
        m.Playertrailer.observeField("visible", "onVisibleChangetrailer")
    end if
    if VODcontent.video_time <> invalid then
        video_time = VODcontent.video_time
    else
        video_time = ""
    end if
    content.addFields({
        "video_time": video_time
    })
    m.Playertrailer.content = content
    m.Playertrailer.visible = true
    m.Playertrailer.setFocus(true)
    m.Playertrailer.control = "play"
    m.HomeTopMenuRowlist.visible = false
    m.BrandingLogo.visible = false
    m.count = 0
    m.Playertrailer.observeField("visibility", "onVisibleChangetrailer")
end function


sub onVisibleChangetrailer()
    if m.Playertrailer = invalid then return
    videoCount = m.ShowFetcher.Content.getChild(0).GetChildCount()

    if(m.count = 0)
        m.count = 1
        m.RowList.visible = true
        whichNodeToSetFocusBasedOnScreenScrolledStatus()
        m.count = 0
        m.ShowBar.control = "start"
        if m.Playertrailer.visibility = false then
            whichNodeToSetFocusBasedOnScreenScrolledStatus()
            m.loadingIndicator.visible = false
        end if
    end if
    showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount)
end sub

sub PlayerStateChangedForTrailer()
    if m.Playertrailer = invalid then return
    if m.Playertrailer.state = "finished" or m.Playertrailer.state = "stopped" or m.Playertrailer.state = "done"
        m.Playertrailer.visible = false
        whichNodeToSetFocusBasedOnScreenScrolledStatus()
        playBackGroundvideo("")
        m.HomeTopMenuRowlist.visible = true
        m.BrandingLogo.visible = true
        m.Playertrailer = invalid
    else if m.Playertrailer.state = "playing"
        m.HomeTopMenuRowlist.visible = false
        m.BrandingLogo.visible = false
    end if
end sub




sub showPaymentPage(videoId)
    ?"showPaymentPage called"
    playBackGroundvideo("")
    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreen = videoId
    else
        showSubscriptionDialog()
    end if

end sub

sub showPaymentPageWhenGoAdsFreeClicked() ' show payment page
    VODcontent = returnTheCurrentFocusedData()
    m.dialogbg_rect.visible = false
    m.isWatchWithOutAdsDialogRectVisible = false
    m.continueWatchingDialogVisible = false'
    playBackGroundvideo("")
    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.top.isGoadsFreeclicked = true
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreen = VODcontent.video_id
    else
        showSubscriptionDialog()
    end if
end sub

sub showSubscriptionDialog()
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = getTextOf("warning")
    dialog.optionsDialog = true
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onSubscriptionRequiredOkButtonselected")
    msg1 = getTextOf("to_avail_this_video")
    msg2 = getTextOf("on_web")
    dialog.message = msg1 + getAppTitle() + msg2
    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog

end sub

sub onSubscriptionRequiredOkButtonselected()
    m.parentScene.dialog.close = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
end sub

sub goToLandingScene()
    m.loadingIndicator.visible = false
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.top.gotoLandingScene = true
    m.dialogbg_rect.visible = false
    m.isWatchWithOutAdsDialogRectVisible = false
    m.continueWatchingDialogVisible = false'
end sub

sub goToSubscriptionListingScene()
    playBackGroundvideo("")
    m.loadingIndicator.visible = false
    VODcontent = returnTheCurrentFocusedData()
    showPaymentPage(VODcontent.video_id)
    m.dialogbg_rect.visible = false
    m.isWatchWithOutAdsDialogRectVisible = false
    m.continueWatchingDialogVisible = false'
end sub


sub hideShowPage()
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true
    m.RowList.visible = false
    m.RowList.setfocus(false)
    m.Title1.visible = false
    m.Episode.visible = false
    m.descri.visible = false
    m.descri_title.visible = false
    m.resolution.visible = false
    m.cast.visible = false

    m.Year.visible = false
    m.Director.visible = false
    m.Duration.visible = false
    m.rating.visible = false
    m.years.visible = false
    m.time.visible = false
    m.direct.visible = false
    m.prod.visible = false
    m.rating.visible = false
    m.years.visible = false
    m.time.visible = false
    m.direct.visible = false
    m.prod.visible = false
    m.casting.visible = false
end sub

sub On_dialogAuthExceed_buttonSelected()
    if m.top.dialogAuthExceed.buttonSelected = 0
        m.parentScene.dialog.close = true
        m.loadingIndicator.visible = false
    else if m.top.dialogAuthExceed.buttonSelected = 1
        m.LogoutTaskAll.callFunc("runLogoutTask", "")
        m.loadingIndicator.visible = true
    end if
end sub

sub OnsessionExpiredClick()
    m.LogoutTask.callFunc("runLogoutTask", "")

end sub


sub logoutAndGoToLandingScene()
    ?"logoutAndGoToLandingScene called"
    if GetParentScene() = invalid then
        return
    end if
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1

            if key = "USER_ID" or key = "userName" or key = "userEmail" or key = "userPhone"
                print "Deleting " section + ":" key
                RegistrySection.Delete(key)
            else
                ?key + " not deleted"
            end if
        end for
        RegistrySection.flush()
    end for
    print i.toStr() " Registry Keys Deleted"
    m.top.logout = true
    m.loadingIndicator.visible = false
    m.parentScene.dialog.close = true
    m.top.goToLandingSceneAndCloseAllScreens = true
end sub



sub onStarted()
    ?"onStarted : show called showId: "m.top.start
    m.loadingProgress = m.top.findNode("loading")
    m.loadingIndicator.visible = true
    print "RUN ShowContentRequest"
    m.ShowFetcher.ContentRequest = m.top.start
    m.ShowFetcher.taskType = "ContentRequest"
    m.ShowFetcher.itemType = m.top.itemType
    m.ShowFetcher.upcomingEventId = m.top.upcomingEventId
    m.ShowFetcher.addFields({
        "ai_type": m.top.ai_type
    })

    m.buttonsLabelList.visible = true
    m.ShowFetcher.callFunc("runShowFetcherTask", "")
end sub


sub onContentChanged()
    if m.ShowFetcher.showFetcherStatus = true
        m.loadingIndicator.visible = false

        print "RUN ContentRequest true"

        if getThumbnailOrientaion() = "LANDSCAPE"
            rowHeights = [270, 270, 270, 270, 270, 270, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320]
            rowItemSize = [[320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180]]
        else if getThumbnailOrientaion() = "PORTRAIT"
            rowHeights = [415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415, 415]
            rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
        end if

        m.RowList.rowHeights = rowHeights
        m.RowList.rowItemSize = rowItemSize
        m.buttonsLabelListItems = []
        m.top.ratingBoolean = false
        m.count3 = 1
        m.AdTimer.control = "start"
        m.Video.visible = true
        whichNodeToSetFocusBasedOnScreenScrolledStatus()
        m.RowList.visible = false
        m.Title1.visible = true
        m.Episode.visible = true
        m.descri.visible = true
        m.descri_title.visible = true
        m.resolution.visible = true
        m.cast.visible = true
        m.Year.visible = false
        m.Director.visible = true

        m.Duration.visible = false'
        m.rating.visible = true
        m.years.visible = false
        m.time.visible = true
        m.direct.visible = true
        m.prod.visible = true
        m.casting.visible = true

        raw = m.ShowFetcher.rawShowfetcherContent
        if raw <> invalid and raw.single_video <> invalid
            if raw.single_video = 0 or raw.single_video = 2 or raw.single_video = 3
                m.issinglevideo = raw.single_video
            else
                m.issinglevideo = 1
            end if
        else
            m.issinglevideo = 1
        end if

        for i = 0 to m.ShowFetcher.content.getchildCount() - 1
            if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getchild(i) <> invalid and m.ShowFetcher.content.getchild(i).type <> invalid
                itemType = m.ShowFetcher.content.getchild(i).type
            else
                itemType = ""
            end if

            if itemType = "CAST" or itemType = "CREW"
                rowHeights.SetEntry(i, 320)
                m.RowList.rowHeights = rowHeights
                rowItemSize.SetEntry(i, [178, 178])
                m.RowList.rowItemSize = rowItemSize
            end if

            if m.issinglevideo = 3
                rowHeights.SetEntry(i, 250)
                m.RowList.rowHeights = rowHeights
                rowItemSize.SetEntry(i, [180, 180])
                m.RowList.rowItemSize = rowItemSize
            end if
        end for

        if m.ShowFetcher.rawShowfetcherContent <> invalid and m.ShowFetcher.rawShowfetcherContent.single_video <> invalid and m.ShowFetcher.rawShowfetcherContent.single_video = 0
            m.issinglevideo = 0
        else if m.ShowFetcher.rawShowfetcherContent <> invalid and m.ShowFetcher.rawShowfetcherContent.single_video <> invalid and m.ShowFetcher.rawShowfetcherContent.single_video = 2
            m.issinglevideo = 2
        else if m.ShowFetcher.rawShowfetcherContent <> invalid and m.ShowFetcher.rawShowfetcherContent.single_video <> invalid and m.ShowFetcher.rawShowfetcherContent.single_video = 3
            m.issinglevideo = 3
        else
            m.issinglevideo = 1
        end if
        subscriptionContent = invalid
        if m.ShowFetcher.Content <> invalid and m.ShowFetcher.Content.getChild(0) <> invalid and m.ShowFetcher.Content.getChild(0).getChild(0) <> invalid and m.ShowFetcher.Content.getChild(0).getChild(0).subscriptionData <> invalid
            subscriptionContent = m.ShowFetcher.Content.getChild(0).getChild(0).subscriptionData
            m.subscriptionList.content = subscriptionContent
        end if
        RowlistContent = m.ShowFetcher.Content
        m.RowList.visible = false
        m.RowList.content = RowlistContent
        m.RowList.numRows = 10



        VODcontent = invalid
        if m.ShowFetcher.Content <> invalid and m.ShowFetcher.Content.getChild(0) <> invalid and m.ShowFetcher.Content.getChild(0).getChild(0) <> invalid
            VODcontent = m.ShowFetcher.Content.getChild(0).getChild(0)
        end if


        m.playNow.title = m.ShowFetcher["rawShowfetcherContent"].button_text
        m.playNow.FHDItemWidth = backgroundPosterLength(Len(m.playNow.title))

        if m.ShowFetcher["rawShowfetcherContent"] <> invalid
            rawContent = m.ShowFetcher["rawShowfetcherContent"]
            if (rawContent.hide_play_button <> invalid and rawContent.hide_play_button = false)
                m.buttonsLabelListItems.push(m.playNow)
            end if
            if rawContent.go_ads_free <> invalid and rawContent.go_ads_free = true
                m.buttonsLabelListItems.push(m.goAdsFree)
            end if
            if rawContent.watched_percentage <> invalid and rawContent.watched_percentage > 0
                m.playNow.watched_percentage = rawContent.watched_percentage
                m.buttonsLabelListItems.push(m.startOverNode)
            end if
            if rawContent.watchlist_flag <> invalid and rawContent.watchlist_flag = 1
                m.buttonsLabelListItems.push(m.RemoveFromMylist)
            else
                m.buttonsLabelListItems.push(m.AddToMyList)
            end if
            if rawContent.teaser_flag <> invalid and rawContent.teaser_flag = 1
                m.buttonsLabelListItems.push(m.WatchTrailer)
            end if
        end if


        if VODcontent <> invalid



            if VODcontent <> invalid and VODcontent.itemType = "NEWS" or VODcontent.itemType = "news" then
                newsHandlingFunction(VODcontent)
                playBackGroundvideo(VODcontent.URL)

            else if VODcontent.itemType = "UPCOMING_EVENT"


            else if VODcontent.itemType = "LIVE_EVENT" or VODcontent.itemType = "RTMP" 'for ongoing events

            else

            end if


            if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0).TagsContent <> invalid and m.ShowFetcher.content.getChild(0).getChild(0).TagsContent.getChildCount() > 0
                m.buttonsLabelListItems.push(m.moreButton)
            end if
            m.buttonsLabelListItems.push(m.likeNode)
            m.buttonsLabelListItems.push(m.disLikeNode)

            m.RowList.unobserveField("rowItemSelected")
            m.RowList.observeField("rowItemSelected", "onRowItemSelected")
            m.RowList.unobserveField("rowItemFocused")
            m.RowList.observeField("rowItemFocused", "OnRowItemFocused")
            m.RowList.unobserveField("itemFocused")
            m.RowList.observeField("itemFocused", "onItemFocused")



            if (VODcontent.itemType = "ott")
                m.SimilarShows.show_id = m.top.start
                m.SimilarShows.callFunc("runSimilarShowsTask", "")
            end if
        else if m.ShowFetcher["rawShowfetcherContent"].hide_play_button <> invalid and m.ShowFetcher["rawShowfetcherContent"].hide_play_button = true
            m.buttonsLabelListItems.push(m.likeNode)
            m.buttonsLabelListItems.push(m.disLikeNode)
            m.SimilarShows.show_id = m.top.start
            m.SimilarShows.callFunc("runSimilarShowsTask", "")
        end if
        addbuttonLabelList(m.buttonsLabelListItems)
        setShowDetailsDataFromZerothPositionVideo()
        if m.ShowFetcher["rawShowfetcherContent"].hide_play_button = false

            if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0) <> invalid then
                m.currentVODContentIfSeasonExists = m.ShowFetcher.content.getChild(0).getChild(0)
            end if
        end if

        if m.ShowFetcher["rawShowfetcherContent"].liked_flag = 1
            m.likeNode.ishighlighted = true
            m.disLikeNode.ishighlighted = false


        else if m.ShowFetcher["rawShowfetcherContent"].disliked_flag = 1
            m.disLikeNode.ishighlighted = true
            m.likeNode.ishighlighted = false
        else
            m.disLikeNode.ishighlighted = false
            m.likeNode.ishighlighted = false
        end if

    else
        m.top.close_this_screen = true
    end if
    m.rectangleForSmallDetails.visible = true
    m.RowList.visible = true
end sub

sub onSimilarShowChanged()
    RowlistContent = m.SimilarShows.similarShowsApiListContent
    if RowlistContent <> invalid and RowlistContent.getChild(0).GetChildCount() > 0 then
        m.RowList.content.insertChild(RowlistContent.getChild(0), m.RowList.content.getChildCount())
    end if

    if m.ShowFetcher["rawShowfetcherContent"].hide_play_button <> true
        if m.issinglevideo = 1
            m.top.rowListSingleVideoData = m.RowList.content.getChild(0)
            m.RowList.content.removeChildIndex(0)
            m.top.rowlistContentCopy = m.RowList.content
        else
            m.RowList.content = m.RowList.content
            m.top.rowlistContentCopy = m.RowList.content

        end if
    else
        m.top.rowlistContentCopy = m.RowList.content
    end if

    m.RowList.visible = true

    rawContent = m.ShowFetcher["rawShowfetcherContent"]
    m.liked_flag = rawContent.liked_flag
    m.disliked_flag = rawContent.disliked_flag

end sub

sub setTagsRowlist(tagsContent)

    rowHeights = [60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
    rowItemSize = [[200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60]]


    m.tagsRowlist.rowHeights = rowHeights
    m.tagsRowlist.rowItemSize = rowItemSize


    for i = 0 to tagsContent.getchildcount() - 1
        ?"itemType : ";itemType
        itemType = invalid
        if tagsContent.getChild(i) <> invalid and tagsContent.getChild(i).type <> invalid
            itemType = tagsContent.getChild(i).type
        end if

        if itemType <> invalid and itemType = "TAGS"
            if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "GENRE"
                rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
            end if

            rowHeights.SetEntry(i, 60)
            m.tagsRowlist.rowHeights = rowHeights
        end if

        if itemType <> invalid and itemType = "CAST"
            if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "TAGS"
                rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
            end if

            rowHeights.SetEntry(i, 60)
            m.tagsRowlist.rowHeights = rowHeights
            rowItemSize.SetEntry(i, [500, 60])
            m.tagsRowlist.rowItemSize = rowItemSize
        end if

        if itemType <> invalid and itemType = "CREW"
            if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "TAGS"
                rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
            end if
            if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "CAST"
                rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
            end if
            rowHeights.SetEntry(i, 60)
            m.tagsRowlist.rowHeights = rowHeights
            rowItemSize.SetEntry(i, [500, 60])
            m.tagsRowlist.rowItemSize = rowItemSize
        end if
    end for
    rowHeights.SetEntry(tagsContent.getchildcount() - 1, 100)
    m.tagsRowlist.rowHeights = rowHeights
    ?m.tagsRowlist.rowHeights
    m.tagsRect.visible = true
    m.HomeTopMenuRowlist.visible = false
    m.textMeasurer.text = "sgjsghjfg  sdgfjhsdg gfshg"
    m.tagsRowlist.content = tagsContent
    m.top.tagsRowlistContent = tagsContent
    m.tagsRowlist.setFocus(true)
end sub

sub onshow_more_buttonFocused()

end sub

sub onshow_more_buttonSelected()
    m.descr_rect.visible = "true"
    m.ScrollableText.visible = "true"
    m.ScrollableText.color = getTextColor()
    m.ScrollableText.text = m.descri.text
    m.ScrollableText.setFocus(true)

end sub




sub change()
    m.global.Adtracker = 0
end sub

sub hideHint()
end sub

sub showHint()
    m.Timer.control = "start"
end sub

sub hideBar()
    m.HideBar.control = "start"
end sub

sub optionsMenu()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press

        if m.HomeTopMenuRowlist.isInFocusChain() 'HomeTopMenuRowlist key handling
            if key = "right" or key = "left"
                return true
            else if key = "down"
                m.buttonsLabelList.setFocus(true)
                return true
            end if
        else if key = "up" and m.buttonsLabelList.hasFocus()
            m.HomeTopMenuRowlist.SET_FOCUS = true
            return true
        end if


        if key = "up" or key = "down"

            if key = "up"and m.buttonsLabelList.hasFocus() = true and m.show_more_button.visible = true


            else if key = "down" and m.show_more_button.hasFocus() and m.descr_rect.visible = false
                m.buttonsLabelList.setFocus(true)
                return true
            end if


            if key = "up" and m.tagsRect.visible = true
            end if

            if m.RowList.hasFocus() = true and key = "up"
                m.mainrectscrolldownTimer.control = "start"

            else if m.buttonsLabelList.hasFocus() = true and key = "down"

                if m.rowlist.content.getchildCount() > 0
                    m.mainrectscrollupTimer.control = "start"
                end if


            else if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true or m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or m.continueWatchingDialogVisible_ForAutoplay = true
                handled = true
            end if


            handled = true
        else if key = "back"


            if m.isWatchWithOutAdsDialogRectVisible = true
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisible = false
                m.continueWatchingDialogVisible = false
                m.RowList.visible = true
                whichNodeToSetFocusBasedOnScreenScrolledStatus()


                m.videoSubscriptionData = invalid
                m.VideoSubscriptionTask = invalid
                handled = true

            else if m.ScrollableText.hasFocus()
                m.descr_rect.visible = false
                m.show_more_button.setFocus(true)
                return true


            else if m.continueWatchingDialogVisible = true
                ?"iscontinueWatchingDialogRectVisible back pressed"
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisible = false
                m.continueWatchingDialogVisible = false
                m.RowList.visible = true
                whichNodeToSetFocusBasedOnScreenScrolledStatus()
                m.videoSubscriptionData = invalid
                m.VideoSubscriptionTask = invalid
                handled = true

            else if m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true
                ?"isWatchWithOutAdsDialogRectVisible back pressed"
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisible = false
                m.continueWatchingDialogVisible = false
                m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false
                m.RowList.visible = true
                whichNodeToSetFocusBasedOnScreenScrolledStatus()
                m.videoSubscriptionData = invalid
                m.VideoSubscriptionTask = invalid
                handled = true

            else if m.continueWatchingDialogVisible_ForAutoplay = true
                ?"iscontinueWatchingDialogRectVisible back pressed"
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisible = false
                m.continueWatchingDialogVisible_ForAutoplay = false
                m.RowList.visible = true
                whichNodeToSetFocusBasedOnScreenScrolledStatus()
                m.videoSubscriptionData = invalid
                m.VideoSubscriptionTask = invalid
                handled = true

            end if

            if m.continueWatchingDialogVisible = false and m.isWatchWithOutAdsDialogRectVisible = false and m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = false and m.continueWatchingDialogVisible_ForAutoplay = false
                playBackGroundvideo("")
            end if


            if m.tagsRect.visible = true
                m.tagsRect.visible = false
                m.HomeTopMenuRowlist.visible = true
                m.buttonsLabelList.setFocus(true)
                return true
            end if

        else if key = "left"

            if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true or m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or m.continueWatchingDialogVisible_ForAutoplay = true
                m.NoButton.setFocus(true)
                handled = true
            end if

        else if key = "right"

            if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true or m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or m.continueWatchingDialogVisible_ForAutoplay = true
                m.YesButton.setFocus(true)
                handled = true
            end if

        else if key = "options"
            onshow_more_buttonSelected()
        end if
    end if
    if press
        if m.RowList.hasFocus() = false
            if key = "left" and m.isWatchWithOutAdsDialogRectVisible = true or key = "left" and m.continueWatchingDialogVisible = true or key = "left" and m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or key = "left" and m.continueWatchingDialogVisible_ForAutoplay = true
                m.NoButton.setFocus(true)
                handled = true
            else if key = "right" and m.isWatchWithOutAdsDialogRectVisible = true or key = "right" and m.continueWatchingDialogVisible = true or key = "right" and m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true or key = "right" and m.continueWatchingDialogVisible_ForAutoplay = true
                m.YesButton.setFocus(true)
                handled = true
            end if

        end if
    end if
    if press
        if m.RowList.hasFocus() = false
            if key = "left" and m.isWatchWithOutAdsDialogRectVisible = true
                m.NoButton.setFocus(true)
                handled = true
            else if key = "right" and m.isWatchWithOutAdsDialogRectVisible = true
                m.YesButton.setFocus(true)
                handled = true
            else if key = "right" and m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true
                m.YesButton.setFocus(true)
                handled = true
            else if key = "right" and m.continueWatchingDialogVisible_ForAutoplay = true
                m.YesButton.setFocus(true)
                handled = true
            end if
        end if
    end if
    return handled
end function



function getcount() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("count")
        tok = sec.Read("count")
        return tok
    end if
    return invalid
end function


sub goToVideoDetailScene()
    playBackGroundvideo("")
    VODcontent = returnTheCurrentFocusedData()
    m.top.goToVideoDetailScene = Str(VODcontent.video_id).Trim()
end sub




function getAutosubtitle() as object
    lat = CreateObject("roRegistrySection", "DW_Authentication")
    if lat.Exists("Autosubtitle")
        lati = lat.Read("Autosubtitle")
        return lati
    end if
end function


function getAutovideoid() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("AutovideoID")
        lati = lat.Read("AutovideoID")
        return lati
    end if
end function

function getAutovideothumb() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("Autovideothumb")
        lati = lat.Read("Autovideothumb")
        return lati
    end if
end function

function getAutovideotitle() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("AutovideoTITLE")
        lati = lat.Read("AutovideoTITLE")
        return lati
    end if
end function

function getAutovideourl() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("AutovideoUrl")
        lati = lat.Read("AutovideoUrl")
        return lati
    end if
end function

function getAutovideoduration() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("AutovideoDuration")
        lati = lat.Read("AutovideoDuration")
        return lati
    end if
end function

function getAutovideocategory() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("autocategory")
        lati = lat.Read("autocategory")
        return lati
    end if
end function

function getAutovideocategoryid() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("Autocategoryid")
        lati = lat.Read("Autocategoryid")
        return lati
    end if
end function

function getAutovideoshowid() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("Autoshowid")
        lati = lat.Read("Autoshowid")
        return lati
    end if
end function

function getAutopremium_flag() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("premium_flag")
        lati = lat.Read("premium_flag")
        return lati
    end if
end function

function getAutorental_flag() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("rental_flag")
        lati = lat.Read("rental_flag")
        return lati
    end if
end function

function getAutofree_video() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("free_video")
        lati = lat.Read("free_video")
        return lati
    end if
end function


function getAutovideoadlink() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("Autoadlink")
        lati = lat.Read("Autoadlink")
        return lati
    end if
end function

function getAutovideochannelid() as object
    lat = CreateObject("roRegistrySection", getAppKey())
    if lat.Exists("Autochannelid")
        lati = lat.Read("Autochannelid")
        return lati
    end if
end function


' function getCountrycode() as object
'     lon = CreateObject("roRegistrySection", getAppKey())
'     if lon.Exists("countrycode")
'         long = lon.Read("countrycode")
'         return long
'     end if
' end function

' function getRegion() as object
'     region = CreateObject("roRegistrySection", getAppKey())
'     if region.Exists("region")
'         reg = region.Read("region")
'         return reg
'     end if
' end function

' function getCity() as object
'     city = CreateObject("roRegistrySection", getAppKey())
'     if city.Exists("city")
'         cit = city.Read("city")
'         return cit
'     end if
' end function


function setVideo() as void
    ?"setVideo called"
    videoContent = createObject("RoSGNode", "ContentNode")
    VODcontent = returnTheCurrentFocusedData()
    videoContent.url = VODcontent.teaser
    videoContent.title = "Trailer Loading...."
    videoContent.streamformat = "hls"
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("tokplayy")
        tok = sec.Read("tokplayy")
    else
    end if
    m.video = m.top.findNode("Video1")
    m.video.content = videoContent
    m.video.visible = true
    m.video.AddHeader("token", tok)
    m.video.control = "stop"
    m.video.observeField("state", "trailerstate")
end function

sub trailerstate()
    rowItemFocusedNow = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    if(m.video.state = "finished" or m.video.state = "stopped")
        VODcontent = returnTheCurrentFocusedData()
        m.background.uri = VODcontent.HDPOSTERURL
        whichNodeToSetFocusBasedOnScreenScrolledStatus()
        m.RowList.visible = true
        m.Title1.visible = true
        m.Episode.visible = true
        m.descri.visible = true
        m.descri_title.visible = true
        m.resolution.visible = true
        m.cast.visible = false
        m.Year.visible = false
        ' m.Director.visible = true
        m.Duration.visible = false'
        m.rating.visible = true
        m.years.visible = false
        m.time.visible = true
        m.direct.visible = true
        m.prod.visible = true
        m.casting.visible = true
        VODcontent = returnTheCurrentFocusedData()
        m.loadingIndicator.visible = false
        if VODcontent.image_title <> invalid
            m.Title1.visible = false
            m.Episode.visible = true

            if VODcontent.DESCRIPTION <> invalid and not VODcontent.DESCRIPTION = ""
                ?"VODcontent.DESCRIPTION <> invalid"
                ?VODcontent.DESCRIPTION
                m.descri.text = VODcontent.DESCRIPTION
                ' m.descri_title.visible = true

            else
                ?"VODcontent.DESCRIPTION <> invalid else"
                m.descri_title.visible = false
                m.descri.text = ""
            end if



            if VODcontent.maturity_name <> invalid then
                m.resolution.visible = true
                m.resolution.Text = VODcontent.maturity_name
            else
                m.resolution.Text = "General"
            end if

            if VODcontent.categories <> invalid then
                m.categories.Text = VODcontent.categoriesWithComma
            else
                m.categories.Text = ""
            end if
            if(VODcontent.show_cast <> invalid and VODcontent.show_cast <> "")
                m.cast.visible = false
                m.cast.Text = VODcontent.show_cast
            else
                m.cast.visible = false
                m.casting.visible = false
            end if
            m.Episode.text = ""
            if VODcontent.year <> invalid then
                m.year.visible = false'
                m.years.visible = true
                m.Year.Text = VODcontent.year
            else
                m.Year.visible = false
                m.years.visible = false
            end if
            minutes = VODcontent.duration_text
            mDuration = convertTime(minutes)
            ' minutes = VODcontent.video_duration
            ' second = minutes.ToInt()*60

            ' mDuration = secondsToHhMmSsConverter(second)
            if mDuration <> invalid then
                m.Duration.visible = false'
                if m.Years.visible = true
                    m.Duration.translation = [160, 200]
                    m.Duration.Text = "•   " + mDuration
                else
                    m.Duration.translation = [90, 200]
                    m.Duration.Text = mDuration
                end if
            else
                m.Duration.visible = false
            end if

            if m.Years.visible = true
                m.Duration.translation = [160, 200]
            else
                m.Duration.translation = [90, 200]
            end if

            if VODcontent.director <> invalid and VODcontent.director <> "" then
                m.Director.visible = true
                m.Director.text = VODcontent.director
            else
                m.Director.visible = false
                m.direct.visible = false
            end if
        else
            m.Title1.visible = true
            if(VODcontent.producer <> invalid)
                m.Episode.visible = true
                m.Episode.text = ""
            else
                m.Episode.visible = false
            end if
            ' m.Title1.text = rowItemFocusedNow.title 'VODcontent.show_name 'UCase(VODcontent.title)

            if VODcontent.DESCRIPTION <> invalid and not VODcontent.DESCRIPTION = ""
                ?"VODcontent.DESCRIPTION <> invalid"
                ?VODcontent.DESCRIPTION
                m.descri.text = VODcontent.DESCRIPTION
                m.descri_title.visible = true

            else
                ?"VODcontent.DESCRIPTION <> invalid else"
                m.descri_title.visible = false
                m.descri.text = ""
            end if


            if VODcontent.maturity_name <> invalid then
                m.resolution.visible = true
                m.resolution.Text = VODcontent.maturity_name
            else
                m.resolution.Text = "General"
            end if

            if VODcontent.categories <> invalid then
                m.categories.Text = VODcontent.categoriesWithComma
            else
                m.categories.Text = ""
            end if
            if(VODcontent.show_cast <> invalid and VODcontent.show_cast <> "")
                m.cast.visible = true
                m.casting.visible = true
                m.cast.Text = VODcontent.show_cast
            else
                m.cast.visible = false
                m.casting.visible = false
            end if
            if VODcontent.year <> invalid then
                m.years.visible = true
                m.year.visible = false'
                m.Year.Text = VODcontent.year
            else
                m.Year.visible = false
                m.years.visible = false
            end if
            minutes = VODcontent.duration_text
            mDuration = convertTime(minutes)
            if mDuration <> invalid then
                m.Duration.visible = false'
                if m.Years.visible = true
                    m.Duration.translation = [160, 200]
                    m.Duration.Text = "•   " + mDuration
                else
                    m.Duration.translation = [90, 200]
                    m.Duration.Text = mDuration
                end if
            else
                m.Duration.visible = false
            end if


            if VODcontent.director <> invalid and VODcontent.director <> "" then
                m.Director.visible = true
                m.Director.text = VODcontent.director
            else
                m.Director.visible = false
                m.direct.visible = false
            end if
        end if

        VODcontent = returnTheCurrentFocusedData()


        m.Video.control = "stop"
        m.Video.visible = false

    else

    end if
    if(m.video.state = "playing")
        m.RowList.visible = false
        m.Title1.visible = false
        m.Episode.visible = false
        m.descri.visible = false
        m.descri_title.visible = false


        m.resolution.visible = false
        m.cast.visible = false
        m.Year.visible = false

        m.Duration.visible = false
        m.rating.visible = false
        m.years.visible = false
        m.time.visible = false
        m.direct.visible = false
        m.prod.visible = false
        m.casting.visible = false
    end if
end sub

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



function onRowItemSelected() as void

    if not m.RowList.content.getChild(m.RowList.RowItemSelected[0]).type = "CAST" and not m.RowList.content.getChild(m.RowList.RowItemSelected[0]).type = "CREW"
        playBackGroundvideo("")
        VODcontent = returnTheCurrentFocusedData()

        if VODcontent.itemtype = "shows" ' ******you may also clicked
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.top.gotoShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo = true

        else '**************normal shows clicked

            if m.issinglevideo <> 3
                m.top.ai_type = m.ShowFetcher.ai_type
                m.top.goToVideoPlayerScene = Str(VODcontent.video_id).Trim()
            end if
        end if
    end if
end function



function onButtonLabelListPlayClicked() as void


    playBackGroundvideo("")
    VODcontent = returnTheCurrentFocusedData()

    if m.issinglevideo = 1
        if VODcontent.itemType = "shows"
            VODcontent = m.top.rowListSingleVideoData.getChild(0)
        end if
    end if


    if VODcontent.itemtype = "shows" ' ******you may also clicked
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo = true

    else '**************normal shows clicked
        valueofcat = VODcontent.TITLESEASON
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("category")
        else
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("category", valueofcat)
            sec.Flush()
        end if


        if m.isSingleVideo = 1
            if VODcontent.video_id <> invalid
                m.top.ai_type = m.ShowFetcher.ai_type
                m.top.goToVideoPlayerScene = Str(VODcontent.video_id).Trim()
            end if
        else
            m.top.ai_type = m.ShowFetcher.ai_type
            if m.ShowFetcher.rawShowfetcherContent <> invalid and m.ShowFetcher.rawShowfetcherContent.resume_video_id <> invalid
                m.top.goToVideoPlayerScene = m.ShowFetcher.rawShowfetcherContent.resume_video_id

            else if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0).video_id <> invalid
                m.top.goToVideoPlayerScene = Str(m.ShowFetcher.content.getChild(0).getChild(0).video_id).Trim()
            end if
        end if
    end if
end function


sub playtrailer()
    m.RowList.visible = false
    m.Title1.visible = false
    m.Episode.visible = false
    m.descri.visible = false
    m.descri_title.visible = false
    m.resolution.visible = false
    m.cast.visible = false
    m.Year.visible = false
    m.Duration.visible = false
    m.rating.visible = false
    m.years.visible = false
    m.time.visible = false
    m.direct.visible = false
    m.prod.visible = false
    m.casting.visible = false
end sub

function OnRowItemFocused()' to not change focused content data for you may also like
    if m.RowList <> invalid and m.RowList.content <> invalid and m.RowList.rowItemFocused <> invalid and m.RowList.rowItemFocused.Count() > 0 and m.RowList.content.getChild(m.RowList.rowItemFocused[0]) <> invalid and m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(0) <> invalid and not m.RowList.content.getChild(m.RowList.rowItemFocused[0]).type = "CAST" and not m.RowList.content.getChild(m.RowList.rowItemFocused[0]).type = "CREW" and not m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(0).itemType = "shows" then
        if m.issinglevideo = 1
            OnRowItemFocused2()
        else
            OnRowItemFocused2()
        end if
    end if
end function

function onItemFocused()
    m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
end function


function OnRowItemFocused2()
    m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
    VODcontent = returnTheCurrentFocusedData()
    m.currentVODContentIfSeasonExists = VODcontent.clone(true)
    rowItemFocusedNow = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])

    displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()

    changeShowdetailMatadata(rowItemFocusedNow)


    if rowItemFocusedNow.itemType <> invalid and rowItemFocusedNow.itemType = "UPCOMING_EVENT"

    else if VODcontent.itemType = "LIVE_EVENT" or VODcontent.itemType = "RTMP"

    end if
    m.loadingIndicator.visible = false
    whichNodeToSetFocusBasedOnScreenScrolledStatus()

    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    VODcontent = returnTheCurrentFocusedData()
    m.loadingIndicator.visible = false



    ' no trailer scenario | handling for if news then playing news as background video instead of playing trailer | trailer button posiyioning etc..
    if VODcontent.teaser <> invalid and VODcontent.itemType <> invalid and VODcontent.itemType <> "news" and VODcontent.teaser <> ""
        m.Timer2.control = "start"
        m.backGroundVideo.visible = true
        if rowItemFocusedNow <> invalid
            playBackGroundvideo(rowItemFocusedNow.teaser)
        end if
        m.background.translation = [0, 0]
        m.Video.visible = false

    else if VODcontent.itemType <> invalid and VODcontent.itemType = "news"
        m.Timer2.control = "stop"
        m.background.uri = VODcontent.HDPOSTERURL
        newsHandlingFunction(VODContent)
        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false

    else
        m.Timer2.control = "stop"
        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false
        m.backGroundVideo.visible = false
        m.backGroundBannerPoster.visible = true
    end if


    if VODcontent.image_title <> invalid
        m.Title1.visible = false
        m.Episode.visible = true

        m.Episode.text = ""
        mDuration = convertTime(minutes)

        if mDuration <> invalid then
            m.Duration.visible = false'
            if m.Years.visible = true
                m.Duration.translation = [160, 200]
                m.Duration.Text = "•   " + mDuration
            else
                m.Duration.translation = [90, 200]
                m.Duration.Text = mDuration
            end if
        else
            m.Duration.visible = false
        end if

    else
        m.Title1.visible = true

    end if

end function




function setShowDetailsDataFromZerothPositionVideo()
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"

    VODcontent = m.ShowFetcher.rawShowfetcherContent
    if m.ShowFetcher.content <> invalid and m.ShowFetcher.content.getChild(0) <> invalid and m.ShowFetcher.content.getChild(0).getChild(0) <> invalid
        rowItemFocusedNow = m.ShowFetcher.content.getChild(0).getChild(0)
        displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()
    end if

    videoCount = 0
    if m.ShowFetcher.Content <> invalid and m.ShowFetcher.Content.getChild(0) <> invalid
        videoCount = m.ShowFetcher.Content.getChild(0).GetChildCount()
    end if

    m.loadingIndicator.visible = false
    m.AdTimer.control = "start"
    m.Video.visible = true
    m.Title1.visible = true
    m.Episode.visible = true
    m.descri.visible = true
    m.descri_title.visible = true
    m.resolution.visible = true
    m.cast.visible = true
    m.Year.visible = false
    m.Duration.visible = false'
    m.rating.visible = true
    m.years.visible = false
    m.time.visible = true
    m.buttonsLabelList.setFocus(true)
    if VODcontent.director <> invalid and VODcontent.director <> "" then
        m.Director.visible = true
    else
        m.Director.visible = false
        m.direct.visible = false
    end if
    m.prod.visible = true
    m.casting.visible = true
    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    m.bannerPoster.uri = VODcontent.logo_thumb



    ' no trailer scenario | handling for if news then playing news as background video instead of playing trailer | trailer button posiyioning etc..
    if VODcontent.teaser <> invalid and VODcontent.itemType <> invalid and VODcontent.itemType <> "news" and VODcontent.teaser <> ""
        m.Timer2.control = "start"
        m.backGroundVideo.visible = true
        if rowItemFocusedNow <> invalid
            playBackGroundvideo(rowItemFocusedNow.teaser)
        end if
        m.background.translation = [0, 0]
        m.Video.visible = false

    else if VODcontent.itemType <> invalid and VODcontent.itemType = "news"
        ?"news item focused : show"
        m.Timer2.control = "stop"
        m.background.uri = VODcontent.logo_thumb
        newsHandlingFunction(VODContent)
        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false
        m.background.uri = VODcontent.logo_thumb

    else if VODcontent.itemType <> invalid and VODcontent.itemType = "RTMP"
        ?"liveEvent item focused : show"
        m.Timer2.control = "stop"
        m.background.uri = VODcontent.HDPOSTERURL

        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false
        m.background.uri = VODcontent.thumbnail

    else
        m.Timer2.control = "stop"
        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false
        m.backGroundVideo.visible = false
        m.background.uri = VODcontent.logo_thumb
        m.backGroundBannerPoster.visible = true
        m.backGroundBannerPoster.uri = VODcontent.logo_thumb
    end if


    if VODcontent.image_title <> invalid and VODcontent.image_title <> ""
        m.imageTitlePoster.uri = VODcontent.image_title
        m.imageTitlePoster.visible = true
        m.Title1.visible = false
    else
        m.imageTitlePoster.visible = false
        m.Title1.visible = true
        m.Title1.text = VODcontent.show_name
    end if


    ' synopsis
    if VODcontent.synopsis <> invalid and VODcontent.synopsis <> ""
        m.descri.text = VODcontent.synopsis
        m.descri_title.visible = true
    else
        m.descri.text = ""
        m.descri_title.visible = false
    end if

    ' categories
    categories = []
    if VODcontent <> invalid and VODcontent.categories <> invalid and VODcontent.categories[0] <> invalid
        categories = VODcontent.categories
    end if

    categoriesWithComma = ""
    if categories <> invalid
        for i = 0 to categories.Count() - 1
            if categories[i] <> invalid and categories[i].category_name <> invalid
                if categoriesWithComma <> ""
                    categoriesWithComma += " , " + categories[i].category_name
                else
                    categoriesWithComma = categories[i].category_name
                end if
            end if
        end for
    end if

    ' cast
    if VODcontent.show_cast <> invalid and VODcontent.show_cast <> ""
        m.cast.visible = true
        m.casting.visible = true
        m.cast.Text = VODcontent.show_cast
    else
        m.cast.visible = false
        m.casting.visible = false
    end if

    if VODcontent.image_title = invalid and VODcontent.year <> invalid
        m.years.visible = true
        m.year.visible = false
        m.Year.Text = VODcontent.year
    else
        m.Year.visible = false
        m.years.visible = false
    end if


    minutes = VODcontent.duration_text
    mDuration = convertTime(minutes)
    if mDuration <> invalid
        m.Duration.visible = false
        if m.Years.visible = true
            m.Duration.translation = [160, 200]
            m.Duration.Text = "•   " + mDuration
        else
            m.Duration.translation = [90, 200]
            m.Duration.Text = mDuration
        end if
    else
        m.Duration.visible = false
    end if


    if VODcontent.director <> invalid and VODcontent.director <> ""
        m.Director.visible = true
        m.Director.text = VODcontent.director
    else
        m.Director.visible = false
        m.direct.visible = false
    end if


    values = []

    if VODcontent.resolution <> invalid then
        values.Push(VODcontent.resolution)
    end if

    if VODcontent.year <> invalid and VODcontent.year <> "" then
        values.Push(VODcontent.year)
    end if

    if VODcontent.rating <> invalid and VODcontent.rating <> "" then
        values.Push(VODcontent.rating)
    end if

    if VODcontent.show_cast <> invalid and VODcontent.show_cast <> "" then
        values.Push(VODcontent.show_cast)
    end if

    if values.Count() > 0
        m.resolution.text = values.Join("   •   ")
    else
        m.resolution.text = "General"
    end if

    if VODcontent.hide_play_button = true
        m.loadingIndicator.visible = false
    end if

end function


sub focusedSecondRow()
    VODcontent = returnTheCurrentFocusedData()
    m.descri.visible = true
    m.descri_title.visible = true
end sub





sub onPlayerVisibleChange()
    m.autoThumb.visible = false
    m.autoplaylabel.visible = false
    m.RowList.visible = true

    if not m.isWatchWithOutAdsDialogRectVisible = true and not m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true and not m.continueWatchingDialogVisible = true and not m.continueWatchingDialogVisible_ForAutoplay = true
        whichNodeToSetFocusBasedOnScreenScrolledStatus()
    end if
    m.BottomBar.visible = true
    m.count = 0
    m.count2 = 0
    m.ShowBar.control = "start"
    m.loadingIndicator.visible = false
    if m.Player.visibility = false then
        m.count = 0
        m.count2 = 0
        if not m.isWatchWithOutAdsDialogRectVisible = true and not m.isWatchWithOutAdsDialogRectVisible_ForAutoplay = true and not m.continueWatchingDialogVisible = true and not m.continueWatchingDialogVisible_ForAutoplay = true
            whichNodeToSetFocusBasedOnScreenScrolledStatus()
        end if
    end if
end sub



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



function secondsToHhMmSsConverter(TotalSeconds as integer) as string
    datetime = CreateObject("roDateTime")
    datetime.FromSeconds(TotalSeconds)

    hours = datetime.GetHours().ToStr()
    minutes = datetime.GetMinutes().ToStr()
    seconds = datetime.GetSeconds().ToStr()

    duration = ""
    if hours <> "0" then
        duration = duration + hours + "h "
    else
        duration = duration + "00" + "h "
    end if
    if minutes <> "0" then
        duration = duration + minutes + "m "
    else
        duration = duration + "00" + "m "
    end if
    if seconds <> "0" then
        duration = duration + seconds + "s"
    else
        duration = duration + "00" + "s "
    end if

    ?duration
    durationWithSpace = " " + duration
    return durationWithSpace

end function

function convertTime(minutes)
    if minutes <> invalid and minutes <> ""
        a = minutes.split(":")
        if a[0] <> invalid and a[1] <> invalid and a[2] <> invalid
            convertedString = a[0] + "h" + " " + a[1] + "m" + " " + a[2] + "s" + " "
        else
            convertedString = ""
        end if

        return convertedString
    else
        return ""
    end if

end function


sub newsHandlingFunction(VODContent)
    ?"itemType = NEWS"
    m.buttonRectangle.visible = true
    m.rectangleForSmallDetails.visible = true
    m.descri.text = VODContent.DESCRIPTION
    m.descri.height = 200
    m.buttonsLabelList.visible = true
end sub




sub playBackGroundvideo(URLToBePlayed)

end sub




sub stopBackgroundTrailerOrNewsVideo()

    ?m.backGroundVideo.state
    isBackgroundTrailerOrNewsVideoPlayingBoolean = m.backGroundVideo.control = "stop"
    m.backGroundVideo.visible = false
    ?"isBackgroundTrailerOrNewsVideoPlayingBoolean"
    ?isBackgroundTrailerOrNewsVideoPlayingBoolean
end sub




sub showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount as integer)
end sub


sub checkingSubscriptionedVideoOrNot()
    m.videoSubs = false
    userSubIDS = getUserSubscriptionsContent()
    videoSubIDS = getVideoSubscriptionsContent()
    m.top.userSubIDS = userSubIDS
    m.top.videoSubIDS = videoSubIDS

    for i = 0 to videoSubIDS.Count()
        for j = 0 to userSubIDS.Count()
            if userSubIDS[i] = videoSubIDS[j] then
                m.videoSubs = true
            end if
        end for
    end for
    m.top.videoSubs = m.videoSubs
end sub





function getUserSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    subIDS = []
    for each jsonitem in GetUserSubscriptions(params)
        subIDS.Push(Str(jsonitem.sub_id))
    end for
    return subIDS
end function




function getVideoSubscriptionsContent()
    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("uid", getUserIdana().Trim())
    params.AddReplace("pubid", getPubID())
    params.AddReplace("video_id", Str(m.top.videoID).Trim())
    print m.top.videoID
    subIDS = []
    for each jsonitem in GetVideoSubscriptions(params)
        subIDS.Push(Str(jsonitem.subscription_id))
    end for
    return subIDS

end function




sub scrollUpAnimation()
    m.isScreenIsNowScrolledUp = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
end sub


sub scrollDownAnimation()

    m.isScreenIsNowScrolledUp = false
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
end sub

sub whichNodeToSetFocusBasedOnScreenScrolledStatus()
    if m.isScreenIsNowScrolledUp = true
        m.RowList.setFocus(true)
    else
        m.buttonsLabelList.setFocus(true)
    end if
end sub




'**************retruns the current focused data. It descrimininates from rowlist or buttonlabellist has the focus.
'it season exists, (singlevideo = 0) it takes that also into consideration.
function returnTheCurrentFocusedData()
    if m.ShowFetcher.itemType = "MICRO_DRAMA"
        m.CurrentFocusedData = m.ShowFetcher.content
    else if m.issinglevideo = 1 'NO SEASONS

        if m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
            m.CurrentFocusedData = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        else if m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
            m.CurrentFocusedData = m.ShowFetcher.content.getChild(0).getChild(0)
        end if

    else if m.issinglevideo = 2 'have playlist videos
        if m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
            m.CurrentFocusedData = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        else if m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
            m.CurrentFocusedData = m.ShowFetcher.content.getChild(0).getChild(0)

        end if
    else if m.issinglevideo = 0 ' HAVE SEASONS
        if m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
            m.CurrentFocusedData = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        else if m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
            if m.currentVODContentIfSeasonExists <> invalid
                m.CurrentFocusedData = m.currentVODContentIfSeasonExists
            else
                m.CurrentFocusedData = m.ShowFetcher.content.getChild(0).getChild(0)
            end if

        end if
    else if m.issinglevideo = 3 'MICRO DRAMA WITH PLAYLIST
        if m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
            m.CurrentFocusedData = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        else if m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
            m.CurrentFocusedData = m.ShowFetcher.content.getChild(0).getChild(0)

        end if
    end if
    return m.CurrentFocusedData
end function

function displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()
    ?"displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction called"

    VODcontent = returnTheCurrentFocusedData()
    if(m.VideoSubscriptionTaskNeedsToRunOnceAgain = false)
        SubscriptionedUseronVisibleChange()
    else
        m.VideoSubscriptionTask = CreateObject("roSGNode", "VideoSubscriptionTask")
        m.VideoSubscriptionTask.show_id = VODcontent.show_id
        m.VideoSubscriptionTask.videoID = VODcontent.video_id
        m.VideoSubscriptionTask.observeField("notifyClickForWatchNowOrSubscribeVisibility", "SubscriptionedUseronVisibleChange")
        m.VideoSubscriptionTask.callFunc("runVideoSubscriptionTask", "")
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = false
        m.currentUserId = getUserIdana()
    end if
end function



'**********this just checks is user subscribed based on show or episodes | with show level subscribtions or so..
function SubscriptionedUseronVisibleChange()
    ?"SubscriptionedUseronVisibleChange called"
    VODcontent = returnTheCurrentFocusedData()

    videoSubscriptionCount = 0
    if VODcontent.subscriptionData <> invalid and VODcontent.subscriptionData.getchild(0) <> invalid
        videoSubscriptionCount = VODcontent.subscriptionData.getchild(0).getchildcount()
    end if

    isSubcribed = checkingSubscribedVideoOrNotBasedOnShowLevelSubscriptionAlso()

    showSubScribeOrPlayNowButtonAndSubscriptionListingLogics(isSubcribed, VODcontent, videoSubscriptionCount)

end function

sub showSubScribeOrPlayNowButtonAndSubscriptionListingLogics(isSubcribed, VODcontent, videoSubscriptionCount)
    ' ?VODcontent
    ' ?"VODcontentui"
    ' ?"videoSubscriptionCount: ";videoSubscriptionCount
    subscriptionContent = VODcontent.subscriptionData
    m.subscriptionList.content = subscriptionContent
    if (isGuest() = "false")
        if (m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubIDSCount <> invalid and m.VideoSubscriptionTask.userSubIDSCount > 0)
            if (videoSubscriptionCount > 0)
                if (isSubcribed = true) 'm.VideoSubscriptionTask.videoSubs = true
                    ' modifyButtonLabelList(m.playNow, 0)
                    subcriptionListVisiblity(false)
                else
                    if VODcontent.is_free_video = true
                        ' modifyButtonLabelList(m.playNow, 0)
                        subcriptionListVisiblity(false)
                    else
                        ' modifyButtonLabelList(m.Subscribe, 0)
                        subcriptionListVisiblity(true)
                    end if
                end if
            else
                ' modifyButtonLabelList(m.playNow, 0)
                subcriptionListVisiblity(false)
            end if
        else
            if (videoSubscriptionCount > 0)
                if VODcontent.is_free_video = true
                    ' modifyButtonLabelList(m.playNow, 0)
                    subcriptionListVisiblity(false)
                else
                    ' modifyButtonLabelList(m.Subscribe, 0)
                    subcriptionListVisiblity(true)
                end if
            else
                ' modifyButtonLabelList(m.playNow, 0)
                subcriptionListVisiblity(false)
            end if
        end if
    else if(isGuest() = "true")
        if (videoSubscriptionCount > 0)
            if VODcontent.is_free_video = true
                ' modifyButtonLabelList(m.playNow, 0)
                subcriptionListVisiblity(false)
            else
                ' modifyButtonLabelList(m.Subscribe, 0)
                subcriptionListVisiblity(true)
            end if
        else
            ' modifyButtonLabelList(m.playNow, 0)
            subcriptionListVisiblity(false)
        end if
    end if
    m.loadingIndicator.visible = false
end sub

' sub showSubScribeOrPlayNowButtonAndSubscriptionListingLogics(isSubcribed, VODcontent, videoSubscriptionCount)

'     subscriptionContent = VODcontent.subscriptionData
'     m.subscriptionList.content = subscriptionContent
'     if (isGuest() = "false")
'         if (m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubIDSCount <> invalid and m.VideoSubscriptionTask.userSubIDSCount > 0)
'         if (videoSubscriptionCount > 0)
'             if (isSubcribed = true)
'                 subcriptionListVisiblity(false)
'             else
'                 if VODcontent.is_free_video = true
'                     subcriptionListVisiblity(false)
'                 else

'                     subcriptionListVisiblity(true)
'                 end if
'             end if
'         else

'             subcriptionListVisiblity(false)
'         end if
'     else
'           if (videoSubscriptionCount > 0)
'                 if VODcontent.is_free_video = true
'                     ' modifyButtonLabelList(m.playNow, 0)
'                     subcriptionListVisiblity(false)
'                 else
'                     ' modifyButtonLabelList(m.Subscribe, 0)
'                     subcriptionListVisiblity(true)
'                 end if
'         subcriptionListVisiblity(false)
'     else

'         subcriptionListVisiblity(true)
'     end if
' else

'     subcriptionListVisiblity(false)
' end if
' end if
' else if(isGuest() = "true")
' if (videoSubscriptionCount > 0)
'     if VODcontent.is_free_video = true
'         subcriptionListVisiblity(false)
'     else
'         subcriptionListVisiblity(true)
'     end if
' else
'     subcriptionListVisiblity(false)
' end if
' end if
' m.loadingIndicator.visible = false
' end sub

function getCurrentVODContentbasedOnSeasonExisting()
    if m.issinglevideo = 1
        VODcontent = returnTheCurrentFocusedData()
    else if m.issinglevideo = 2
        VODcontent = returnTheCurrentFocusedData()
    else if m.issinglevideo = 3
        VODcontent = returnTheCurrentFocusedData()
    else if m.issinglevideo = 0
        VODcontent = m.currentVODContentIfSeasonExists
    end if
    return VODcontent
end function





function checkingSubscribedVideoOrNotBasedOnShowLevelSubscriptionAlso()

    videoSubscriptionCount = 0
    VODcontent = returnTheCurrentFocusedData()

    if VODcontent.subscriptionData <> invalid and VODcontent.subscriptionData.getchild(0) <> invalid
        videoSubscriptionCount = VODcontent.subscriptionData.getchild(0).getchildcount()
    end if


    isSubcribed = false
    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubIDS <> invalid and VODcontent.subscriptionData <> invalid
        for i = 0 to m.VideoSubscriptionTask.userSubIDS.Count() - 1

            for j = 0 to videoSubscriptionCount - 1
                if m.VideoSubscriptionTask.userSubIDS[i] <> invalid and VODcontent.subscriptionData.getChild(0).getChild(j) <> invalid and VODcontent.subscriptionData.getChild(0).getChild(j).subscription_id <> invalid
                    if m.VideoSubscriptionTask.userSubIDS[i] = VODcontent.subscriptionData.getChild(0).getChild(j).subscription_id then
                        ?"subscribed2 !!"
                        isSubcribed = true
                    end if
                end if
            end for
        end for
    end if

    return isSubcribed
end function


function onTagsRowItemSelected()
    m.tagsRect.visible = false
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
    playBackGroundvideo("")
    m.top.goToShowMoreScene = m.tagsRowlist.RowItemSelected
end function



sub showExceedPopDialog()
    ?"showExceedPopDialog called"
    if GetParentScene() = invalid then
        return
    end if
    m.parentScene.dialog = m.top.dialogAuthExceed
end sub


function backgroundPosterLength(input)
    for inputValue = 1 to 200
        returnValue = calculateReturn(inputValue)
        if input = inputValue
            return returnValue
        end if
    end for
end function

function calculateReturn(inputValue as integer) as integer
    if inputValue < 1 or inputValue > 200
        return invalid
    end if
    return 60 + (inputValue - 1) * 18
end function

function onLikeDislikeResponse()
    if m.LikeDislikeTask.LikeDislikeTaskResult <> invalid and m.LikeDislikeTask.LikeDislikeTaskResult.success <> invalid and m.LikeDislikeTask.LikeDislikeTaskResult.success = true
        updateLikeDislikeHighlight(m.LikeDislikeTask.LikeDislikeTaskResult)
    end if
end function

sub updateLikeDislikeHighlight(LikeDislikeTaskResult)
    content = m.buttonsLabelList.content
    if content = invalid then return

    row = content.getChild(0)
    if row = invalid then return

    selectedAction = LikeDislikeTaskResult.action

    for i = 0 to row.getChildCount() - 1
        item = row.getChild(i)
        if item = invalid then return

        clicked = (item.id = "LIKE" and selectedAction = "LIKE_CLICKED") or (item.id = "DISLIKE" and selectedAction = "DISLIKE_CLICKED")
        item.ishighlighted = clicked

        if item.id = "LIKE"
            if clicked then
                m.liked_flag = 1
            else
                m.liked_flag = 0
            end if
        else if item.id = "DISLIKE"
            if clicked then
                m.disliked_flag = 1
            else
                m.disliked_flag = 0
            end if
        end if
    end for
end sub


sub subcriptionListVisiblity(visibility as boolean)
    if visibility = true
        m.subscriptionList.visible = true
        m.buttonsLabelList.translation = [95, 485]  '593
        m.RowList.translation = [95, m.buttonsLabelList.translation[1] + 300]
             else
         if getThumbnailOrientaion() = "LANDSCAPE"
        m.subscriptionList.visible = false
        m.buttonsLabelList.translation = [95, 485]
        m.RowList.translation = [95, m.buttonsLabelList.translation[1] + 300]
        else
        m.subscriptionList.visible = false
        m.buttonsLabelList.translation = [95, 485]
        m.RowList.translation = [95, m.buttonsLabelList.translation[1] + 190]
        end if 
    end if
    ' else
        
        '  if getThumbnailOrientaion() = "LANDSCAPE"
        ' m.subscriptionList.visible = false
        ' m.buttonsLabelList.translation = [95, 485]
        ' m.RowList.translation = [95, m.buttonsLabelList.translation[1] + 300]
        ' else
        ' m.subscriptionList.visible = false
        ' m.buttonsLabelList.translation = [95, 485]
        ' m.RowList.translation = [95, m.buttonsLabelList.translation[1] + 190]
        ' end if 
    ' end if
    ' else
    '     m.subscriptionList.visible = false
    '     m.buttonsLabelList.translation = [95, 485]
    '     m.RowList.translation = [95, m.buttonsLabelList.translation[1] + 220]
    ' end if
end sub


sub changeShowdetailMatadata(VODcontent)
    if VODcontent.image_title <> invalid and VODcontent.image_title <> ""
        m.imageTitlePoster.uri = VODcontent.image_title
        m.imageTitlePoster.visible = true
        m.Title1.visible = false
    else
        m.imageTitlePoster.visible = false
        m.Title1.visible = true
        m.Title1.text = VODcontent.title
    end if

    values = []

    if VODcontent.resolution <> invalid and VODcontent.resolution <> "" then
        values.Push(VODcontent.resolution)
    end if

    if VODcontent.duration_text <> invalid and VODcontent.duration_text <> "" then
        values.Push(VODcontent.duration_text)
    end if

    if VODcontent.rating <> invalid and VODcontent.rating <> "" then
        values.Push(VODcontent.rating)
    end if

    if VODcontent.maturity_name <> invalid and VODcontent.maturity_name <> "" then
        values.Push(VODcontent.maturity_name)
    end if

    if values.Count() > 0
        m.resolution.text = values.Join("   •   ")
    else
        m.resolution.text = "General"
    end if


    if VODcontent.DESCRIPTION <> invalid and VODcontent.DESCRIPTION <> ""
        m.descri.text = VODcontent.DESCRIPTION
        m.descri_title.visible = true
    else
        m.descri.text = ""
        m.descri_title.visible = false
    end if
    m.backGroundBannerPoster.uri = VODcontent.HDPOSTERURL
end sub

sub setShowdetailMatadataForShow()
    VODcontent = m.ShowFetcher.rawShowfetcherContent
    m.backGroundBannerPoster.uri = VODcontent.logo_thumb
    m.backGroundBannerPoster.visible = true
    if VODcontent.image_title <> invalid and VODcontent.image_title <> ""
        m.imageTitlePoster.uri = VODcontent.image_title
        m.imageTitlePoster.visible = true
        m.Title1.visible = false
    else
        m.imageTitlePoster.visible = false
        m.Title1.visible = true
        m.Title1.text = VODcontent.show_name
    end if
    values = []

    if VODcontent.resolution <> invalid then
        values.Push(VODcontent.resolution)
    end if

    if VODcontent.year <> invalid and VODcontent.year <> "" then
        values.Push(VODcontent.year)
    end if

    if VODcontent.rating <> invalid and VODcontent.rating <> "" then
        values.Push(VODcontent.rating)
    end if

    if VODcontent.show_cast <> invalid and VODcontent.show_cast <> "" then
        values.Push(VODcontent.show_cast)
    end if

    if values.Count() > 0
        m.resolution.text = values.Join("   •   ")
    else
        m.resolution.text = "General"
    end if
    if VODcontent.synopsis <> invalid and VODcontent.synopsis <> ""
        m.descri.text = VODcontent.synopsis
        m.descri_title.visible = true
    else
        m.descri.text = ""
        m.descri_title.visible = false
    end if
end sub


sub onSetDefaultFocus()
    m.buttonsLabelList.setFocus(true)
end sub

sub showLoading(showBoolean)
    if showBoolean <> invalid and m.loadingIndicator <> invalid
        if showBoolean = true
            m.loadingIndicator.visible = true
        else
            m.loadingIndicator.visible = false
        end if
    end if
end sub

sub onRawContentChanged()
    ?"onRawContentChanged calledfdfdf44"
    m.loadingIndicator.visible = false
    setShowdetailMatadataForShow()
end sub 