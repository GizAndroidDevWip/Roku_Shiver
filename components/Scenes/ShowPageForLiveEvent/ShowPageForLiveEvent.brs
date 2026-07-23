sub init()
    ?"show init"
    m.ShowFetcher = CreateObject("roSGNode", "ShowFetcher")
    m.ShowFetcher.observeField("LiveEventResponseData", "onContentChanged")
    m.SimilarShows = CreateObject("roSGNode", "SimilarShows")
    m.SimilarShows.observeField("similarShowsApiListContent", "onSimilarShowChanged")
    m.UserSubscription = CreateObject("roSGNode", "UserSubscription")
    m.UserSubscription.observeField("SubsResponse", "ifSubscriptionCheckNeeded") ' uncomment this to bypass subscription
    m.VideoSubscriptionTask = CreateObject("roSGNode", "VideoSubscriptionTask")

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


    ' m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    ' m.buttonsLabelList.ObserveField("buttonSelected", "OnPlaylist")

    m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    m.buttonsLabelList.ObserveField("itemSelected", "onButtonsLabelList")
    m.buttonsLabelList.ObserveField("itemFocused", "onButtonsLabelListFocused")
    m.buttonsLabelList.focusBitmapBlendColor = getButtonSelectionColor()
    initialiseButtonsLabelList()

    m.autoThumb = m.top.findNode("autoThumb")



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
    m.labelForSpecialPages = m.top.findNode("labelForSpecialPages")
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
            scrollDownAnimation()
            whichNodeToSetFocusBasedOnScreenScrolledStatus()
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
    ' onButtonLabelListPlayClicked()
    ifSubscriptionCheckNeededForButtonClick()
    if idSelected = "PLAY"
        '     OnPlaylistremove()
        ' else if idSelected = "ADDTOMYLIST"
        '     OnPlaylist()
        ' else if idSelected = "SUBSCRIBE"
        '     ' if isGuest() = "true"
        '     '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        '     '     m.top.gotoLandingScene = true
        '     ' else
        '     '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        '     '     m.top.goToPaymentDescriptionScreen = VODcontent.video_id
        '     ' end if
        '     onButtonLabelListPlayClicked()
        ' else if idSelected = "REMOVEFROMMYLIST"
        '     OnPlaylistremove()
        ' else if idSelected = "WATCHTRAILER"
        '     OnTrailer()
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

    ' m.AddToMyList = createObject("RoSGNode", "ContentNode")
    ' m.AddToMyList.id = "ADDTOMYLIST"
    ' m.AddToMyList.title = "Add To My ListTTTT"
    ' m.AddToMyList.HDLISTITEMICONURL = "pkg:/images/plus.png"
    ' m.AddToMyList.HDLISTITEMICONSELECTEDURL = "pkg:/images/plus.png"

    m.Subscribe = createObject("RoSGNode", "ContentNode")
    m.Subscribe.id = "SUBSCRIBE"
   
   
    m.Subscribe.title = getText("subscribe")
    
    m.Subscribe.HDLISTITEMICONURL = "pkg:/images/premium_icon.png"
    m.Subscribe.HDLISTITEMICONSELECTEDURL = "pkg:/images/premium_icon.png"

    ' m.RemoveFromMylist = createObject("RoSGNode", "ContentNode")
    ' m.RemoveFromMylist.id = "REMOVEFROMMYLIST"
    ' m.RemoveFromMylist.title = "Remove From My List"
    ' m.RemoveFromMylist.HDLISTITEMICONURL = "pkg:/images/minus.png"
    ' m.RemoveFromMylist.HDLISTITEMICONSELECTEDURL = "pkg:/images/minus.png"

    ' m.WatchTrailer = createObject("RoSGNode", "ContentNode")
    ' m.WatchTrailer.id = "WATCHTRAILER"
    ' m.WatchTrailer.title = "Watch Trailer"
    ' m.WatchTrailer.HDLISTITEMICONURL = "pkg:/images/playbutton2.png"
    ' m.WatchTrailer.HDLISTITEMICONSELECTEDURL = "pkg:/images/playbutton2.png"


    ' addbuttonLabelList([
    '     m.playNow,
    '     m.AddToMyList,
    '     m.WatchTrailer
    ' ])
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
    if(added = "added")
        modifyButtonLabelList(m.RemoveFromMylist, 1)
    else
        modifyButtonLabelList(m.AddToMyList, 1)
    end if
