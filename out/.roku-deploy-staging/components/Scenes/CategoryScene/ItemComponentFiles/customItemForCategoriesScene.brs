sub Init()
    m.tagTitle = m.top.findNode("TagTitle")
    m.selectionPoster = m.top.findNode("selectionPoster")
    m.main_rect = m.top.findNode("main_rect")
end sub


function itemContentChanged()
    m.tagTitle.text = m.top.itemContent.title
end function


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
        m.main_rect.width = m.top.width
        m.main_rect.height = m.top.height
        m.tagTitle.width = m.top.width - 60
        m.tagTitle.height = m.top.height - 60
        m.tagTitle.translation = [30, 30]
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