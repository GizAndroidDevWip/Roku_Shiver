' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

sub init()
    'initializing values for nodes
     ? ">>> LIVE VIDEO INIT >>"
    m.liveStream = m.top.findNode("liveStream")
    m.liveStream.retrievingBarVisibilityAuto = false
    m.top.Video = m.liveStream
    
    m.liveLoadingPoster = m.top.findNode("liveLoadingPoster")
'    m.bufferingAnimation = m.top.findNode("bufferingAnimation")
    m.focusBorder = m.top.findNode("focusBorder")
    m.hud = m.top.findNode("Hud")
    m.top.hud = m.hud
    m.top.observeField("focusedChild", "onFocusedChildChange")
    
    m.UIConstants = m.top.createChild("UIConstants")
    m.hud.height = m.UIConstants.root.hud.height
    
    'start timer for handling timeout error of loading live video stream 
    m.timer = CreateObject("roSGNode","Timer")
    m.timer.duration = 10
    m.timer.observeField("fire", "TimerCheck")
    m.timer.control = "start"
    
    m.isFullScreenMode = false
    m.isFullScreenModeAllowed = true
    m.borderWidth = 5
    
    m.top.setFocus(True)
end sub

sub TimerCheck()
    if m.top.LiveUrl.len() = 0  then
         HandleLiveStreamError()
    end if     
end sub

sub OnTranslationChange()

    m.liveStream.translation = m.top.videoTranslation
    m.liveLoadingPoster.translation = m.top.videoTranslation
'    m.bufferingAnimation.translation = m.top.videoTranslation
    m.focusBorder.translation = [m.top.videoTranslation[0] - m.borderWidth, m.top.videoTranslation[1] - m.borderWidth]
end sub

sub OnLiveUrlChange()
    content = createObject("roSGNode", "ContentNode")
    content.url = m.top.liveUrl
    content.streamFormat = "m3u8"
    m.liveStream.content = content
    m.liveStream.control = "play"
    m.liveStream.observeField("state", "onLiveStreamStateChange")
end sub


sub OnLiveStreamStateChange()
    if m.liveStream.state = "error"
        HandleLiveStreamError()
    else if m.liveStream.state = "playing"
'        m.top.removeChild(m.bufferingAnimation)
    else if m.liveStream.state = "finished"
        m.liveLoadingPoster.visible = true
        m.isFullScreenModeAllowed = false
    end if
end sub

sub HandleLiveStreamError()
    m.liveLoadingPoster.visible = true
    m.liveStream.visible = false
'    m.top.removeChild(m.bufferingAnimation)
    m.isFullScreenModeAllowed = false
end sub    

sub onLiveLoadingPosterChange()
    m.liveLoadingPoster.uri = m.top.liveLoadingPoster
end sub


sub onFocusedChildChange()
    if m.top.focusedChild = invalid then
        m.focusBorder.visible = false
        m.top.isFocused = false
    else
        m.focusBorder.visible = true
        m.top.isFocused = true
    end if
end sub


sub onWidthChange()
    m.liveStream.width = m.top.width
    m.liveLoadingPoster.width = m.top.width
'    m.bufferingAnimation.width = m.top.width
    m.focusBorder.width = m.top.width + m.borderWidth * 2
end sub


sub onHeightChange()
    m.liveStream.height = m.top.height
    m.liveLoadingPoster.height = m.top.height
'    m.bufferingAnimation.height = m.top.height
    m.focusBorder.height = m.top.height + m.borderWidth * 2
end sub

sub onSizeChange()
    m.top.width = m.top.size[0]
    m.top.height = m.top.size[1]
end sub

sub OnContent()
    m.hud.content = m.top.content
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
        if m.isFullScreenMode
            if key = "back"
                m.top.videoTranslation = m.minimizedTranslation
                m.top.width = m.minimizedWidth
                m.top.height = m.minimizedHeight
                m.isFullScreenMode = false
                m.hud.show = false
            else if key = "OK"
                m.hud.show = not m.hud.show
            end if
            handled = true
        else
            if key = "OK"
                if m.isFullScreenModeAllowed
                    m.minimizedTranslation = m.top.videoTranslation
                    m.minimizedWidth = m.top.width
                    m.minimizedHeight = m.top.height
                    m.top.videoTranslation = "[0, 0]"
                    m.top.width = m.UIConstants.root.background.size[0]
                    m.top.height = m.UIConstants.root.background.size[1]
                    m.isFullScreenMode = true
                    handled = true
                end if
            end if
        end if
    end if
    
    return handled
end function