end sub

sub onPlaylistaddchanged()

    added = m.playListadd.PlaylistResponse
    if(added = "added")
        modifyButtonLabelList(m.RemoveFromMylist, 1)
    else
        modifyButtonLabelList(m.AddToMyList, 1)
    end if
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




sub onVisibleChangetrailer()
    videoCount = m.ShowFetcher.LiveEventResponseData.getChild(0).GetChildCount()

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




' subscription required checking
sub ifSubscriptionCheckNeededForButtonClick()
    if (getSubscriptionRequired() = "true")
        if isGuest() = "true"
            m.loadingIndicator.visible = false
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.top.gotoLandingScene = true
            m.Video.control = "stop"
            m.Video.content = invalid
            m.Video.visible = true

        else if isGuest() = "false"
            VODcontent = returnTheCurrentFocusedData()
            ?"jjnm"
            m.LINEAREVENTsubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
            m.LINEAREVENTsubscriptionTask.eventId = str(m.top.upcomingEventId)
            ?"uiui"
            m.LINEAREVENTsubscriptionTask.observeField("notifyClick", "checkSubscriptionOfLiveEvent")
            m.LINEAREVENTsubscriptionTask.callFunc("runVideoSubscriptionTask", "")

        end if

    else
        if isGuest() = "true"
            ifRegisterationMandatoryOrNot() '************** Registeration Mandatory checking

        else
            playLiveEvent()
        end if
    end if
end sub




' Registerartion Mandatory checking
sub ifRegisterationMandatoryOrNot()
    if (getRegisterationMandatory() = "true")
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
    else
        playLiveEvent()
    end if
end sub





function OnSubscriptionComplete()

end function


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

    end if

end sub

sub onDialogNoSelected()
    ?"onDialogNoSelected"
    VODcontent = returnTheCurrentFocusedData()

    ' playvideo()
    if m.isWatchWithOutAdsDialogRectVisible = true

    else if m.continueWatchingDialogVisible = true ' this is resume case when resume button is pressed
        ?"m.continueWatchingDialogVisible = true"

    end if

end sub

sub showPaymentPage() ' show payment page
    ?"showPaymentPage called"
    m.loadingIndicator.visible = false
    VODcontent = returnTheCurrentFocusedData()
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.top.goToPaymentDescriptionScreen = VODcontent.video_id
end sub



sub hideShowPage()
    ?"hideShowPage called"
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true
    m.RowList.visible = false
    m.RowList.setfocus(false)
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
    print "RUN ShowContentRequest"
    m.ShowFetcher.ContentRequest = m.top.start
    m.ShowFetcher.taskType = "ContentRequest"
    m.ShowFetcher.itemType = "LIVE_EVENT"
    m.ShowFetcher.upcomingEventId = m.top.upcomingEventId
    m.ShowFetcher.callFunc("runShowFetcherTask", "")
end sub




sub OnLoginFinished()
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.top.gotoLandingScene = false
    ' m.loadingIndicator.visible = true
    m.RowList.visible = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    m.top.subscontent = 1

    section = CreateObject("roRegistrySection", getAppKey()) ' to mainly notify homescreen to refresh homescreen
    section.Write("isJustLoggedIn", "yes")
end sub




sub OnRegFinished()
    m.top.gotoLandingScene = false

    ' m.loadingIndicator.visible = true
    m.RowList.visible = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
    m.count = 0
    m.count2 = 0
    m.count3 = 0
    m.count4 = 0
    m.top.subscontent = 1
    section = CreateObject("roRegistrySection", getAppKey()) ' to mainly notify homescreen to refresh homescreen
    section.Write("isJustLoggedIn", "yes")
end sub



