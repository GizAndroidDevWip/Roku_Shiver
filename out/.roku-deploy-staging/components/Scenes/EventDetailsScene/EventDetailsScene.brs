sub init()
    m.EventDetailApiTask = CreateObject("roSGNode", "EventDetailApiTask")
    m.EventDetailApiTask.observeField("EventDetailApiTaskStatus", "onContentChanged")
    m.SimilarShows = CreateObject("roSGNode", "SimilarShows")
    m.SimilarShows.observeField("similarShowsApiListContent", "onSimilarShowChanged")
    m.UserSubscription = CreateObject("roSGNode", "UserSubscription")
    m.UserSubscription.observeField("SubsResponse", "ifSubscriptionCheckNeeded") ' uncomment this to bypass subscription
    ' m.UserSubscription.observeField("SubsResponse", "playVideo")
    m.VideoSubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")

    ' paymentdescriptionLogicScreen
    ' m.PaymentDescription = m.top.findNode("PaymentDescription")
    m.Ratings = CreateObject("roSGNode", "Rating")
    m.Ratings.observeField("RatingResponse", "OnRatingResponse")
    m.Ratings.rating = -1
    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    m.count5 = 0
    ' m.Show = m.top.findNode("Show")
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogoutResponse")
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = "You are no longer Logged in this device. Please Login again to access."
    m.top.dialogAuthExceed.buttons = ["Press OK to Login Again"]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")
    m.screenStack = []
    m.GridScreen = m.top.findNode("GridScreen")

    m.loadingIndicator = m.top.findNode("loading")

    m.AdTimer = m.top.findNode("AdTimer")
    m.Video = m.top.findNode("Video1")
    m.RowList = m.top.findNode("RowList")
    m.RowList.visible = false
    m.BottomBar = m.top.findNode("BottomBar")
    m.ShowBar = m.top.findNode("ShowBar")
    m.HideBar = m.top.findNode("HideBar")
    m.Title1 = m.top.findNode("Title1")
    m.Title1.Font.size = "55"
    m.resolution = m.top.findNode("resolution")
    m.categories = m.top.findNode("categories")
    m.Episode = m.top.findNode("Episode")
    m.Image = m.top.findNode("Image")
    m.descri = m.top.findNode("descri")
    m.synopsis = m.top.findNode("synopsis")
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
    m.name_label = m.top.findNode("name_label")
    m.subscriptionCornerRounded = m.top.findNode("subscriptionCornerRounded")

    m.autoplaylabel = m.top.findNode("autoplaylabel")
    m.autoplaylabel.Font.size = "50"

    ' m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    ' m.buttonsLabelList.ObserveField("buttonSelected", "OnPlaylist")

    m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    m.buttonsLabelList.ObserveField("itemSelected", "onButtonsLabelList")
    m.buttonsLabelList.ObserveField("itemFocused", "onButtonsLabelListFocused")
    m.buttonsLabelList.focusBitmapBlendColor = getButtonSelectionColor()
    initialiseButtonsLabelList()

    m.tagsRowlist = m.top.findNode("tagsRowlist")
    m.tagsRowlist.observeField("RowItemSelected", "onTagsRowItemSelected")
    m.tagsRect = m.top.findNode("tagsRect")
    m.TagsBgPoster = m.top.findNode("TagsBgPoster")
    m.TagsBgPoster.blendColor = "#141414"
    
    m.gradientOverlayForBackgroundPlayer = m.top.findNode("gradientOverlayForBackgroundPlayer")
    m.dialogbanner_poster = m.top.findNode("dialogbanner_poster")

    m.autoThumb = m.top.findNode("autoThumb")
    m.autoplaylabel = m.top.findNode("autoplaylabel")
    m.autoplaylabel.Font.size = "50"

    ' m.buttonPlaylistremove = m.top.findNode("buttonPlaylistremove")
    ' m.buttonPlaylistremove.ObserveField("buttonSelected", "OnPlaylistremove")
    ' m.buttonPlaylistremove.visible = false



    m.playNowButton = m.top.findNode("playNowButton")

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
    ' m.labelForSpecialPages = m.top.findNode("labelForSpecialPages")
    m.subscriptionList = m.top.findNode("subscriptionList")
    m.NoButton.ObserveField("buttonSelected", "onDialogNoSelected")
    m.YesButton.ObserveField("buttonSelected", "onDialogYesSelected")

    m.isWatchWithOutAdsDialogRectVisible = false ' dialog box visible flag for watch withoutads
    m.continueWatchingDialogVisible = false 'same dialog box using another flag for continue watching



    ' m.subscriptionList.observeField("visible", "SubscriptionedUseronVisibleChange")
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

    '**autoplay
    m.upnext_video_name = m.top.findNode("upnext_video_name")
    m.UpNext_rect = m.top.findNode("UpNext_rect")
    m.Upnext_mainTitle = m.top.findNode("Upnext_mainTitle")

    

        m.Upnext_mainTitle.text = getText("up_next")
  

    m.Upnext_mainTitle.color = getButtonSelectionColor()


    ' Main content labels
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
    m.synopsis.color = getTextColor()
    m.casting.color = getTextColor()
    m.cast.color = getTextColor()
    m.direct.color = getTextColor()
    m.Director.color = getTextColor()
    m.Year.color = getTextColor()
    m.Duration.color = getTextColor()
    m.autoplaylabel.color = getTextColor()


    ' Up Next labels
    m.Upnext_mainTitle.color = getTextColor()
    m.upnext_video_name.color = getTextColor()

    ' Gradient backgrounds
    m.bannerPoster.blendColor = getBackgroundColor1() ' pkg:/images/home_gradient2.png
    m.gradientOverlayForBackgroundPlayer.blendColor = getBackgroundColor1() ' pkg:/images/home_gradient2.png
    m.dialogbanner_poster.blendColor = getBackgroundColor1() ' pkg:/images/img_newbg.9.png
    m.TagsBgPoster.blendColor = getBackgroundColor1() ' pkg:/images/img_newbg.9.png
    m.top.observeField("visible", "onVisibleChange")
end sub

sub onVisibleChange()
    if m.top.visible = true
        if m.buttonsLabelList.visible <> invalid and m.buttonsLabelList.visible
            ' m.VideoSubscriptionTask.videoDetailsResponse = invalid 'nullified this for a later check. videodetailsresponse is not invalid is checked later.
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.buttonsLabelList.visible = false
            ' init()
            onStarted()
        end if
    end if

end sub

'labellist click handling function
sub onButtonsLabelList()
    ?"onButtonsLabelList called"
    itemSelected = m.buttonsLabelList.itemSelected
    idSelected = m.buttonsLabelList.content.getChild(itemSelected).id
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
    VODcontent = returnTheCurrentFocusedData()
    if idSelected = "PLAY"
        onButtonLabelListPlayClicked()
    else if idSelected = "ADDTOMYLIST"
        OnPlaylist()
    else if idSelected = "SUBSCRIBE"
        playBackGroundvideo("")
        ' if isGuest() = "true"
        '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        '     m.top.gotoLandingScene = true
        ' else
        '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        '     m.top.goToPaymentDescriptionScreenForEvent = Str(m.top.EVENT_ID)
        ' end if
        onButtonLabelListPlayClicked()
    else if idSelected = "REMOVEFROMMYLIST"
        OnPlaylistremove()
    else if idSelected = "WATCHTRAILER"
        OnTrailer()
    else if idSelected = "MORE"
    end if

end sub

' labellist focused handling function
sub onButtonsLabelListFocused()
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
end sub

'just for initialising buttons,  if want to create new button set just call addbuttonLabelList with new buttons
sub initialiseButtonsLabelList()
    m.playNow = createObject("RoSGNode", "ContentNode")
    m.playNow.id = "PLAY"
    
        m.playNow.title = getText("play")
 
    m.playNow.HDLISTITEMICONURL = "pkg:/images/playbutton.png"
    m.playNow.HDLISTITEMICONSELECTEDURL = "pkg:/images/playbutton.png"

    m.AddToMyList = createObject("RoSGNode", "ContentNode")
    m.AddToMyList.id = "ADDTOMYLIST"
   
        m.AddToMyList.title = getText("add_to_my_list")
  

    m.AddToMyList.HDLISTITEMICONURL = "pkg:/images/plus.png"
    m.AddToMyList.HDLISTITEMICONSELECTEDURL = "pkg:/images/plus.png"

    m.Subscribe = createObject("RoSGNode", "ContentNode")
    m.Subscribe.id = "SUBSCRIBE"
   
        m.Subscribe.title = getText("subscribe")
    

    m.Subscribe.HDLISTITEMICONURL = "pkg:/images/premium_icon.png"
    m.Subscribe.HDLISTITEMICONSELECTEDURL = "pkg:/images/premium_icon.png"

    m.RemoveFromMylist = createObject("RoSGNode", "ContentNode")
    m.RemoveFromMylist.id = "REMOVEFROMMYLIST"


    
        m.RemoveFromMylist.title = getText("remove_from_mylist")
  


    ' m.RemoveFromMylist.title = "Remove From My List"
    m.RemoveFromMylist.HDLISTITEMICONURL = "pkg:/images/minus.png"
    m.RemoveFromMylist.HDLISTITEMICONSELECTEDURL = "pkg:/images/minus.png"

    m.WatchTrailer = createObject("RoSGNode", "ContentNode")
    m.WatchTrailer.id = "WATCHTRAILER"
   

        m.WatchTrailer.title = getText("watch_trailer")




    m.WatchTrailer.HDLISTITEMICONURL = "pkg:/images/playbutton2.png"
    m.WatchTrailer.HDLISTITEMICONSELECTEDURL = "pkg:/images/playbutton2.png"

    m.moreButton = createObject("RoSGNode", "ContentNode")
    m.moreButton.id = "MORE"

   
        m.moreButton.title = getText("more")
   
    m.moreButton.HDLISTITEMICONURL = "pkg:/images/more_image.png"
    m.moreButton.HDLISTITEMICONSELECTEDURL = "pkg:/images/more_image.png"


    addbuttonLabelList([
        m.playNow
        ' m.AddToMyList,
        ' m.WatchTrailer
    ])
end sub

