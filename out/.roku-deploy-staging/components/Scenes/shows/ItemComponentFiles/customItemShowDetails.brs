sub Init()
    ?"customItemShowDetails init called"
    m.Poster = m.top.findNode("poster")
    if getThumbnailOrientaion() = "LANDSCAPE"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE()
    else if getThumbnailOrientaion() = "PORTRAIT"
        m.Poster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
        m.Poster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT ()
    end if
    m.Premium = m.top.findNode("premiumIcon")
    m.name_label = m.top.findNode("name_label")
    m.name_label.font.size = 20
    m.descriptionBanner = m.top.findNode("descriptionBanner")
    m.main_rect = m.top.findNode("main_rect")
    m.main_rect.color = getBackGroundColor1()
    m.premium_tag = m.top.findNode("premium_tag")
    m.sub_label = m.top.findNode("sub_label")
    m.sub_label.font.size = 20
    m.watchProgressContainer = m.top.findNode("watchProgressContainer")
    m.watchProgressLineBg = m.top.findNode("watchProgressLineBg")
    m.watchProgressLine = m.top.findNode("watchProgressLine")
    m.watchProgressLine.blendColor = getButtonSelectionColor()
    m.cornerRounded = m.top.findNode("cornerRounded")
    m.highlighter = m.top.findNode("highlighter")
    m.free_icon = m.top.findNode("free_icon")
    m.lock_icon = m.top.findNode("lock_icon")
    m.episodeTitle = m.top.findNode("episodeTitle")
    m.name_label.color = getTextColor()
    m.sub_label.color = getTextColor()
    m.descriptionBanner.color = getTextColor()
    m.episodeTitle.color = "#cccccc"
end sub