sub onContentChanged()
    print "RUN ContentRequest true"
    m.buttonsLabelListItems = []
    m.buttonsLabelListItems.push(m.playNow)
    m.top.ratingBoolean = false
    m.loadingIndicator.visible = false
    m.count3 = 1
    m.AdTimer.control = "start"
    m.Video.visible = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
    m.RowList.visible = true
    m.image.visible = true
    m.Title1.visible = true
    m.Episode.visible = true
    m.descri.visible = true
    m.descri_title.visible = true
    m.resolution.visible = true
    m.Year.visible = false
    m.Director.visible = true

    m.Duration.visible = false'
    m.rating.visible = true
    m.years.visible = false
    m.time.visible = true
    m.prod.visible = true

    ?m.ShowFetcher.LiveEventResponseData
    ?"m.ShowFetcher.LiveEventResponseData"
    ' if m.ShowFetcher.LiveEventResponseData.getChild(0).GetChildCount() > 1
    ' if m.ShowFetcher.LiveEventResponseData[0][0]
    '     RowlistContent = m.ShowFetcher.LiveEventResponseData
    '     m.issinglevideo = 0
    ' else
    '     content = createObject("RoSGNode", "ContentNode")
    '     RowlistContent = content
    '     m.issinglevideo = 1
    ' end if


    ' subscriptionContent = m.ShowFetcher.LiveEventResponseData.getChild(0).getChild(0).subscriptionData
    ' m.subscriptionList.content = subscriptionContent


    ' m.RowList.content = RowlistContent
    ' m.RowList.numRows = 2

    ' VODcontent = m.ShowFetcher.LiveEventResponseData.getChild(0).getChild(0)
    VODcontent = m.ShowFetcher.LiveEventResponseData[0][0]
    ?VODcontent
    ?"VODcontent"

    m.Title1.text = VODcontent.show_name
    ' m.bannerPoster.uri = VODcontent.thumbnail
    m.labelForSpecialPages.text = VODcontent.schedule_time

    m.backGroundBannerPoster.uri = VODcontent.logo_thumb
    if VODcontent.DESCRIPTION <> invalid and not VODcontent.DESCRIPTION = ""
        m.descri.text = VODcontent.description
    else
        m.descri_title.visible = false
        m.descri.text = ""
    end if
    ' videoCount = m.ShowFetcher.LiveEventResponseData.getChild(0).GetChildCount()
    ' showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount)

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


    m.LINEAREVENTsubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
    m.LINEAREVENTsubscriptionTask.eventId = str(m.top.upcomingEventId)
    m.LINEAREVENTsubscriptionTask.observeField("notifyClick", "showSubScribeOrPlayNowButtonAndSubscriptionListingLogics") 'SubscriptionedUseronVisibleChange notifyClickForWatchNowOrSubscribeVisibility
    m.LINEAREVENTsubscriptionTask.callFunc("runVideoSubscriptionTask", "")


    'news page visibility controlls
    ' if VODcontent.itemType = "NEWS" or VODcontent.itemType = "news" then
    '     newsHandlingFunction(VODcontent)
    '     playBackGroundvideo(VODcontent.URL)
    '     ' else if VODcontent.itemType = "ENDED_EVENT"
    ' else if VODcontent.itemType = "UPCOMING_EVENT"
    '     upcomingEventHandlingFunction(VODcontent)

    ' if VODcontent.itemType = "LIVE" or VODcontent.itemType = "RTMP" 'for ongoing events
    '     LIVEEVENTHandlingFunction(VODcontent)
    '     ' else
    '     '     if VODcontent.teaser <> invalid
    '     '         m.buttonsLabelListItems.push(m.WatchTrailer)
    '     '     end if
    ' end if

    addbuttonLabelList(m.buttonsLabelListItems)
    ' displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()
    ' SubscriptionedUseronVisibleChange()
    ' ifSubscriptionCheckNeededForButtonDisplay()
    '************** currentVODContentIfSeasonExists - is for saving the last focused data in the rowlist.
    'this is for - if season exists, and we moved focus from labellist to any episode in the rowlist and then come back focus to labellist, then that last focused data to this variable
    ' m.currentVODContentIfSeasonExists = m.ShowFetcher.LiveEventResponseData.getChild(0).getChild(0)
end sub

' sub onSimilarShowChanged()
'     RowlistContent = m.SimilarShows.similarShowsApiListContent
'     if RowlistContent <> invalid and RowlistContent.getChild(0).GetChildCount() > 0 then
'         m.RowList.content.insertChild(RowlistContent.getChild(0), m.RowList.content.getChildCount())