sub addbuttonLabelList(nodes as object)
    content = createObject("RoSGNode", "ContentNode")
    m.buttonsLabelList.content = content

    for each node in nodes
        m.buttonsLabelList.content.appendChild(node)
    end for
end sub

function modifyButtonLabelList(newNode as object, index as integer)
    if index >= m.buttonsLabelList.content.GetChildCount()
        m.buttonsLabelList.content.appendChild(newNode)
    else
        if not m.buttonsLabelList.content.getChild(index).id = newNode.id
            m.buttonsLabelList.content.replaceChild(newNode, index)
        end if

    end if

end function



sub OnPlaylist()
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("templateGuest")
        tok = sec.Read("templateGuest")
        guest = 1
    else if sec.Exists("regularreg")
        guest = 0
    else if sec.Exists("regularlog")
        guest = 0
    else
        guest = 0
    end if
    if guest = 0
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
        ' m.Landing.show = true
        ' VODcontent = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
        m.Video.control = "stop"
    end if

    'to position showdetail page buttons when playlist button clicked
    ' if m.buttonTrailer.visible = true
    '     trailerButtonIsVisibleScenarioForButtonsPositioning()
    ' else
    '     trailerButtonIsNotVisibleScenarioForButtonsPositioning()
    ' end if
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
        ' ?m.Ratings.userRating
        ?m.Ratings.rating
    else
        m.parentScene.dialog = m.top.dialogRatingFeedError
    end if
end sub



' sub On_dialogRatingSelected()
'     GetParentScene()
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("showidlist")
'         showid = sec.Read("showidlist")
'     else
'     end if
'     if m.top.dialogRating.buttonSelected = 0 then
'         m.Ratings.rating = 5
'         m.Ratings.showid = showid
'         m.Ratings.callFunc("runRatingTask", "")
'     else if m.top.dialogRating.buttonSelected = 1 then
'         m.Ratings.rating = 4
'         m.Ratings.showid = showid
'         m.Ratings.callFunc("runRatingTask", "")
'     else if m.top.dialogRating.buttonSelected = 2 then
'         m.Ratings.rating = 3
'         m.Ratings.showid = showid
'         m.Ratings.callFunc("runRatingTask", "")
'     else if m.top.dialogRating.buttonSelected = 3 then
'         m.Ratings.rating = 2
'         m.Ratings.showid = showid
'         m.Ratings.callFunc("runRatingTask", "")
'     else if m.top.dialogRating.buttonSelected = 4 then
'         m.Ratings.rating = 1
'         m.Ratings.showid = showid
'         m.Ratings.callFunc("runRatingTask", "")
'     end if
' end sub

sub On_dialogRatingFeedSelected()
    m.parentScene.dialog.close = true
    m.top.ratingBoolean = true
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



function playtrailers()
    playBackGroundvideo("")
    m.backGroundVideo.control = "stop"
    m.backGroundVideo.visible = false
    VODcontent = returnTheCurrentFocusedData()
    m.background.visible = true
    m.loadingIndicator.visible = true
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        title: VODcontent.title + " " + "-" + " " + "Trailer",
        url: VODcontent.teaser,
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    if m.Playertrailer = invalid:
        m.Playertrailer = m.top.CreateChild("Playertrailer")
        m.Playertrailer.observeField("state", "PlayerStateChanged")
        m.Playertrailer.observeField("visible", "onVisibleChangetrailer")
    end if
    m.Playertrailer.content = content
    m.Playertrailer.visible = true
    m.Playertrailer.setFocus(true)
    m.Playertrailer.control = "play"
    m.count = 0
    m.Playertrailer.observeField("visibility", "onVisibleChangetrailer")
    ' ?"m.Video.state"
    ' ?m.Playertrailer.state
end function



' subscription required checking
sub ifSubscriptionCheckNeededForButtonClick()
    if (getSubscriptionRequired() = "true")
        if isGuest() = "true"
            if (getRegisterationMandatory() = "true")
                m.loadingIndicator.visible = false
                m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                m.top.gotoLandingScene = true
                m.Video.control = "stop"
                m.Video.content = invalid
                m.Video.visible = true
            else
                playLiveEvent()
            end if

        else if isGuest() = "false"
            callSubscriptionCheckAPI()
        end if
    else
        if isGuest() = "true"
            ' ifRegisterationMandatoryOrNot() '************** Registeration Mandatory checking
            if (getRegisterationMandatory() = "true")
                m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                m.top.gotoLandingScene = true
            else
                playLiveEvent()
            end if
        else
            playLiveEvent()
        end if
    end if
end sub



' subscription required checking
sub callSubscriptionCheckAPI()
    ' if (getSubscriptionRequired() = "true")
    ' if isGuest() = "true"
    '     m.loadingIndicator.visible = false
    '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    '     m.top.gotoLandingScene = true
    '     m.Video.control = "stop"
    '     m.Video.content = invalid
    '     m.Video.visible = true

    ' else if isGuest() = "false"
    VODcontent = returnTheCurrentFocusedData()
    m.VideoSubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
    m.VideoSubscriptionTask.videoID = str(m.top.EVENT_ID)
    m.VideoSubscriptionTask.IS_LISTING = true
    m.VideoSubscriptionTask.observeField("notifyClick", "checkSubscriptionOfLiveEvent")
    m.VideoSubscriptionTask.callFunc("runVideoSubscriptionTask", "")
    ' end if

    ' else
    '     if isGuest() = "true"
    '         ifRegisterationMandatoryOrNot() '************** Registeration Mandatory checking

    '     else
    '         playvideo()
    '     end if
    ' end if
end sub


'**********play button or subscribe clicked
sub checkSubscriptionOfLiveEvent()
    ?"checkSubscriptionOfLiveEvent called : show"
    if m.LINEAREVENTsubscriptionTask.videoSubs = true
        ?"checkSubscriptionOfLiveEvent if"
        playLiveEvent()
    else
        m.loadingIndicator.visible = false
        if getIsSubscriptionRequiredInRoku() = "true"
            ?"checkSubscriptionOfLiveEvent else"
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.top.goToPaymentDescriptionScreenForEvent = Str(m.top.EVENT_ID)
        else
            showSubscriptionDialog()
        end if
    end if
end sub

sub getVideoDetailsAPI() ' initially video details api called to get ideo details data
    ?"getVideoDetailsAPI called"
    VODcontent = returnTheCurrentFocusedData()
    ?VODcontent.video_id
    m.GetVideoDetailsTask = CreateObject("roSGNode", "GetVideoDetailsTask")
    m.GetVideoDetailsTask.videoID = VODcontent.videos[0].video_id
    m.GetVideoDetailsTask.observeField("videoDetailsResponse", "playLiveEvent")
    m.GetVideoDetailsTask.callFunc("runGetVideoDetailsTask", "")
end sub



' Registerartion Mandatory checking
sub ifRegisterationMandatoryOrNot()

end sub





' sub watchWithOutAds() ' logic checking free video , or rental, premium, payperview or combined.

'     m.isExceptionalCaseForMonthlyUserAndRental = false
'     m.isUserSubscribed = m.VideoSubscriptionTask.videoSubs
'     ? m.VideoSubscriptionTask
'     ?" m.LINEAREVENTsubscriptionTask"

'     VODcontent = returnTheCurrentFocusedData()
'     ?m.VideoSubscriptionTask.videoDetailsResponse
'     ?" m.VideoSubscriptionTask.videoDetailsResponse"
'     VODcontentForVideoDetails = m.VideoSubscriptionTask.videoDetailsResponse




'     m.videoSubscriptionDataPreCheck = m.VideoSubscriptionTask.videoSubscriptionResponseData
'     if m.videoSubscriptionDataPreCheck <> invalid
'         m.videoSubscriptionData = m.videoSubscriptionDataPreCheck
'     else
'         m.videoSubscriptionData = {}
'     end if


'     m.userSubIDSCount = m.VideoSubscriptionTask.userSubIDSCount
'     m.userSubIDSCountStatic = m.userSubIDSCount
'     ?"watchWithOutAds called"
'     ?"userSubIDSCount:"
'     ?m.userSubIDSCount.getInt()
'     ' m.VideoSubscriptionTask.callFunc("stopVideoSubscriptionTask", "")



'     if VODcontentForVideoDetails.free_video = true and m.videoSubscriptionData.DoesExist("Monthly") and m.videoSubscriptionData.DoesExist("Rental") and not m.VideoSubscriptionTask.userSubsTypes.DoesExist("Monthly")
'         ?"VODcontent.free_video = true and VODcontent.premium_flag = 1 and VODcontent.rental_flag = 1"

'         playOrsubscribe(VODcontent, m.userSubIDSCount, false)

'     else if VODcontentForVideoDetails.free_video = true and m.videoSubscriptionData.DoesExist("Monthly") and not m.VideoSubscriptionTask.userSubsTypes.DoesExist("Monthly")
'         ?"VODcontent.free_video = true and VODcontent.premium_flag = 1"
'         playOrsubscribe(VODcontent, m.userSubIDSCount, false)

'     else if VODcontentForVideoDetails.free_video = true and m.videoSubscriptionData.DoesExist("Rental") and not m.VideoSubscriptionTask.userSubsTypes.DoesExist("Monthly")
'         ?"VODcontent.free_video = true and VODcontent.rental_flag = 1"
'         playOrsubscribe(VODcontent, m.userSubIDSCount, false)

'     else if m.VideoSubscriptionTask.userSubsTypes.DoesExist("Monthly") and m.videoSubscriptionData.DoesExist("Rental") and not m.videoSubscriptionData.DoesExist("Monthly") ' exceptional case for subscribed user >> convince to take rental subscription
'         ?"m.userSubIDSCount > 0 and m.videoSubscriptionData.DoesExist(Rental) exceptional case"
'         playOrsubscribe(VODcontent, m.userSubIDSCount, true)


'     else if VODcontentForVideoDetails.free_video = true and not m.videoSubscriptionData.DoesExist("Rental") and not m.videoSubscriptionData.DoesExist("Monthly") and not m.videoSubscriptionData.DoesExist("Pay Per View")' only free video
'         ?"VODcontent.free_video = true"
'         ' playvideo()
'         continueWatchingLogic(VODcontent) ' continuewatching logic

