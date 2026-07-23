sub init()
    ?"dshkasjhdkahskdc454"
    m.top.translation = [0, 0]
    m.top.duration = 9000
    m.top.maxDays = 2
    m.top.ignoreTrickPlayKeys = true
    m.top.minimumNowBarOffset = 13800
    m.top.programTitleFocusedColor = "#ffffff"
    m.top.nowBarOffset = 0
    m.top.nowBarHeight = 500
    m.top.nowBarWidth = 5
    m.top.showPastTimeScreen = true
    m.top.channelInfoComponentName = "customItemHomeForTimeGrid"
    m.top.channelNoDataText = ""
    m.top.channelInfoWidth = 550
end sub


function onkeyEvent(key as String, press as Boolean) as Boolean
    if press = false
        return false
    else
        if key = "backspace" and press  
            return true
        else if key = "home" and press
            return true
        else if key = "up" and press
            if m.top.programFocusedDetails.focusChannelIndex = 0
                ?"dshkasjhdkahskdc454 up key pressed"
                ?m.top.programFocusedDetails.focusChannelIndex
                m.top.KEY_PRESSED_STATE = "CHANGE_FOCUS_TO_CATEGORY"
                return true
            end if
            
            ?"dshkasjhdkahskdc454 up key pressed"
            ?m.top.programFocusedDetails.focusChannelIndex
            ?m.top.channelFocused
            ?m.top.channelUnfocused
        else if key = "down" and press
            ?"dshkasjhdkahskdc454 down key pressed"
            ?m.top.programFocusedDetails.focusChannelIndex
            ' ?m.top.channelUnfocused
        end if
    end if
    return false
end function