sub Init()

    m.Poster = m.top.findNode("poster")
    m.itemView_Center_Label = m.top.findNode("itemView_Center_Label")
    ' m.onFocusPlayVideo = m.top.findNode("onFocusPlayVideo")
    ' m.onFocusPlayVideo.observeField("state", "onTrailerstate")
    ' m.onFocusPlayVideoTimer = createObject("roSGNode", "Timer")
    ' m.onFocusPlayVideoTimer.observeField("fire", "onFocusPlayVideoTimerFire")
    ' m.onFocusPlayVideoTimer.duration = 1
    ' m.onFocusPlayVideoTimer.repeat = false
    ' m.top.appendChild(m.onFocusPlayVideoTimer)
    m.posterForBanner = m.top.findNode("posterForBanner")
    if getThumbnailOrientaion() = "LANDSCAPE"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()

    else if getThumbnailOrientaion() = "PORTRAIT"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
    end if

    m.Premium = m.top.findNode("premiumIcon")
    m.topTrendingOrder = m.top.findNode("topTrendingOrder")
    m.topTrendingOrderOverlayGradient = m.top.findNode("topTrendingOrderOverlayGradient")
    m.title = m.top.findNode("title")
    m.which_week = m.top.findNode("which_week")
    m.banner_title = m.top.findNode("banner_title")
    m.type = m.top.findNode("type")

    m.synopsis = m.top.findNode("synopsis")
    m.directorAndYear = m.top.findNode("directorAndYear")
    m.bottom_gradient = m.top.findNode("bottom_gradient")
    m.bannerLeftGradient = m.top.findNode("bannerLeftGradient")
    m.top_gradient = m.top.findNode("top_gradient")
    m.descriptionBanner = m.top.findNode("descriptionBanner")
    m.startingdate = m.top.findNode("startingdate")
    m.endingdate = m.top.findNode("endingdate")

    m.main_rect = m.top.findNode("main_rect")
    m.main_rect.color = getBackgroundColor1()
    m.myMaskGroup = m.top.findNode("myMaskGroup")
    ' m.myMaskGroup.blendColor = getBackGroundColor1()
    m.free_icon = m.top.findNode("free_icon")
    m.lock_icon = m.top.findNode("lock_icon")
    m.liveIcon = m.top.findNode("live")
    m.Progressbar = m.top.findNode("Progressbar")
    m.Progressbar.color = getButtonSelectionColor()
    m.playButton = m.top.findNode("playButton")

    'Theme color changes
    m.bannerLeftGradient = m.top.findNode("bannerLeftGradient")
    m.bannerLeftGradient.blendColor = getBackgroundColor1()
    m.topTrendingOrderOverlayGradient = m.top.findNode("topTrendingOrderOverlayGradient")
    if getTheme2() = "DARK"
        m.topTrendingOrderOverlayGradient.blendColor = "#000000"
        m.topTrendingOrderOverlayGradient.visible = true
    else
         m.topTrendingOrderOverlayGradient.visible = false
    end if
    m.imageTitlePoster = m.top.findNode("imageTitlePoster")
    m.bottom_gradient = m.top.findNode("bottom_gradient")
    m.bottom_gradient.blendColor = "#000000"
    m.top_gradient = m.top.findNode("top_gradient")
    m.top_gradient.blendColor = getBackgroundColor1()
    m.descriptionBanner = m.top.findNode("descriptionBanner")
    m.descriptionBanner.color = getBackgroundColor1()
    m.topTrendingOrder.color = getTextColor()
    m.title.color = getTextColor()
    m.which_week.color = getTextColor()
    m.banner_title.color = getTextColor()
    m.type.color = getTextColor()
    m.synopsis.color = getTextColor()
    m.directorAndYear.color = getTextColor()
end sub



