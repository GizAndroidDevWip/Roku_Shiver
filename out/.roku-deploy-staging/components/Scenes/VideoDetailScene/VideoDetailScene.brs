sub init()
    m.Title = m.top.findNode("Title")
    m.Title.Font.size = "62"
    m.resolution = m.top.findNode("resolution")
    m.categories = m.top.findNode("categories")
    m.description = m.top.findNode("description")
    m.bannerPosterGradient = m.top.findNode("bannerPosterGradient")
    m.buttonsLabelList = m.top.findNode("buttonsLabelList")
    m.buttonsLabelList.ObserveField("itemSelected", "onButtonsLabelList")
    m.buttonsLabelList.ObserveField("itemFocused", "onButtonsLabelListFocused")
    m.buttonsLabelList.focusBitmapBlendColor = "#FFFFFF"
    m.buttonsLabelList.focusedColor = "#000000"
    m.buttonsLabelList.color = "#000000"


    '  m.buttonsLabelList.focusedColor = "#000000"
    initialiseButtonsLabelList()
    m.backgroundbanner = m.top.findNode("backGroundBannerPoster")
    m.backgroundbanner.uri = ""
    m.loading = m.top.findNode("loading")
    m.Video = m.top.findNode("Video1")

    m.tagsRowlist = m.top.findNode("tagsRowlist")
    m.tagsRowlist.observeField("RowItemSelected", "onTagsRowItemSelected")
    m.tagsRect = m.top.findNode("tagsRect")
    m.TagsBgPoster = m.top.findNode("TagsBgPoster")
    m.TagsBgPoster.blendColor = "#141414"

    '**autoplay
    m.upnext_video_name = m.top.findNode("upnext_video_name")
    m.UpNext_rect = m.top.findNode("UpNext_rect")
    m.Upnext_mainTitle = m.top.findNode("Upnext_mainTitle")
    
        m.Upnext_mainTitle.text =getText("up_next")
       

        m.Upnext_mainTitle.text = "Up Next"
    

    m.Upnext_mainTitle.color = getButtonSelectionColor()
    m.upnextTimer = m.top.findNode("upNextTimer")
    m.upnextTimer.observeField("fire", "onUpNextTimerFire")

    'Dialog
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")
    m.NoButton = m.top.findNode("NoButton")
    m.NoButton.getChild(0).blendColor = getButtonSelectionColor()
    m.YesButton = m.top.findNode("YesButton")
    m.YesButton.getChild(0).blendColor = getButtonSelectionColor()
    m.dialogmessage_label = m.top.findNode("dialogmessage_label")
    m.cancelbutton_Label = m.top.findNode("cancelbutton_Label")
    m.exitbutton_Label = m.top.findNode("exitbutton_Label")
    m.NoButton.ObserveField("buttonSelected", "onDialogNoSelected")
    m.YesButton.ObserveField("buttonSelected", "onDialogYesSelected")

    m.Title.color = getTextColor()
    m.resolution.color = getTextColor()
    m.categories.color = getTextColor()
    m.description.color = getTextColor()
    m.bannerPosterGradient.blendColor = getBackgroundColor1()

    m.top.observeField("visible", "onVisibleChange")
end sub

sub onVisibleChange()
    if m.top.visible = true
        getVideoDetailsAPI()
    end if
end sub

sub getVideoDetailsAPI() ' initially video details api called to get ideo details data
    ?"getVideoDetailsAPI called"
    m.loading.visible = true
    m.GetVideoDetailsTask = CreateObject("roSGNode", "GetVideoDetailsTask")
    m.GetVideoDetailsTask.videoID = m.top.videoId
    m.GetVideoDetailsTask.observeField("videoDetailsResponse", "onContentChanged")
    m.GetVideoDetailsTask.callFunc("runGetVideoDetailsTask", m.top.show_id)
end sub


sub onContentChanged()
    setMetaData()
    runVideoSubscriptionTask1()
end sub

sub setMetaData()
    ?m.ai_type
    ?"setMetaData called"
    ' ?m.GetVideoDetailsTask.videoDetailsResponse
    m.loading.visible = false
    content = m.GetVideoDetailsTask.videoDetailsResponse
    m.Title.text = content.video_title
    m.description.text = content.video_description
    categorieText = ""
    if m.GetVideoDetailsTask.videoDetailsResponse <> invalid and m.GetVideoDetailsTask.videoDetailsResponse.category_name <> invalid
        for i = 0 to m.GetVideoDetailsTask.videoDetailsResponse.category_name.Count()
            if m.GetVideoDetailsTask.videoDetailsResponse.category_name[i] <> invalid
                if categorieText <> ""
                    categorieText = categorieText + ", " + m.GetVideoDetailsTask.videoDetailsResponse.category_name[i]

                else
                    categorieText = m.GetVideoDetailsTask.videoDetailsResponse.category_name[i]

                end if
            end if
        end for
    end if
    m.concatenatedcategoryText = categorieText
    m.categories.text = m.concatenatedcategoryText
    m.backgroundbanner.uri = content.thumbnail_350_200

    ' m.buttonsLabelListItems.push(m.AddToMyList)
    ' if VODcontent.teaser <> invalid
    '     m.buttonsLabelListItems.push(m.WatchTrailer)
    ' end if
    ' if(content.watchlist_flag <> invalid and content.watchlist_flag = true)
    '     modifyButtonLabelList(m.RemoveFromMylist, 1)
    ' else
    '     modifyButtonLabelList(m.AddToMyList, 1)
    ' end if

    getShowDetailsAPI(content.show_id)
    VODcontent = returnTheCurrentFocusedData()
    if VODcontent <> invalid and VODcontent.video_id <> invalid
        video_id = VODcontent.video_id.ToStr()
    else
        video_id = m.GetVideoDetailsTask.videoID.ToStr()
    end if
    callAutoplayAPI(video_id)
end sub

sub runVideoSubscriptionTask1()
    ' ?"VideoSubscriptionTask1 called"
    m.VideoSubscriptionTask1 = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.VideoSubscriptionTask1.videoID = str(m.top.videoId)
    m.VideoSubscriptionTask1.observeField("videoDetailsResponse", "showButtonLabelList")
    m.VideoSubscriptionTask1.callFunc("runVideoSubscriptionTask", "")
end sub

sub showButtonLabelList()
    m.buttonsLabelListItems = []

    if m.VideoSubscriptionTask1.videoSubIDSCount = 0
        m.buttonsLabelListItems.push(m.playNow)
    else
        if m.VideoSubscriptionTask1.videoSubs = true
            m.buttonsLabelListItems.push(m.playNow)
        else
            m.buttonsLabelListItems.push(m.Subscribe)
        end if
    end if


    if m.GetVideoDetailsTask <> invalid and m.GetVideoDetailsTask.TagsContent <> invalid
        if m.GetVideoDetailsTask.TagsContent.getChildCount() > 0


            m.buttonsLabelListItems.push(m.moreButton)
        end if
    end if
    addbuttonLabelList(m.buttonsLabelListItems)
    m.buttonsLabelList.setFocus(true)