'     else if VODcontentForVideoDetails.free_video = false and m.VideoSubscriptionTask.videoSubs = false and not m.VideoSubscriptionTask.userSubsTypes.DoesExist("Monthly") 'not subscribed user, premium or rental video >> show payment page
'         ?"VODcontent.free_video = false and m.VideoSubscriptionTask.videoSubs = false and not m.VideoSubscriptionTask.userSubsTypes.DoesExist(Monthly)"
'         showPaymentPage()


'     else ' video with neither any of above flags pass though this  ex; freeVideo=false. rental=true, or premium=true and may not be subscribed user
'         ?"watchWithOutAds else condition"
'         ' playvideo()
'         ' continueWatchingLogic(VODcontent)  ' continuewatching logic

'         if m.VideoSubscriptionTask.videoSubs = true
'             continueWatchingLogic(VODcontent) ' continuewatching logic
'         else
'             ' showPaymentPage() 'if else condition, go to payment page
'             playOrsubscribe(VODcontent, m.userSubIDSCount, false)
'         end if
'     end if

' end sub


' sub playOrsubscribe(VODcontent, userSubIDSCount as integer, isExceptionalCaseForMonthlyUserAndRental as boolean) ' logic for play or show subscribtion screen
'     ?"playOrsubscribe called"
'     m.isExceptionalCaseForMonthlyUserAndRental = isExceptionalCaseForMonthlyUserAndRental



'     if m.VideoSubscriptionTask.videoSubs = false 'or m.isExceptionalCaseForMonthlyUserAndRental = true
'         ?"userSubIDSCount = 0: playOrsubscribe"

'         m.dialogmessage_label.text = "Watch with Ads?"
'         m.cancelbutton_Label.text = "Continue"
'         m.exitbutton_Label.text = "Subscribe"
'         m.dialogbg_rect.visible = true
'         m.isWatchWithOutAdsDialogRectVisible = true
'         m.YesButton.setFocus(true)
'         m.loadingIndicator.visible = false
'     else
'         continueWatchingLogic(VODcontent) ' continuewatching logic
'     end if
' end sub

' sub playOrsubscribeForMonthlyUserRentalCase(VODcontent, userSubIDSCount as integer) ' logic for play or show subscribtion screen
'     ?"playOrsubscribeForMonthlyUserRentalCase called"


'     if m.VideoSubscriptionTask.videoSubs = false

'         ?"userSubIDSCount = 0: playOrsubscribe"

'         m.dialogmessage_label.text = "Watch with Ads?"
'         m.cancelbutton_Label.text = "Continue"
'         m.exitbutton_Label.text = "Subscribe"
'         m.dialogbg_rect.visible = true
'         m.isWatchWithOutAdsDialogRectVisible = true
'         m.YesButton.setFocus(true)
'         m.loadingIndicator.visible = false

'     else
'         ?"userSubIDSCount = 0: playOrsubscribe else"

'         continueWatchingLogic(VODcontent) ' continuewatching logic
'     end if
' end sub


sub continueWatchingLogic(VODcontent)
    if VODcontent.watched_duration <> invalid
        if VODcontent.watched_duration > 0
            ?"VODcontent.watched_duration > 0"
            ?"watched_duration"
            ?VODcontent.watched_duration
            showContinueWatchingDialog()
            ?"continueWatchingLogic called"
        else
            ?"VODcontent.watched_duration > 0 else"
            ?"watched_duration"
            ?VODcontent.watched_duration
            playvideo()
        end if
    end if

end sub

sub showContinueWatchingDialog()
    ?"showContinueWatchingDialog called"
    

        m.dialogmessage_label.text = getText("continue_watching")
    
    ' m.dialogmessage_label.text = "Continue Watching?"

    

        m.cancelbutton_Label.text =getText("resume")


   

        m.exitbutton_Label.text = getText("start_over")
  


    m.dialogbg_rect.visible = true
    m.continueWatchingDialogVisible = true
    m.NoButton.setFocus(true)
    m.loadingIndicator.visible = false
end sub




function OnVideoSubs() ' when video has any subscription active,  this is called
    ?"OnVideoSubs called"
    m.isUserSubscribed = m.VideoSubscriptionTask.videoSubs

    if m.count = 0
        ' m.count = 1
        if m.isUserSubscribed = true 'if user has any subscriptions

            m.count = 0
            ' playVideo()
            watchWithOutAds()
        else

            m.dialogbg_rect.visible = true
            m.isWatchWithOutAdsDialogRectVisible = true
            m.YesButton.setFocus(true)
            m.loadingIndicator.visible = false
        end if
    end if
end function


function OnSubscriptionComplete()
    ' if m.PaymentDescription.isSubscribed = true
    '     m.count = 0
    '     m.watched_duration = 0
    '     m.RowList.visible = true
    '     m.top.goToPaymentDescriptionScreen =false
    '     m.RowList.setFocus(true)
    '     m.loadingIndicator.visible = false
    '     m.BottomBar.visible = true
    '     m.ShowBar.control = "start"
    ' end if
end function


sub JustGoToContinueWatchingFunctionAfterIsLoggedInCheck()
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("templateGuest") ' guest scenario
        hideShowPage()
        m.loadingIndicator.visible = false
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
        VODcontent = returnTheCurrentFocusedData()
        ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id

    else ' logged in scenario
        VODcontent = returnTheCurrentFocusedData()
        continueWatchingLogic(VODContent)
    end if
end sub


sub onDialogYesSelected()
    ?"onDialogYesSelected called"

    if m.isWatchWithOutAdsDialogRectVisible = true
        ?"m.isWatchWithOutAdsDialogRectVisible = true"
        m.dialogbg_rect.visible = false
        m.loadingIndicator.visible = false
        VODcontent = returnTheCurrentFocusedData()
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreen = VODcontent.video_id


    else if m.continueWatchingDialogVisible = true ' this is start over case when start over button is pressed
        ?"m.continueWatchingDialogVisible = true"

        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false
        m.continueWatchingDialogVisible = false'
        m.watched_duration = 0
        playvideo()
    end if
end sub


sub onDialogNoSelected()
    ?"onDialogNoSelected"
    VODcontent = returnTheCurrentFocusedData()

    ' playvideo()
    if m.isWatchWithOutAdsDialogRectVisible = true
        ?"m.isWatchWithOutAdsDialogRectVisible = true: onDialogNoSelected"
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false
        m.continueWatchingDialogVisible = false'
        ' playvideo()
        continueWatchingLogic(VODcontent)
    else if m.continueWatchingDialogVisible = true ' this is resume case when resume button is pressed
        ?"m.continueWatchingDialogVisible = true"
        m.dialogbg_rect.visible = false
        m.isWatchWithOutAdsDialogRectVisible = false '******this is resume case************
        m.continueWatchingDialogVisible = false'
        m.watched_duration = VODcontent.watched_duration ' setting watched_duration
        playvideo() ' start over button selected
    end if

end sub


sub showPaymentPage(videoId) ' show payment page
    ?"showPaymentPage called"
    m.loadingIndicator.visible = false
    if getIsSubscriptionRequiredInRoku() = "true"
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreen = videoId
    else
        showSubscriptionDialog()
    end if
    ' m.loadingIndicator.visible = false
    ' VODcontent = returnTheCurrentFocusedData()
    ' m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
    ' 'showSubscriptionDialog()
end sub

sub showSubscriptionDialog()
    dialog = createObject("roSGNode", "Dialog")
    ' dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
    ' dialog.title = "Currently unavailable!"


    
        dialog.title = getText("warning")
   


    dialog.optionsDialog = true
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onSubscriptionRequiredOkButtonselected")

    
        msg1 = getText("to_avail_this_video")
  

   
        msg2 = getText("on_web")
  




    dialog.message = msg1 + getAppTitle() + msg2
    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
end sub

'     dialog = createObject("roSGNode", "Dialog")
'     ' dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
'     dialog.title = "Currently unavailable!"
'     dialog.optionsDialog = true
'     dialog.message = "To avail this video, visit our website.. Please visit " + getAppTitle() + " on the web for help"
'     m.top.dialog = dialog
'     m.parentScene = GetParentScene()
'     m.parentScene.dialog = dialog
' end sub

sub onSubscriptionRequiredOkButtonselected()
    m.parentScene.dialog.close = true
end sub

sub hideShowPage()
    ?"hideShowPage called"
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true
    m.image.visible = false
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
    if GetParentScene() = invalid then
        return
    end if
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
    m.top.logout = true
    m.parentScene.dialog.close = true
end sub



sub onStarted()
    ?"onStarted : show called showId: "m.top.start
    m.loadingProgress = m.top.findNode("loading")
    m.loadingIndicator.visible = true
    ' m.EventDetailApiTask.ContentRequest = m.top.start
    m.EventDetailApiTask.taskType = "ContentRequest"
    ' m.EventDetailApiTask.itemType = m.top.itemType
    m.EventDetailApiTask.EVENT_ID = m.top.EVENT_ID
    m.EventDetailApiTask.callFunc("runEventDetailApiTask", "")
end sub


