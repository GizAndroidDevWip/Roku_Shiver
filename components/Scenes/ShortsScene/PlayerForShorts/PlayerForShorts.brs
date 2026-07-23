

sub init()
    ?"init called : Player.brs ...."
    m.video = m.top.findNode("VideoPlayer")
    m.video.observeField("state", "onVideoPlayerStateChanged")
    m.playerOverlayPoster = m.top.findNode("playerOverlayPoster")
    m.slideUp = m.top.findNode("slideUp")
    m.slideDown = m.top.findNode("slideDown")
    m.dialogbg_rect = m.top.findNode("dialogbg_rect")

    m.label = m.top.findNode("label")
    m.labelBackground = m.top.findNode("labelBackground")

    m.PlayerTask = CreateObject("roSGNode", "PlayerTaskForShorts")
    m.PlayerTask.observeField("state", "taskStateChanged")
    m.PlayerTask.observeField("isFinished", "onPlayerStateChanged")

end sub

'***when manually started or stopped the palyer
sub controlChanged()
    ?"controlChanged called"

    control = m.top.control
    if control = "play" then
        playContent()
    else if control = "stop" then
        exitPlayer()
    end if
end sub

sub playContent()
    ' ?"playContent calledfsdfdsfsdfsdf"
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.video.visible = true
        m.dialogbg_rect.visible = true
        m.label.text = content.title
        m.label.visible = true
        m.labelBackground.translation = [m.label.translation[0] - 20, m.label.translation[1] - 10]
        m.labelBackground.width = m.label.boundingRect().width + 40
        m.labelBackground.height = m.label.boundingRect().height + 20
        m.labelBackground.visible = true

        m.playerOverlayPoster.uri = content.thumbnail
        m.playerOverlayPoster.visible = true
        m.PlayerTask.video = m.video
        m.PlayerTask.skipAd = m.top.skipAd 'setting skipAd value to playertask
        m.PlayerTask.watched_duration = m.top.watched_duration 'setting watched_duration value to playertask
        m.PlayerTask.control = "STOP"
        m.PlayerTask.control = "RUN"
        ?m.video.content
        ?"m.video.content"
    end if
end sub

sub exitPlayer()
    m.video.control = "stop"
    m.video.visible = false
    ' m.PlayerTask = invalid
    m.top.state = "done"
    m.top.visibility = false
    m.PlayerTask.control = "STOP"
end sub

sub taskStateChanged(event1 as object)
    state = event1.GetData()
    ' ?state
    m.top.playerState = m.video.state'm.top.getchild(0).state '***bringing the playerstate status to player from playertask
    if state = "done" or state = "stop" or state = "finished"
        exitPlayer()
        sec = CreateObject("roRegistrySection", getAppKey())
    end if
end sub


'***this is used for autoplay in show page
sub onPlayerStateChanged()
    m.Player.playerState = "stop" or m.Player.playerState = "finished" or m.Player.playerState = "back_pressed"
    m.top.closethispage = "true"
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "back"
            m.video.visible = true
            m.video.setFocus(true)
            m.top.playerState = "back_pressed"
            exitPlayer()

        else if key = "up"
            if m.top.content <> invalid and m.top.content.rawVideoContent <> invalid and m.top.content.rawVideoContent.nodeIndex <> invalid and m.top.content.rawVideoContent.nodeIndex > 0
                m.playerOverlayPoster.visible = true
                m.slideDown.control = "start"
                return false
            end if
        else if key = "down"
            m.playerOverlayPoster.visible = true
            m.slideUp.control = "start"
            return false
        end if
    else
    end if
    return true
end function


sub onVideoPlayerStateChanged()
    ?"onVideoPlayerStateChanged"
    ?m.video.state
    if m.video.state = "playing"
        m.playerOverlayPoster.visible = false
        m.playerOverlayPoster.uri = ""
    else if m.video.state = "finished"
        playContent()
    end if
end sub

