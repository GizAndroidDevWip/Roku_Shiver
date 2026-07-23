' ********** Copyright 2020 Roku Corp.  All Rights Reserved. **********

' Note that we need to import this file in MainScene.xml using relative path.

sub InitScreenStack()
    m.menu = m.top.findNode("HomeTopMenuRowlist")
    m.BrandingLogo = m.top.findNode("BrandingLogo")
    m.loadingIndicator = m.top.findNode("loadingIndicator")
    screenStack = m.global.screenStackArray
    if screenStack = invalid then
        screenStack = []
        m.global.addFields({ screenStackArray: screenStack })
    end if
end sub

sub ShowScreen(node as object)
    screenStack = m.global.screenStackArray
    prev = screenStack.Peek() ' take current screen from screen stack but don't delete it
    if prev <> invalid
        prev.visible = false ' hide current screen if it exist
        prev.SetFocus(false)
    end if
    m.top.AppendChild(node) ' add new screen to scene

    topMenuVisibility(node) ' check if top menu should be visible on new screen or not
    ' show new screen
    node.visible = true
    node.SetFocus(true)
    screenStack.Push(node)
    ' ?"node pushed to screenStackArray"
    ' ?node
    m.global.screenStackArray = screenStack
end sub

sub CloseScreen(node as object)
    ' ?"CloseScreen : "node
    screenStack = m.global.screenStackArray
    ?m.global.screenStackArray
    ?"screstavk1"
    if node = invalid or (screenStack.Peek() <> invalid and screenStack.Peek().IsSameNode(node))
        last = screenStack.Pop() ' remove screen from screenStack
        ?last
        ?"lastscreen"
        last.visible = false ' hide screen
        m.top.RemoveChild(last) ' remove screen from scene

        ' take previous screen and make it visible
        prev = screenStack.Peek()
        ?prev
        ?"prevvisble"
        if prev <> invalid
            prev.visible = true
            topMenuVisibility(prev) ' check if top menu should be visible on previous screen or not
            prev.SetFocus(true)
        end if
        m.global.screenStackArray = screenStack
        ?m.global.screenStackArray
        ?"screestacharay"
    end if
    showLoader(false)
end sub

sub topMenuVisibility(node)


    'top menu
    if m.menu <> invalid
        ' Force the menu to the top of the Z-order (visual front)
        m.top.RemoveChild(m.menu)
        m.top.AppendChild(m.menu)
        m.top.RemoveChild(m.BrandingLogo)
        m.top.AppendChild(m.BrandingLogo)
        m.top.RemoveChild(m.loadingIndicator)
        m.top.AppendChild(m.loadingIndicator)

        menuAllowedScreens = {
            "HomeScene": true,
            "Show": true,
            "Search": true,
            "AllCategory": true,
            "CategoryScene": true,
            "MyListScene": true
        }

        brandingLogoNotAllowedScreens = {
            "LaunchScene": true,
            "VideoPlayerScene": true,
        }
        subtype = node.getSubtype()
        if subtype <> invalid and menuAllowedScreens.DoesExist(subtype) then m.menu.visible = true else m.menu.visible = false
        if subtype <> invalid and brandingLogoNotAllowedScreens.DoesExist(subtype) then m.BrandingLogo.visible = false else m.BrandingLogo.visible = true
    end if
end sub


sub removeScreenFromScreenStack(node as object)
    ' ?"CloseScreen : "node
    screenStack = m.global.screenStackArray
    if node = invalid or (screenStack.Peek() <> invalid and screenStack.Peek().IsSameNode(node))
        last = screenStack.Pop() ' remove screen from screenStack
        last.visible = false ' hide screen
        m.top.RemoveChild(last) ' remove screen from scene
        prev = screenStack.Peek()
        topMenuVisibility(prev) ' check if top menu should be visible on previous screen or not
        m.global.screenStackArray = screenStack
    end if
end sub

function GetCurrentScreen()
    screenStack = m.global.screenStackArray
    return screenStack.Peek()
end function


sub CloseAllScreen()
    ' ?"CloseAllScreen called"
    screenStack = m.global.screenStackArray
    screenStack.clear()
    m.global.screenStackArray = screenStack
    showLoader(false)
end sub

'********this will close only landing and register scenes from the screenstack no matter how mach time gone back and returned***************
sub CloseLoginAndLandingPages()
    ' ?"CloseLoginAndLandingPages called"
    screenStack = m.global.screenStackArray
    for each item in m.global.screenStackArray
        if item.sceneName = "Landing" or item.sceneName = "RegisterScene" or item.sceneName = "TvCodeScene" or item.sceneName = "EmailLogin" or item.sceneName = "LoginChooseScene"
            last = screenStack.Pop()
            m.top.RemoveChild(last)
        end if
    end for
    m.global.screenStackArray = screenStack
    showLoader(false)
end sub


sub CloseScreenWithSceneName(sceneName as string)
    oldStack = m.global.screenStackArray
    newStack = []

    for each node in oldStack
        if node <> invalid and node.sceneName = sceneName
            node.visible = false
            m.top.RemoveChild(node)
        else
            newStack.Push(node)
        end if
    end for

    m.global.screenStackArray = newStack
end sub

function GetParentScene() as object
    m.parentScene = m.top.GetParent()
    while m.parentScene <> invalid
        grandParent = m.parentScene.GetParent()
        if grandParent = invalid then
            exit while
        end if
        m.parentScene = grandParent
    end while
    return m.parentScene
end function

sub showLoader(boolean as boolean)
    if m.loadingIndicator <> invalid
        m.loadingIndicator.visible = boolean
        ?"dsdsds"
    end if  
end sub
