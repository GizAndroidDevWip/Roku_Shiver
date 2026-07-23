sub ShowInfoTextScreen(data as object)
    m.infoTextScene = CreateObject("roSGNode", "InfoTextScene")
    m.infoTextScene.observeField("goBack", "onInfoTextGoBack")
    ShowScreen(m.infoTextScene)
    m.infoTextScene.contentData = data
end sub

sub onInfoTextGoBack()
    CloseScreen(m.infoTextScene)
end sub