sub itemContentChanged()

    ' ?"itemContentChanged"
    ' ?m.top.itemContent
    if m.top.itemContent.itemType = "SHOW_MORE_ITEM"
        m.main_rect.color = getBackGroundColor1()
        m.title.color = getButtonSelectionColor()
        m.title.width = m.top.width
        m.title.height = m.top.height
        m.title.horizAlign = "center"
        m.title.text = getTextOf("show_more")
        m.title.vertAlign = "center"
        m.title.translation = [0, 0]
    else
        m.main_rect.color = "#00000000"
        updateLayout()

        if m.top.itemContent <> invalid and m.top.itemContent.thumbnail_orientation <> invalid
            m.thumbnail_orientation = m.top.itemContent.thumbnail_orientation

        else
            m.thumbnail_orientation = getThumbnailOrientaion()

        end if


        if m.top.itemContent.itemType = "SCHEDULE" or m.top.itemContent.itemType = "SHORTS"
            m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
            m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        else
            m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
            m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()
        end if


        if m.thumbnail_orientation = "LANDSCAPE"
            m.Poster.uri = m.top.itemContent.HDBACKGROUNDIMAGEURL
            ' m.myMaskGroup.uri = "pkg:/images/rounded_corners.png"
            if m.top.itemContent.itemType = "SCHEDULE"
                m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
                m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
            else
                m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
                m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()

                if m.top.itemContent.HDBACKGROUNDIMAGEURL <> "" and m.top.itemContent.HDBACKGROUNDIMAGEURL <> invalid
                    m.Poster.uri = m.top.itemContent.HDBACKGROUNDIMAGEURL
                else
                    m.Poster.uri = getPLACEHOLDER_IMAGE()
                    ' if  m.top.itemContent.HDPosterURLPortrait<>""  and  m.top.itemContent.HDPosterURLPortrait<>invalid
                    '     m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
                    ' else
                    '     m.Poster.uri = getPLACEHOLDER_IMAGE_PORTRAIT ()
                    ' end if
                end if

            end if


        else if m.thumbnail_orientation = "PORTRAIT"
            if m.top.itemContent.itemType = "BANNER" or m.top.itemContent.itemType = "PODCAST"
                ' m.posterForBanner.width = m.top.width
                ' m.posterForBanner.height = m.top.height
                ' m.posterForBanner.loadWidth = m.top.width
                ' m.posterForBanner.loadHeight = m.top.height
                m.posterForBanner.failedBitmapUri = getPLACEHOLDER_IMAGE()
                m.posterForBanner.loadingBitmapUri = getPLACEHOLDER_IMAGE()
                if m.top.itemContent.HDBACKGROUNDIMAGEURL <> invalid and m.top.itemContent.HDBACKGROUNDIMAGEURL <> ""
                    m.posterForBanner.uri = m.top.itemContent.HDBACKGROUNDIMAGEURL
                else
                    m.posterForBanner.uri = getPLACEHOLDER_IMAGE()
                end if
            else
                ' m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
                m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
                m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()


                if m.top.itemContent.HDPosterURLPortrait <> "" and m.top.itemContent.HDPosterURLPortrait <> invalid
                    m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
                    ' m.myMaskGroup.uri = "pkg:/images/rounded_corners_portrait.png"
                else
                    m.Poster.uri = getPLACEHOLDER_IMAGE_PORTRAIT ()
                end if
            end if
        end if




        if m.top.itemContent.Title <> invalid
            m.title.text = m.top.itemContent.Title
        end if
        m.title.font.size = 23
        m.title.color = getTextColor()

        m.descriptionBanner.visible = "false"
        m.banner_title.visible = "false"
        m.directorAndYear.visible = "false"
        m.type.visible = "false"

        if m.top.itemContent.is_free_video <> invalid and m.top.itemContent.is_free_video = true
            m.free_icon.visible = true
            m.lock_icon.visible = false

        else if m.top.itemContent.is_locked <> invalid and m.top.itemContent.is_locked = true
            m.lock_icon.visible = true
            m.free_icon.visible = false

        else
            m.free_icon.visible = false
            m.lock_icon.visible = false
        end if



        ' if m.top.itemContent.is_free_video <> invalid and m.top.itemContent.is_free_video = true
        '     m.free_icon.visible = false
        '     m.lock_icon.visible = false
        ' else
        '     m.free_icon.visible = false
        '     m.lock_icon.visible = true
        '     if (IsNotNull2(m.top.itemContent.rental_flag) and m.top.itemContent.rental_flag = 1) or (IsNotNull2(m.top.itemContent.payper_flag) and m.top.itemContent.payper_flag = 1) then
        '         m.lock_icon.uri = "pkg:/images/icons/dollar.png"
        '     else if getIsUserSubscribed2() = "true" then ' Assumes this global/helper is available
        '         m.lock_icon.uri = "pkg:/images/icons/unlock.png"
        '     else
        '         m.lock_icon.uri = "pkg:/images/icons/lock_icon.png"
        '     end if
        ' end if



        if m.top.itemContent.premium_flag = 1
            m.Premium.visible = true
        else
            m.Premium.visible = true
        end if


        if m.top.itemContent.DoesExist("categoryType") and m.top.itemContent.categoryType = "LIVE"
            ' ?"banner item called"
            ' if not m.top.itemContent.name = invalid
            ' end if
            m.liveIcon.visible = true
            m.playButton.visible = false
            m.Progressbar.visible = false
            setTitleVisibility()
            ' m.banner_title.visible = true
            ' m.type.text = m.top.itemContent.duration_text
            ' m.synopsis.text = ""'m.top.itemContent.synopsis
            ' m.synopsis.visible = false
            ' m.synopsis.font.size = 26
            ' m.synopsis.translation = [0, m.banner_title.translation[1] + m.banner_title.boundingRect().height + 70]
            ' m.type.visible = false
            ' m.type.font.size = 26
            ' m.type.translation = [0, m.banner_title.translation[1] + m.banner_title.boundingRect().height + 10]
            ' m.descriptionBanner.visible = false
            ' ' m.descriptionBanner.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
            ' m.top_gradient.visible = false
            ' m.descriptionBanner.height = 300
            ' m.descriptionBanner.width = 500
            ' m.descriptionBanner.font.size = "35"
            ' m.descriptionBanner.translation = [30, m.banner_title.translation[1] + m.banner_title.boundingRect().height + 10]
            ' m.descriptionBanner.font = "font:SmallestSystemFont"
            ' m.banner_title.text = ""
            ' m.descriptionBanner.text = ""
            ' m.poster.visible = false
            ' m.posterForBanner.visible = false
            ' m.imageTitlePoster.visible = false
            ' m.bannerLeftGradient.visible = true
            ' m.lock_icon.visible = false
            ' m.free_icon.visible = false
            ' m.title.visible = false
            ' m.itemView_Center_Label.visible = false
            ' m.main_rect.color = "#00000000"
            return
        else
            m.liveIcon.visible = false
            m.imageTitlePoster.visible = false
            m.title.visible = true
            m.synopsis.visible = "false"
            m.bottom_gradient.visible = "false"
            m.top_gradient.visible = false
            m.bannerLeftGradient.visible = false
            m.type.visible = false
            setTitleVisibility()
            m.posterForBanner.visible = false
            m.poster.visible = true
            m.Poster.translation = [0, 0]
            if m.PlayerForTimeGrid <> invalid
                m.PlayerForTimeGrid.visible = false
            end if
        end if


        if m.top.itemContent.DoesExist("categoryType") and m.top.itemContent.categoryType = "FEATURED"
            ' ?"banner item called"
            m.imageTitlePoster.visible = false
            if not m.top.itemContent.name = invalid
                m.banner_title.text = m.top.itemContent.name
            end if
            setTitleVisibility()
            m.banner_title.visible = false
            m.type.text = m.top.itemContent.duration_text
            m.synopsis.text = ""'m.top.itemContent.synopsis
            m.synopsis.visible = false
            m.synopsis.font.size = 26
            m.synopsis.translation = [0, m.banner_title.translation[1] + m.banner_title.boundingRect().height + 70]
            m.type.visible = false
            m.type.font.size = 26
            m.type.translation = [0, m.banner_title.translation[1] + m.banner_title.boundingRect().height + 10]
            m.descriptionBanner.visible = false
            m.descriptionBanner.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
            m.bottom_gradient.visible = true
            m.bottom_gradient.height = 582
            m.bottom_gradient.translation = [0, 268]
            m.top_gradient.visible = false
            m.descriptionBanner.font.size = "35"
            m.descriptionBanner.font = "font:SmallestSystemFont"
            m.descriptionBanner.translation = [105, 615]
            m.descriptionBanner.height = 180
            m.descriptionBanner.width = 700
            m.posterForBanner.loadWidth = m.top.width
            m.posterForBanner.loadHeight = m.top.height
            m.posterForBanner.width = 850
            m.posterForBanner.height = 559
            m.posterForBanner.translation = [0, 0]
            m.posterForBanner.visible = true
            m.poster.visible = false
            m.posterForBanner.failedBitmapUri = getPLACEHOLDER_IMAGE()
            m.posterForBanner.loadingBitmapUri = getPLACEHOLDER_IMAGE()
            m.posterForBanner.uri = m.top.itemContent.HDBACKGROUNDIMAGEURL
            m.bannerLeftGradient.visible = false
            m.lock_icon.visible = false
            m.free_icon.visible = false
            m.title.visible = false
            return
        else
            m.imageTitlePoster.visible = false
            m.descriptionBanner.visible = false
            m.title.visible = true
            m.synopsis.visible = "false"
            m.bottom_gradient.visible = "false"
            m.top_gradient.visible = false
            m.bannerLeftGradient.visible = false
            m.type.visible = false
            m.banner_title.text = ""
            setTitleVisibility()
            m.posterForBanner.visible = false
            m.poster.visible = true
            m.Poster.translation = [0, 0]
        end if


        if m.top.itemContent.DoesExist("itemType")

            if m.top.itemContent.itemType = "FILM_OF_THE_WEEK"
                ' ?"filmOfTheWeek item called"
                m.Poster.uri = m.top.itemContent.HDPOSTERURL
                m.main_rect.width = "500"
                m.main_rect.height = "281"
                m.bottom_gradient.visible = true
                m.bottom_gradient.translation = [0, m.top.height - 500]
                m.bottom_gradient.height = 500
                m.bottom_gradient.width = m.top.width
                ' m.Poster.width = "500"
                ' m.Poster.height = "281"
                m.Poster.width = "1680"
                m.Poster.height = "936"
                m.which_week.font.size = "16"
                m.which_week.text = m.top.itemContent.week
                m.which_week.visible = true
                m.which_week.translation = [10, 140]
                m.banner_title.font.size = "35"
                m.banner_title.visible = "true"
                ' m.banner_title.translation = [49, 182]
                m.banner_title.translation = [59, 218]
                m.banner_title.text = m.top.itemContent.show_name
                m.type.text = m.top.itemContent.type
                m.type.visible = "false"
                m.type.font.size = "20"
                m.descriptionBanner.visible = "false"
                m.descriptionBanner.font.size = "27"
                ' m.descriptionBanner.translation = "[47,267]"
                m.descriptionBanner.translation = "[55,322]"
                m.descriptionBanner.height = "106"
                m.descriptionBanner.width = "1610"
                m.descriptionBanner.text = m.top.itemContent.synopsis
                m.directorAndYear.visible = "true"
                m.directorAndYear.translation = "[10,190]"
                m.directorAndYear.font.size = "18"
                ' m.top_gradient.translation = [0, -3]
                m.top_gradient.translation = [-6, -2]
                m.top_gradient.height = 782
                m.top_gradient.visible = true


                if not m.top.itemContent.director = invalid and not m.top.itemContent.year = invalid
                    m.directorAndYear.text = m.top.itemContent.director + " " + m.top.itemContent.year.toStr()
                else if not m.top.itemContent.director = invalid and m.top.itemContent.year = invalid
                    m.directorAndYear.text = m.top.itemContent.director
                else if m.top.itemContent.director = invalid and not m.top.itemContent.year = invalid
                    m.directorAndYear.text = m.top.itemContent.year.toStr()
                end if

            else

            end if
        end if


        if m.top.itemContent.DoesExist("categoryType") and m.top.itemContent.categoryType = "SHORTS"
            m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
        else

        end if

        if m.top.itemContent.DoesExist("categoryType") and m.top.itemContent.categoryType = "PODCASTS"
            m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
        else
            ' m.top.itemContent.categoryType = "PODCASTS"
            'm.Poster.uri=m.top.itemContent.HDPosterURLPortrait
        end if


        if m.top.itemContent.DoesExist("categoryType")
            if m.top.itemContent.categoryType = "GENRES"

                ' m.main_rect.color = getButtonSelectionColor()
                m.Poster.visible = true
                m.playButton.visible = true
                m.PlayButton.uri = "pkg:/images/icons/channel.png"
                
                _iv_translation = m.itemView_Center_Label.translation
                if m.playButton.visible = true
                    m.itemView_Center_Label.visible = true
                    m.itemView_Center_Label.translation = [_iv_translation[0], 75]
                else
                    m.itemView_Center_Label.translation = [_iv_translation[0], 0]
                end if

                if m.top.itemContent.HDPosterURL <> invalid and m.top.itemContent.HDPosterURL <> ""
                    m.Poster.uri = m.top.itemContent.HDPosterURL
                    
                else if m.top.itemContent.HDPosterURLPortrait <> invalid and m.top.itemContent.HDPosterURLPortrait <> ""
                    m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
                else
                    m.Poster.visible = false
                    m.itemView_Center_Label.visible = true
                end if

                m.lock_icon.visible = false
                m.posterForBanner.visible = false
                if m.top.itemContent.name <> invalid then m.itemView_Center_Label.text = m.top.itemContent.name else m.itemView_Center_Label.text = m.top.itemContent.category_name
                return
            else
                m.itemView_Center_Label.visible = false
                m.Poster.visible = true
                m.posterForBanner.visible = false
                m.PlayButton.uri = "pkg:/images/icons/play.png"
                m.PlayButton.visible = false
            end if
        end if

        if m.top.itemContent.DoesExist("categoryType") and m.top.itemContent.categoryType = "TOP_TRENDING"
            m.topTrendingOrder.text = m.top.itemContent.topTrendingOrder.ToStr()
            m.topTrendingOrder.visible = true
            ' ?"Len(m.top.itemContent.topTrendingOrder.ToStr())"
            ' ?Len(m.top.itemContent.topTrendingOrder.ToStr())
            ' ?m.top.itemContent.topTrendingOrder

            handleTopTrendingText(m.top.itemContent.topTrendingOrder)
            m.bottom_gradient.visible = true

            m.topTrendingOrderOverlayGradient.height = m.Poster.height
            m.topTrendingOrderOverlayGradient.translation = [m.Poster.translation[0] - 60, 0]
            m.bottom_gradient.translation = [0, m.top.height - 100]
            m.bottom_gradient.height = 100
            m.bottom_gradient.width = m.top.width
            m.descriptionBanner.visible = "false" 'FALSE
            m.Poster.uri = m.top.itemContent.tumbnail
            m.title.text = m.top.itemContent.title
            m.title.visible = false
            m.topTrendingOrderOverlayGradient.visible = true
            m.startingdate.visible = "true"
            m.playButton.visible = false
            return
        else
            setTitleVisibility()
            m.endingdate.visible = false
            m.topTrendingOrderOverlayGradient.visible = false
            m.topTrendingOrder.visible = false
            m.bottom_gradient.visible = false
            m.descriptionBanner.visible = false
            ' m.Poster.failedBitmapUri =  getPLACEHOLDER_IMAGE()
            ' m.Poster.loadingBitmapUri =  getPLACEHOLDER_IMAGE()
        end if


        ' if m.top.itemContent.DoesExist("itemtype") and m.top.itemContent.categoryType = "FEATURED"
        '     ' ?"featured item called"
        '     m.CornerRoundedforHomeScene.width = "1700"
        '     m.CornerRoundedforHomeScene.height = "956"
        '     m.title.visible = false
        '     m.banner_title.text = m.top.itemContent.Title
        '     m.banner_title.wrap = "true"
        '     m.banner_title.visible = "true"
        '     m.type.text = m.top.itemContent.type
        '     m.type.visible = "false"
        '     m.type.font.size = "20"

        '     m.directorAndYear.text = m.top.itemContent.director + " " + m.top.itemContent.year.toStr()
        '     m.directorAndYear.visible = "true"
        '     m.directorAndYear.font.size = "18"

        '     m.descriptionBanner.visible = "true"
        '     m.descriptionBanner.text = m.top.itemContent.synopsis
        '     m.descriptionBanner.font.size = "32"
        '     return
        ' else

        ' end if


        if m.top.itemContent.itemType = "SCHEDULE"
            m.bottom_gradient.visible = true
            m.bottom_gradient.translation = [0, m.top.height - 100]
            m.bottom_gradient.height = 100
            m.bottom_gradient.width = m.top.width
            m.descriptionBanner.visible = "false" 'FALSE
            m.descriptionBanner.text = convertToDate(m.top.itemContent.start_time)
            m.Poster.uri = m.top.itemContent.tumbnail

            m.title.text = m.top.itemContent.title
            setTitleVisibility()
            m.startingdate.visible = "true"
            m.startingdate.text = convertZTimeToNormalLocalTime(m.top.itemContent.start_time) + "  -  "
            m.endingdate.visible = "true"
            m.endingdate.text = convertZTimeToNormalLocalTime(m.top.itemContent.end_time)
            todaysdate = getTodaysDate()

            if m.descriptionBanner.text = todaysdate then 'Friday Feb 8, 2024(todaysdate format)
                m.descriptionBanner.visible = "false" 'FALSE
                setTitleVisibility()
                ' m.startingdate.translation = "[10,338]"
                m.startingdate.font.size = "18"
                ' m.endingdate.translation = "[120,340]"
                m.endingdate.font.size = "18"

            else
                setTitleVisibility()
                m.descriptionBanner.visible = "false" 'TRUE
                ' m.descriptionBanner.translation = "[10,315]"
                m.descriptionBanner.font.size = "18"
                m.startingdate.font.size = "18"
                m.endingdate.font.size = "18"
                return
            end if
            return
        else
            m.endingdate.visible = false
            m.bottom_gradient.visible = false
            m.descriptionBanner.visible = false
            ' m.Poster.failedBitmapUri =  getPLACEHOLDER_IMAGE()
            ' m.Poster.loadingBitmapUri =  getPLACEHOLDER_IMAGE()
        end if



        ' if m.top.itemContent.itemType = "featured"
        '     ?"featured item called"
        '     m.CornerRoundedforHomeScene.width = "1700"
        '     m.CornerRoundedforHomeScene.height = "956"
        '     m.title.visible = "false"
        '     m.banner_title.text = m.top.itemContent.Title
        '     m.banner_title.wrap = "true"
        '     m.banner_title.visible = "true"
        '     m.type.text = m.top.itemContent.type
        '     m.type.visible = "false"
        '     m.type.font.size = "20"

        '     m.directorAndYear.text = m.top.itemContent.director + " " + m.top.itemContent.year.toStr()
        '     m.directorAndYear.visible = "true"
        '     m.directorAndYear.font.size = "18"

        '     m.descriptionBanner.visible = "true"
        '     m.descriptionBanner.text = m.top.itemContent.synopsis
        '     m.descriptionBanner.font.size = "32"
        ' end if





        if m.top.itemContent.DoesExist("itemType")
            if m.top.itemContent.itemType = "LIVE_EVENT"
                m.Poster.uri = m.top.itemContent.HDPOSTERURL
                m.liveIcon.visible = true
            else
                m.liveIcon.visible = false
            end if
        end if


        if m.top.itemContent.DoesExist("itemType")
            if m.top.itemContent.itemType = "CONTINUE_WATCHING"
                ' ?"continueWatching item called"
                m.Progressbar.visible = true
                m.playButton.visible = true
                if m.top.itemContent.DoesExist("watched_percentage")
                    ' m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
                    m.progressbar.width = (m.top.itemContent.watched_percentage / 100) * m.main_rect.width
                    m.progressbar.visible = true

                end if
            else
                m.Progressbar.visible = false
                m.playButton.visible = false
            end if
        end if



        ' if m.top.height < 400 and m.top.width < 400
        '     if m.top.itemContent.categoryType <> "FEATURED"
        '         m.Poster.loadWidth = 300'850
        '         m.Poster.loadHeight = 300'559
        '         ?"dhgdfjsdhgjfsdhgjfhd111111111 ";m.top.itemContent.categoryType
        '     else
        '         ?"dhgdfjsdhgjfsdhgjfhd22222 ";m.top.itemContent.categoryType
        '         m.Poster.loadWidth = 850
        '         m.Poster.loadHeight = 559
        '     end if
        ' end if

    end if