sub onContentChanged()
    print "RUN ContentRequest true"

    ' if getThumbnailOrientaion() = "LANDSCAPE"
    '     rowHeights = [320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320, 320]
    '     rowItemSize = [[320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180]]
    ' else if getThumbnailOrientaion() = "PORTRAIT"
    '     rowHeights = [400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400]
    '     rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
    ' end if

    ' m.RowList.rowHeights = rowHeights
    ' m.RowList.rowItemSize = rowItemSize
    m.buttonsLabelListItems = []
    m.buttonsLabelListItems.push(m.playNow)
    m.top.ratingBoolean = false
    m.loadingIndicator.visible = false
    m.count3 = 1
    m.AdTimer.control = "start"
    m.Video.visible = true
    m.image.visible = true
    m.Title1.visible = true
    m.Episode.visible = true
    m.descri.visible = true
    m.synopsis.visible = true
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

    ' if m.EventDetailApiTask.Content.getChild(0).GetChildCount() > 1
    '     RowlistContent = m.EventDetailApiTask.Content
    '     m.issinglevideo = 0
    ' else
    '     content = createObject("RoSGNode", "ContentNode")
    '     RowlistContent = content
    '     m.issinglevideo = 1
    ' end if


    ' subscriptionContent = m.EventDetailApiTask.Content.subscriptions
    ' m.subscriptionList.content = subscriptionContent


    ' m.RowList.content = RowlistContent
    ' m.RowList.numRows = 2



    VODcontent = m.EventDetailApiTask.Content
    m.top.itemType = VODcontent.type

    ' sec = CreateObject("roRegistrySection", getAppKey())
    ' if sec.Exists("templateGuest")
    '     tok = sec.Read("templateGuest")
    ' else
    '     if(VODcontent.RELEASEDATE = "1")
    '         m.top.playlistAdd = true
    '         m.top.playlistRemove = false
    '     else
    '         m.top.playlistAdd = false
    '         m.top.playlistRemove = true
    '     end if
    ' end if


    'news page visibility controlls
    if VODcontent.itemType = "UPCOMING_EVENT"

    else if VODcontent.itemType = "LIVE_EVENT" or VODcontent.itemType = "RTMP" 'for ongoing events

    else

    end if

    ' if m.EventDetailApiTask.content.getChild(0).getChild(0).TagsContent.getChildCount() > 0
    '     m.buttonsLabelListItems.push(m.moreButton)
    ' end if

    ' m.RowList.unobserveField("rowItemSelected")
    ' m.RowList.observeField("rowItemSelected", "onRowItemSelected")
    ' m.RowList.unobserveField("rowItemFocused")
    ' m.RowList.observeField("rowItemFocused", "OnRowItemFocused")


    ' addbuttonLabelList(m.buttonsLabelListItems)
    setData()
    '************** currentVODContentIfSeasonExists - is for saving the last focused data in the rowlist.
    'this is for - if season exists, and we moved focus from labellist to any episode in the rowlist and then come back focus to labellist, then that last focused data to this variable
    ' m.currentVODContentIfSeasonExists = m.EventDetailApiTask.content.getChild(0).getChild(0)

    ' VODcontent = returnTheCurrentFocusedData()
end sub

' sub onSimilarShowChanged()
'     RowlistContent = m.SimilarShows.similarShowsApiListContent
'     if RowlistContent <> invalid and RowlistContent.getChild(0).GetChildCount() > 0 then
'         m.RowList.content.insertChild(RowlistContent.getChild(0), m.RowList.content.getChildCount())
'     end if
' end sub

' sub setTagsRowlist(tagsContent)

'     rowHeights = [60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
'     rowItemSize = [[200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60]]


'     m.tagsRowlist.rowHeights = rowHeights
'     m.tagsRowlist.rowItemSize = rowItemSize


'     for i = 0 to tagsContent.getchildcount() - 1
'         ?"itemType : ";itemType
'         itemType = invalid
'         if tagsContent.getChild(i) <> invalid and tagsContent.getChild(i).type <> invalid
'             itemType = tagsContent.getChild(i).type
'         end if

'         if itemType <> invalid and itemType = "TAGS"
'             rowHeights.SetEntry(i, 60)
'             m.tagsRowlist.rowHeights = rowHeights
'         end if

'         if itemType <> invalid and itemType = "CAST"
'             if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "TAGS"
'                 rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
'             end if

'             rowHeights.SetEntry(i, 60)
'             m.tagsRowlist.rowHeights = rowHeights
'             rowItemSize.SetEntry(i, [500, 60])
'             m.tagsRowlist.rowItemSize = rowItemSize
'         end if

'         if itemType <> invalid and itemType = "CREW"
'             if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "TAGS"
'                 rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
'             end if
'             if invalid <> tagsContent.getChild(i - 1) and invalid <> tagsContent.getChild(i - 1).type and tagsContent.getChild(i - 1).type = "CAST"
'                 rowHeights.SetEntry(i - 1, 150) ' *****this is to put a gap after tags and cast and crew list
'             end if
'             rowHeights.SetEntry(i, 60)
'             m.tagsRowlist.rowHeights = rowHeights
'             rowItemSize.SetEntry(i, [500, 60])
'             m.tagsRowlist.rowItemSize = rowItemSize
'         end if
'     end for
'     rowHeights.SetEntry(tagsContent.getchildcount() - 1, 100)
'     m.tagsRowlist.rowHeights = rowHeights

'     m.tagsRect.visible = true
'     m.tagsRowlist.content = tagsContent
'     m.top.tagsRowlistContent = tagsContent
'     m.tagsRowlist.setFocus(true)
' end sub


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
        ?"key pressed"

        if key = "up" or key = "down"
            ' if m.PaymentDescription.visible = false then

        else if key = "back"

            if m.isWatchWithOutAdsDialogRectVisible = true
                ?"isWatchWithOutAdsDialogRectVisible back pressed"
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisible = false
                m.continueWatchingDialogVisible = false


                m.videoSubscriptionData = invalid
                m.VideoSubscriptionTask = invalid
                handled = true

            else if m.continueWatchingDialogVisible = true
                ?"iscontinueWatchingDialogRectVisible back pressed"
                m.dialogbg_rect.visible = false
                m.isWatchWithOutAdsDialogRectVisible = false
                m.continueWatchingDialogVisible = false

                m.videoSubscriptionData = invalid
                m.VideoSubscriptionTask = invalid
                handled = true

            end if

            if m.continueWatchingDialogVisible = false and m.isWatchWithOutAdsDialogRectVisible = false
                playBackGroundvideo("")
            end if


            if m.tagsRect.visible = true
                m.tagsRect.visible = false
                m.buttonsLabelList.setFocus(true)
                return true
            end if

        else if key = "left"

            if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true
                ?"left"
                m.NoButton.setFocus(true)
                handled = true

            end if

        else if key = "right"

            if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true
                ?"right"
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
    VODcontent = returnTheCurrentFocusedData()
    m.top.goToVideoDetailScene = Str(VODcontent.video_id).Trim()
end sub

function playVideo()

end function


sub playLiveEvent()
    VODcontent = returnTheCurrentFocusedData()
    categories = []
    if VODcontent <> invalid and VODcontent.categories <> invalid and VODcontent.categories[0] <> invalid
        categories = VODcontent.categories
    end if
    categoriesWithComma = ""
    if categories <> invalid
        for i = 0 to categories.Count() - 1
            if categories <> invalid and categories[i] <> invalid and categories[i].category_name <> invalid
                if categoriesWithComma <> ""
                    categoriesWithComma = categoriesWithComma + "," + categories[i].category_name
                else
                    categoriesWithComma = categoriesWithComma + categories[i].category_name
                end if
            end if
        end for
    end if

     video_time=VODcontent.video_time
       video_type= VODcontent.type

    videoContent = {
        streamFormat: "m3u8"
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: VODcontent.event_name,
        video_time:video_time,
        url: VODcontent.live_url,
        categories: categoriesWithComma
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.

    }

    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "is_live": "1",
        "video_id":video_time,
        "eventId": m.top.EVENT_ID,
        "categoriesWithComma": categoriesWithComma,
        "ai_type": " ",
        "type": video_type
    })
  

    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if
    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)

    playBackGroundvideo("")
    m.backGroundVideo.control = "stop"
    m.backGroundVideo.visible = false
    m.Player.skipAd = true
    m.Player.control = "play"
    m.Player.observeField("visibility", "onPlayerVisibleChange")
end sub


function getAutosubtitle() as object
    lat = CreateObject("roRegistrySection", "DW_Authentication")
    if lat.Exists("Autosubtitle")
        lati = lat.Read("Autosubtitle")
        return lati
    end if
end function


