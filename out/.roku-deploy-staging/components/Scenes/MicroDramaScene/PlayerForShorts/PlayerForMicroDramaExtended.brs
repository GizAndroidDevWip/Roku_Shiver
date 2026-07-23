' PlayerForMicroDramaExtended.brs
' this file was created only for the purpose of handling left and right key events in PlayerForMicroDramaExtended scene
sub init()
    m.top.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "left" or key = "right"
            print "Key pressed: "; key
            return true
        end if
    end if
    return false
end function
