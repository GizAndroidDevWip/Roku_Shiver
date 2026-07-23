
Function Init()
    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")
    m.buttons           =   m.top.findNode("Buttons")
    m.poster            =   m.top.findNode("Poster")
    m.description       =   m.top.findNode("Description")
    m.background        =   m.top.findNode("Background")
    m.Player            =   m.top.findNode("Player")
    result = []
    m.handle = false
    for each button in ["Play"]
        result.push({title : button})
    end for
    m.buttons.content = ContentList2SimpleNode(result)
End Function

' set proper focus to buttons if Details opened and stops Video if Details closed
Sub onVisibleChange()
    if m.top.visible = true then
        m.buttons.jumpToItem = 0
        m.buttons.setFocus(true)
   
    end if
End Sub

' set proper focus to Buttons in case if return from Video PLayer
Sub OnFocusedChildChange()
    if m.top.isInFocusChain() and not m.buttons.hasFocus() and not m.Player.hasFocus() then
        m.buttons.setFocus(true)
    end if
End Sub


Sub onItemSelected()
? "DETAIL SCREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEN"
    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    macroDNT = "true"
    if di.IsRIDADisabled()
    macroDNT = "false"
    end if
    macroIP = di.GetExternalIp()
    version=di.GetVersion()
    version_major=mid(version,3,1)
    version_minor=mid(version,5,2)
    version_build=mid(version,8,5)
    if version_minor.toint() < 10 then
        version_minor=mid(version_minor,2)
    end if
    macroUserAgent = "Roku/DVP-"+version_major+"."+version_minor+" ("+version+")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = di.GetUserCountryCode()
    macroLang =  di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    macroChannelID = Str(m.top.content.channel_id).Trim()
    macroVideoID = Str(m.top.content.video_id).Trim()
    macroDuration = m.top.content.video_duration
    macrouserID = m.top.content.user_id

    adUURRLL = m.top.content.ad_link
       
    tempONE= strReplace(adUURRLL,"[WIDTH]",macroWidth)
    tempTWO = strReplace(tempONE,"[HEIGHT]",macroHeight)
    tempTHREE = strReplace(tempTWO,"[DNT]",macroDNT)
    tempFOUR = strReplace(tempTHREE,"[IP_ADDRESS]",macroIP)
    tempFIVE = strReplace(tempFOUR,"[USER_AGENT]",macroUserAgent)
    tempSIX = strReplace(tempFIVE,"[DEVICE_IFA]",macroADID)
    tempSEVEN = strReplace(tempSIX,"[UUID]",macroUUID)
    tempEIGHT = strReplace(tempSEVEN,"[USER_ID]",macrouserID)
    tempNINE = strReplace(tempEIGHT,"[REGION]",macroRegion)
    tempTEN = strReplace(tempNINE,"[COUNTRY]",macroCountry)
    tempELEVEN = strReplace(tempTEN,"[DEVICE_ID]",macroUUID)
    tempTWELVE = strReplace(tempELEVEN,"[DEVICE_MODEL]",macroDevModel)
    tempTHIRTEEN = strReplace(tempTWELVE,"[CHANNEL_ID]",macroChannelID)
    tempFOURTEEN = strReplace(tempTHIRTEEN,"[VIDEO_ID]",macroVideoID)
    finalAdURL = strReplace(tempFOURTEEN,"[DURATION]",macroDuration)

   'finalAdURL = "https://search.spotxchange.com/vast/2.0/224109?VPI[]=MP4&player_width=1920&player_height=1280&app[bundle]=B07BD3VXB2"


  if m.top.itemSelected = 0
          videoContent = {
        streamFormat: m.top.content.streamFormat,
        titleSeason: m.top.content.titleSeason,
        title: m.top.content.title,
        url:  m.top.content.url,
        categories: m.top.content.categories
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: m.top.content.video_duration
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.ad_url =  finalAdURL
'     if m.Player = invalid:
'        m.Player = m.top.CreateChild("Player")
'        m.Player.observeField("state", "PlayerStateChanged")
'        m.Player.observeField("visible", "onVideoVisibleChange")
'    end if

    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.control = "play"
    m.handle = true
  end if
End Sub

sub PlayerStateChanged()
  ? "PlayerStateChanged"
    if m.Player.state = "done" or m.Player.state = "stop"
        m.Player.visible = false
        m.top.removeChild(m.Player)
        m.Player = invalid
        m.buttons.setFocus(true)
        m.handle = false
    else if m.Player.state = "error"
        m.Player.visible = false
    else if m.Player.state = "playing"
    else if m.Player.state = "finished"
        m.Player.visible = false
    end if
end sub

Sub onVideoVisibleChange()
  ? "on player visibility changed"
    if m.Player.visible = false and m.top.visible = true
        m.buttons.setFocus(true)
        m.Player.control = "stop"
        m.Player.content = invalid
        m.top.removeChild(m.Player)
        m.handle = false
    end if
End Sub




' Content change handler
Sub OnContentChange()
    m.description.content   = m.top.content
    m.description.Description.width = "770"
    m.poster.uri            = m.top.content.hdBackgroundImageUrl
    m.background.uri            = m.top.content.hdBackgroundImageUrl
End Sub

'///////////////////////////////////////////'
' Helper function convert AA to Node
Function ContentList2SimpleNode(contentList as Object, nodeType = "ContentNode" as String) as Object
    result = createObject("roSGNode",nodeType)
    if result <> invalid
        for each itemAA in contentList
            item = createObject("roSGNode", nodeType)
            item.setFields(itemAA)
            result.appendChild(item)
        end for
    end if
    return result
End Function

function onKeyEvent(key as String, press as Boolean) as Boolean
   print "DetailsScreen: keyevent = "; key
   if press
        if key = "back"
            m.Player.control = "stop"
            m.top.removeChild(m.Player)
            m.buttons.setFocus(true)
            m.handle = false
    end if
 end if
 return false
end function


Function strReplace(basestr As String, oldsub As String, newsub As String) As String

    newstr = ""

    i = 1
    while i <= Len(basestr)
        x = Instr(i, basestr, oldsub)
        if x = 0 then
            newstr = newstr + Mid(basestr, i)
            exit while
        endif

        if x > i then
            newstr = newstr + Mid(basestr, i, x-i)
            i = x
        endif

        newstr = newstr + newsub
        i = i + Len(oldsub)
    end while

    return newstr
End Function