end sub


sub setTitleVisibility()
    if getHide_Title_Under_Movies() = "true"
        m.title.visible = false
    else
        m.title.visible = true
    end if
end sub

function handleTopTrendingText(topTrendingOrder)
    if m.thumbnail_orientation = "LANDSCAPE"
        if topTrendingOrder < 10
            topTrendingOrderYposition = m.Poster.translation[1] - 35
        else
            topTrendingOrderYposition = m.Poster.translation[1] - 25
        end if
    else m.thumbnail_orientation = "PORTRAIT"
        if topTrendingOrder < 10
            topTrendingOrderYposition = m.Poster.translation[1] + 90
        else
            topTrendingOrderYposition = m.Poster.translation[1] + 115
        end if
    end if

    if topTrendingOrder < 10
        m.topTrendingOrder.font.size = 170
    else
        m.topTrendingOrder.font.size = 170
    end if

    if topTrendingOrder = 1
        m.topTrendingOrder.translation = [-60, topTrendingOrderYposition]
    else if topTrendingOrder = 11
        m.topTrendingOrder.translation = [-130, topTrendingOrderYposition]
    else if topTrendingOrder = 21
        m.topTrendingOrder.translation = [-140, topTrendingOrderYposition]
    else if topTrendingOrder = 34
        m.topTrendingOrder.translation = [-192, topTrendingOrderYposition]

    else if topTrendingOrder < 10
        m.topTrendingOrder.translation = [-110, topTrendingOrderYposition] ' 1 - 9
    else if topTrendingOrder < 20
        m.topTrendingOrder.translation = [-160, topTrendingOrderYposition] ' 10 to 19
    else if topTrendingOrder > 19
        m.topTrendingOrder.translation = [-174, topTrendingOrderYposition] ' 20 - etc
    end if
