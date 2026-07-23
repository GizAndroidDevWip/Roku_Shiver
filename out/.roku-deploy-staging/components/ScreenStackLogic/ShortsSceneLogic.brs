sub showShortsScene()
    m.shortsScene = CreateObject("roSGNode", "ShortsScene")
    m.shortsScene.observeField("closethispage", "closeThisPage4")
    m.shortsScene.callShortsApi = true
    ShowScreen(m.shortsScene)
end sub

sub playSelectedShortsVideo(video_id)
    m.shortsScene = CreateObject("roSGNode", "ShortsScene")
    m.shortsScene.observeField("closethispage", "closeThisPage4")
    m.shortsScene.playSelectedShortsVideo = video_id
    ShowScreen(m.shortsScene)
end sub

sub closeThisPage4()
    CloseScreen(m.shortsScene)
    ' CloseAllScreen()
    'showHomeScene()
end sub