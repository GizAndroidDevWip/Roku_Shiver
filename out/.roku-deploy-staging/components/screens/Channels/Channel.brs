sub init()
   
'    m.ChannelFetcher = CreateObject("roSGNode", "ChannelFetcher")
'    m.ChannelFetcher.observeField("Content", "onContentChanged")
'    m.count = 0
'    m.AdTimer = m.top.findNode("AdTimer")
'    m.RowList = m.top.findNode("RowList")
'    m.BottomBar = m.top.findNode("BottomBar")
'    m.ShowBar = m.top.findNode("ShowBar")
'    m.HideBar = m.top.findNode("HideBar")
'    m.Hint = m.top.findNode("Hint")
'    m.Timer = m.top.findNode("Timer")
'    m.Hint.font.size = "15"
   
  
end sub

'sub onStarted()
'    m.count = 0
'    m.ChannelFetcher.ContentRequest = m.top.start
'  
'end sub
'
'sub onContentChanged()
'    showHint()
'    m.AdTimer.control = "start"
'    m.RowList.setFocus(true)
'    m.RowList.rowLabelFont.size = "24"
'    m.Timer.observeField("fire", "hideHint")
'    m.AdTimer.observeField("fire", "change")
''    m.RowList.observeField("rowItemSelected", "ChannelChange")
'    m.RowList.content = m.ChannelFetcher.Content
'
'    if m.count = 0
'    m.global.AdTracker = 0
'    VODcontent =  m.top.Content
'    di = CreateObject("roDeviceInfo")
'    displaySize = di.GetDisplaySize()
'    macroHeight = Str(displaySize.h).Trim()
'    macroWidth = Str(displaySize.w).Trim()
'    macroDNT = "true"
'    if di.IsRIDADisabled()
'    macroDNT = "false"
'    end if
'    macroIP = di.GetExternalIp()
'    version=di.GetVersion()
'    version_major=mid(version,3,1)
'    version_minor=mid(version,5,2)
'    version_build=mid(version,8,5)
'    if version_minor.toint() < 10 then
'        version_minor=mid(version_minor,2)
'    end if
'    macroUserAgent = "Roku/DVP-"+version_major+"."+version_minor+"("+version+")"
'    macroADID = di.GetRIDA()
'    macroDevModel = di.GetModel()
'    macroUUID = di.GetChannelClientId()
'    macroCountry = di.GetUserCountryCode()
'    macroLang =  di.GetCurrentLocale()
'    macroRegion = di.GetCurrentLocale()
'    macroChannelID = Str(VODcontent.channel_id).Trim()
'    macroVideoID = Str(VODcontent.channel_id).Trim()
'    macroDuration = "0"
'    macrouserID = VODcontent.user_id
'
'    adUURRLL = VODcontent.ad_link
'    adPODURL = VODcontent.ad_pod_url 
'        
'    tempONE= strReplace(adUURRLL,"[WIDTH]",macroWidth)
'    tempTWO = strReplace(tempONE,"[HEIGHT]",macroHeight)
'    tempTHREE = strReplace(tempTWO,"[DNT]",macroDNT)
'    tempFOUR = strReplace(tempTHREE,"[IP_ADDRESS]",macroIP)
'    tempFIVE = strReplace(tempFOUR,"[USER_AGENT]",macroUserAgent)
'    tempSIX = strReplace(tempFIVE,"[DEVICE_IFA]",macroADID)
'    tempSEVEN = strReplace(tempSIX,"[UUID]",macroUUID)
'    tempEIGHT = strReplace(tempSEVEN,"[USER_ID]",macrouserID)
'    tempNINE = strReplace(tempEIGHT,"[REGION]",macroRegion)
'    tempTEN = strReplace(tempNINE,"[COUNTRY]",macroCountry)
'    tempELEVEN = strReplace(tempTEN,"[DEVICE_ID]",macroUUID)
'    tempTWELVE = strReplace(tempELEVEN,"[DEVICE_MODEL]",macroDevModel)
'    tempTHIRTEEN = strReplace(tempTWELVE,"[CHANNEL_ID]",macroChannelID)
'    tempFOURTEEN = strReplace(tempTHIRTEEN,"[VIDEO_ID]",macroChannelID)
'    tempFIFTEEN = strReplace(tempFOURTEEN,"[APP_STORE_URL]",getRokuChannelStoreURL())
'    tempSIXTEEN = strReplace(tempFIFTEEN,"[DEVICE_MAKE]","RA")
'    finalAdURL = strReplace(tempSIXTEEN,"[TOTAL_DURATION]",macroDuration)
''    finalAdURL = "https://search.spotxchange.com/vast/2.0/224109?VPI[]=MP4&player_width=1920&player_height=1280&app[bundle]=B07BD3VXB2"
' ? "********************"
' ? finalAdURL
' ? "********************"
' 
'                    tempONE= strReplace(adPODURL,"[WIDTH]",macroWidth)
'                    tempTWO = strReplace(tempONE,"[HEIGHT]",macroHeight)
'                    tempTHREE = strReplace(tempTWO,"[DNT]",macroDNT)
'                    tempFOUR = strReplace(tempTHREE,"[IP_ADDRESS]",macroIP)
'                    tempFIVE = strReplace(tempFOUR,"[USER_AGENT]",macroUserAgent)
'                    tempSIX = strReplace(tempFIVE,"[DEVICE_IFA]",macroADID)
'                    tempSEVEN = strReplace(tempSIX,"[UUID]",macroUUID)
'                    tempEIGHT = strReplace(tempSEVEN,"[USER_ID]",macrouserID)
'                    tempNINE = strReplace(tempEIGHT,"[REGION]",macroRegion)
'                    tempTEN = strReplace(tempNINE,"[COUNTRY]",macroCountry)
'                    tempELEVEN = strReplace(tempTEN,"[DEVICE_ID]",macroUUID)
'                    tempTWELVE = strReplace(tempELEVEN,"[DEVICE_MODEL]",macroDevModel)
'                    tempTHIRTEEN = strReplace(tempTWELVE,"[CHANNEL_ID]",macroChannelID)
'                    tempFOURTEEN = strReplace(tempTHIRTEEN,"[VIDEO_ID]",macroVideoID)
'                    tempFIFTEEN = strReplace(tempFOURTEEN,"[APP_STORE_URL]",getRokuChannelStoreURL())
'                    tempSIXTEEN = strReplace(tempFIFTEEN,"[DEVICE_MAKE]","RA")
'                    finalAdPODURL = strReplace(tempSIXTEEN,"[TOTAL_DURATION]",macroDuration)
'                
'                 ? "********************"
'                 ? finalAdPODURL
'                 ? "********************"
' 
'
'
'     videoContent = {
'        streamFormat: VODcontent.streamFormat,
'        titleSeason: VODcontent.titleSeason,
'        title: VODcontent.title,
'        url:  VODcontent.url,
'        categories: VODcontent.categories
'        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
'        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
'        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
'        length: VODcontent.video_duration
'    }
'    content = CreateObject("roSGNode", "VideoContent")
'    content.setFields(videoContent)
'    content.ad_url =  finalAdURL.EncodeUri()
'    content.ad_pod_url =  finalAdPODURL.EncodeUri()
'     if m.PlayerLive = invalid:
'        m.PlayerLive = m.top.CreateChild("PlayerLive")
'        m.PlayerLive.observeField("state", "PlayerStateChanged")
'        m.PlayerLive.observeField("visible", "onVideoVisibleChange")
'    end if
'
'    m.PlayerLive.content = content
'    m.PlayerLive.visible = true
'    m.PlayerLive.setFocus(true)
'    m.PlayerLive.control = "play"
'    m.PlayerLive.observeField("visibility", "onVisibleChange")
'    end if
'
'end sub