'     end if

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
        if key = "down"
            if m.buttonsLabelList.visible = true then
                m.buttonsLabelList.setFocus(true)

            end if
            ?"m.buttonPlaylist.hasFocus()"
            ' m.playNowButton.focusFootprintBitmapUri = "pkg:/images/img_loginbg.png"

        end if
    end if
    ' if key = "up" or key = "down"
    ' if m.PaymentDescription.visible = false then
    if m.RowList.hasFocus() = true and key = "up"
        m.mainrectscrolldownTimer.control = "start"

        ' else if m.buttonsLabelList.hasFocus() = true and key = "down"
        if m.rowlist.content.getchildCount() > 0
            m.mainrectscrollupTimer.control = "start"
        end if


        ' else if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true
        '     handled = true
        ' end if

        ' end if
        handled = true
        ' else if key = "back"

        if m.isWatchWithOutAdsDialogRectVisible = true
            ?"isWatchWithOutAdsDialogRectVisible back pressed"
            m.dialogbg_rect.visible = false
            m.isWatchWithOutAdsDialogRectVisible = false
            m.continueWatchingDialogVisible = false
            m.RowList.visible = true
            whichNodeToSetFocusBasedOnScreenScrolledStatus()


            m.videoSubscriptionData = invalid
            m.VideoSubscriptionTask = invalid
            handled = true

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
        end if

        if m.continueWatchingDialogVisible = false and m.isWatchWithOutAdsDialogRectVisible = false
            ?"back pressed on base showpage screen"
            playBackGroundvideo("")
        end if

        ' else if key = "left"

        if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true
            ?"left"
            m.NoButton.setFocus(true)
            handled = true

        end if

        ' else if key = "right"

        ' if m.isWatchWithOutAdsDialogRectVisible = true or m.continueWatchingDialogVisible = true
        '     ?"right"
        '     m.YesButton.setFocus(true)
        '     handled = true
        ' end if

    end if
    ' end if
    if press
        m.buttonsLabelList.setFocus(true)
        ' if m.RowList.hasFocus() = false
        '     if key = "left" and m.isWatchWithOutAdsDialogRectVisible = true or key = "left" and m.continueWatchingDialogVisible = true
        '         ?"left"
        '         m.NoButton.setFocus(true)
        '         handled = true
        '     else if key = "right" and m.isWatchWithOutAdsDialogRectVisible = true or key = "right" and m.continueWatchingDialogVisible = true
        '         ?"right"
        '         m.YesButton.setFocus(true)
        '         handled = true
        '     end if

        ' end if
    end if
    ' if press
    '     if m.RowList.hasFocus() = false
    '         if key = "left" and m.isWatchWithOutAdsDialogRectVisible = true
    '             ?"left"
    '             m.NoButton.setFocus(true)
    '             handled = true
    '         else if key = "right" and m.isWatchWithOutAdsDialogRectVisible = true
    '             ? "right"
    '             m.YesButton.setFocus(true)
    '             handled = true

    '         end if
    '     end if
    ' end if
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
        m.image.visible = true
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
            m.image.visible = true
            m.Episode.visible = true
            m.Image.uri = VODcontent.image_title

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

               
                   cast2=getText("cast")
              
                

                
                m.cast.Text = cast2 + ":" + " " + VODcontent.show_cast
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
            m.image.visible = true
            m.Title1.visible = true
            if(VODcontent.producer <> invalid)
                m.Episode.visible = true
                m.Episode.text = ""
            else
                m.Episode.visible = false
            end if
            m.Title1.text = rowItemFocusedNow.title 'VODcontent.show_name 'UCase(VODcontent.title)

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



' function onRowItemSelected() as void
'     m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST" ' changing flag for rowlist clicked
'     ?"onRowItemSelected called"
'     playBackGroundvideo("")
'     VODcontent = returnTheCurrentFocusedData()

'     if VODcontent.itemtype = "shows"
'         m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
'         m.top.gotoShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo = true
'     else
'         valueofcat = VODcontent.TITLESEASON
'         sec = CreateObject("roRegistrySection", getAppKey())
'         if sec.Exists("category")
'         else
'             sec = CreateObject("roRegistrySection", getAppKey())
'             sec.Write("category", valueofcat)
'             sec.Flush()
'         end if

'         m.UserSubscription.callFunc("runUserSubscription", "")
'         videoCount = m.ShowFetcher.LiveEventResponseData.getChild(0).GetChildCount()
'         ' showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount)
'     end if
' end function