end function


function getTodaysDate()
    date = CreateObject("roDateTime")
    day = date.GetDayOfMonth()
    getyear = date.GetYear()
    dayofweek = date.GetDayOfWeek()
    dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    if dayofweek >= 0 and dayofweek < dayNames.Count()
        dayName = dayNames[dayofweek]
    else
    end if
    month = date.GetMonth()
    monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    abbreviatedMonth = monthNames[month - 1] ' Adjust for 0-based indexing
    currentdate = dayName + " " + abbreviatedMonth + " " + day.toStr() + ", " + getyear.toStr()
    return currentdate
end function



sub updateLayout()
    if m.top.height > 0 and m.top.width > 0 then
        m.Poster.width = m.top.width
        m.Poster.height = m.top.height
        m.Poster.loadWidth = m.top.width
        m.Poster.loadHeight = m.top.height

        ' m.onFocusPlayVideo.width = m.top.width
        ' m.onFocusPlayVideo.height = m.top.height

        m.itemView_Center_Label.width = m.top.width '- 30
        m.itemView_Center_Label.height = m.top.height ' - 30

        m.posterForBanner.width = m.top.width
        m.posterForBanner.height = m.top.height
        m.posterForBanner.loadWidth = m.top.width
        m.posterForBanner.loadHeight = m.top.height

        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height
        ' ?m.top.width '-320
        ' ?m.top.height '-180

        m.bottom_gradient.width = m.top.width
        m.top_gradient.width = m.top.width

        'roundcorner
        m.myMaskGroup.maskSize = [m.top.width, m.top.height]

        if IsNotNull2(m.top.height) and IsNotNull2(m.top.width) and m.top.height < m.top.width
            m.myMaskGroup.maskUri = "pkg:/images/design_assets/rounded_corners.png"
            m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()
        else if IsNotNull2(m.top.height) and IsNotNull2(m.top.width) and m.top.height > m.top.width
            m.myMaskGroup.maskUri = "pkg:/images/design_assets/rounded_corners_portrait.png"
            m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        else
            m.myMaskGroup.maskUri = ""
        end if

        'date  '48-ok
        m.descriptionBanner.translation = [105, 615]'[10, m.top.height - 54]

        'startindate translation
        m.startingdate.translation = [10, m.top.height - 30]
        m.endingdate.translation = [113, m.top.height - 30]


        m.bottom_gradient.translation = [10, 465]'[10, m.top.height - 30]
        '  m.bottom_gradient.translation= "[10,190]"

        'title position
        m.title.translation = [10, m.top.height + 10]
        m.title.width = m.top.width

        'progressbar

        m.Progressbar.translation = [0, m.top.height - 11]
        m.Progressbar.width = m.top.width


        'liveIcon
        m.liveIcon.translation = [15, 15]

        m.bannerLeftGradient.translation = [0, 0]
        m.bannerLeftGradient.height = m.top.height

        'lock-icon
        m.lock_icon.translation = [m.top.width - 45, 15]

        'playnowButton
        m.playButton.translation = [(m.top.width / 2) - 35, (m.top.height / 2) - 35]

        ' if m.top.itemContent.item_shape = "SQUARE" or m.top.itemContent.item_shape = "ROUND"

        ' end if

    end if