end sub


sub setTagsRowlist(tagsContent)

    rowHeights = [60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
    rowItemSize = [[200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60], [200, 60]]


    m.tagsRowlist.rowHeights = rowHeights
    m.tagsRowlist.rowItemSize = rowItemSize


    for i = 0 to tagsContent.getchildcount() - 1
        ' ?"itemType : ";itemType
        itemType = invalid
        if tagsContent.getChild(i) <> invalid and tagsContent.getChild(i).type <> invalid
            itemType = tagsContent.getChild(i).type
        end if

        if itemType <> invalid and itemType = "TAGS"
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

    ' ?"m.tagsRowlist.rowItemSize"
    ' ' ?m.tagsRowlist.rowItemSize
    ' ?m.tagsRowlist.rowHeights
    m.tagsRect.visible = true
    m.tagsRowlist.content = tagsContent
    m.top.tagsRowlistContent = tagsContent
    m.tagsRowlist.setFocus(true)
end sub


sub getShowDetailsAPI(showId) ' ***show details api called to get  show details data of the video
    ?"getShowDetailsAPI called: ";showId
    m.GetShowDetailsTask = CreateObject("roSGNode", "GetShowDetailsTask")
    m.GetShowDetailsTask.showId = showId
    m.GetShowDetailsTask.observeField("showDetailsResponse", "OnGetShowDetailsTask")
    m.GetShowDetailsTask.callFunc("runGetShowDetailsTask", "")
end sub


sub OnGetShowDetailsTask() '*** the show details data received
    ?"OnGetShowDetailsTask called"
    showDetailsContent = m.GetShowDetailsTask.showDetailsResponse
    ?showDetailsContent
end sub


sub addbuttonLabelList(nodes as object)
    ' ?"addbuttonLabelList called"; nodes
    content = createObject("RoSGNode", "ContentNode")
    m.buttonsLabelList.content = content

    for each node in nodes
        m.buttonsLabelList.content.appendChild(node)
    end for
end sub


function modifyButtonLabelList(newNode as object, index as integer)
    ?"modifyButtonLabelList called;"; newNode
    if index >= m.buttonsLabelList.content.GetChildCount()
        m.buttonsLabelList.content.appendChild(newNode)
    else
        if not m.buttonsLabelList.content.getChild(index).id = newNode.id
            m.buttonsLabelList.content.replaceChild(newNode, index)
        end if

    end if
end function



'just for initialising buttons,  if want to create new button set just call addbuttonLabelList with new buttons
sub initialiseButtonsLabelList()
    ?"initialiseButtonsLabelList called"
    m.playNow = createObject("RoSGNode", "ContentNode")
    m.playNow.id = "PLAY"
 
        m.playNow.title = getText("play")
    
    ' m.playNow.HDLISTITEMICONURL = "pkg:/images/playbutton.png"
    ' m.playNow.HDLISTITEMICONSELECTEDURL = "pkg:/images/playbutton.png"
    m.playNow.blendColor = getTextColor()

    m.AddToMyList = createObject("RoSGNode", "ContentNode")
    m.AddToMyList.id = "ADDTOMYLIST"

    
        m.AddToMyList.title = getText("add_to_mylist")
    
    m.AddToMyList.HDLISTITEMICONURL = "pkg:/images/plus.png"
    m.AddToMyList.HDLISTITEMICONSELECTEDURL = "pkg:/images/plus.png"

    m.Subscribe = createObject("RoSGNode", "ContentNode")
    m.Subscribe.id = "SUBSCRIBE"

    

        m.Subscribe.title = getText("subscribe")
    



    ' m.Subscribe.HDLISTITEMICONURL = "pkg:/images/premium_icon.png"
    ' m.Subscribe.HDLISTITEMICONSELECTEDURL = "pkg:/images/premium_icon.png"

    m.RemoveFromMylist = createObject("RoSGNode", "ContentNode")
    m.RemoveFromMylist.id = "REMOVEFROMMYLIST"



   
        m.RemoveFromMylist.title =  getText("remove_from_mylist")
   


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
    ' addbuttonLabelList([
    '     m.playNow,
    '     m.AddToMyList,
    '     m.WatchTrailer
    ' ])
end sub


'labellist click handling function
sub onButtonsLabelList()
    ?"onButtonsLabelList called"
    itemSelected = m.buttonsLabelList.itemSelected
    idSelected = m.buttonsLabelList.content.getChild(itemSelected).id
    VODcontent = returnTheCurrentFocusedData()
    if idSelected = "PLAY"
        ' runVideoSubscriptionTask()
        m.top.goToVideoPlayerScene = true
    else if idSelected = "ADDTOMYLIST"
        OnPlaylist()
    else if idSelected = "SUBSCRIBE"
        ' if isGuest() = "true"
        '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        '     m.top.gotoLandingScene = true
        ' else
        '     m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        '     m.top.goToPaymentDescriptionScreen = VODcontent.video_id
        ' ' end if
        ' runVideoSubscriptionTask()
        m.top.goToVideoPlayerScene = true
    else if idSelected = "REMOVEFROMMYLIST"
        OnPlaylistremove()
    else if idSelected = "WATCHTRAILER"
        ' OnTrailer()
    else if idSelected = "MORE"
        setTagsRowlist(m.GetVideoDetailsTask.tagsContent)
    end if
end sub


sub onButtonLabelListPlayClicked()
    ?"playOrSubscribeLogicFunction called"
    if (isGuest() = "false")

        if getSubscriptionRequired() = "true"
            runVideoSubscriptionTask()
        else
            playvideo()
        end if
    else if(isGuest() = "true")
        ' if (m.VideoSubscriptionTask.videoSubIDSCount <> invalid and m.VideoSubscriptionTask.videoSubIDSCount > 0)

        '     ' showPaymentPage()
        ' else
        ' print"Display Watch Now Button"
        ' playvideo()
        if (getRegisterationMandatory() = "true")
            m.top.gotoLandingScene = true
        else
            VODcontent = returnTheCurrentFocusedData()
            if getSubscriptionRequired() = "true"
                runVideoSubscriptionTask()
            else
                playvideo()
            end if
        end if
    end if
    ' end if
end sub


sub runVideoSubscriptionTask()
    m.loading.visible = true
    ?"VideoSubscriptionTask called"
    m.VideoSubscriptionTask = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.VideoSubscriptionTask.videoID = str(m.top.videoId)
    m.VideoSubscriptionTask.observeField("videoDetailsResponse", "userLoggedInLimitCheck")
    m.VideoSubscriptionTask.callFunc("runVideoSubscriptionTask", "")
end sub

sub userLoggedInLimitCheck()
    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "logoutAndGoToLandingScene")
    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = "You are no longer Logged in this device. Please Login again to access."

  
        okTitle =  getText("ok") ' Default value
  

    ' Set "Logout All" button text
   
        logoutAllTitle = getText("logout_all") ' Default value
        ?"lk"
   

    m.top.dialogAuthExceed.buttons = [okTitle, logoutAllTitle]


    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")

    m.LogoutTask1 = CreateObject("roSGNode", "LogoutTask")
    m.LogoutTask1.observeField("LogoutResponse", "logoutAndGoToLandingScene")
    m.top.sessionExpiredPopUp = CreateObject("roSGNode", "BackDialog")
    m.top.sessionExpiredPopUp.backgroundUri = "pkg:/images/black.jpg"
   
        m.top.sessionExpiredPopUp.title =  getText("session_expired_message")
    


    ' m.top.sessionExpiredPopUp.title = "Your session expired. Please login to continue"
    m.top.sessionExpiredPopUp.buttons = ["Ok"]
    m.top.sessionExpiredPopUp.ObserveField("buttonSelected", "OnsessionExpiredClick")

    ?m.VideoSubscriptionTask
    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubResponse <> invalid and m.VideoSubscriptionTask.userSubResponse.forcibleLogout <> invalid
        forcibleLogout = m.VideoSubscriptionTask.userSubResponse.forcibleLogout 'false
    else
        forcibleLogout = false
    end if

    if m.VideoSubscriptionTask <> invalid and m.VideoSubscriptionTask.userSubResponse <> invalid and m.VideoSubscriptionTask.userSubResponse.session_expired <> invalid
        session_expired = m.VideoSubscriptionTask.userSubResponse.session_expired 'true
    else
        session_expired = false
    end if

    m.parentScene = GetParentScene()
    if forcibleLogout = true ' user logged in limit - case
        m.parentScene.dialog = m.top.dialogAuthExceed
        ?"lkl"
    else if session_expired = true
        ?"kl"
        m.parentScene.dialog = m.top.sessionExpiredPopUp
        ?m.top.sessionExpiredPopUp
        ?m.parentScene.dialog
        ?"mlkl"
    else
        'playLogic() -commented play
        ' m.top.goToVideoPlayerScene=true

    end if
