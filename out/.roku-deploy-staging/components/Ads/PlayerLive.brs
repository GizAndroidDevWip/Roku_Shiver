'*********************************************************************
'** (c) 2016-2017 Roku, Inc.  All content herein is protected by U.S.
'** copyright and other applicable intellectual property laws and may
'** not be copied without the express permission of Roku, Inc., which
'** reserves all rights.  Reuse of any of this content for any purpose
'** without the permission of Roku, Inc. is strictly prohibited.
'********************************************************************* 

' Player

sub init()
    m.video = m.top.CreateChild("Video")            
end sub

sub controlChanged()
    'handle orders by the parent/owner
    control = m.top.control
    if control = "play" then
        playContent()
    else if control = "stop" then
        exitPlayer()
    end if
end sub

sub playContent()
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.video.visible = false
        ?"playerlive calleddddd"

        m.PlayerTaskLive = CreateObject("roSGNode", "PlayerTaskLive")
        m.PlayerTaskLive.observeField("state", "taskStateChanged")
        m.PlayerTaskLive.videos = m.video
        m.PlayerTaskLive.control = "RUN"
        m.top.visibility = true
    end if
end sub

sub exitPlayer()
    m.video.control = "stop"
    m.video.visible = false
    m.PlayerTaskLive = invalid
    m.top.state = "done"
    m.top.visibility = false
end sub

sub taskStateChanged(event as Object)
    state = event.GetData()
    if state = "done" or state = "stop"
        exitPlayer()
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
   if press
        if key = "back"
        exitPlayer()
    end if
    end if
    return true
end function

