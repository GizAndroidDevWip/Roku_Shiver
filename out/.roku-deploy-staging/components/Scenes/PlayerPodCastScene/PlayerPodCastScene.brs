sub init()
    m.audio = createObject("roSGNode", "Audio")
    m.audio.observeField("state", "audioPlayerStateChanged")
    m.image = m.top.findNode("image")
    m.title = m.top.findNode("title")
    m.title.font.size = 75
    m.description = m.top.findNode("description")
    M.description.font.size = 30
    m.controlposter = m.top.findNode("controlposter")
    m.rewindPoster = m.top.findNode("rewind")
    m.fastForward = m.top.findNode("fastForward")
    m.PLAY = "pkg:/images/play-xxl.png"
    m.REWIND = "pkg:/images/rewind.png"
    m.PAUSE = "pkg:/images/pause.png"
    m.FORWARD = "pkg:/images/fastforward.png"

    m.top.setFocus(true)
end sub

sub onAudioSet()
    ?"onAudioSet called"
    m.image.uri = m.top.content.HDPosterURL
    m.title.text = m.top.content.name
    m.description.text = m.top.content.description
    m.controlposter.uri = m.PAUSE

    audiocontent = createObject("RoSGNode", "ContentNode")
    audiocontent.url = m.top.content.url'"https://gizmeon.s.llnwi.net/vod/podcast/1669122566148.mp3"
    m.audio.content = audiocontent
    m.top.appendChild(m.audio)
    m.audio.control = "play"
end sub


function OnkeyEvent(key, press) as boolean
    result = false
    if press
        ?"m.audio.state ";m.audio.state
        if key = "back"
            m.audio.control = "stop"

        else if key = "left" or key = "rewind"
            if m.audio.state = "playing" or m.audio.state = "stopped" or m.audio.state = "finished" or m.audio.state = "paused"
                m.audio.seek = m.audio.position - 10
                m.rewindPoster.blendColor = "#4a4a4a"
            end if

        else if key = "right" or key = "fastforward"
            if m.audio.state = "playing" or m.audio.state = "stopped" or m.audio.state = "finished" or m.audio.state = "paused"
                m.audio.seek = m.audio.position + 10
                m.fastforward.blendColor = "#4a4a4a"
            end if
        else if key = "up"
            m.audio.control = "resume"
            return true
        else if key = "down"
        else if key = "OK" or key = "play"

            if m.audio.state = "playing"
                m.audio.control = "pause"

            else if m.audio.state = "buffering"
                m.audio.control = "pause"

            else if m.audio.state = "paused"
                m.audio.control = "resume"

            else if m.audio.state = "stopped"
                m.audio.control = "play"

            else if m.audio.state = "finished"
                m.audio.control = "replay"
            end if
            return true
        end if
    else
        m.fastforward.blendColor = "#ffffff"
        m.rewindPoster.blendColor = "#ffffff"
    end if
    return result
end function

function audioPlayerStateChanged()
    ?"audioPlayerStateChanged called"
    if m.audio.state = "finished"
        ?"finished"
        m.controlposter.uri = m.PLAY

    else if m.audio.state = "playing"
        m.controlposter.uri = m.PAUSE

    else if m.audio.state = "buffering"
        m.controlposter.uri = m.PAUSE

    else if m.audio.state = "paused"
        m.controlposter.uri = m.PLAY

    else if m.audio.state = "stopped"
        m.controlposter.uri = m.PLAY

    else if m.audio.state = "error"
        m.controlposter.uri = m.PLAY
        ?"error occurred during playback"
        ?"Audio Player Error: "; m.audio.errorMsg
    end if
end function