end sub


sub On_dialogAuthExceed_buttonSelected()
    if m.top.dialogAuthExceed.buttonSelected = 0
        m.parentScene.dialog.close = true
        m.loading.visible = false
    else if m.top.dialogAuthExceed.buttonSelected = 1
        m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
        m.LogoutTaskAll.observeField("LogoutResponse", "logoutAndGoToLandingScene")
        m.LogoutTaskAll.callFunc("runLogoutTask", "")
        m.loading.visible = true
    end if
end sub

sub OnsessionExpiredClick()
    ?"kjj"
    m.LogoutTask1.callFunc("runLogoutTask", "")
    m.loading.visible = true
    ?"yttytyty"
end sub

sub logoutAndGoToLandingScene()
    ?"logoutAndGoToLandingScene called"
    try
        if GetParentScene() = invalid then
            return
        end if

        Registry = CreateObject("roRegistry")
        i = 0
        for each section in Registry.GetSectionList()
            RegistrySection = CreateObject("roRegistrySection", section)
            for each key in RegistrySection.GetKeyList()
                i = i + 1
                ' if key <> "templateInstalled" and key <> "templateGuestEvent" and key <> "country_code" and key <> "ippaddress" and key <> "channelsids" and key <> "PubID" and key <> "countrycode" and key <> "channelID" and key <> "MENU_ITEMS_TITLE" and key <> "MENU_ITEMS_ORDER" and key <> "MENU_ITEMS_TYPE" and key <> "REVERSE_TV_CODE_FLOW" and key <> "BUTTON_SELECTION_COLOR" and key <> "SIGN_IN_MESSAGE" and key <> "REGISTRATION_MANDATORY" and key <> "SIGN_UP_REQUIRED"
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
        m.loading.visible = false
        m.parentScene.dialog.close = true
        m.top.goToLandingSceneAndCloseAllScreens = true
    catch E
    end try
end sub


'''''''''
' checkSubscription:
'
' @return {dynamic}
'''''''''
function checkSubscription()
    ?"checkSubscription called"
    if m.VideoSubscriptionTask.videoSubs = true
        ?"subscribed = true"
        playvideo()
    else
        ?"subscribed = false"
        VODcontent = returnTheCurrentFocusedData()
        showPaymentPage(VODcontent.video_id)
        ' m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
        ' ' showSubscriptionDialog()
    end if
end function

sub playLogic()
    videoSubscriptionCount = m.VideoSubscriptionTask.videoSubIDSCount
    free_video = m.VideoSubscriptionTask.videoDetailsResponse.free_video

    if videoSubscriptionCount = 0
        if getRegisterationMandatory() = "true"
            if isGuest() = "true" ' go to login
                ?"playLogic111"
                goToLandingScene()
            else if getAdRequired() = "true" ' play video with ads
                m.skipAd = false
                ?"playLogic222"
                playVideo()
            else ' playvideo
                m.skipAd = true
                ?"playLogic333"
                playVideo()
            end if
        else if getAdRequired() = "true" ' play video with ads
            m.skipAd = false
            ?"playLogic444"
            playVideo()
        else 'play video
            m.skipAd = true
            ?"playLogic555"
            playVideo()
        end if
        ' else if videoSubscriptionCount > 0 and free_video = true ' watch without ads
        '     if m.VideoSubscriptionTask.videoSubs = true ' play video
        '         m.skipAd = true
        '         playVideo()
        '     else if isGuest() = "true" ' go to login
        '         goToLandingScene()
        '     else ' play video with ads
        '         m.skipAd = false
        '         playVideo()
        '     end if
    else 'video has subscriptions
        ' if getRegisterationMandatory() = "true"
        if m.VideoSubscriptionTask.videoSubs = true ' play video
            m.skipAd = true
            ?"playLogic666"
            playVideo()
        else if isGuest() = "true" ' go to login
            ?"playLogic777"
            goToLandingScene()
        else ' go to subscription screen
            ?"playLogic888"
            goToSubscriptionListingScene()
        end if
        ' else
        '     if getAdRequired() = "true" ' play video with ads
        '         m.skipAd = false
        '         playVideo()
        '     else ' playvideo
        '         m.skipAd = true
        '         playVideo()
        '     end if
        ' end if

    end if
end sub




sub OnPlaylist()
    if isGuest() = "true"
        m.loading.visible = false
        m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
        m.top.gotoLandingScene = true
        m.Video.control = "stop"
    else
        m.playListadd = CreateObject("roSGNode", "playListadd")
        m.playListadd.wflag = "1"
        m.playListadd.showid = m.GetVideoDetailsTask.videoDetailsResponse.show_id
        m.playListadd.uid = getUserIdana()
        m.playListadd.observeField("PlaylistResponse", "onPlaylistaddchanged")
        m.playListadd.callFunc("runPlayListAdd", "")
    end if
