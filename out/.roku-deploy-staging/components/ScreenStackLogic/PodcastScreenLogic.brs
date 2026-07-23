sub showPodcastScreen()
    m.Podcast = CreateObject("roSGNode", "Podcast")
    m.Podcast.ObserveField("rowItemSelected", "ongoToPlayerPodCastSceneFromPodcast")
    ShowScreen(m.Podcast)
end sub

sub ongoToPlayerPodCastSceneFromPodcast()
    rowlist = event.GetRoSGNode()
    selectedIndex = event.GetData()
    rowContent = rowlist.content
    rowContentItem = rowContent.getChild(selectedIndex[0]).getChild(selectedIndex[1])

    '  code to show videoPlayerscreen
    if rowContentItem.DoesExist("podcast_id")
        ' ShowVideoPlayerScene(rowContentItem, selectedIndex, rowContentItem.video_id)
        ShowPlayerPodCastScene(rowContentItem)
    else if rowContentItem.DoesExist("show_id")
        ShowShowDetailsScreen(rowContentItem) 
    end if
end sub