function autoplayvideo()
    ' if(m.count = 0)
    '     m.count = 1
    '     VODcontent = returnTheCurrentFocusedData()
    '     m.background.visible = true
    '     m.Video.control = "stop"
    '     m.Video.content = invalid
    '     m.Video.visible = true
    '     di = CreateObject("roDeviceInfo")
    '     displaySize = di.GetDisplaySize()
    '     macroHeight = Str(displaySize.h).Trim()
    '     macroWidth = Str(displaySize.w).Trim()
    '     macroDNT = "true"
    '     if di.IsRIDADisabled()
    '         macroDNT = "false"
    '     end if
    '     macroIP = di.GetExternalIp()
    '     version = di.GetVersion()
    '     version_major = mid(version, 3, 1)
    '     version_minor = mid(version, 5, 2)
    '     version_build = mid(version, 8, 5)
    '     if version_minor.toint() < 10 then
    '         version_minor = mid(version_minor, 2)
    '     end if
    '     macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    '     macroADID = di.GetRIDA()
    '     macroDevModel = di.GetModel()
    '     macroUUID = di.GetChannelClientId()
    '     macroCountry = di.GetUserCountryCode()
    '     macroLang = di.GetCurrentLocale()
    '     macroRegion = di.GetCurrentLocale()
    '     macroChannelID = getAutovideochannelid().Trim()
    '     macroVideoID = getAutovideoid().Trim()
    '     macroDuration = getAutovideoduration().trim()
    '     macrouserID = getUserIdana().Trim()
    '     macrvideoID = getAutovideoid().Trim()
    '     macrotitle = getAutovideotitle()
    '     m.uidana = getUserIdana()
    '     m.EventDetailApiTask.user_id = m.uidana
    '     m.EventDetailApiTask.event_type = "POP02"
    '     m.EventDetailApiTask.video_id = macrvideoID
    '     m.EventDetailApiTask.video_title = macrotitle
    '     m.EventDetailApiTask.channel_id = macroChannelID
    '     sec = CreateObject("roRegistrySection", getAppKey())
    '     sec.Write("videoID", m.EventDetailApiTask.video_id)
    '     sec.Write("videoTITLE", m.EventDetailApiTask.video_title)
    '     sec.Write("channelID", m.EventDetailApiTask.channel_id)
    '     sec.Write("category", getAutovideocategory())
    '     sec.Flush()
    '     adUURRLL = getAutovideoadlink()
    '     tempONE = strReplace(adUURRLL, "[WIDTH]", macroWidth)
    '     tempTWO = strReplace(tempONE, "[HEIGHT]", macroHeight)
    '     tempTHREE = strReplace(tempTWO, "[DNT]", macroDNT)
    '     tempFOUR = strReplace(tempTHREE, "[IP_ADDRESS]", macroIP)
    '     tempFIVE = strReplace(tempFOUR, "[USER_AGENT]", macroUserAgent)
    '     tempSIX = strReplace(tempFIVE, "[DEVICE_IFA]", macroADID)
    '     tempSEVEN = strReplace(tempSIX, "[UUID]", macroUUID)
    '     tempEIGHT = strReplace(tempSEVEN, "[USER_ID]", macrouserID.Trim())
    '     tempNINE = strReplace(tempEIGHT, "[REGION]", getRegion())
    '     tempTEN = strReplace(tempNINE, "[COUNTRY]", getCountrycode())
    '     tempELEVEN = strReplace(tempTEN, "[DEVICE_ID]", macroUUID)
    '     tempTWELVE = strReplace(tempELEVEN, "[DEVICE_MODEL]", macroDevModel)
    '     tempTHIRTEEN = strReplace(tempTWELVE, "[CHANNEL_ID]", macroChannelID.Trim())
    '     tempFOURTEEN = strReplace(tempTHIRTEEN, "[VIDEO_ID]", macroVideoID.Trim())
    '     tempFIFTEEN = strReplace(tempFOURTEEN, "[APP_STORE_URL]", getRokuChannelStoreURL())
    '     tempSIXTEEN = strReplace(tempFIFTEEN, "[DEVICE_MAKE]", "RA")
    '     temp17 = strReplace(tempSIXTEEN, "[BUNDLE]", getBundleID())
    '     temp18 = strReplace(temp17, "[LATITUDE]", getLatitude().Trim())
    '     temp19 = strReplace(temp18, "[LONGITUDE]", getLongitude().Trim())
    '     temp20 = strReplace(temp19, "[KEYWORDS]", getAutovideocategory())
    '     temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle())
    '     temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
    '     temp23 = strReplace(temp22, "[CITY]", getCity())
    '     temp24 = strReplace(temp23, "[SHOW_ID]", getAutovideoshowid())
    '     temp25 = strReplace(temp24, "[CATEGORIES]", getAutovideocategoryid())
    '     temp26 = strReplace(temp25, "[CONTENT_TITLE]", getAutovideotitle())
    '     finalAdURL = strReplace(temp26, "[DURATION]", macroDuration.Trim())
    '     di = CreateObject("roDeviceInfo")
    '     advid = di.GetRIDA()
    '     videoContent = {
    '         streamFormat: "m3u8",
    '         titleSeason: "",
    '         title: getAutovideotitle(),
    '         url: getAutovideourl(),
    '         categories: "Cat"
    '         nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
    '         nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
    '         nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    '     }
    '     '  subtitle_config = [
    '     '     {Language : "eng", Description :"English", TrackName : "https://gizmeon.s.llnwi.net/vod/subtitles/vsshort-en.vtt"},
    '     '     {Language : "gmh", Description :"German", TrackName : "https://gizmeon.s.llnwi.net/vod/subtitles/vsshort-de.srt"}
    '     '     ]

    '     ' videoContent.ClosedCaptions = True
    '     ' subtitle_config = VODcontent.subtitles

    '     content = CreateObject("roSGNode", "VideoContent")
    '     content.setFields(videoContent)
    '     content.ad_url = finalAdURL.EncodeUri()
    '     if getAutosubtitle() <> "invalid"
    '         subtitleJson = parsejson(getAutosubtitle())
    '         if subtitleJson <> invalid
    '             content.ClosedCaptions = True
    '             content.globalCaptionMode = "On"
    '             content.HDBranded = True
    '             content.IsHD = True
    '             content.SubtitleConfig = subtitleJson
    '             content.SubtitleTracks = subtitleJson
    '         end if
    '     end if


    '     ' content.ClosedCaptions = true
    '     ' content.SubtitleTracks = subtitle_config


    '     if m.Player = invalid:
    '         m.Player = m.top.CreateChild("Player")
    '         m.Player.observeField("state", "PlayerStateChanged")
    '         m.Player.observeField("visible", "onVideoVisibleChange")
    '     end if
    '     m.Player.content = content
    '     m.Player.visible = true
    '     m.Player.setFocus(true)

    '     playBackGroundvideo("")

    '     m.Player.control = "play"
    '     m.Player.observeField("visibility", "onPlayerVisibleChange")
    ' end if
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



'this is when play button in labellist clicked
function onButtonLabelListPlayClicked() as void
    ?"onButtonLabelListPlayClicked called"

    playBackGroundvideo("")
    VODcontent = returnTheCurrentFocusedData()

    ' if isGuest() = "true"
    ' m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    ' m.top.gotoLandingScene = true
    ' else
    ' m.UserSubscription.callFunc("runUserSubscription", "")
    ifSubscriptionCheckNeededForButtonClick()
    ' end if
end function




sub playtrailer()
    m.image.visible = false
    m.Title1.visible = false
    m.Episode.visible = false
    m.descri.visible = false
    m.descri_title.visible = false
    m.resolution.visible = false
    m.cast.visible = false
    m.Year.visible = false
    ' m.Director.visible = false
    m.Duration.visible = false
    m.rating.visible = false
    m.years.visible = false
    m.time.visible = false
    m.direct.visible = false
    m.prod.visible = false
    m.casting.visible = false
end sub





function setData()
    m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"

    VODcontent = m.EventDetailApiTask.content
    rowItemFocusedNow = m.EventDetailApiTask.content

    displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()


    m.loadingIndicator.visible = true
    m.AdTimer.control = "start"
    m.Video.visible = true
    m.image.visible = true
    m.Title1.visible = true
    m.Episode.visible = true
    m.descri.visible = true
    m.synopsis.visible = true
    m.descri_title.visible = true
    m.resolution.visible = true
    m.cast.visible = false
    m.Year.visible = false
    ' m.Director.visible = true
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
    m.casting.visible = false

    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    if VODcontent <> invalid and VODcontent.logo_thumb <> invalid and VODcontent.logo_thumb <> ""
        m.bannerPoster.uri = VODcontent.logo_thumb
        m.backGroundBannerPoster.uri = VODcontent.logo_thumb

    else if VODcontent <> invalid and VODcontent.thumbnail_350_200 <> invalid and VODcontent.thumbnail_350_200 <> ""
        m.backGroundBannerPoster.uri = VODcontent.thumbnail_350_200
        m.bannerPoster.uri = VODcontent.thumbnail_350_200

    end if
    m.loadingIndicator.visible = false
    m.backGroundBannerPoster.visible = true



    ' no trailer scenario | handling for if news then playing news as background video instead of playing trailer | trailer button posiyioning etc..
    if VODcontent.teaser <> invalid and VODcontent.itemType <> invalid and VODcontent.itemType <> "news" and VODcontent.teaser <> ""
        m.Timer2.control = "start"
        m.backGroundVideo.visible = true
        playBackGroundvideo(rowItemFocusedNow.teaser)
        m.background.translation = [0, 0]
        m.Video.visible = false

    else if VODcontent.type <> invalid and VODcontent.type = "LIVE"
        ?"liveEvent item focused : show"
        m.Timer2.control = "stop"

        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false

    else if VODcontent.type = "ENDED"
        m.Timer2.control = "stop"
        m.background.translation = [0, 0]
        m.Video.control = "stop"
        m.Video.visible = false
        m.backGroundVideo.visible = false

    end if


    ' if VODcontent.image_title <> invalid
    ' m.Title1.visible = false
    ' m.image.visible = true
    ' m.Episode.visible = true
    ' m.Image.uri = VODcontent.image_title

    ' if VODcontent.description <> invalid and not VODcontent.description = ""
    '     m.descri.text = VODcontent.description
    '     m.descri_title.visible = true
    ' else
    '     m.descri_title.visible = false
    '     m.descri.text = ""
    ' end if


    ' if VODcontent.resolution <> invalid then
    '     m.resolution.visible = true
    '     m.resolution.Text = VODcontent.resolution
    ' else
    '     m.resolution.Text = "General"
    ' end if

    ' if VODcontent.categories <> invalid then
    '     m.categories.Text = VODcontent.categoriesWithComma
    ' else
    '     m.categories.Text = ""
    ' end if

    ' if(VODcontent.show_cast <> invalid and VODcontent.show_cast <> "")
    '     m.cast.visible = false
    '     m.cast.Text = VODcontent.show_cast
    ' else
    '     m.cast.visible = false
    '     m.casting.visible = false
    ' end if
    ' m.Episode.text = ""
    ' if VODcontent.year <> invalid then
    '     m.year.visible = false'
    '     m.years.visible = true
    '     m.Year.Text = VODcontent.year
    ' else
    '     m.Year.visible = false
    '     m.years.visible = false
    ' end if
    ' minutes = VODcontent.duration_text
    ' mDuration = convertTime(minutes)

    ' if mDuration <> invalid then
    '     m.Duration.visible = false'
    '     if m.Years.visible = true
    '         m.Duration.translation = [160, 200]
    '         m.Duration.Text = "•   " + mDuration
    '     else
    '         m.Duration.translation = [90, 200]
    '         m.Duration.Text = mDuration
    '     end if
    ' else
    '     m.Duration.visible = false
    ' end if

    ' if VODcontent.director <> invalid and VODcontent.director <> "" then
    '     m.Director.visible = true
    '     m.Director.text = VODcontent.director
    ' else
    '     m.Director.visible = false
    '     m.direct.visible = false
    ' end if

    ' else
    m.image.visible = true
    m.Title1.visible = true
    if(VODcontent.producer <> invalid)
        m.Episode.visible = true
        m.Episode.text = ""
    else
        m.Episode.visible = false
    end if
    m.Title1.text = VODcontent.event_name'VODcontent.show_name 'UCase(VODcontent.title)

    if VODcontent.schedule_time <> invalid and not VODcontent.schedule_time = ""
        m.descri.text = convertToDate(VODContent.schedule_time) + "  |  " + convertZTimeToNormalLocalTime(VODcontent.schedule_time)
        m.descri_title.visible = true

    else
        m.descri_title.visible = true
        ' testing
        m.descri.text = VODcontent.synopsis
        m.Title1.text = VODcontent.show_name
        m.Title1.visible = true
    end if



    if VODcontent.description <> invalid then
        m.resolution.visible = true
        m.resolution.Text = VODcontent.description
    else
        ' Need to change-- Test
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
    ' end if
end function