end sub

sub OnPlaylistremove()
    m.top.playlistAdd = false
    m.top.playlistRemove = true
    m.playListadd = CreateObject("roSGNode", "playListadd")
    m.playListadd.wflag = "0"
    m.playListadd.showid = m.GetVideoDetailsTask.videoDetailsResponse.show_id
    m.playListadd.uid = getUserIdana()
    m.playListadd.observeField("PlaylistResponse", "onPlaylistaddchangedremove")
    m.playListadd.callFunc("runPlayListAdd", "")
end sub

'**************retruns the current focused data. It descrimininates from rowlist or buttonlabellist has the focus.
'it season exists, (singlevideo = 0) it takes that also into consideration.
function returnTheCurrentFocusedData()
    ?m.GetVideoDetailsTask.videoDetailsResponse
    ?"returnTheCurrentFocusedData called"
    return m.GetVideoDetailsTask.videoDetailsResponse
end function


function playvideo()
    ?"playvideo called"
    ' ?"m.count = 0: playvideo "
    m.loading.visible = false
    VODcontent = returnTheCurrentFocusedData()
    content = m.GetVideoDetailsTask.videoDetailsResponse
    showDetailsContent = m.GetShowDetailsTask.showDetailsResponse
    ' m.background.visible = true
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true


    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    macroDNT = "1"
    if di.IsRIDADisabled()
        macroDNT = "0"
    end if
    macroIP = di.GetExternalIp()
    version = di.GetVersion()
    version_major = mid(version, 3, 1)
    version_minor = mid(version, 5, 2)
    version_build = mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = mid(version_minor, 2)
    end if
    macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    macroChannelID = getchannelsid().Trim()
    macroVideoID = Str(content.video_id).Trim()
    macroDurations = content.video_duration.Trim()
    macroDuration = macroDurations.toInt()
    macrouserID = getUserIdana().Trim()
    macrvideoID = content.video_id
    macrotitle = content.title
    m.uidana = getUserIdana()
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("videoID", content.video_id.ToStr())
    sec.Write("videoTITLE", content.video_title)
    sec.Write("channelID", content.channel_id.ToStr())
    sec.Write("category", m.concatenatedcategoryText)
    sec.Flush()
    ' ?"content :"
    ' ?content.subtitles[0]

    if getCountrycode() = "EU"
        consent = "1"
        GDPR = "1"
    else
        consent = "0"
        GDPR = "0"
    end if



    if content.video_description <> invalid
        video_description = content.video_description
    else
        video_description = ""
    end if



    maturity = ""
    if showDetailsContent.maturity <> invalid
        maturity = showDetailsContent.maturity
    end if
    producer = ""
    if showDetailsContent.producer <> invalid
        producer = showDetailsContent.producer
    end if

    dt = CreateObject("roDateTime")
    timestamp = dt.AsSeconds().ToStr()
    timeStampPre = dt.AsSeconds()
    timeStampMilliSeconds = (timeStampPre.ToStr() + "000")
    adUURRLL = content.ad_link

    temp1 = strReplace(adUURRLL, "[WIDTH]", macroWidth)
    temp2 = strReplace(temp1, "[HEIGHT]", macroHeight)
    temp3 = strReplace(temp2, "[DNT]", macroDNT)
    temp4 = strReplace(temp3, "[IP_ADDRESS]", macroIP)
    temp5 = strReplace(temp4, "[USER_AGENT]", macroUserAgent)
    temp6 = strReplace(temp5, "[DEVICE_IFA]", macroADID.Escape())
    temp7 = strReplace(temp6, "[UUID]", macroUUID)
    temp8 = strReplace(temp7, "[USER_ID]", macrouserID.Trim())
    temp9 = strReplace(temp8, "[REGION]", getRegion().Escape())
    temp10 = strReplace(temp9, "[COUNTRY]", getCountrycode().Escape())
    temp11 = strReplace(temp10, "[DEVICE_ID]", macroUUID)
    temp12 = strReplace(temp11, "[DEVICE_MODEL]", macroDevModel.Escape())
    temp13 = strReplace(temp12, "[CHANNEL_ID]", macroChannelID.Trim())
    temp14 = strReplace(temp13, "[VIDEO_ID]", macroVideoID.Trim())
    temp15 = strReplace(temp14, "[APP_STORE_URL]", getRokuChannelStoreURL().EncodeUri())
    temp16 = strReplace(temp15, "[DEVICE_MAKE]", "RA")
    temp17 = strReplace(temp16, "[BUNDLE]", getBundleID())
    temp18 = strReplace(temp17, "[LATITUDE]", getLatitude().Trim())
    temp19 = strReplace(temp18, "[LONGITUDE]", getLongitude().Trim())
    temp20 = strReplace(temp19, "[KEYWORDS]", m.concatenatedcategoryText.Trim().Escape())
    temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle().Escape())
    temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
    temp23 = strReplace(temp22, "[CITY]", getCity().Escape())
    temp24 = strReplace(temp23, "[SHOW_ID]", content.show_id.ToStr().Trim())
    temp25 = strReplace(temp24, "[CATEGORIES]", m.concatenatedcategoryText.Escape())
    temp26 = strReplace(temp25, "[CONTENT_TITLE]", content.video_title.Trim().Escape())
    temp27 = strReplace(temp26, "[VIDEO_TITLE]", content.video_title.Escape())
    temp28 = strReplace(temp27, "[VIDEO_URL]", content.video_name)
    temp29 = strReplace(temp28, "[CHANNEL_NAME]", getAppTitle().Escape())
    temp30 = strReplace(temp29, "[AUTOPLAY]", "0")
    temp31 = strReplace(temp30, "[MUTE]", "0")
    temp32 = strReplace(temp31, "[DEVICE_IFA]", di.GetRIDA())
    temp33 = strReplace(temp32, "[OS]", "rokuos")
    temp34 = strReplace(temp33, "[OS_VERSION]", di.GetOSVersion().major)
    temp35 = strReplace(temp34, "[ISP]", getIsp().Escape())
    temp36 = strReplace(temp35, "[DEVICE_BRAND_NAME]", "roku")
    temp37 = strReplace(temp36, "[LMT]", "0")
    temp38 = strReplace(temp37, "[SEASON]", "0")
    temp39 = strReplace(temp38, "[EPISODE]", "0")
    temp40 = strReplace(temp39, "[SERIES]", m.concatenatedcategoryText.Escape())
    temp41 = strReplace(temp40, "[PRODUCER]", producer.Trim().Escape())
    temp42 = strReplace(temp41, "[IS_LIVE]", "0")
    temp43 = strReplace(temp42, "[RATING]", maturity.Trim().Escape())
    temp44 = strReplace(temp43, "[LANGUAGE]", "English")
    temp45 = strReplace(temp44, "[AD_POSITION]", "7")
    temp46 = strReplace(temp45, "[PLACEMENT]", "1")
    temp47 = strReplace(temp46, "[SKIPPABLE]", "0")
    temp48 = strReplace(temp47, "[PRODUCTION_QUALITY]", "1")
    temp49 = strReplace(temp48, "[CONSENT]", consent)
    temp50 = strReplace(temp49, "[GDPR]", GDPR)
    temp51 = strReplace(temp50, "[COPPA]", "1")
    temp52 = strReplace(temp51, "[DNT]", "1")
    temp53 = strReplace(temp52, "[CACHEBUSTER]", timeStampMilliSeconds)
    temp54 = strReplace(temp53, "[TIMESTAMP]", timestamp)
    temp55 = strReplace(temp54, "[TIMESTAMP_MS]", timeStampMilliSeconds)
    temp56 = strReplace(temp55, "[DESCRIPTION]", video_description.Escape())
    temp57 = strReplace(temp56, "[APPID]", getappId())
    temp58 = strReplace(temp57, "[US_PRIVACY]", "")

    finalAdURL = strReplace(temp58, "[DURATION]", Str(macroDuration).Trim())

    ?"finalAdURL printed: "
    ? "********************"
    ? finalAdURL
    ? "********************"

    SubtitleTracks = []

    for each item in content.subtitles
        subtitleItem = {}
        subtitleItem.Language = item.language_name
        subtitleItem.Description = item.short_code
        subtitleItem.TrackName = item.subtitle_url
        SubtitleTracks.push(subtitleItem)
    end for

    ' SubtitleTracks = [{Language : "English", Description : "test", TrackName : content.subtitles[0].subtitle_url}]
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: content.video_title,
        url: content.video_name,
        audio_languages: content.audio_languages,
        categories: m.concatenatedcategoryText,
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: VODcontent.video_duration
    }
    ' videoContent.ClosedCaptions = True
    subtitle_config = VODcontent.subtitles

    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "is_live": "0",
        "audio_languages": m.GetVideoDetailsTask.videoDetailsResponse.audio_languages,
        "language_id": m.GetVideoDetailsTask.videoDetailsResponse.language_id
    })
    content.ad_url = finalAdURL.EncodeUri()
    if subtitle_config <> invalid
        content.ClosedCaptions = True
        content.globalCaptionMode = "On"
        content.HDBranded = True
        content.IsHD = True
        content.SubtitleConfig = subtitle_config
        content.SubtitleTracks = SubtitleTracks
        content.subtitleTrack = SubtitleTracks
    end if

    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("VIDEO_LANGUAGE_CHANGED", "OnVideoLangugageChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if
    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)

    m.Player.watched_duration = m.watched_duration 'setting watched_duration
    if m.skipAd = true
        m.Player.skipAd = true
    else
        m.Player.skipAd = false
    end if
    m.Player.control = "play"
    m.Player.observeField("visibility", "onPlayerVisibleChange")
    ' m.Player.observeField("autoplay", "onAutoplay")