end sub



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
    return date.AsDateString("short-month-short-weekday")
end function

function onitemHasFocus()
    ' if m.top.itemHasFocus
    '     m.onFocusPlayVideo.width = m.top.width + 100
    '     m.onFocusPlayVideo.height = m.top.height + 100
    '     m.onFocusPlayVideo.translation = [-50, -50]
    ' else
    '     m.onFocusPlayVideo.width = m.top.width
    '     m.onFocusPlayVideo.height = m.top.height
    '     m.onFocusPlayVideo.translation = [0, 0]
    ' end if
    if m.top.itemContent <> invalid
        if m.top.itemHasFocus and m.top.itemContent.categoryType = "LIVE"
            if m.PlayerForTimeGrid = invalid
                ' callLiveApi() 'HOMESCENE_BANNER_PLAY 'call live api
            else if m.PlayerForTimeGrid <> invalid and m.PlayerForTimeGrid.getchild(3) <> invalid and m.PlayerForTimeGrid.getchild(3).control = "stop"
                m.PlayerForTimeGrid.getchild(3).control = "play"
                m.PlayerForTimeGrid.getchild(3).visible = true
                m.PlayerForTimeGrid.visible = true
                m.banner_title.visible = true
                if m.PlayerForTimeGrid <> invalid and m.PlayerForTimeGrid.content <> invalid and m.PlayerForTimeGrid.content.title <> invalid
                    m.banner_title.text = m.PlayerForTimeGrid.content.title
                end if
                if m.PlayerForTimeGrid <> invalid and m.PlayerForTimeGrid.content <> invalid and m.PlayerForTimeGrid.content.descriptionBanner <> invalid
                    m.descriptionBanner.text = m.PlayerForTimeGrid.content.description
                end if
                m.global.Live_player = m.PlayerForTimeGrid
            end if

        else if m.top.itemContent.categoryType = "FEATURED"
            ' m.onFocusPlayVideo.control = "stop"
            ' m.onFocusPlayVideo.visible = false
            if m.PlayerForTimeGrid <> invalid and m.PlayerForTimeGrid.getchild(3) <> invalid
                m.PlayerForTimeGrid.visible = false
                m.PlayerForTimeGrid.getchild(3).visible = false
            end if
        else
            if m.top.itemContent.itemtype = "SHOW" 'trailer play
                ' ?"m.onFocusPlayVideo.control = stop111 "m.top.itemContent.itemtype
                ' m.onFocusPlayVideoTimer.control = "stop"
                ' m.onFocusPlayVideo.control = "stop"
                ' if m.global.Live_player = invalid 'and m.global.Live_player.getchild(3) <> invalid and m.global.Live_player.getchild(3).state <> "playing"
                '     m.onFocusPlayVideoTimer.control = "start"
                ' end if
            else
                ' ?"m.onFocusPlayVideo.control = stop222 "m.top.itemContent.itemtype
                ' m.onFocusPlayVideo.control = "stop"
                ' m.onFocusPlayVideo.visible = false
            end if
        end if
    end if