sub itemContentChanged()
    ' ?"itemContentChanged showdetails"
    ' ?m.top.itemContent
    updateLayout()
    if getThumbnailOrientaion() = "LANDSCAPE"
        m.Poster.uri = m.top.itemContent.HDPOSTERURL
    else if getThumbnailOrientaion() = "PORTRAIT"
        m.Poster.uri = m.top.itemContent.HDPosterURLPortrait
    end if

    if m.top.itemContent.issinglevideo <> invalid and m.top.itemContent.issinglevideo = 3
        m.Poster.uri = ""
        m.Poster.visible = false
        m.main_rect.color = "#000000"
        m.episodeTitle.text = m.top.itemContent.title
        m.episodeTitle.visible = true
    else
        m.episodeTitle.visible = false
        m.Poster.visible = true
    end if

    if m.top.itemContent.itemtype = "CAST" or m.top.itemContent.itemtype = "CREW"
        if m.top.itemContent.HDPOSTERURL <> invalid and m.top.itemContent.HDPOSTERURL <> ""
            m.Poster.uri = m.top.itemContent.HDPOSTERURL
        else
            m.Poster.uri = "pkg:/images/cast_placeholder.png"
        end if
        ' m.poster_bottom_shadow.translation = "[0,158]"
        ' m.poster_bottom_shadow.width = "250"
        ' m.poster_bottom_shadow.height = "140"
        m.name_label.width = 150
        m.name_label.translation = [10, 190]
        m.sub_label.translation = [10, 190]
        m.sub_label.width = m.top.width

        if m.top.itemContent.TITLE <> invalid and m.top.itemContent.TITLE <> "" and m.top.itemContent.role <> invalid and m.top.itemContent.role <> ""
            m.name_label.text = m.top.itemContent.role + Chr(10) + m.top.itemContent.TITLE
        else if m.top.itemContent.role <> invalid and m.top.itemContent.role <> ""
            m.name_label.text = m.top.itemContent.role
        else if m.top.itemContent.TITLE <> invalid and m.top.itemContent.TITLE <> ""
            m.name_label.text = m.top.itemContent.TITLE
        else
            m.name_label.text = ""
        end if
        m.sub_label.visible = false
        return
    end if



    ' this is for displaying names for season videos or similar shows
    if m.top.itemContent.itemType = "ott"
        m.name_label.text = m.top.itemContent.TITLE
    else if m.top.itemContent.itemType = "shows"
        m.name_label.text = m.top.itemContent.show_name
    else if m.top.itemContent.itemType = "videos"
        m.name_label.text = m.top.itemContent.title
    else if m.top.itemContent.itemType = "key_art_work"
        ' m.name_label.text = m.top.itemContent.Title
        ' m.sub_label.text = m.top.itemContent.sub_Title
    else if m.top.itemContent.itemType = "isthisSimilarvideos"
        ' m.name_label.text = m.top.itemContent.title
    end if


    if getHide_Title_Under_Movies() = "true"
        m.name_label.visible = false
    else
        m.name_label.visible = true
    end if


    if m.top.itemContent.itemtype = "cast" or m.top.itemContent.itemtype = "crew"
        ' ?"m.top.itemContent.cast"
        ' ? m.top.itemContent.cast

        ' m.sub_label.translation = "[10,260]"
        ' m.sub_label.width = "250"
    end if

    if m.top.itemContent.itemtype = "key_art_work"
        ' ?m.top.itemContent.Title
        ' ?m.top.itemContent.sub_Title

        m.sub_label.translation = "[10,285]"
        m.sub_label.width = "250"

    end if

    if m.top.itemContent.itemType = "shows"
        m.premium_tag.width = "30"
        m.premium_tag.height = "30"
    end if

    if m.top.itemContent.itemType = "isthisSimilarvideos"
        ?"testingriniraju"
        ? m.top.itemContent
        m.play_now_poster.visible = true
    end if


    if m.top.itemContent.premium_flag = 1
        m.Premium.visible = true
    else
        m.Premium.visible = false
    end if


    if m.top.itemContent.DoesExist("itemType")
        if m.top.itemContent.itemType = "ott"
            if m.top.itemContent.issinglevideo = invalid or m.top.itemContent.issinglevideo = 3 then return
            m.watchProgressContainer.visible = true
            if m.top.itemContent.DoesExist("watched_percentage")
                m.watchProgressLine.width = (m.top.itemContent.watched_percentage / 100) * (m.main_rect.width - 20)
                if m.watchProgressLine.width > 0 then m.watchProgressContainer.visible = true else m.watchProgressContainer.visible = false
            end if

        else
            m.watchProgressContainer.visible = false
        end if
    end if

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



    if m.top.itemContent.seasonIndex = 0
        m.highlighter.visible = false
    else
        m.highlighter.visible = false
    end if

end sub



sub updateLayout()
    if m.top.height > 0 and m.top.width > 0 then
        m.Poster.width = m.top.width
        m.Poster.height = m.top.height
        m.Poster.loadWidth = m.top.width
        m.Poster.loadHeight = m.top.height

        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height

        m.episodeTitle.width = m.top.width
        m.episodeTitle.height = m.top.height

        m.cornerRounded.height = m.top.height
        m.cornerRounded.width = m.top.width

        'title position
        m.name_label.translation = [10, m.top.height + 10]
        m.name_label.width = m.top.width

        'watchProgressLine
        m.watchProgressLine.translation = [10, m.top.height - 7]
        m.watchProgressLineBg.translation = [10, m.top.height - 7]
        m.watchProgressLineBg.width = m.top.width - 20
        m.watchProgressContainer.width = m.top.width - 20

        'hilighter
        m.highlighter.width = m.top.width
        m.highlighter.height = m.top.height

        'lock-icon
        m.lock_icon.translation = [m.top.width - 45, 15]
    end if
end sub



sub onFocusPercentChanged()
    ' ?"onFocusPercentChanged called"
    if m.top.focusPercent = 1 and m.top.itemContent.itemtype = "ott"
        m.highlighter.visible = false 'true
    else
        m.highlighter.visible = false
    end if
end sub


sub OnrowHasFocus()
    if m.top.focusPercent = 1 and m.top.itemContent.itemtype = "ott" then
        m.highlighter.visible = false 'true
    else
        m.highlighter.visible = false
    end if
end sub