function convertZTimeToNormalLocalTime(input)
    dt = CreateObject("roDateTime")
    dt.FromISO8601String(input)
    dt.ToLocalTime()
    shortTime = dt.asTimeStringLoc("short-h12")
    ' ?"shortTime printed: ";shortTime
    return shortTime
end function

function convertToDate(inputValue)
    date = CreateObject("roDateTime")
    date.FromISO8601String(inputValue)
    return date.AsDateString("short-month")
end function
' sub focusedSecondRow()
'     VODcontent = returnTheCurrentFocusedData()
'     m.descri.visible = true
'     m.descri_title.visible = true
' end sub





sub onPlayerVisibleChange()
    ?"onPlayerVisibleChange called"
    m.autoThumb.visible = false
    m.autoplaylabel.visible = false


    m.BottomBar.visible = true
    m.count = 0
    m.count2 = 0
    m.ShowBar.control = "start"
    m.loadingIndicator.visible = false
    if m.Player.visibility = false then
        m.count = 0
        m.count2 = 0
    end if
    m.buttonsLabelList.setFocus(true)
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






' sub continueWatchingLogicForAutoplay(VODcontent)
'     if VODcontent.watched_duration > 0
'         ?"VODcontent.watched_duration > 0"
'         ?"watched_duration"
'         ?VODcontent.watched_duration
'         showContinueWatchingDialog()
'         ?"continueWatchingLogic called"
'     else
'         ?"VODcontent.watched_duration > 0 else"
'         ?"watched_duration"
'         ?VODcontent.watched_duration
'         autoplayvideo()
'     end if
' end sub

' sub showContinueWatchingDialogForAutoplay()
'     ?"showContinueWatchingDialog called"
'     m.dialogmessage_label.text = "Continue Watching?"
'     m.cancelbutton_Label.text = "Resume"
'     m.exitbutton_Label.text = "Start Over"
'     m.dialogbg_rect.visible = true
'     m.continueWatchingDialogVisible = true
'     m.YesButton.setFocus(true)
'     m.loadingIndicator.visible = false
'     m.VideoSubscriptionTask = invalid
' end sub



' sub onDialogNoSelectedForAutoplay()
'     ?"onDialogNoSelected"
'     VODcontent = returnTheCurrentFocusedData()

'     ' playvideo()
'     if m.isWatchWithOutAdsDialogRectVisible = true
'         ?"m.isWatchWithOutAdsDialogRectVisible = true: onDialogNoSelected"
'         m.dialogbg_rect.visible = false
'         m.isWatchWithOutAdsDialogRectVisible = false
'         m.continueWatchingDialogVisible = false'
'         ' playvideo()
'         continueWatchingLogic(VODcontent)
'     else if m.continueWatchingDialogVisible = true ' this is resume case when resume button is pressed
'         ?"m.continueWatchingDialogVisible = true"
'         m.dialogbg_rect.visible = false
'         m.isWatchWithOutAdsDialogRectVisible = false '******this is resume case************
'         m.continueWatchingDialogVisible = false'
'         m.watched_duration = VODcontent.watched_duration ' setting watched_duration
'         autoplayvideo() ' start over button selected
'     end if

' end sub


function secondsToHhMmSsConverter(TotalSeconds as integer) as string
    ?"secondsToHhMmSsConverter called"
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

sub positionShowdetailsButtons()

    'to position showdetail page buttons when playlist button clicked
    ' if m.buttonTrailer.visible = true
    '     trailerButtonIsVisibleScenarioForButtonsPositioning()
    ' else
    '     trailerButtonIsNotVisibleScenarioForButtonsPositioning()
    ' end if

end sub



sub newsHandlingFunction(VODContent)
    ?"itemType = NEWS"
    ' ?m.RowList.content.getChild(m.RowList.rowItemFocused[0])
    ' ?m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    m.buttonRectangle.visible = true
    m.rectangleForSmallDetails.visible = true
    m.descri.text = VODContent.DESCRIPTION
    m.descri.height = 325
    ' m.labelForSpecialPages.visible = true
    m.Title1.text = VODContent.event_name
    m.buttonsLabelList.visible = true
    ' m.labelForSpecialPages.text = VODContent.duration_text
end sub




sub playBackGroundvideo(URLToBePlayed)
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = URLToBePlayed
    videoContent.title = "Trailer Loading...."
    videoContent.streamformat = "m3u8"
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("tokplayy")
        tok = sec.Read("tokplayy")
    else
    end if
    m.backGroundVideo.content = videoContent
    m.backGroundVideo.visible = true
    m.backGroundVideo.AddHeader("token", tok)
    m.backGroundVideo.control = "play"
    ' video.observeField("state", "trailerstate")
    if URLToBePlayed = ""
        m.backGroundVideo.control = "stop"
        m.backGroundVideo.visible = false
    end if
    ?"playBackGroundvideo is called "
    ?URLToBePlayed
    ?m.backGroundVideo.visible
    ?m.backGroundVideo.state
end sub




sub stopBackgroundTrailerOrNewsVideo()
    ?"stopBackgroundTrailerOrNewsVideo called"
    ?m.backGroundVideo.state
    'stopping trailer playing
    isBackgroundTrailerOrNewsVideoPlayingBoolean = m.backGroundVideo.control = "stop"
    m.backGroundVideo.visible = false
    ?"isBackgroundTrailerOrNewsVideoPlayingBoolean"
    ?isBackgroundTrailerOrNewsVideoPlayingBoolean
end sub




' sub showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount as integer)
'     if videoCount = 1
'         ?"videoCount = 1"
'         m.RowList.visible = false
'         m.playNowButton.visible = true
'     else
'         ?"videoCount = 1 else"
'         m.RowList.visible = true
'         m.playNowButton.visible = false
'     end if
' end sub





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



' This Logic has been uploaded to google drive
' https://drive.google.com/file/d/1OuEHNm-3AWgTl2zElm4mV0bZpvDXpaKW/view?usp=sharing
sub playOrSubscribeLogicFunction()
    ?"playOrSubscribeLogicFunction called"
    if (isGuest() = "false")
        ' if (m.VideoSubscriptionTask.userSubIDSCount <> invalid and m.VideoSubscriptionTask.userSubIDSCount > 0)
        '     if (m.VideoSubscriptionTask.videoSubIDSCount <> invalid and m.VideoSubscriptionTask.videoSubIDSCount > 0)
        '         if checkingSubscribedVideoOrNotBasedOnShowLevelSubscriptionAlso() = true'(m.VideoSubscriptionTask.videoSubs = true)
        '             ' print"Display Watch Now Button"
        '             ' playvideo()
        '             ?"playOrSubscribeLogicFunction111"
        '             watchWithOutAds()

        '         else
        '             ' print"Show subscribe button"
        '             ?"playOrSubscribeLogicFunction222"
        '             showPaymentPage()
        '         end if
        '     else
        '         ' print"Display Watch Now Button"
        '         ' playvideo()
        '         ?"playOrSubscribeLogicFunction333"
        '         watchWithOutAds()
        '     end if
        ' else
        '     if (m.VideoSubscriptionTask.videoSubIDSCount <> invalid and m.VideoSubscriptionTask.videoSubIDSCount > 0)
        '         ' print"Show subscribe Button"
        '         ?"playOrSubscribeLogicFunction444"
        '         showPaymentPage()
        '     else
        '         ' print "Display Watch Now Button"
        '         ' playvideo()
        '         ?"playOrSubscribeLogicFunction555"
        '         watchWithOutAds()
        '     end if
        ' end if

        watchWithOutAds()
    else if(isGuest() = "true")
        if (m.VideoSubscriptionTask.videoSubIDSCount <> invalid and m.VideoSubscriptionTask.videoSubIDSCount > 0)

            VODcontent = returnTheCurrentFocusedData()
            showPaymentPage(VODcontent.video_id)
        else
            ' print"Display Watch Now Button"
            ' playvideo()
            if (getRegisterationMandatory() = "true")
                m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                m.top.gotoLandingScene = true
            else
                ' playvideo()
                watchWithOutAds()

            end if
        end if
    end if
end sub



' sub scrollUpAnimation()
'     m.scrollUpAnimation.control = "start"
'     m.isScreenIsNowScrolledUp = true
'     whichNodeToSetFocusBasedOnScreenScrolledStatus()
' end sub

' 'starts the scrollDown animation
' sub scrollDownAnimation()
'     m.scrollDownAnimation.control = "start"
'     m.isScreenIsNowScrolledUp = false
'     whichNodeToSetFocusBasedOnScreenScrolledStatus()
' end sub

' sub whichNodeToSetFocusBasedOnScreenScrolledStatus()
'     if m.isScreenIsNowScrolledUp = true
'         m.RowList.setFocus(true)
'     else
'         m.buttonsLabelList.setFocus(true)
'     end if
' end sub




'**************retruns the current focused data. It descrimininates from rowlist or buttonlabellist has the focus.
'it season exists, (singlevideo = 0) it takes that also into consideration.
function returnTheCurrentFocusedData()
    return m.EventDetailApiTask.content
end function

function displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()
    ?"displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction called"

    VODcontent = returnTheCurrentFocusedData()
    if(m.VideoSubscriptionTaskNeedsToRunOnceAgain = false)'if((m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.videoDetailsResponse <> invalid) and m.currentUserId.Trim() = getUserIdana().Trim())'(not m.VideoSubscriptionTaskNeedsToRunOnceAgain = true) 'if subscription api had called called alreadyy and data exists , then videosubscription is not called, else it is called

        SubscriptionedUseronVisibleChange()
    else
        m.LINEAREVENTsubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
        m.LINEAREVENTsubscriptionTask.observeField("notifyClick", "SubscriptionedUseronVisibleChange")
        m.LINEAREVENTsubscriptionTask.eventId = m.top.EVENT_ID.toStr().Trim()
        m.LINEAREVENTsubscriptionTask.callFunc("runVideoSubscriptionTask", "")
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = false
        m.currentUserId = getUserIdana()
    end if
end function



