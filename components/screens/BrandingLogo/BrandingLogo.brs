sub init()
    m.logoPoster = m.top.findNode("logoPoster")
    m.logoPoster.uri = "pkg:/images/watermarklogo.png" ' Set default logo
    m.top.observeField("uri", "onUriChange")
end sub

sub onUriChange()
    newUri = m.top.uri
    if newUri <> invalid and newUri <> ""
        m.logoPoster.uri = newUri
    end if
end sub