'this is when play button in labellist clicked
function onButtonLabelListPlayClicked() as void
    ?"onButtonLabelListPlayClicked called"

    ' playBackGroundvideo("")
    ' VODcontent = returnTheCurrentFocusedData()
    VODcontent = m.ShowFetcher.LiveEventResponseData[0][0]
    ?VODcontent

    ' if VODcontent.itemtype = "shows" ' ******you may also clicked
    if VODcontent.itemtype = "LIVE"
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo = true
    end if

    ' else '**************normal shows clicked
    '     valueofcat = VODcontent.TITLESEASON
    '     sec = CreateObject("roRegistrySection", getAppKey())
    '     if sec.Exists("category")
    '     else
    '         sec = CreateObject("roRegistrySection", getAppKey())
    '         sec.Write("category", valueofcat)
    '         sec.Flush()
    '     end if
    '     m.UserSubscription.callFunc("runUserSubscription", "")
    ' end if
end function




sub playtrailer()
    m.RowList.visible = false
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




sub focusedSecondRow()
    VODcontent = returnTheCurrentFocusedData()
    m.descri.visible = true
    m.descri_title.visible = true
end sub





sub onPlayerVisibleChange()
    ?"onPlayerVisibleChange called"
    m.autoThumb.visible = false
    m.RowList.visible = true


    whichNodeToSetFocusBasedOnScreenScrolledStatus()
    m.BottomBar.visible = true
    m.count = 0
    m.count2 = 0
    m.ShowBar.control = "start"
    m.loadingIndicator.visible = false
    if m.Player.visibility = false then
        m.count = 0
        m.count2 = 0
        whichNodeToSetFocusBasedOnScreenScrolledStatus()
    end if
    videoCount = m.ShowFetcher.LiveEventResponseData.getChild(0).GetChildCount()
    showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount)
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
        convertedString = a[0] + "h" + " " + a[1] + "m" + " " + a[2] + "s" + " "

        return convertedString
    else
        return ""
    end if

end function




sub upcomingEventHandlingFunction(VODContent)
    ?"upcomingEventHandlingFunction called"
    m.rectangleForSmallDetails.visible = false
    m.buttonRectangle.visible = false
    m.bannerPoster.uri = VODcontent.HDPOSTERURL
    m.descri.text = VODcontent.DESCRIPTION
    m.playNowButton.visible = false
    m.descri.height = 325
    m.RowList.unobserveField("rowItemSelected")
    ' dt = CreateObject("roDateTime")
    ' dt.fromISO8601String(VODContent.schedule_time)
    ' ?dt.asSeconds()
    ' ?dt
    m.labelForSpecialPages.visible = true
    m.labelForSpecialPages.text = VODContent.day + " " + VODContent.schedule_time
    ?"VODContent.day + " " + VODContent.schedule_time"
    ?VODContent.day + " " + VODContent.schedule_time
end sub




sub LIVEEVENTHandlingFunction(VODContent)
    ?"LIVEEVENTHandlingFunction called"
    ' m.rectangleForSmallDetails.visible = true
    ' m.buttonRectangle.visible = true
    ' m.backGroundBannerPoster.visible = true
    ' m.backGroundBannerPoster.uri = VODcontent.thumbnail
    ' m.descri.text = VODcontent.DESCRIPTION
    ' m.playNowButton.visible = false
    ' m.descri.height = 325
    ' dt = CreateObject("roDateTime")
    ' dt.fromISO8601String(VODContent.schedule_time)
    ' ?dt.asSeconds()
    ' ?dt
    ' m.labelForSpecialPages.visible = true
    ' m.labelForSpecialPages.text = VODContent.day + " " + VODContent.schedule_time
    ' ?"VODContent.day + " " + VODContent.schedule_time"
    ' ?VODContent.day + " " + VODContent.schedule_time



    ' addbuttonLabelList([m.playNow])
end sub





sub newsHandlingFunction(VODContent)
    ?"itemType = NEWS"
    ' ?m.RowList.content.getChild(m.RowList.rowItemFocused[0])
    ' ?m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    m.buttonRectangle.visible = false
    m.rectangleForSmallDetails.visible = false
    m.descri.text = VODContent.DESCRIPTION
    m.descri.height = 325
    m.labelForSpecialPages.visible = true
    m.labelForSpecialPages.text = VODContent.duration_text
    rowItemFocusedNow = m.RowList.content.getChild(0).getChild(0)
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