'**********this just checks is user subscribed based on show or episodes | with show level subscribtions or so..
function SubscriptionedUseronVisibleChange()
    ?"SubscriptionedUseronVisibleChange called"
    VODcontent = returnTheCurrentFocusedData()
    ' ?"VODcontent.subscriptionData.getchild(0).getchildcount()";VODcontent.subscriptionData.getchild(0).getchildcount()


    videoSubscriptionCount = 0
    if m.LINEAREVENTsubscriptionTask <> invalid and m.LINEAREVENTsubscriptionTask.videoSubIDSCount <> invalid
        videoSubscriptionCount = m.LINEAREVENTsubscriptionTask.videoSubIDSCount
    end if

    isSubcribed = m.LINEAREVENTsubscriptionTask.videoSubs'checkingSubscribedVideoOrNotBasedOnShowLevelSubscriptionAlso()
    ' ?"SubscriptionedUseronVisibleChange : isSubcribed ";isSubcribed

    showSubScribeOrPlayNowButtonAndSubscriptionListingLogics(isSubcribed, VODcontent, videoSubscriptionCount)
    ' m.buttonsLabelList.visible = true
end function



' This Logic has been uploaded to google drive
' https://drive.google.com/file/d/1OuEHNm-3AWgTl2zElm4mV0bZpvDXpaKW/view?usp=sharing
sub showSubScribeOrPlayNowButtonAndSubscriptionListingLogics(isSubcribed, VODcontent, videoSubscriptionCount)
    ?"videoSubscriptionCount: ";videoSubscriptionCount
    subscriptionContent = VODcontent.subscriptions
    m.subscriptionList.content = m.EventDetailApiTask.subscriptions
    if (isGuest() = "false")
        if (m.LINEAREVENTsubscriptionTask.userSubIDSCount <> invalid and m.LINEAREVENTsubscriptionTask.userSubIDSCount > 0)
            if (videoSubscriptionCount > 0)
                if (isSubcribed = true) 'm.LINEAREVENTsubscriptionTask.videoSubs = true
                    if not VODcontent.type = "UPCOMING"
                        modifyButtonLabelList(m.playNow, 0)
                        m.buttonsLabelList.visible = true
                    else
                        m.buttonsLabelList.visible = false
                    end if
                    m.subscriptionList.visible = false
                else
                    modifyButtonLabelList(m.Subscribe, 0)
                    m.subscriptionList.visible = true
                end if
            else
                if not VODcontent.type = "UPCOMING"
                    modifyButtonLabelList(m.playNow, 0)
                    m.buttonsLabelList.visible = true
                else
                    m.buttonsLabelList.visible = false
                end if
                m.subscriptionList.visible = false
            end if
        else
            if (videoSubscriptionCount > 0)
                modifyButtonLabelList(m.Subscribe, 0)
                m.buttonsLabelList.visible = true
                m.subscriptionList.visible = true
            else
                if not VODcontent.type = "UPCOMING"
                    modifyButtonLabelList(m.playNow, 0)
                    m.buttonsLabelList.visible = true
                else
                    m.buttonsLabelList.visible = false
                end if
                m.subscriptionList.visible = false
            end if
        end if
    else if(isGuest() = "true")

        if (getRegisterationMandatory() = "true")

            if (videoSubscriptionCount > 0)
                modifyButtonLabelList(m.Subscribe, 0)
                m.buttonsLabelList.visible = true
                m.subscriptionList.visible = true
            else
                if not VODcontent.type = "UPCOMING"
                    modifyButtonLabelList(m.playNow, 0)
                    m.buttonsLabelList.visible = true
                else
                    m.buttonsLabelList.visible = false
                end if
                m.subscriptionList.visible = false
            end if
        else
            if not VODcontent.type = "UPCOMING"
                modifyButtonLabelList(m.playNow, 0)
                m.buttonsLabelList.visible = true
            else
                m.buttonsLabelList.visible = false
            end if
        end if
    end if

end sub

function getCurrentVODContentbasedOnSeasonExisting()
    if m.issinglevideo = 1
        VODcontent = returnTheCurrentFocusedData()
    else if m.issinglevideo = 0
        VODcontent = m.currentVODContentIfSeasonExists
    end if
    return VODcontent
end function




'function that checks subscription count based on showlevel subscription or video subscription
function checkingSubscribedVideoOrNotBasedOnShowLevelSubscriptionAlso()

    videoSubscriptionCount = 0
    VODcontent = returnTheCurrentFocusedData()

    if VODcontent.subscriptionData <> invalid and VODcontent.subscriptionData.getchild(0) <> invalid
        videoSubscriptionCount = VODcontent.subscriptionData.getchild(0).getchildcount()
    end if


    isSubcribed = false
    showSubscriptions = m.EventDetailApiTask.rawEventDetailApiTaskContent.subscriptions

    if m.issinglevideo = 1 'and showSubscriptions.count() <> 0 '*********if it is a show subscription checks done from show subscription, else individual videos subscriptions
        for i = 0 to m.VideoSubscriptionTask.userSubIDS.Count() - 1
            for j = 0 to showSubscriptions.count() - 1
                if showSubscriptions <> invalid and showSubscriptions[j] <> invalid and showSubscriptions[j].subscription_id <> invalid
                    if m.VideoSubscriptionTask.userSubIDS[i] = showSubscriptions[j].subscription_id then
                        ?"subscribed !!"
                        isSubcribed = true
                    end if
                end if
            end for
        end for
    else if m.issinglevideo = 0 '******not a show
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
    end if
    ?isSubcribed
    ?"isSubcribed"
    return isSubcribed
end function

' function onTagsRowItemSelected()
'     ?"onTagsRowItemSelected calleddddd"
'     m.tagsRect.visible = false
'     whichNodeToSetFocusBasedOnScreenScrolledStatus()
'     m.top.goToShowMoreScene = m.tagsRowlist.RowItemSelected
' end function




'******************autoplay
'******this method called after one video finished, this is for autoplaying next video
function PlayerStateChanged()
    ?"PlayerStateChanged called : show"

    if invalid <> m.Player and invalid <> m.Player.playerState
        if m.Player.playerState = "finished" or m.Player.playerState = "stopped"
            ' if m.AutoplayData2 <> invalid
            '     m.UpNext_rect.visible = true
            '     m.upnext_video_name.text = m.AutoplayData2.videoDetailsResponse.video_title
            '     ' autoPlayVideo2()
            ' end if
        else if m.Player.playerState = "back_pressed" or m.Player.playerState = ""
            ' m.UpNext_rect.visible = false
        end if
        if m.Player.state = "change_video_track"
            ' ' m.Player.control = "stop"
            ' m.Player.content.url = "https://gizmeon.mdc.akamaized.net/PUB-50054/202307311690796936/playlist.m3u8"
            ' m.Player.control = "play"
        else

        end if
    end if

end function


'''''''''
' OnVideoLangugageChanged: this is used to call autoplay api agin so that the autoplay video follows the selected language
'
' @param {dynamic} params - video id of the newly selected video
'''''''''
' function OnVideoLangugageChanged()
'     callAutoplayAPI(m.Player.VIDEO_LANGUAGE_CHANGED)
' end function

'*****
' sub callAutoplayAPI(video_id)
'     m.AutoPlayAPiTask = CreateObject("roSGNode", "AutoPlayAPiTask")
'     ' m.AutoPlayAPiTask.videoID = str(m.gridScreen.focusedContent.video_id)
'     m.AutoPlayAPiTask.observeField("AutoPlayAPiTaskContent", "OnAutoPlayAPiTaskContent")
'     m.AutoPlayAPiTask.callFunc("runAutoPlayAPiTask", video_id)
' end sub

' sub OnAutoPlayAPiTaskContent()
'     ?"OnAutoPlayAPiTaskContent called"
'     if m.AutoPlayAPiTask <> invalid and m.AutoPlayAPiTask.AutoPlayAPiTaskContent <> invalid and m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data <> invalid
'         m.AutoplayData = m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data
'         getVideoDetailsAPIForAutoPlay(m.AutoplayData.video_id.ToStr())
'     end if
' end sub


' sub getVideoDetailsAPIForAutoPlay(video_id as string)
'     m.GetVideoDetailsTaskForAutoPlay = CreateObject("roSGNode", "GetVideoDetailsTask")
'     m.GetVideoDetailsTaskForAutoPlay.videoID = video_id
'     m.GetVideoDetailsTaskForAutoPlay.observeField("videoDetailsResponse", "OngetVideoDetailsAPIForAutoPlay")
'     m.GetVideoDetailsTaskForAutoPlay.callFunc("runGetVideoDetailsTask", "")
' end sub

' function OngetVideoDetailsAPIForAutoPlay()
'     ?"OngetVideoDetailsAPIForAutoPlay calledddd"
'     m.AutoplayData2 = m.GetVideoDetailsTaskForAutoPlay
' end function

' function autoPlayVideo2()
'     ?"playvideo calledddddddddd"
'     ?"m.count = 0: playvideo "
'     m.count = 1

'     m.background.visible = true
'     m.Video.control = "stop"
'     m.Video.content = invalid
'     m.Video.visible = true


'     di = CreateObject("roDeviceInfo")
'     displaySize = di.GetDisplaySize()
'     macroHeight = Str(displaySize.h).Trim()
'     macroWidth = Str(displaySize.w).Trim()
'     macroDNT = "1"
'     if di.IsRIDADisabled()
'         macroDNT = "0"
'     end if
'     macroIP = di.GetExternalIp()
'     version = di.GetVersion()
'     version_major = mid(version, 3, 1)
'     version_minor = mid(version, 5, 2)
'     version_build = mid(version, 8, 5)
'     if version_minor.toint() < 10 then
'         version_minor = mid(version_minor, 2)
'     end if
'     macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
'     macroADID = di.GetRIDA()
'     macroDevModel = di.GetModel()
'     macroUUID = di.GetChannelClientId()
'     macroCountry = di.GetUserCountryCode()
'     macroLang = di.GetCurrentLocale()
'     macroRegion = di.GetCurrentLocale()
'     macroChannelID = getchannelsid().Trim()
'     macroVideoID = m.AutoplayData.video_id.toStr().Trim()
'     macroDurations = m.AutoplayData2.videoDetailsResponse.video_duration.toStr().Trim()
'     macroDuration = macroDurations.toInt() * 60
'     macrouserID = getUserIdana().Trim()
'     macrvideoID = m.AutoplayData.video_id.toStr().Trim()
'     macrotitle = m.AutoplayData2.videoDetailsResponse.video_title
'     m.uidana = getUserIdana()
'     m.EventDetailApiTask.user_id = m.uidana
'     m.EventDetailApiTask.event_type = "POP02"
'     m.EventDetailApiTask.video_id = macrvideoID
'     m.EventDetailApiTask.video_title = macrotitle
'     m.EventDetailApiTask.channel_id = macroChannelID
'     categoriesWithComma = ""
'     for i = 0 to m.AutoplayData2.videoDetailsResponse.categories.Count() - 1
'         categoriesWithComma = categoriesWithComma + m.AutoplayData2.videoDetailsResponse.categories[i].category_name + ","
'     end for