'Sub change()
'    m.global.Adtracker = 0
'End Sub
'
'Sub  hideHint()
'    m.Hint.visible = false
'End Sub
'
'Sub showHint()
'    m.Hint.visible = true
'    m.Timer.control = "start"
'End Sub

'Sub optionsMenu()
'    if m.global.Options = 0
'        m.ShowBar.control = "start"
'        m.RowList.setFocus(true)
'        hideHint()
'    else
'        m.HideBar.control = "start"
'        m.PlayerLive.setFocus(true)
'        showHint()
'    End if
'End Sub

'function onKeyEvent(key as String, press as Boolean) as Boolean 
'    handled = false
'        if press
'           if key="up" or key = "down"
'                   if m.global.Options = 0
'                        m.global.Options = 1
'                        optionsMenu()
'                   else
'                        m.global.Options = 0
'                        optionsMenu()
'                   end if
'                 handled = true
'            else if key = "back"
'           
'    
'                 m.PlayerLive.control = "stop"
'                 m.PlayerLive.content = invalid
'                 handled = false
'         
'            
'        end if
'      end if
'    return handled
'end function

'Function ChannelChange1111()
'    m.global.AdTracker = 0
'    m.PlayerLive.control = "stop"
'    m.PlayerLive.content = invalid
'    VODcontent = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
'    di = CreateObject("roDeviceInfo")
'    displaySize = di.GetDisplaySize()
'    macroHeight = Str(displaySize.h).Trim()
'    macroWidth = Str(displaySize.w).Trim()
'    macroDNT = "true"
'    if di.IsRIDADisabled()
'    macroDNT = "false"
'    end if
'    macroIP = di.GetExternalIp()
'    version=di.GetVersion()
'    version_major=mid(version,3,1)
'    version_minor=mid(version,5,2)
'    version_build=mid(version,8,5)
'    if version_minor.toint() < 10 then
'        version_minor=mid(version_minor,2)
'    end if
'    macroUserAgent = "Roku/DVP-"+version_major+"."+version_minor+" ("+version+")"
'    macroADID = di.GetRIDA()
'    macroDevModel = di.GetModel()
'    macroUUID = di.GetChannelClientId()
'    macroCountry = di.GetUserCountryCode()
'    macroLang =  di.GetCurrentLocale()
'    macroRegion = di.GetCurrentLocale()
'    macroChannelID = Str(VODcontent.channel_id).Trim()
'    macroVideoID = Str(VODcontent.video_id).Trim()
'    macroDuration = VODcontent.video_duration
'    macrouserID = VODcontent.user_id
'
'    adUURRLL = VODcontent.ad_link
'       
'    tempONE= strReplace(adUURRLL,"[WIDTH]",macroWidth)
'    tempTWO = strReplace(tempONE,"[HEIGHT]",macroHeight)
'    tempTHREE = strReplace(tempTWO,"[DNT]",macroDNT)
'    tempFOUR = strReplace(tempTHREE,"[IP_ADDRESS]",macroIP)
'    tempFIVE = strReplace(tempFOUR,"[USER_AGENT]",macroUserAgent)
'    tempSIX = strReplace(tempFIVE,"[DEVICE_IFA]",macroADID)
'    tempSEVEN = strReplace(tempSIX,"[UUID]",macroUUID)
'    tempEIGHT = strReplace(tempSEVEN,"[USER_ID]",macrouserID)
'    tempNINE = strReplace(tempEIGHT,"[REGION]",macroRegion)
'    tempTEN = strReplace(tempNINE,"[COUNTRY]",macroCountry)
'    tempELEVEN = strReplace(tempTEN,"[DEVICE_ID]",macroUUID)
'    tempTWELVE = strReplace(tempELEVEN,"[DEVICE_MODEL]",macroDevModel)
'    tempTHIRTEEN = strReplace(tempTWELVE,"[CHANNEL_ID]",macroChannelID)
'    tempFOURTEEN = strReplace(tempTHIRTEEN,"[VIDEO_ID]",macroVideoID)
'    tempFIFTEEN = strReplace(tempFOURTEEN,"[APP_STORE_URL]",getRokuChannelStoreURL())
'    tempSIXTEEN = strReplace(tempFIFTEEN,"[DEVICE_MAKE]","RA")
'    finalAdURL = strReplace(tempSIXTEEN,"[TOTAL_DURATION]",macroDuration)
''    finalAdURL = "https://search.spotxchange.com/vast/2.0/224109?VPI[]=MP4&player_width=1920&player_height=1280&app[bundle]=B07BD3VXB2"
' ? "********************"
' ? finalAdURL
' ? "********************"
'
'
'     videoContent = {
'        streamFormat: VODcontent.streamFormat,
'        titleSeason: VODcontent.titleSeason,
'        title: VODcontent.title,
'        url:  VODcontent.url,
'        categories: VODcontent.categories
'        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
'        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
'        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
'        length: VODcontent.video_duration
'    }
'    content = CreateObject("roSGNode", "VideoContent")
'    content.setFields(videoContent)
'    content.ad_url =  finalAdURL.EncodeUri()
'     if m.PlayerLive = invalid:
'        m.PlayerLive = m.top.CreateChild("PlayerLive")
'        m.PlayerLive.observeField("state", "PlayerStateChanged")
'        m.PlayerLive.observeField("visible", "onVideoVisibleChange")
'    end if
'
'    m.PlayerLive.content = content
'    m.PlayerLive.visible = true
'    m.PlayerLive.setFocus(true)
'    m.PlayerLive.control = "play"
'    m.PlayerLive.observeField("visibility", "onVisibleChange")
'    
'    
'    
'    
'End Function



'Sub onVisibleChange()
'if m.PlayerLive <> invalid
'    if m.PlayerLive.visibility = false then
'    m.RowList.setFocus(true)
'    m.PlayerLive.content = m.top.Content
'    m.PlayerLive.control = "play"
'    m.count = 1
'    end if
'end if  
'End Sub


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


