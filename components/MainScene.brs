'********** Copyright 2020 Roku Corp.  All Rights Reserved. **********

sub init()
    m.global.AddField("channelStore", "node", false)
    m.global.channelStore = CreateObject("roSGNode", "ChannelStore")
    m.topMenu = m.top.findNode("HomeTopMenuRowlist")
    m.topMenu.observeField("rowItemSelected", "onTopMenuSelected")

    textMeasurer = createObject("roSGNode", "Label")
    textMeasurer.id = "textMeasurer"
    font = createObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Medium.ttf"
    font.size = 25
    textMeasurer.font = font
    m.top.appendChild(textMeasurer)
    textMeasurer.visible = false
    m.global.AddField("textMeasurer", "node", false)
    m.global.textMeasurer = textMeasurer

    m.lastFocusedIndex = 0

    InitScreenStack()
    showLaunchScene()
    ' showLogicChooseScreen()
    'showTimeGridScene()
    'showEmailLoginScreen()
    ' ShowSearchScreen()
    ' showTvCodeScreen()     'Reverse Tv Code Login Screen
    'showLandingScreen()
    ' showHomeScene()

    ' configAA = ReadConfigFile("pkg:/source/config.json")
    ' m.groups = GetProductGroups(configAA)
    'setupCommandList(m.groups)''

    ' create billing component node'
    m.billing = createObject("roSGNode", "Billing")


    ' Set product screen as the initial screen'
    ' m.productScreen = m.top.FindNode("productScreen")
    ' m.productScreen.billing = m.billing
    ' m.productScreen.groups = m.groups
    'm.productScreen.ObserveField("itemSelected", "onProductSelected")
    'm.purchaseGrid = m.top.FindNode("purchaseGrid")
    'm.purchaseGrid.ObserveField("itemSelected", "onPurchaseSelected")
    'm.userGrid = m.top.FindNode("userGrid")
    'm.userGrid.ObserveField("itemSelected", "onUserItemSelected")

    ' m.purchaseScreen = m.top.FindNode("purchaseScreen")
    ' m.purchaseScreen.visible = false

    ' m.top.observeField("orders", "startAsyncDoOrder")

    'm.billing.callFunc("getProductList", {})
    'm.billing.callFunc("getPurchaseList", {})
end sub

function onGetPurchases(event)
    print "onGetPurchases"
    purchaseData = event.getData()
    purchaseList = {}
    if purchaseData.GetChildCount() > 0 then
        for index = 0 to purchaseData.GetChildCount() - 1
            purchase = purchaseData.getChild(index)
            purchaseList[purchase.code] = purchase
            'print "purchase "; index; " - purchase= "; purchase
        end for
    end if
    ' print "m.getPurchaseType= "; m.getPurchaseType
    if m.getPurchaseType = "getPurchases"
        m.top.purchaseList = purchaseList
    else if m.getPurchaseType = "getAllPurchases"
        m.top.extPurchaseList = purchaseList
    end if
    m.getPurchasesType = ""
end function

function OnkeyEvent(key as string, press as boolean) as boolean
    result = false
    if press
        ' handle "back" key press
        if key = "back"
            screenStack = m.global.screenStackArray
            ? "screenStack main"
            ? screenStack
            ? "screenStack main"
            if screenStack <> invalid then
                numberOfScreens = screenStack.Count()
                ' close top screen if there are two or more screens in the screen stack
                if numberOfScreens > 1
                    CloseScreen(invalid)
                    result = true
                end if
            end if
        end if
    end if
    ' The OnKeyEvent() function must return true if the component handled the event,
    ' or false if it did not handle the event.

    if not press then return false


    ' If menu has focus and user presses down, move focus to the current screen
    if m.topMenu <> invalid and m.topMenu.isinFocusChain() and key = "down"
        screenStack = m.global.screenStackArray
        currentScreen = screenStack.Peek()

        if currentScreen <> invalid
            currentScreen.setFocus(true)
            if currentScreen.SET_DEFAULT_FOCUS <> invalid
                currentScreen.SET_DEFAULT_FOCUS = true
            end if
            return true
        end if
    end if

    return result
end function

