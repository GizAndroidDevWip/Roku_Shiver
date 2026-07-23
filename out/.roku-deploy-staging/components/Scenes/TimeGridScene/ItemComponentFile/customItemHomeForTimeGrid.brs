sub Init()
    m.Title = m.top.findNode("Title")
    m.poster = m.top.findNode("poster")

end sub



sub itemContentChanged()
    if m.top.content <> invalid 'and m.top.content.Title <> invalid
        m.Title.text = m.top.content.Title
        if m.top.content.HDSMALLICONURL <> invalid and m.top.content.HDSMALLICONURL <> ""
            m.poster.uri = m.top.content.HDSMALLICONURL
        else
            m.poster.uri = "pkg:/images/placeholder.png"
        end if
    end if

end sub

sub updateLayout()
    if m.top.height > 0 and m.top.width > 0 then
        m.poster.height = m.top.height
        m.Title.height = m.top.height
        ' m.poster.width = m.top.width
    end if
end sub




