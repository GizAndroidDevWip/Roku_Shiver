'*********************************************************************
'** (c) 2016-2017 Roku, Inc.  All content herein is protected by U.S.
'** copyright and other applicable intellectual property laws and may
'** not be copied without the express permission of Roku, Inc., which
'** reserves all rights.  Reuse of any of this content for any purpose
'** without the permission of Roku, Inc. is strictly prohibited.
'********************************************************************* 

Library "Roku_Ads.brs"

sub init()
    m.top.functionName = "playContentWithAds" 
    m.top.id = "PlayerTask"
end sub

sub playContentWithAds()
    video = m.top.video
    view = video.getParent() 
    RAF = Roku_Ads()
    content = video.content
    RAF.setAdUrl(content.ad_url)
    ? "AD tag URL "+content.ad_url
    RAF.enableAdMeasurements(true)
    RAF.setContentGenre(content.categories)  'if unset, ContentNode has it as []
    RAF.setContentLength(content.length)
    adPods = RAF.getAds() 'array of ad pods
    keepPlaying = true 'gets set to `false` when showAds() was exited via Back button
    if adPods <> invalid and adPods.count() > 0
       keepPlaying = RAF.showAds(adPods, invalid, view)
       
    end if

    port = CreateObject("roMessagePort")
    if keepPlaying then
        video.AddHeader("token",getToken())
        video.observeField("position", port)
        video.observeField("state", port)
        video.visible = true
        video.control = "play"
        video.setFocus(true) 'so we can handle a Back key interruption
    end if

    curPos = 0
    adPods = invalid
    isPlayingPostroll = false
    
    while keepPlaying
      msg = wait(0, port)
      if type(msg) = "roSGNodeEvent"   
        
            if msg.GetField() = "position" then
                  curPos = msg.GetData() 
                  adPods = RAF.getAds(msg)
                    if adPods <> invalid and adPods.count() > 0
                      video.control = "stop"  
                    end if
            else if msg.GetField() = "state" then
                  curState = msg.GetData()
                  print "PlayerTaskLive: state = "; curState
                  if curState = "stopped" then
                    if adPods = invalid or adPods.count() = 0 then 
                        exit while
                    end if

                    print "PlayerTaskLive: playing midroll/postroll ads"
                    keepPlaying = RAF.showAds(adPods, invalid, view)
                    adPods = invalid
                    if isPlayingPostroll then 
                        exit while
                    end if
                    if keepPlaying then
                        print "PlayerTaskLive: mid-roll finished, seek to "; stri(curPos)
                        video.AddHeader("token",getToken())
                        video.visible = true
                        video.seek = curPos
                        video.control = "play"
                        video.setFocus(true) 'important: take the focus back (RAF took it above)
                    end if
                        
                else if curState = "finished" then
                    print "PlayerTaskLive: main content finished"
                    ' render post-roll ads
                    adPods = RAF.getAds(msg)
                    if adPods = invalid or adPods.count() = 0 then 
                        exit while
                    end if
                    print "PlayerTaskLive: has postroll ads"
                    isPlayingPostroll = true
                    ' stop the video, the post-roll would show when the state changes to  "stopped" (above)
                    video.control = "stop"
                end if
            end if
        end if
    end while

    print "PlayerTaskLive: exiting playContentWithAds()"
end sub

Function getToken()
    url = CreateObject("roUrlTransfer")
    url.SetUrl("https://poppo.tv/proxy/api/GenerateToken")
    url.AddHeader("access-token", getAuthorisationToken())
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    rsp = url.GetToString()
    responseJSON = ParseJSON(rsp)
    m.token = responseJSON.data
    return m.token
End Function

Function getAuthTokenAPI()
    urlTfer = CreateObject("roUrlTransfer")
    urlTfer.SetUrl("https://poppo.tv/proxy/authenticate?uid=2")
    urlTfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    urlTfer.setPort(m.port)
    Xrsp = urlTfer.GetToString()
    Xresp = ParseJSON(Xrsp)
    authToken = Xresp.token
    return authToken
End Function