end function

sub onPlayerVisibleChange()
    ?"onPlayerVisibleChange called"
    m.loading.visible = false
    ' m.Player.visible = false
    ' ?m.buttonsLabelList.visible
    m.Video.visible = false
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


function onTagsRowItemSelected()
    ?"onTagsRowItemSelected called"
    m.tagsRect.visible = false
    m.top.goToShowMoreScene = m.tagsRowlist.RowItemSelected
end function

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "up"

        else if key = "down"

        else if key = "left"

            if m.continueWatchingDialogVisible = true or m.continueWatchingDialogVisible_ForAutoplay = false
                m.NoButton.setFocus(true)
                handled = true
            end if

        else if key = "right"

            if m.continueWatchingDialogVisible = true or m.continueWatchingDialogVisible_ForAutoplay = true
                m.YesButton.setFocus(true)
                handled = true
            end if

        else if key = "back"
            if m.tagsRect.visible = true
                m.tagsRect.visible = false
                m.buttonsLabelList.setFocus(true)
                return true
            end if
        end if
    end if
    return handled
end function


sub showSubscriptionDialog()
    dialog = createObject("roSGNode", "Dialog")
    ' dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"

    
        dialog.title = getText("warning")
    
    ' dialog.title = "Currently unavailable!"
    dialog.optionsDialog = true
    dialog.buttons = ["OK"]
    dialog.ObserveField("buttonSelected", "onSubscriptionRequiredOkButtonselected")
    dialog.message = "To avail this video, visit our website.. Please visit " + getAppTitle() + " on the web for help"
    m.top.dialog = dialog
    m.parentScene = GetParentScene()
    m.parentScene.dialog = dialog
    ' dialog = createObject("roSGNode", "Dialog")
    ' ' dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
    ' dialog.title = "Currently unavailable!"
    ' dialog.optionsDialog = true
    ' dialog.message = "To avail this video, visit our website"
    ' m.top.dialog = dialog
    ' m.parentScene = GetParentScene()
    ' m.parentScene.dialog = dialog
end sub

sub onSubscriptionRequiredOkButtonselected()
    m.parentScene.dialog.close = true
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

'******************autoplay
'******this method called after one video finished, this is for autoplaying next video
function PlayerStateChanged()
    ?"PlayerStateChanged called : videodetailscene ";m.Player.playerState
    if invalid <> m.Player and invalid <> m.Player.playerState
        if m.Player.playerState = "finished" or m.Player.playerState = "stopped"
            if m.AutoplayData2 <> invalid
                m.UpNext_rect.visible = true
                m.upnext_video_name.text = m.AutoplayData2.videoDetailsResponse.video_title
                m.upnextTimer.control = "start"
            end if
        else if m.Player.playerState = "back_pressed" or m.Player.playerState = ""
            m.UpNext_rect.visible = false
        end if
        if m.Player.state = "change_video_track"
            ' ' m.Player.control = "stop"
            ' m.Player.content.url = "https://gizmeon.mdc.akamaized.net/PUB-50054/202307311690796936/playlist.m3u8"
            ' m.Player.control = "play"
        else

        end if
    end if
end function

sub onUpNextTimerFire()
    ?"onUpNextTimerFire called"
    m.UpNext_rect.visible = false
    m.loading.visible = true
    playLogicForAutoplay()
end sub

'''''''''
' OnVideoLangugageChanged: this is used to call autoplay api again so that the autoplay video follows the selected language
'
' @param {dynamic} params - video id of the newly selected video
'''''''''
function OnVideoLangugageChanged()
    callAutoplayAPI(m.Player.VIDEO_LANGUAGE_CHANGED)
end function

'*****
sub callAutoplayAPI(video_id)
    m.AutoPlayAPiTask = CreateObject("roSGNode", "AutoPlayAPiTask")
    ' m.AutoPlayAPiTask.videoID = str(m.gridScreen.focusedContent.video_id)
    m.AutoPlayAPiTask.observeField("AutoPlayAPiTaskContent", "OnAutoPlayAPiTaskContent")
    m.AutoPlayAPiTask.callFunc("runAutoPlayAPiTask", video_id, m.top.show_id)
