sub ShowPlayerPodCastScene(inputValue as dynamic)
  m.PlayerPodCast = CreateObject("roSGNode", "PlayerPodCastScene") 
  ' m.videoPlayerScreen.selectedIndex = selectedIndex       'Here we are passing selectedIndex, videoListContent, and videoId to VideoPlayer file.

  if inputValue <> invalid
      m.PlayerPodCast.content = inputValue
  end if
  ShowScreen(m.PlayerPodCast)   
end sub
