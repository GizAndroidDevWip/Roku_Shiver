sub Init()
    m.tagTitle = m.top.findNode("TagTitle")
    ' m.selectionPoster = m.top.findNode("selectionPoster")
    ' m.selectionPoster.blendColor = getButtonSelectionColor()
    m.main_rect = m.top.findNode("main_rect")
    ?"dds"
    m.lock_icon = m.top.findNode("lock_icon")
    m.free_icon = m.top.findNode("free_icon")
    ' m.main_rect = m.top.findNode("main_rect")
    m.title = m.top.findNode("title")
    m.showMoreDetailPoster = m.top.findNode("showMoreDetail_poster")
    m.showMoreDetailLabel = m.top.findNode("showMoreDeat_label")
    m.title = m.top.findNode("title")
    ' m.lock_icon = m.top.findNode("lock_icon")
    ' m.free_icon = m.top.findNode("free_icon")


    m.CornerRounded = m.top.findNode("CornerRounded")
end sub

sub itemContentChanged()


    updateLayout()


    orientation = invalid
    content = m.top.itemContent

    if content <> invalid and content.thumbnail_orientation <> invalid
        orientation = UCase(content.thumbnail_orientation)
    else
        orientation = UCase(getThumbnailOrientaion())
    end if

    if orientation = "LANDSCAPE"
        m.showMoreDetailPoster.failedBitmapUri = getPLACEHOLDER_IMAGE()
        m.showMoreDetailPoster.loadingBitmapUri = getPLACEHOLDER_IMAGE()
        if content <> invalid and content.HDPOSTERURL <> invalid
            m.showMoreDetailPoster.uri = content.HDPOSTERURL
        end if

    else if orientation = "PORTRAIT"
        m.showMoreDetailPoster.failedBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT()
        m.showMoreDetailPoster.loadingBitmapUri = getPLACEHOLDER_IMAGE_PORTRAIT()
        if content <> invalid and content.HDPosterURLPortrait <> invalid
            m.showMoreDetailPoster.uri = content.HDPosterURLPortrait
        end if
    end if




    content = m.top.itemContent
    ' if result is not invalid, sets course image, course name, trainer name and progressbar after null validation
    if content <> invalid

        m.title.text = content.title
        m.title.visible = false

        if not content.title = invalid
            m.showMoreDetailLabel.text = content.title
            m.showMoreDetailLabel.visible = true
            ?"ddfd"
        end if


        if getHide_Title_Under_Movies() = "true"
            m.showMoreDetailLabel.visible = false
        else
            m.showMoreDetailLabel.visible = true
        end if


        m.showMoreDetailLabel.font.size = "20"
        m.showMoreDetailLabel.color = getTextColor()


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

    end if
end sub


function OnkeyEvent(key, press) as boolean

    result = false
    if press


        if key = "back"

        else if key = "left"

        else if key = "right"

        else if key = "up"
            m.topMenuRowlist.setFocus(true)
        else if key = "down"
            m.showMoreDetailPoster.setFocus(true)
        else if key = "OK"

        end if

    end if
    return result
end function


sub updateLayout()
    if m.top.height > 0 and m.top.width > 0 then
        m.showMoreDetailPoster.width = m.top.width
        m.showMoreDetailPoster.height = m.top.height
        m.showMoreDetailPoster.loadHeight = m.top.height
        m.showMoreDetailPoster.loadWidth = m.top.width

        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height

        m.CornerRounded.height = m.top.height
        m.CornerRounded.width = m.top.width

        'lock-icon
        m.lock_icon.translation = [m.top.width - 45, 15]

        'title position
        m.showMoreDetailLabel.translation = [10, m.top.height + 10]
        m.showMoreDetailLabel.width = m.top.width

    end if
end sub

' this function gets the parent node in the list
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