end sub

sub OnAutoPlayAPiTaskContent()
    ?"OnAutoPlayAPiTaskContent called"
    if m.AutoPlayAPiTask <> invalid and m.AutoPlayAPiTask.AutoPlayAPiTaskContent <> invalid and m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data <> invalid
        m.AutoplayData = m.AutoPlayAPiTask.AutoPlayAPiTaskContent.data
        getVideoDetailsAPIForAutoPlay(m.AutoplayData.video_id.ToStr())
    end if
end sub


sub getVideoDetailsAPIForAutoPlay(video_id as string)
    m.GetVideoDetailsTaskForAutoPlay = CreateObject("roSGNode", "GetVideoDetailsTask")
    m.GetVideoDetailsTaskForAutoPlay.videoID = video_id
    m.autoplayVideoId = video_id
    m.GetVideoDetailsTaskForAutoPlay.observeField("videoDetailsResponse", "getVideoSubscriptionTaskAPIForAutoPlay")
    m.GetVideoDetailsTaskForAutoPlay.callFunc("runGetVideoDetailsTask", m.top.show_id)
end sub


sub getVideoSubscriptionTaskAPIForAutoPlay() '## calls VideoSubscriptionTask api of autoplay video
    m.VideoSubscriptionTaskForAutoPlay = CreateObject("roSGNode", "VideoSubscriptionTask")
    m.VideoSubscriptionTaskForAutoPlay.videoID = m.autoplayVideoId
    m.VideoSubscriptionTaskForAutoPlay.observeField("videoDetailsResponse", "OngetVideoDetailsAPIForAutoPlay")
    m.VideoSubscriptionTaskForAutoPlay.callFunc("runVideoSubscriptionTask", "")
end sub


function OngetVideoDetailsAPIForAutoPlay()
    ?"OngetVideoDetailsAPIForAutoPlay called"
    m.AutoplayData2 = m.GetVideoDetailsTaskForAutoPlay
end function

sub playLogicForAutoplay()
    ?"playLogicForAutoplay called"
    videoSubscriptionCount = m.VideoSubscriptionTaskForAutoPlay.videoSubIDSCount
    free_video = m.VideoSubscriptionTaskForAutoPlay.videoDetailsResponse.free_video

    if videoSubscriptionCount = 0
        if getRegisterationMandatory() = "true"
            if isGuest() = "true" ' go to login
                m.UpNext_rect.visible = false
                m.loading.visible = false
                m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
                m.Video.control = "stop"
                ?"playLogicForAutoplay111"
                showLoginDialog()
            else if getAdRequired() = "true" ' play video with ads
                m.skipAd = false
                ?"playLogicForAutoplay222"
                autoPlayVideo2()
            else ' playvideo
                m.skipAd = true
                ?"playLogicForAutoplay333"
                autoPlayVideo2()
            end if
        else if getAdRequired() = "true" ' play video with ads
            m.skipAd = false
            ?"playLogicForAutoplay444"
            autoPlayVideo2()
        else 'play video
            m.skipAd = true
            ?"playLogicForAutoplay555"
            autoPlayVideo2()
        end if
        ' else if videoSubscriptionCount > 0 and free_video = true ' watch without ads
        '     if m.VideoSubscriptionTask.videoSubs = true ' play video
        '         m.skipAd = true
        '         playVideo()
        '     else if isGuest() = "true" ' go to login
        '         goToLandingScene()
        '     else ' play video with ads
        '         m.skipAd = false
        '         playVideo()
        '     end if
    else 'video has subscriptions
        ' if getRegisterationMandatory() = "true"
        if m.VideoSubscriptionTaskForAutoPlay.videoSubs = true ' play video
            m.skipAd = true
            ?"playLogicForAutoplay666"
            autoPlayVideo2()
        else if isGuest() = "true" ' go to login
            m.UpNext_rect.visible = false
            m.loading.visible = false
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.Video.control = "stop"
            ?"playLogicForAutoplay777"
            showLoginDialog()
        else ' go to subscription screen
            m.UpNext_rect.visible = false
            m.loading.visible = false
            m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
            m.Video.control = "stop"
            ?"playLogicForAutoplay888"
            showSubscriptionPageDialog()
            m.UpNext_rect.visible = false
        end if
        ' else
        '     if getAdRequired() = "true" ' play video with ads
        '         m.skipAd = false
        '         playVideo()
        '     else ' playvideo
        '         m.skipAd = true
        '         playVideo()
        '     end if
        ' end if
    end if
end sub