'     if m.AutoplayData2.videoDetailsResponse.season <> invalid
'         season = m.AutoplayData2.videoDetailsResponse.season
'     else
'         season = ""
'     end if
'     if m.AutoplayData2.videoDetailsResponse.video_order <> invalid
'         video_order = m.AutoplayData2.videoDetailsResponse.video_order
'     else
'         video_order = ""
'     end if
'     sec = CreateObject("roRegistrySection", getAppKey())
'     sec.Write("videoID", m.AutoplayData.video_id.toStr().Trim())
'     sec.Write("videoTITLE", m.AutoplayData2.videoDetailsResponse.video_title)
'     sec.Write("channelID", m.EventDetailApiTask.channel_id)
'     sec.Write("category", categoriesWithComma.Trim())
'     sec.Flush()


'     if getCountrycode() = "EU"
'         consent = "1"
'         GDPR = "1"
'     else
'         consent = "0"
'         GDPR = "0"
'     end if

'     dt = CreateObject("roDateTime")
'     timestamp = dt.AsSeconds().ToStr()
'     timeStampPre = dt.AsSeconds()
'     timeStampMilliSeconds = (timeStampPre.ToStr() + "000")
'     ' adUURRLL = VODcontent.ad_link
'     adUURRLL = m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data.ad_link
'     ?"hhj"

'     finalAdURL = ""
'     if adUURRLL <> invalid

'         temp1 = strReplace(adUURRLL, "[WIDTH]", macroWidth)
'         temp2 = strReplace(temp1, "[HEIGHT]", macroHeight)
'         temp3 = strReplace(temp2, "[DNT]", macroDNT)
'         temp4 = strReplace(temp3, "[IP_ADDRESS]", macroIP)
'         temp5 = strReplace(temp4, "[USER_AGENT]", macroUserAgent)
'         temp6 = strReplace(temp5, "[DEVICE_IFA]", macroADID.Escape())
'         temp7 = strReplace(temp6, "[UUID]", macroUUID)
'         temp8 = strReplace(temp7, "[USER_ID]", macrouserID.Trim())
'         temp9 = strReplace(temp8, "[REGION]", getRegion().Escape())
'         temp10 = strReplace(temp9, "[COUNTRY]", getCountrycode().Escape())
'         temp11 = strReplace(temp10, "[DEVICE_ID]", macroUUID)
'         temp12 = strReplace(temp11, "[DEVICE_MODEL]", macroDevModel.Escape())
'         temp13 = strReplace(temp12, "[CHANNEL_ID]", macroChannelID.Trim())
'         temp14 = strReplace(temp13, "[VIDEO_ID]", macroVideoID.Trim())
'         temp15 = strReplace(temp14, "[APP_STORE_URL]", getRokuChannelStoreURL())
'         temp16 = strReplace(temp15, "[DEVICE_MAKE]", "RA")
'         temp17 = strReplace(temp16, "[BUNDLE]", getBundleID())
'         temp18 = strReplace(temp17, "[LATITUDE]", getLatitude().Trim())
'         temp19 = strReplace(temp18, "[LONGITUDE]", getLongitude().Trim())
'         temp20 = strReplace(temp19, "[KEYWORDS]", categoriesWithComma.Trim().Escape())
'         temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle().Escape())
'         temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
'         temp23 = strReplace(temp22, "[CITY]", getCity().Escape())
'         temp24 = strReplace(temp23, "[SHOW_ID]", m.AutoplayData2.videoDetailsResponse.show_id.toStr().Trim())
'         temp25 = strReplace(temp24, "[CATEGORIES]", categoriesWithComma.Escape())
'         temp26 = strReplace(temp25, "[CONTENT_TITLE]", m.AutoplayData2.videoDetailsResponse.video_title.Trim().Escape())
'         temp27 = strReplace(temp26, "[VIDEO_TITLE]", m.AutoplayData2.videoDetailsResponse.video_title.Trim().Escape())
'         temp28 = strReplace(temp27, "[VIDEO_URL]", m.AutoplayData.video_name)
'         temp29 = strReplace(temp28, "[CHANNEL_NAME]", getAppTitle().Escape())
'         temp30 = strReplace(temp29, "[AUTOPLAY]", "0")
'         temp31 = strReplace(temp30, "[MUTE]", "0")
'         temp32 = strReplace(temp31, "[DEVICE_IFA]", di.GetRIDA())
'         temp33 = strReplace(temp32, "[OS]", "rokuos")
'         temp34 = strReplace(temp33, "[OS_VERSION]", di.GetOSVersion().major)
'         temp35 = strReplace(temp34, "[ISP]", getIsp().Escape())
'         temp36 = strReplace(temp35, "[DEVICE_BRAND_NAME]", "roku")
'         temp37 = strReplace(temp36, "[LMT]", "0")
'         temp38 = strReplace(temp37, "[SEASON]", season.ToStr().Trim().Escape())
'         temp39 = strReplace(temp38, "[EPISODE]", video_order.ToStr().Trim().Escape())
'         temp40 = strReplace(temp39, "[SERIES]", m.AutoplayData2.videoDetailsResponse.video_title.Escape())
'         temp41 = strReplace(temp40, "[PRODUCER]", "".Trim().Escape())
'         temp42 = strReplace(temp41, "[IS_LIVE]", "0")
'         temp43 = strReplace(temp42, "[RATING]", "".Trim().Escape())
'         temp44 = strReplace(temp43, "[LANGUAGE]", "English")
'         temp45 = strReplace(temp44, "[AD_POSITION]", "7")
'         temp46 = strReplace(temp45, "[PLACEMENT]", "1")
'         temp47 = strReplace(temp46, "[SKIPPABLE]", "0")
'         temp48 = strReplace(temp47, "[PRODUCTION_QUALITY]", "1")
'         temp49 = strReplace(temp48, "[CONSENT]", consent)
'         temp50 = strReplace(temp49, "[GDPR]", GDPR)
'         temp51 = strReplace(temp50, "[COPPA]", "1")
'         temp52 = strReplace(temp51, "[DNT]", "1")
'         temp53 = strReplace(temp52, "[CACHEBUSTER]", timeStampMilliSeconds)
'         temp54 = strReplace(temp53, "[TIMESTAMP]", timestamp)
'         temp55 = strReplace(temp54, "[TIMESTAMP_MS]", timeStampMilliSeconds)
'         temp56 = strReplace(temp55, "[DESCRIPTION]", m.AutoplayData2.videoDetailsResponse.video_description.Escape())
'         temp57 = strReplace(temp56, "[APPID]", getappId())
'         temp58 = strReplace(temp57, "[US_PRIVACY]", "")

'         ?temp58
'         ?"temp58"

'         finalAdURL = strReplace(temp58, "[DURATION]", Str(macroDuration).Trim())
'         ?"[DURATION]"

'     end if

'     ?Str(macroDuration).Trim()
'     ?"Str(macroDuration).Trim()"

'     ?"finalAdURL printed: "
'     ? "********************"
'     ? finalAdURL
'     ? "********************"
'     videoContent = {
'         streamFormat: "m3u8",
'         titleSeason: "",
'         HDBranded: true,
'         ClosedCaptions: true,
'         IsHD: true,
'         title: m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse.video_title,
'         url: m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse.video_name,
'         categories: categoriesWithComma
'         nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
'         nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
'         nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
'         length: m.AutoplayData2.videoDetailsResponse.video_duration.toStr().Trim()
'     }
'     ' videoContent.ClosedCaptions = True
'     subtitle_config = m.AutoplayData2.videoDetailsResponse.subtitles

'     SubtitleTracks = []
'     for each item in m.AutoplayData2.videoDetailsResponse.subtitles
'         subtitleItem = {}
'         subtitleItem.Language = item.language_name
'         subtitleItem.Description = item.short_code
'         subtitleItem.TrackName = item.subtitle_url
'         SubtitleTracks.push(subtitleItem)
'     end for

'     content = CreateObject("roSGNode", "VideoContent")
'     content.setFields(videoContent)
'     content.addFields({
'         "is_live": 0,
'         "audio_languages": m.AutoplayData2.videoDetailsResponse.audio_languages,
'         "category": categoriesWithComma.Trim()

'     })
'     ?categoriesWithComma.Trim()
'     ?"categoriesWithComma.Trim()"
'     content.ad_url = finalAdURL.EncodeUri()
'     if subtitle_config <> invalid
'         content.ClosedCaptions = True
'         content.globalCaptionMode = "On"
'         content.HDBranded = True
'         content.IsHD = True
'         content.SubtitleConfig = subtitle_config
'         content.SubtitleTracks = SubtitleTracks
'         content.SubtitleTrack = SubtitleTracks
'     end if

'     if m.Player = invalid:
'         m.Player = m.top.CreateChild("Player")
'         m.Player.observeField("state", "PlayerStateChanged")
'         m.Player.observeField("visible", "onVideoVisibleChange")
'     end if
'     m.Player.content = content
'     m.Player.visible = true
'     ?"m.player printed:..."
'     ?m.Player
'     m.Player.setFocus(true)

'     playBackGroundvideo("")
'     m.backGroundVideo.control = "stop"
'     m.backGroundVideo.visible = false

'     m.Player.watched_duration = m.watched_duration 'setting watched_duration
'     ?"watched_duration_passing_to_videoplayer"
'     ?m.watched_duration


'     m.Player.skipAd = true
'     m.Player.control = "play"


'     m.Player.observeField("visibility", "onPlayerVisibleChange")
'     ' m.Player.observeField("autoplay", "onAutoplay")
'     callAutoplayAPI(macroVideoID)
' end function