end function

' function onFocusPlayVideoTimerFire()
'     ?"onFocusPlayVideoTimerFire called"



'     if not m.top.itemContent.categoryType = "FEATURED" and not m.top.itemContent.categoryType = "GENRES" and not m.top.itemContent.categoryType = "TOP_TRENDING" and not m.top.itemContent.categoryType = "CONTINUE_WATCHING" and not m.top.itemContent.categoryType = "SCHEDULE" and m.top.itemHasFocus
'         videoContent = createObject("RoSGNode", "ContentNode")
'         videoContent.url = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8" 'm.top.itemContent.show_trailer '
'         videoContent.title = ""
'         videoContent.unObserveField("state")
'         videoContent.streamformat = "m3u8"
'         sec = CreateObject("roRegistrySection", getAppKey2())
'         if sec.Exists("tokplayy")
'             tok = sec.Read("tokplayy")
'         end if
'         m.onFocusPlayVideo.content = videoContent
'         ' m.onFocusPlayVideo.AddHeader("token", tok)
'         m.onFocusPlayVideo.control = "play"
'         ' video.observeField("state", "trailerstate")
'         ' if URLToBePlayed = ""
'         '     m.backGroundVideo.control = "stop"
'         '     m.backGroundVideo.visible = false
'         ' end if
'     end if
' end function