sub showPlayNowButtonInCaseThereIsJustOneVideoAvailable(videoCount as integer)
    ' if videoCount = 1
    '     ?"videoCount = 1"
    '     m.RowList.visible = false
    '     m.playNowButton.visible = true
    ' else
    '     ?"videoCount = 1 else"zz
    '     m.RowList.visible = true
    '     m.playNowButton.visible = false
    ' end if
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
    m.scrollUpAnimation.control = "start"
    m.isScreenIsNowScrolledUp = true
    whichNodeToSetFocusBasedOnScreenScrolledStatus()
end sub

'starts the scrollDown animation
sub scrollDownAnimation()
    m.scrollDownAnimation.control = "start"
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



'**********play button or subscribe clicked
sub checkSubscriptionOfLiveEvent()
    ?"checkSubscriptionOfLiveEvent called : show"
    if m.LINEAREVENTsubscriptionTask.videoSubs = true
        ?"checkSubscriptionOfLiveEvent if"
        playLiveEvent()
    else
        ?"checkSubscriptionOfLiveEvent else"
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.goToPaymentDescriptionScreenForEvent = Str(m.top.upcomingEventId)
    end if
end sub


sub playLiveEvent()
    ' VODcontent = m.ShowFetcher.LiveEventResponseData.getChild(0).getChild(0)
    videoContent = {
        streamFormat: "m3u8"
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: VODcontent.show_name,
        url: VODcontent.live_url,
        categories: ""
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.

    }

    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "is_live": "1",
        "eventId": m.top.upcomingEventId
    })
    content.ad_url = ""

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
    m.Player.control = "play"
    m.Player.skipAd = false
    m.Player.control = "play"
    m.Player.observeField("visibility", "onPlayerVisibleChange")
end sub



'**************retruns the current focused data. It descrimininates from rowlist or buttonlabellist has the focus.
'it season exists, (singlevideo = 0) it takes that also into consideration.
function returnTheCurrentFocusedData()
    ?"returnTheCurrentFocusedData called"
    if m.issinglevideo = 1

        if m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
            ?"returnTheCurrentFocusedData: ROWLIST m.issinglevideo = 1"
            m.CurrentFocusedData = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        else if m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
            ' if m.CurrentFocusedData = invalid
            ?"returnTheCurrentFocusedData: BUTTON_LABELLIST m.issinglevideo = 1"
            m.CurrentFocusedData = m.ShowFetcher.LiveEventResponseData.getChild(0).getChild(0)
            ' end if
        end if
    else if m.issinglevideo = 0
        if m.top.isRowlistOrLabelListIsInFocusNow = "ROWLIST"
            ?"returnTheCurrentFocusedData: ROWLIST m.issinglevideo = 0"
            m.CurrentFocusedData = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
        else if m.top.isRowlistOrLabelListIsInFocusNow = "BUTTON_LABELLIST"
            
            ' if m.CurrentFocusedData = invalid
            ?"returnTheCurrentFocusedData: BUTTON_LABELLIST m.issinglevideo = 0"
            if m.currentVODContentIfSeasonExists <> invalid '********if currentVODContentIfSeasonExists is invalid, data in zeroth position is taken
                m.CurrentFocusedData = m.currentVODContentIfSeasonExists '********** currentVODContentIfSeasonExists - is the last focused vodcontent data when focus moved to rowlist any of the episode and come back
            else
                m.CurrentFocusedData = m.ShowFetcher.LiveEventResponseData.getChild(0).getChild(0)
                ' m.CurrentFocusedData= m.ShowFetcher.LiveEventResponseData[0][0]
            end if
            ' end if
        end if
    end if
    return m.CurrentFocusedData
end function



'******** function to display subscription listing in show page . will call LINEAREVENTsubscriptionTask and if subscribed user, then subscription listings wont be shown
' function displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction()
'     ?"displaySubscriptionTitlesBasedOnUsersSubscriptionStatusFunction called"
'     ' ?"m.VideoSubscriptionTask.videoDetailsResponse"m.VideoSubscriptionTask.videoDetailsResponse
'     ?"m.currentUserId.Trim()";m.currentUserId.Trim()
'     ?"getUserIdana().Trim()";getUserIdana().Trim()

'     ' VODcontent = returnTheCurrentFocusedData()
'     ?"kjkk"
'     if(m.VideoSubscriptionTaskNeedsToRunOnceAgain = false)'if((m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.videoDetailsResponse <> invalid) and m.currentUserId.Trim() = getUserIdana().Trim())'(not m.VideoSubscriptionTaskNeedsToRunOnceAgain = true) 'if subscription api had called called alreadyy and data exists , then videosubscription is not called, else it is called

