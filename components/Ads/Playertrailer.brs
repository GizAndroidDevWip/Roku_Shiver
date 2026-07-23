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
    m.video.observeField("state", "videoStateChanged")
    m.count=0
end sub

sub controlChanged()
if(m.count=0)
m.count=1
    'handle orders by the parent/owner
    control = m.top.control
    if control = "play" then
        playContent()
    else if control = "stop" then
        exitPlayer()
    end if
    end if
end sub

sub playContent()
    content = m.top.content
    if content <> invalid then
        m.video.content = content
        m.video.visible = false
        m.PlayerTaskTrailer = CreateObject("roSGNode", "PlayerTaskTrailer")
        m.PlayerTaskTrailer.observeField("state", "taskStateChanged")
        m.PlayerTaskTrailer.video = m.video
        m.PlayerTaskTrailer.control = "RUN"
'        m.top.visibility = true
    end if
end sub

sub exitPlayer()
    print "Player : exitPlayer()"
    m.count=0
    m.video.control = "stop"
    m.video.visible = false
    m.PlayerTaskTrailer = invalid
    m.top.state = "done"
    m.top.visibility = false
end sub

sub taskStateChanged(event as Object)
    print "Playertrailer : taskStateChanged(), id = "; event.getNode(); ", "; event.getField(); " = "; event.getData()
    state = event.GetData()
    print "statess"
    print state
    if state = "done" or state = "stop"
        exitPlayer()
    end if
end sub

sub videoStateChanged()
    print "Playertrailer : videoStateChanged(), state = "; m.video.state
    m.top.state = m.video.state
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    print "Player: keyevent = "; key
   if press
        if key = "back"
        exitPlayer()
        
    end if
    end if
    return true
end function

