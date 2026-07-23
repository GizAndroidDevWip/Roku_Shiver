sub init()
    m.top.setFocus(true)
    m.currentPlayingIndex = 0
    m.loading = m.top.findNode("loading")
    m.loading.visible = true
    m.mainVideoDataList = CreateObject("RoSGNode", "ContentNode")

end sub

sub playSelectedShortsVideo() 'call ShortsDetailsTask
    m.shortsDetailsTask = CreateObject("roSGNode", "ShortsDetailsTask")
    m.shortsDetailsTask.observeField("shortsDetailsResponse", "addSelctedVideoToMainVideoDataList")
    m.shortsDetailsTask.shortsID = m.top.playSelectedShortsVideo
    m.shortsDetailsTask.callFunc("runShortsDetailsTask", "")
end sub

sub addSelctedVideoToMainVideoDataList() ' add one ShortsDetailsTask data/ selected video data to mainVideoDataList's 0th position and then proceed the rest normally
    shortsDetailsResponse = m.shortsDetailsTask.shortsDetailsResponse
    existingDataListCount = m.mainVideoDataList.getchildcount()

    childDataNode = m.mainVideoDataList.createChild("ContentNode")
    childDataNode.url = shortsDetailsResponse.url
    childDataNode.title = shortsDetailsResponse.title
    childDataNode.thumbnail = shortsDetailsResponse.thumbnail
    childDataNode.addFields({
        "nodeIndex": existingDataListCount
        "video_id": shortsDetailsResponse.video_id.ToStr()
        "video_time": shortsDetailsResponse.video_time.ToStr()
        "rawItemData": shortsDetailsResponse
    })
    callShortsApi()
end sub

sub callShortsApi()
    m.shortsApiTask = CreateObject("roSGNode", "ShortsApiTask")
    m.shortsApiTask.observeField("ShortsApiTaskListStatus", "onSetData")
    m.shortsApiTask.callFunc("runShortsApiTask", "")
end sub

sub onSetData()
    content = m.shortsApiTask
    existingDataListCount = m.mainVideoDataList.getchildcount()

    if content <> invalid and content.ShortsApiTaskContent <> invalid and not content.ShortsApiTaskContent.count() = 0
        data = content.ShortsApiTaskContent
        for i = 0 to data.count() - 1
            childDataNode = m.mainVideoDataList.createChild("ContentNode")
            childDataNode.url = data[i].url ' "https://gizmeon.s.llnwi.net/wasabi/vod/PUB-50030/202405301717060253/playlist~480p.m3u8"
            childDataNode.title = data[i].title
            childDataNode.thumbnail = data[i].thumbnail
            childDataNode.addFields({
                "nodeIndex": existingDataListCount + i
                "video_id": data[i].video_id.ToStr()
                "video_time": data[i].video_time.ToStr()
                "rawItemData": data[i]
            })
        end for
    end if
    if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchild(0) <> invalid
        playVideo(m.mainVideoDataList.getchild(0))
    end if
end sub


function OnkeyEvent(key, press) as boolean
    result = false

    if press
        if key = "up"
            if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchild(m.currentPlayingIndex - 1) <> invalid

                playVideo(m.mainVideoDataList.getchild(m.currentPlayingIndex - 1))
            end if
        else if key = "down"

            if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchild(m.currentPlayingIndex + 1) <> invalid

                playVideo(m.mainVideoDataList.getchild(m.currentPlayingIndex + 1))
            end if

        else if key = "back"
            if m.Player.playerState = "stop" or m.Player.playerState = "finished" or m.Player.playerState = "back_pressed"
                m.top.closethispage = "true"
            end if
        end if
    else
    end if
    return result
end function

sub playVideo(inputContent)
    m.loading.visible = false
    if m.Player = invalid
        m.Player = m.top.CreateChild("PlayerForShorts")
        m.Player.observeField("playerState", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if

    m.currentPlayingIndex = inputContent.nodeIndex
    ' m.playerOverlayPoster.uri = "https://gizmeon.mdc.akamaized.net/thumbnails/event/1717413318435.jpg"'inputContent.thumbnail
    ' m.playerOverlayPoster.visible = true
    videoContent = {
        streamFormat: "",
        titleSeason: "",
        HDBranded: true,
        ClosedCaptions: true,
        IsHD: true,
        title: inputContent.title,
        id: "",
        url: inputContent.url
        categories: "",
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.addFields({
        "thumbnail": inputContent.thumbnail,
        "video_time": inputContent.video_time,
        "video_id": inputContent.video_id,
        "is_live": "0" 'not live
        "rawVideoContent": inputContent
    })
    content.ClosedCaptions = true
    content.globalCaptionMode = "On"
    content.HDBranded = true
    content.IsHD = true

    m.Player.content = content
    m.Player.visible = true
    m.Player.skipAd = true
    m.Player.setFocus(true)
    m.Player.control = "play"

    if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchildcount() <> invalid and inputContent.nodeIndex <> invalid and m.mainVideoDataList.getchildcount() - 3 = inputContent.nodeIndex
        callShortsApi2()
    end if
end sub

sub PlayerStateChanged()

    if m.Player.playerState = "playing"

    else if m.Player.playerState = "stop"or m.Player.playerState = "back_pressed"
        m.top.closethispage = "true"

    else if m.Player.playerState = "finished"
        if m.mainVideoDataList <> invalid and m.mainVideoDataList.getchild(m.currentPlayingIndex + 1) <> invalid
            nextNode = m.mainVideoDataList.getchild(m.currentPlayingIndex + 1)
            playVideo(nextNode)
        else
            ?"No more videos to play"
        end if
    end if
end sub

sub callShortsApi2()
    m.shortsApiTask2 = CreateObject("roSGNode", "ShortsApiTask")
    m.shortsApiTask2.observeField("ShortsApiTaskListStatus", "onAddData")
    m.shortsApiTask2.callFunc("runShortsApiTask", "")
end sub

sub onAddData()
    content = m.shortsApiTask2
    existingDataListCount = m.mainVideoDataList.getchildcount()
    if content <> invalid and content.ShortsApiTaskContent <> invalid and not content.ShortsApiTaskContent.count() = 0
        data = content.ShortsApiTaskContent
        for i = 0 to data.count() - 1
            childDataNode = CreateObject("RoSGNode", "ContentNode")
            childDataNode.url = data[i].url ' "https://gizmeon.s.llnwi.net/wasabi/vod/PUB-50030/202405301717060253/playlist~480p.m3u8"
            childDataNode.title = data[i].title
            childDataNode.thumbnail = data[i].thumbnail
            childDataNode.addFields({
                "nodeIndex": existingDataListCount + i
                "video_id": data[i].video_id.ToStr()
                "video_time": data[i].video_time.ToStr()
                "rawItemData": data[i]

            })
            m.mainVideoDataList.appendChild(childDataNode)
        end for
    end if
    ?"hdajfjahgjfhdgjfd";existingDataListCount
end sub