'         SubscriptionedUseronVisibleChange()
'     else
'         m.LINEAREVENTsubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
'         m.LINEAREVENTsubscriptionTask.eventId = str(m.top.upcomingEventId)
'         m.LINEAREVENTsubscriptionTask.observeField("notifyClick", "SubscriptionedUseronVisibleChange") 'SubscriptionedUseronVisibleChange notifyClickForWatchNowOrSubscribeVisibility
'         m.LINEAREVENTsubscriptionTask.callFunc("runVideoSubscriptionTask", "")

'         m.VideoSubscriptionTaskNeedsToRunOnceAgain = false
'         m.currentUserId = getUserIdana()
'     end if
' end function



'**********this just checks is user subscribed based on show or episodes | with show level subscribtions or so..
function SubscriptionedUseronVisibleChange()
    ?"SubscriptionedUseronVisibleChange called"
    ' VODcontent = returnTheCurrentFocusedData()
    ?"VODcontent.subscriptionData.getchild(0).getchildcount()";
    ' VODcontent.subscriptionData.getchild(0).getchildcount()
    isSubcribed = false

    videoSubscriptionCount = 0
    if m.LINEAREVENTsubscriptionTask <> invalid and m.LINEAREVENTsubscriptionTask.eventSubscriptionResponseDataUnParsed <> invalid and m.LINEAREVENTsubscriptionTask.eventSubscriptionResponseDataUnParsed.count() <> 0
        ?"jjjjjjjjjjj"
        videoSubscriptionCount = m.LINEAREVENTsubscriptionTask.eventSubscriptionResponseDataUnParsed.count()
        ?"jkkk"
        if m.LINEAREVENTsubscriptionTask.userSubIDS <> invalid
            ?"yuyuu"
            userSubIDS = m.LINEAREVENTsubscriptionTask.userSubIDS
            eventSubscriptionResponseDataUnParsed = m.LINEAREVENTsubscriptionTask.eventSubscriptionResponseDataUnParsed

            for i = 0 to userSubIDS.Count() - 1
                for j = 0 to videoSubscriptionCount - 1
                    if userSubIDS[i] <> invalid and eventSubscriptionResponseDataUnParsed[j] <> invalid
                        if userSubIDS[i] = eventSubscriptionResponseDataUnParsed[j].subscription_id then
                            ?"subscribed !!"
                            isSubcribed = true
                        end if
                    end if
                end for
            end for
        end if

    else '**********video has no subscription case
        ?"klll"
        isSubcribed = true ' *****if video has no subscriptions then subscribed flag is set to true
        ?"hjjhh"
    end if


    ' if isSubcribed=true and isGuest() = "false" and m.LINEAREVENTsubscriptionTask.userSubIDS<>invalid and m.LINEAREVENTsubscriptionTask.userSubIDSCount>0
    '     modifyButtonLabelList(m.playNow, 0)
    '     m.subscriptionList.visible = false


    ?"uyuyu"
    m.buttonsLabelList.visible = true
    if(isGuest() = "false")

        if isSubcribed = true
            ' m.buttonsLabelList.setFocus(true)
            modifyButtonLabelList(m.playNow, 0)

            ' m.subscriptionList.visible = false
        else
            ' m.buttonsLabelList.setFocus(true)
            modifyButtonLabelList(m.Subscribe, 0)
            ' m.subscriptionList.visible = true
        end if

    else

        modifyButtonLabelList(m.Subscribe, 0)
        ' m.subscriptionList.visible = true
    end if

end function