function autoPlayVideo2()
    ?"playvideo called"
    m.count = 1
    ' VODcontent = returnTheCurrentFocusedData()
    m.Video.control = "stop"
    m.Video.content = invalid
    m.Video.visible = true


    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    macroDNT = "1"
    if di.IsRIDADisabled()
        macroDNT = "0"
    end if
    macroIP = di.GetExternalIp()
    version = di.GetVersion()
    version_major = mid(version, 3, 1)
    version_minor = mid(version, 5, 2)
    version_build = mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = mid(version_minor, 2)
    end if
    macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    macroChannelID = getchannelsid().Trim()
    macroVideoID = m.AutoplayData.video_id.toStr().Trim()
    macroDurations = m.AutoplayData2.videoDetailsResponse.video_duration.toStr().Trim()
    macroDuration = macroDurations.toInt()
    macrouserID = getUserIdana().Trim()
    macrvideoID = m.AutoplayData.video_id.toStr().Trim()
    macrotitle = m.AutoplayData2.videoDetailsResponse.video_title
    ' m.uidana = getUserIdana()
    ' m.showFetcher.user_id = m.uidana
    ' m.ShowFetcher.event_type = "POP02"
    ' m.ShowFetcher.video_id = macrvideoID
    ' m.ShowFetcher.video_title = macrotitle
    ' m.ShowFetcher.channel_id = macroChannelID
    categoriesWithComma = ""
    for i = 0 to m.AutoplayData2.videoDetailsResponse.categories.Count() - 1
        categoriesWithComma = categoriesWithComma + m.AutoplayData2.videoDetailsResponse.categories[i].category_name + ","
    end for

    if m.AutoplayData2.videoDetailsResponse.season <> invalid
        season = m.AutoplayData2.videoDetailsResponse.season
    else
        season = ""
    end if
    if m.AutoplayData2.videoDetailsResponse.video_order <> invalid
        video_order = m.AutoplayData2.videoDetailsResponse.video_order
    else
        video_order = ""
    end if
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("videoID", m.AutoplayData.video_id.toStr().Trim())
    sec.Write("videoTITLE", m.AutoplayData2.videoDetailsResponse.video_title)
    sec.Write("channelID", getchannelsid())
    sec.Write("category", categoriesWithComma.Trim())
    sec.Flush()


    if getCountrycode() = "EU"
        consent = "1"
        GDPR = "1"
    else
        consent = "0"
        GDPR = "0"
    end if

    dt = CreateObject("roDateTime")
    timestamp = dt.AsSeconds().ToStr()
    timeStampPre = dt.AsSeconds()
    timeStampMilliSeconds = (timeStampPre.ToStr() + "000")
    ' adUURRLL = VODcontent.ad_link
    adUURRLL = m.AutoplayData2.videoDetailsResponse.ad_link

    temp1 = strReplace(adUURRLL, "[WIDTH]", macroWidth)
    temp2 = strReplace(temp1, "[HEIGHT]", macroHeight)
    temp3 = strReplace(temp2, "[DNT]", macroDNT)
    temp4 = strReplace(temp3, "[IP_ADDRESS]", macroIP)
    temp5 = strReplace(temp4, "[USER_AGENT]", macroUserAgent)
    temp6 = strReplace(temp5, "[DEVICE_IFA]", macroADID.Escape())
    temp7 = strReplace(temp6, "[UUID]", macroUUID)
    temp8 = strReplace(temp7, "[USER_ID]", macrouserID.Trim())
    temp9 = strReplace(temp8, "[REGION]", getRegion().Escape())
    temp10 = strReplace(temp9, "[COUNTRY]", getCountrycode().Escape())
    temp11 = strReplace(temp10, "[DEVICE_ID]", macroUUID)
    temp12 = strReplace(temp11, "[DEVICE_MODEL]", macroDevModel.Escape())
    temp13 = strReplace(temp12, "[CHANNEL_ID]", macroChannelID.Trim())
    temp14 = strReplace(temp13, "[VIDEO_ID]", macroVideoID.Trim())
    temp15 = strReplace(temp14, "[APP_STORE_URL]", getRokuChannelStoreURL().EncodeUri())
    temp16 = strReplace(temp15, "[DEVICE_MAKE]", "RA")
    temp17 = strReplace(temp16, "[BUNDLE]", getBundleID())
    temp18 = strReplace(temp17, "[LATITUDE]", getLatitude().Trim())
    temp19 = strReplace(temp18, "[LONGITUDE]", getLongitude().Trim())
    temp20 = strReplace(temp19, "[KEYWORDS]", categoriesWithComma.Trim().Escape())
    temp21 = strReplace(temp20, "[APP_NAME]", getAppTitle().Escape())
    temp22 = strReplace(temp21, "[DEVICE_TYPE]", "Roku")
    temp23 = strReplace(temp22, "[CITY]", getCity().Escape())
    temp24 = strReplace(temp23, "[SHOW_ID]", m.AutoplayData2.videoDetailsResponse.show_id.toStr().Trim())
    temp25 = strReplace(temp24, "[CATEGORIES]", categoriesWithComma.Escape())
    temp26 = strReplace(temp25, "[CONTENT_TITLE]", m.AutoplayData2.videoDetailsResponse.video_title.Trim().Escape())
    temp27 = strReplace(temp26, "[VIDEO_TITLE]", m.AutoplayData2.videoDetailsResponse.video_title.Trim().Escape())
    temp28 = strReplace(temp27, "[VIDEO_URL]", m.AutoplayData2.videoDetailsResponse.video_name)
    temp29 = strReplace(temp28, "[CHANNEL_NAME]", getAppTitle().Escape())
    temp30 = strReplace(temp29, "[AUTOPLAY]", "0")
    temp31 = strReplace(temp30, "[MUTE]", "0")
    temp32 = strReplace(temp31, "[DEVICE_IFA]", di.GetRIDA())
    temp33 = strReplace(temp32, "[OS]", "rokuos")
    temp34 = strReplace(temp33, "[OS_VERSION]", di.GetOSVersion().major)
    temp35 = strReplace(temp34, "[ISP]", getIsp().Escape())
    temp36 = strReplace(temp35, "[DEVICE_BRAND_NAME]", "roku")
    temp37 = strReplace(temp36, "[LMT]", "0")
    temp38 = strReplace(temp37, "[SEASON]", season.ToStr().Trim().Escape())
    temp39 = strReplace(temp38, "[EPISODE]", video_order.ToStr().Trim().Escape())
    temp40 = strReplace(temp39, "[SERIES]", m.AutoplayData2.videoDetailsResponse.video_title.Escape())
    temp41 = strReplace(temp40, "[PRODUCER]", "".Trim().Escape())
    temp42 = strReplace(temp41, "[IS_LIVE]", "0")
    temp43 = strReplace(temp42, "[RATING]", "".Trim().Escape())
    temp44 = strReplace(temp43, "[LANGUAGE]", "English")
    temp45 = strReplace(temp44, "[AD_POSITION]", "7")
    temp46 = strReplace(temp45, "[PLACEMENT]", "1")
    temp47 = strReplace(temp46, "[SKIPPABLE]", "0")
    temp48 = strReplace(temp47, "[PRODUCTION_QUALITY]", "1")
    temp49 = strReplace(temp48, "[CONSENT]", consent)
    temp50 = strReplace(temp49, "[GDPR]", GDPR)
    temp51 = strReplace(temp50, "[COPPA]", "1")
    temp52 = strReplace(temp51, "[DNT]", "1")
    temp53 = strReplace(temp52, "[CACHEBUSTER]", timeStampMilliSeconds)
    temp54 = strReplace(temp53, "[TIMESTAMP]", timestamp)
    temp55 = strReplace(temp54, "[TIMESTAMP_MS]", timeStampMilliSeconds)
    temp56 = strReplace(temp55, "[DESCRIPTION]", m.AutoplayData2.videoDetailsResponse.video_description.Escape())
    temp57 = strReplace(temp56, "[APPID]", getappId())
    temp58 = strReplace(temp57, "[US_PRIVACY]", "")

    finalAdURL = strReplace(temp58, "[DURATION]", Str(macroDuration).Trim())

    ?"finalAdURL printed: "
    ? "********************"
    ? finalAdURL
    ? "********************"
    videoContent = {
        streamFormat: "m3u8",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse.video_title,
        url: m.GetVideoDetailsTaskForAutoPlay.videoDetailsResponse.video_name,
        categories: categoriesWithComma
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: m.AutoplayData2.videoDetailsResponse.video_duration.toStr().Trim()
    }
    ' videoContent.ClosedCaptions = True
    subtitle_config = m.AutoplayData2.videoDetailsResponse.subtitles

    SubtitleTracks = []
    for each item in m.AutoplayData2.videoDetailsResponse.subtitles
        subtitleItem = {}
        subtitleItem.Language = item.language_name
        subtitleItem.Description = item.short_code
        subtitleItem.TrackName = item.subtitle_url
        SubtitleTracks.push(subtitleItem)
    end for

    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "is_live": "0",
        "audio_languages": m.AutoplayData2.videoDetailsResponse.audio_languages,
        "language_id": m.AutoplayData2.videoDetailsResponse.language_id
    })
    content.ad_url = finalAdURL.EncodeUri()
    if subtitle_config <> invalid
        content.ClosedCaptions = True
        content.globalCaptionMode = "On"
        content.HDBranded = True
        content.IsHD = True
        content.SubtitleConfig = subtitle_config
        content.SubtitleTracks = SubtitleTracks
        content.SubtitleTrack = SubtitleTracks
    end if

    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("VIDEO_LANGUAGE_CHANGED", "OnVideoLangugageChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if
    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.watched_duration = m.watched_duration 'setting watched_duration
    m.Player.skipAd = true
    m.Player.control = "play"

    m.Player.observeField("visibility", "onPlayerVisibleChange")
    callAutoplayAPI(macroVideoID)
end function

sub goToLandingScene()
    m.loading.visible = false
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    m.Video.control = "stop"
    m.top.gotoLandingScene = true
end sub

sub goToSubscriptionListingScene()
    m.loading.visible = false
    VODcontent = returnTheCurrentFocusedData()
    showPaymentPage(VODcontent.video_id)
    ' m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    ' m.top.goToPaymentDescriptionScreen = VODcontent.video_id
end sub

sub showLoginDialog()
    m.top.loginDialog = CreateObject("roSGNode", "BackDialog")
    m.top.loginDialog.backgroundUri = "pkg:/images/black.jpg"
    m.top.loginDialog.title = "Please login to continue autoplay!"
    m.top.loginDialog.buttons = ["Ok", "Cancel"]
    m.top.loginDialog.ObserveField("buttonSelected", "OnLoginDialogClicked")
    m.parentScene.dialog = m.top.loginDialog
end sub

sub OnLoginDialogClicked()
    if m.top.loginDialog.buttonSelected = 0
        m.parentScene.dialog.close = true
        goToLandingScene()
    else if m.top.loginDialog.buttonSelected = 1
        m.parentScene.dialog.close = true
        m.loading.visible = false
    end if
end sub

sub showSubscriptionPageDialog()
    m.top.subscriptionDialog = CreateObject("roSGNode", "BackDialog")
    m.top.subscriptionDialog.backgroundUri = "pkg:/images/black.jpg"
    m.top.subscriptionDialog.title = "Please Subscribe to continue autoplay!"
    m.top.subscriptionDialog.buttons = ["Ok", "Cancel"]
    m.top.subscriptionDialog.ObserveField("buttonSelected", "OnSubscriptionPageDialogClicked")
    m.parentScene.dialog = m.top.subscriptionDialog
end sub

sub OnSubscriptionPageDialogClicked()
    if m.top.subscriptionDialog.buttonSelected = 0
        m.parentScene.dialog.close = true
        goToSubscriptionListingSceneForautoplay()
    else if m.top.subscriptionDialog.buttonSelected = 1
        m.parentScene.dialog.close = true
        m.loading.visible = false
    end if
end sub

sub goToSubscriptionListingSceneForautoplay()
    m.loading.visible = false
    VODcontent = returnTheCurrentFocusedData()
    m.VideoSubscriptionTaskNeedsToRunOnceAgain = true
    showPaymentPage(m.autoplayVideoId)
    ' m.top.goToPaymentDescriptionScreen = m.autoplayVideoId
end sub






'####################AUTOPLAY

sub continueWatchingLogic(watched_duration)
    ?"continueWatchingLogic called"
    if watched_duration <> invalid
        if watched_duration > 0
            ?"VODcontent.watched_duration > 0 ";watched_duration
            showContinueWatchingDialog()
        else
            ?"VODcontent.watched_duration > 0 else"
            playvideo()
        end if
    end if
end sub

sub continueWatchingLogicForAutoplay(watched_duration)
    ?"continueWatchingLogicForAutoplay called"
    if watched_duration <> invalid
        if watched_duration > 0
            ?"continueWatchingLogicForAutoplay > 0 ";watched_duration
            showContinueWatchingDialogForAutoplay()
        else
            ?"continueWatchingLogicForAutoplay > 0 else"
            autoPlayVideo2()
        end if
    end if
end sub


sub showContinueWatchingDialog()
    ?"showContinueWatchingDialog called"

   

        m.dialogmessage_label.text =  getText("continue_watching")
   

    ' m.dialogmessage_label.text = "Continue Watching?"

  

        m.cancelbutton_Label.text =  getText("resume")

   


    ' m.cancelbutton_Label.text = "Resume"
   

        m.exitbutton_Label.text = getText("start_over")
    


    ' m.exitbutton_Label.text = "Start Over"
    m.dialogbg_rect.visible = true
    m.continueWatchingDialogVisible = true
    m.NoButton.setFocus(true)
    m.loading.visible = false
end sub


sub showContinueWatchingDialogForAutoplay()
    ?"showContinueWatchingDialogForAutoplay called"

    

        m.dialogmessage_label.text =  getText("continue_watching")
    
    ' m.dialogmessage_label.text = "Continue Watching?"

    

        m.cancelbutton_Label.text = getText("resume")

   


    ' m.cancelbutton_Label.text = "Resume"


    

        m.exitbutton_Label.text = getText("start_over")
    



    ' m.exitbutton_Label.text = "Start Over"
    m.dialogbg_rect.visible = true
    m.continueWatchingDialogVisible_ForAutoplay = true
    m.continueWatchingDialogVisible = false
    m.NoButton.setFocus(true)
    m.loading.visible = false
end sub


sub onDialogNoSelected()
    VODcontent = returnTheCurrentFocusedData()
    m.loading.visible = true

    if m.continueWatchingDialogVisible = true ' this is resume case when resume button is pressed
        ?"onDialogNoSelected: 1"
        m.dialogbg_rect.visible = false
        m.continueWatchingDialogVisible = false'
        m.watched_duration = VODcontent.watched_duration ' setting watched_duration
        playvideo() ' start over button selected


    else if m.continueWatchingDialogVisible_ForAutoplay = true
        ?"onDialogNoSelected: 2"
        m.dialogbg_rect.visible = false
        m.continueWatchingDialogVisible = false'
        m.watched_duration = VODcontent.watched_duration ' setting watched_duration to autoplay function
        autoPlayVideo2() ' start over button selected
    end if
end sub



sub onDialogYesSelected()

    if m.continueWatchingDialogVisible = true ' this is start over case when start over button is pressed
        ?"onDialogYesSelected: 1"
        m.loading.visible = true
        m.dialogbg_rect.visible = false
        m.continueWatchingDialogVisible = false'
        m.watched_duration = 0
        playvideo() ' continue watching clicked


    else if m.continueWatchingDialogVisible_ForAutoplay = true ' this is start over case when start over button is pressed
        ?"onDialogYesSelected: 2"
        m.loading.visible = true
        m.dialogbg_rect.visible = false
        m.continueWatchingDialogVisible_ForAutoplay = false'
        m.watched_duration = 0
        autoPlayVideo2() ' continue watching clicked
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
end sub