sub onTopMenuSelected()
    selectedItem = m.topMenu.rowItemSelected

    ' Null check content hierarchy
    content = m.topMenu.content
    if content = invalid or content.getChildCount() = 0 then return

    row = content.getChild(0)
    if row = invalid or selectedItem = invalid or selectedItem[1] = invalid then return

    selectedNode = row.getChild(selectedItem[1])
    if selectedNode = invalid then return

    ' Cache values
    menuType = selectedNode.type
    itemClicked = selectedNode.vanity_url
    title = selectedNode.title

    ' Check screen stack context
    screenStack = m.global.screenStackArray
    currentScreen = invalid
    if screenStack <> invalid then currentScreen = screenStack.Peek()


    ' Handle Logic based on Screen Context
    if currentScreen <> invalid and itemClicked <> invalid
        ' Handle GENRE immediately
        if menuType <> invalid and menuType <> "SMART_HOME" and menuType <> "HOME" and menuType <> "subscription" and menuType <> "search"
            if menuType = "GENRE"
                m.top.GENRE_SELECTED = itemClicked
                goToShowMoreSceneOnTopMenuClick({
                    "tagType": "GENRE",
                    "id": itemClicked,
                    "key": itemClicked,
                    "title": title
                })
            else if menuType = "LIVE"
                if getMULTI_CHANNELS_REQUIRED() = "true" then showTimeGridScene() else showVideoPlayerSceneForTimeGridSceneForTopMenuLive()
            end if
            return
        end if

        if itemClicked = "subscribe"
            if isGuest() = "true" then onGoToLandingScene4() else onGoToPaymentDescriptionScree()
        else if itemClicked = "searchIcon"
            ShowSearchScreen()
            ' else if itemClicked = "LIVE"
            '     showVideoPlayerSceneForTimeGridSceneForTopMenuLive()
        else
            if currentScreen.subType() = "HomeScene"
                ' User is on HomeScene
                currentScreen.ONTOPMENU_ITEM_SELECTED = itemClicked
            else
                ' Default Action: Go Home & Load SmartHome
                m.top.SMARTHOME_SELECTED = itemClicked
                CloseAllScreen()
                showHomeScene({ GOTO_HOME_AND_LOAD_SMARTHOME: itemClicked })
            end if
        end if
    end if
end sub



sub appExitFunc()
    '"exit from home back press"
    m.top.appExit = true
end sub

function launchShowScene()
    rowContentItem = createObject("RoSGNode", "ContentNode")
    rowContentItem.addFields({ "show_id": m.top.launch_show_screen })
    ShowShowDetailsScreen(rowContentItem)
end function


' sub onTopMenuFocused()
'     ' m.menuTimer.control = "STOP"
'     focusedItem = m.topMenu.rowItemFocused
'     m.itemFocused = m.topMenu.content.getchild(0).getchild(focusedItem[1]).vanity_url
'     screenStack = m.global.screenStackArray
'     if (m.itemFocused = "searchIcon") or (m.itemFocused = "subscribe") then return
'     currentScreen = invalid
'     if screenStack <> invalid then currentScreen = screenStack.Peek()
'     if currentScreen <> invalid and currentScreen.subtype() <> "HomeScene" and m.lastFocusedIndex <> focusedItem[1]
'         ' m.menuTimer.control = "START"
'     end if
'     m.lastFocusedIndex = m.topMenu.rowItemFocused[1]
' end sub

' sub onTimerExecuted()
'     m.menuTimer.control = "STOP"
'     if m.topMenu <> invalid
'         if m.itemFocused <> invalid and m.itemFocused <> "home"
'             showHomeScene({ GOTO_HOME_AND_LOAD_SMARTHOME: m.itemFocused })
'             m.lastFocusedIndex = m.topMenu.rowItemFocused[1]
'         end if
'     end if
' end sub

' Triggers whenever another component updates the field
sub OnShowCustomDialog(event_ as Object)
    dialogData = event_.GetData()
    if dialogData = invalid then return

    ' Create a standard, versatile dialog node
    m.customDialog = CreateObject("roSGNode", "Dialog")
    m.customDialog.title = dialogData.title
    m.customDialog.message = dialogData.message
    m.customDialog.buttons = dialogData.buttons
    m.customDialog.id = dialogData.id

    ' Store the context/origin component so we know who to respond to
    m.dialogOriginComponent = dialogData.origin

    ' Handle clicks cleanly using buttonSelected
    m.customDialog.ObserveField("buttonSelected", "OnDialogButtonSelected")

    ' Display it on screen
    m.top.dialog = m.customDialog
end sub

' Callback for the button actions
sub OnDialogButtonSelected(event_ as Object)
    buttonIndex = event_.GetData()

    ' If the originating component wants to know what was clicked, pass it back
    if m.dialogOriginComponent <> invalid
        m.dialogOriginComponent.dialogResult = {
            buttonIndex: buttonIndex,
            buttonText: m.customDialog.buttons[buttonIndex],
            dialogMessage: m.customDialog.message,
            title: m.customDialog.title,
            id: m.customDialog.id
        }
    end if

    ' Close and clear the dialog
    m.customDialog.close = true
    m.customDialog = invalid
    m.dialogOriginComponent = invalid
end sub