' This Logic has been uploaded to google drive
' https://drive.google.com/file/d/1OuEHNm-3AWgTl2zElm4mV0bZpvDXpaKW/view?usp=sharing
sub showSubScribeOrPlayNowButtonAndSubscriptionListingLogics()'isSubcribed, videoSubscriptionCount
    ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics called"
    ' ?"videoSubscriptionCount: ";videoSubscriptionCount
    ' ' subscriptionContent = VODcontent.subscriptionData
    ' m.subscriptionList.content = subscriptionContent
    if (isGuest() = "false")
        if (m.LINEAREVENTsubscriptionTask.userSubIDSCount <> invalid and m.LINEAREVENTsubscriptionTask.userSubIDSCount > 0)
            if (m.LINEAREVENTsubscriptionTask.videoSubIDSCount > 0)
                if (m.LINEAREVENTsubscriptionTask.videoSubs = true) 'm.LINEAREVENTsubscriptionTask.videoSubs = true
                    ' print"Display Watch Now Button"
                    ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics000"
                    modifyButtonLabelList(m.playNow, 0)
                    ' m.subscriptionList.visible = false
                    m.buttonsLabelList.visible = true
                else
                    ' print"Show subscribe button"
                    ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics111"
                    modifyButtonLabelList(m.Subscribe, 0)
                    ' m.subscriptionList.visible = true
                    m.buttonsLabelList.visible = true
                end if
            else
                ' print"Display Watch Now Button"
                ' playvideo()
                ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics222"
                modifyButtonLabelList(m.playNow, 0)
                ' m.subscriptionList.visible = false
                m.buttonsLabelList.visible = true
            end if
        else
            if (m.LINEAREVENTsubscriptionTask.videoSubIDSCount > 0)
                ' print"Show subscribe Button"
                ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics444"
                modifyButtonLabelList(m.Subscribe, 0)
                ' m.subscriptionList.visible = true
                m.buttonsLabelList.visible = true
            else
                ' print "Display Watch Now Button"
                ' playvideo()
                ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics555"
                modifyButtonLabelList(m.playNow, 0)
                ' m.subscriptionList.visible = false
                m.buttonsLabelList.visible = true
            end if
        end if
    else if(isGuest() = "true")
        if (m.LINEAREVENTsubscriptionTask.videoSubIDSCount > 0)
            ' print "Show Subscribe Button"
            ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics666"
            modifyButtonLabelList(m.Subscribe, 0)
            ' m.subscriptionList.visible = true
            m.buttonsLabelList.visible = true
        else
            ' print"Display Watch Now Button"
            ' playvideo()
            ?"showSubScribeOrPlayNowButtonAndSubscriptionListingLogics777"
            modifyButtonLabelList(m.playNow, 0)
            ' m.subscriptionList.visible = false
            m.buttonsLabelList.visible = true
        end if
    end if

    ' if VODcontent.issinglevideo = 0
    '     m.subscriptionList.visible = false
    ' end if
end sub


sub ifSubscriptionCheckNeededForButtonDisplay()
    VODcontent = returnTheCurrentFocusedData()
    m.eventSubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
    m.eventSubscriptionTask.eventId = str(m.top.upcomingEventId)
    m.eventSubscriptionTask.observeField("videoSubs", "buttonVisibilityHandling")
    m.eventSubscriptionTask.callFunc("runVideoSubscriptionTask", "")
end sub

sub buttonVisibilityHandling()
    m.buttonsLabelList.visible = true
    if(isGuest() = "false")

        if m.eventSubscriptionTask.videoSubs = true
            ' m.buttonsLabelList.setFocus(true)
            modifyButtonLabelList(m.playNow, 0)

            ' m.subscriptionList.visible = false
        else
            ' m.buttonsLabelList.setFocus(true)
            modifyButtonLabelList(m.Subscribe, 0)
            ' m.subscriptionList.visible = true
        end if

    else
        if m.eventSubscriptionTask.videoSubIDSCount > 0
            modifyButtonLabelList(m.Subscribe, 0)
        else
            modifyButtonLabelList(m.playNow, 0)
        end if
        ' m.subscriptionList.visible = true
    end if
end sub



sub ifSubscriptionCheckNeededForButtonDisplay2()
    VODcontent = returnTheCurrentFocusedData()
    m.eventSubscriptionTask = CreateObject("roSGNode", "LINEAREVENTsubscriptionTask")
    m.eventSubscriptionTask.eventId = str(m.top.upcomingEventId)
    m.eventSubscriptionTask.observeField("videoSubs", "makeSubscribeButtonVisible")
    m.eventSubscriptionTask.callFunc("runVideoSubscriptionTask", "")
end sub

sub makeSubscribeButtonVisible()
    if m.eventSubscriptionTask.videoSubs = false
        addbuttonLabelList([m.Subscribe])
        m.buttonsLabelList.visible = true
        m.buttonsLabelList.setFocus(true)
    else
        m.buttonsLabelList.visible = false
    end if
end sub



function getLanguageCodeSelected3() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("LANGUAGE_CODE_SELECTED")
        value = ses.Read("LANGUAGE_CODE_SELECTED")
        return value
    else
        return "en"
    end if
end function