' sub onTrailerstate()
'     if m.onFocusPlayVideo.state = "buffering"
'         m.onFocusPlayVideo.visible = false
'     else if m.onFocusPlayVideo.state = "playing"
'         if m.top.itemHasFocus
'             m.onFocusPlayVideo.visible = true
'         else
'             m.onFocusPlayVideo.visible = false
'         end if
'     else if m.onFocusPlayVideo.state = "stopped"
'         m.onFocusPlayVideo.visible = false
'     end if
' end sub



'########################## BANNER ITEMVIEW LIVE PLAY SECTION #################################################

sub callLiveApi()
    m.liveApi = createObject("roSGNode", "LiveFetcher")
    if m.top.itemContent.live_channel_id <> invalid and m.top.itemContent.live_channel_id.Tostr() <> ""
        m.liveApi.channel_id = m.top.itemContent.live_channel_id.ToStr()
    else
        m.liveApi.channel_id = getchannelsid()
    end if
    m.liveApi.LiveScheduleRequest = "run"
    m.liveApi.callFunc("runLiveFetcherTask", "HOMESCENE_BANNER_PLAY")
    m.liveApi.observeField("livefetcherResponse", "onPlayLive")
end sub

sub onPlayLive()
    playLiveVideo(m.liveApi.livefetcherResponse[0])
