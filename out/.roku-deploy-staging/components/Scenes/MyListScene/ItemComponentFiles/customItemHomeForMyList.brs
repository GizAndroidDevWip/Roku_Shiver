sub Init()

    m.Poster = m.top.findNode("poster")
    if getThumbnailOrientaion() = "LANDSCAPE"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()

    else if getThumbnailOrientaion() = "PORTRAIT"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
    end if

    m.Premium = m.top.findNode("premiumIcon")
    m.lock_icon = m.top.findNode("lock_icon")
    m.free_icon = m.top.findNode("free_icon")


    m.title = m.top.findNode("title")
    m.which_week = m.top.findNode("which_week")
    m.banner_title = m.top.findNode("banner_title")
    m.type = m.top.findNode("type")
    m.directorAndYear = m.top.findNode("directorAndYear")
    m.bottom_gradient = m.top.findNode("bottom_gradient")
    m.top_gradient = m.top.findNode("top_gradient")
    m.descriptionBanner = m.top.findNode("descriptionBanner")
    m.main_rect = m.top.findNode("main_rect")
    m.CornerRoundedforHomeScene = m.top.findNode("CornerRoundedforHomeScene")
    m.liveIcon = m.top.findNode("live")
    m.Progressbar = m.top.findNode("Progressbar")
    m.Progressbar.color = getButtonSelectionColor()
    m.playButton = m.top.findNode("playButton")
end sub



sub itemContentChanged()

    updateLayout()

    if getThumbnailOrientaion() = "LANDSCAPE"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()
        m.Poster.uri = m.top.itemContent.HDPOSTERURL

    else if getThumbnailOrientaion() = "PORTRAIT"
        if m.top.itemContent.itemType = "BANNER"
            m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
            m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()
            m.Poster.uri = m.top.itemContent.HDPosterURL
        else
            m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
            m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
            m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        end if
    end if

    if not m.top.itemContent.Title = invalid
        m.title.text = m.top.itemContent.Title
    end if
    m.title.font.size = "20"
    m.title.color = getTextColor()

    if getHide_Title_Under_Movies() = "true"
        m.title.visible = false
    else
        m.title.visible = true
    end if

    m.descriptionBanner.visible = "false"
    m.banner_title.visible = "false"
    m.directorAndYear.visible = "false"
    m.type.visible = "false"


    if m.top.itemContent.is_free_video <> invalid and m.top.itemContent.is_free_video = true
        m.free_icon.visible = false
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
        m.Premium.visible = false
    else
        m.Premium.visible = false
    end if


    if m.top.itemContent.DoesExist("itemType") and m.top.itemContent.itemType = "BANNER"
        m.CornerRoundedforHomeScene.visible = "false"
        if not m.top.itemContent.Title = invalid
            m.banner_title.text = m.top.itemContent.Title
        end if
        m.title.visible = "false"
        m.banner_title.visible = "true"
        m.type.text = m.top.itemContent.type
        m.type.visible = "true"
        m.type.font.size = "20"
        m.descriptionBanner.visible = "true"
        m.descriptionBanner.text = m.top.itemContent.resolution
        m.bottom_gradient.visible = "true"
        m.top_gradient.visible = true
        m.descriptionBanner.font.size = "32"
        m.descriptionBanner.font = "font:SmallestBoldSystemFont"
    else
        m.bottom_gradient.visible = "false"
        m.top_gradient.visible = false
    end if


    if m.top.itemContent.DoesExist("itemType")

        if m.top.itemContent.itemType = "FILM_OF_THE_WEEK"
            m.main_rect.width = "500"
            m.main_rect.height = "281"
            m.Poster.width = "500"
            m.Poster.height = "281"
            m.which_week.font.size = "16"
            m.which_week.text = m.top.itemContent.week
            m.which_week.visible = true
            m.which_week.translation = [10, 140]
            m.banner_title.font.size = "30"
            m.banner_title.visible = "true"
            m.banner_title.translation = [10, 160]
            m.banner_title.text = m.top.itemContent.show_name
            m.type.text = m.top.itemContent.type
            m.type.visible = "false"
            m.type.font.size = "20"
            m.descriptionBanner.visible = "true"
            m.descriptionBanner.font.size = "18"
            m.descriptionBanner.translation = "[10,220]"
            m.descriptionBanner.text = m.top.itemContent.resolution
            m.directorAndYear.visible = "true"
            m.directorAndYear.translation = "[10,190]"
            m.directorAndYear.font.size = "18"

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




    if m.top.itemContent.itemType = "featured"
        '    ?"featured item called"
        m.CornerRoundedforHomeScene.width = "1700"
        m.CornerRoundedforHomeScene.height = "956"
        m.title.visible = "false"
        m.banner_title.text = m.top.itemContent.Title
        m.banner_title.wrap = "true"
        m.banner_title.visible = "true"
        m.type.text = m.top.itemContent.type
        m.type.visible = "false"
        m.type.font.size = "20"

        m.directorAndYear.text = m.top.itemContent.director + " " + m.top.itemContent.year.toStr()
        m.directorAndYear.visible = "true"
        m.directorAndYear.font.size = "18"

        m.descriptionBanner.visible = "true"
        m.descriptionBanner.text = m.top.itemContent.synopsis
        m.descriptionBanner.font.size = "32"
    end if

    if m.top.itemContent.DoesExist("itemType")
        if m.top.itemContent.itemType = "LIVE" or m.top.itemContent.itemType = "LIVE_EVENT"
            m.Poster.uri = m.top.itemContent.HDPOSTERURL
            m.liveIcon.visible = true
        else
            m.liveIcon.visible = false
        end if
    end if


    if m.top.itemContent.DoesExist("itemType")

        if m.top.itemContent.itemType = "CONTINUE_WATCHING"
            m.Progressbar.visible = true
            m.playButton.visible = true
            if m.top.itemContent.DoesExist("watched_percentage")
                m.progressbar.width = (m.top.itemContent.watched_percentage / 100) * m.main_rect.width
                m.progressbar.visible = true

            end if
        else
            m.Progressbar.visible = false
            m.playButton.visible = false
        end if
    end if

end sub



sub updateLayout()
    if m.top.height > 0 and m.top.width > 0 then
        m.Poster.width = m.top.width
        m.Poster.height = m.top.height
        m.Poster.loadHeight = m.top.height
        m.Poster.loadWidth = m.top.width

        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height

        'gradients
        m.bottom_gradient.width = m.top.width
        m.top_gradient.width = m.top.width

        'roundcorner
        m.CornerRoundedforHomeScene.width = m.top.width
        m.CornerRoundedforHomeScene.height = m.top.height

        'title position
        m.title.translation = [10, m.top.height + 10]
        m.title.width = m.top.width

        'progressbar
        m.Progressbar.translation = [0, m.top.height - 11]
        m.Progressbar.width = m.top.width

        'liveIcon
        m.liveIcon.translation = [m.top.width - 90, 20]

        'lock-icon
        m.lock_icon.translation = [m.top.width - 45, 15]

        'playnowButton
        m.playButton.translation = [(m.top.width / 2) - 35, (m.top.height / 2) - 35]
    end if
end sub