end sub

sub playLiveVideo(liveResponseData)
    ?"playVideoFunction called : VideoPlayerForTimeGridScene"
    if liveResponseData <> invalid and liveResponseData.now_playing <> invalid

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
            "is_from": "HOMESCENE_BANNER_PLAY"
        })
        content.ClosedCaptions = true
        content.globalCaptionMode = "On"
        content.HDBranded = true
        content.IsHD = true
        if m.PlayerForTimeGrid = invalid:
            m.PlayerForTimeGrid = m.top.CreateChild("PlayerForTimeGrid")
            m.PlayerForTimeGrid.getchild(3).width = 1154
            m.PlayerForTimeGrid.getchild(3).height = m.top.height
            m.PlayerForTimeGrid.getchild(3).enableUI = false
            m.PlayerForTimeGrid.getchild(3).translation = [544, 0]
            m.PlayerForTimeGrid.observeField("state", "PlayerForTimeGridStateChanged")
            m.PlayerForTimeGrid.observeField("visible", "onVideoForTimeGridPlayerVisibleChange")
            m.global.Live_player = m.PlayerForTimeGrid
        end if
        m.top.removeChild(m.banner_title) 'remove and add to change the z-order
        m.top.removeChild(m.descriptionBanner)
        m.top.removeChild(m.bannerLeftGradient)
        m.top.removeChild(m.liveIcon)

        m.top.appendChild(m.bannerLeftGradient)
        m.top.appendChild(m.descriptionBanner)
        m.top.appendChild(m.banner_title)
        m.top.appendChild(m.liveIcon)

        m.banner_title.text = title
        m.descriptionBanner.text = description

        m.PlayerForTimeGrid.content = content
        m.PlayerForTimeGrid.watched_duration = 0
        m.PlayerForTimeGrid.visible = true
        m.PlayerForTimeGrid.skipAd = true
        m.PlayerForTimeGrid.setFocus(true)
        m.PlayerForTimeGrid.control = "play"
    end if
end sub

function PlayerForTimeGridStateChanged()
    ?"PlayerForTimeGridStateChanged called : VideoPlayerScene ";m.PlayerForTimeGrid.state
    if m.PlayerForTimeGrid.state = "done" or m.PlayerForTimeGrid.state = "stop"
        ?"onVideoForTimeGridPlayerVisibleChange called222"
        m.PlayerForTimeGrid.control = "stop"
    end if
end function


function onVideoForTimeGridPlayerVisibleChange(params)
    ?"onVideoForTimeGridPlayerVisibleChange called"
    ?m.PlayerForTimeGrid.state

end function

'*******************Channel Id***********************************
function getchannelsid() as object
    sec = CreateObject("roRegistrySection", getAppKey2())
    if sec.Exists("channelsids")
        ChannelId = sec.Read("channelsids")
        return ChannelId
    else
        return ""
    end if
end function

function getFastChannelId() as string
    data = CreateObject("roRegistrySection", getAppKey2())
    if data.Exists("FAST_CHANNEL_ID")
        output = data.Read("FAST_CHANNEL_ID")
        return output
    else
        return "0"
    end if
end function