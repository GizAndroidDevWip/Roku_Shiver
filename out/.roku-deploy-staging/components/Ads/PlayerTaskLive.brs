Library "Roku_Ads.brs"
function init()
    m.EventFetcher = CreateObject("roSGNode", "EventFetcher")
    m.Timer = m.top.findNode("Timer")
    m.Timer.control = "start"
    m.Timer.observeField("fire", "change")
    m.top.id = "PlayerTaskLive"
    m.top.adBoolean = true
    m.top.adPlaying = False
    m.top.functionName = "runTask"
    m.useStitched = true
    m.count = 0
    m.top.PauseBoolean = false

end function

function runTask()
    value = m.top.videos
    cont = value.content
    ?"dddtrdt"
    ?value
    ?cont
    if cont.title = "true"
        adapter = loadAdapter()
        loadStream(adapter)
        runLoop(adapter)
        ?"jhjj"
    else
        port = CreateObject("roMessagePort")
        vidContent = createObject("RoSGNode", "ContentNode")
        vidContent.title = cont.channel_name'"LIVE TV"
        vidContent.url = cont.url
        vidContent.live = cont.is_live
        vidContent.streamformat = "hls"
        ' m.top.videos.content = vidContent
        m.top.videos.content = vidContent
        ?"ghhghgh"
        m.top.videos.visible = true
        video_time = value.position

        ' m.top.videos.content.is_live

        Event(getUserIdana(), "POP02", "0", cont.title, getchannelsid(), "", cont.is_live, video_time,"")
        ?"eventgetuseridlivetv"
        m.top.videos.control = "prebuffer"
        m.top.videos.enableCookies()
        m.top.videos.AddHeader("token", getToken())
        m.top.videos.observeField("position", port)
        m.top.videos.observeField("state", port)
        m.top.videos.control = "play"
        keepPlaying = true
        while keepPlaying
            msg = wait(0, port)
            if type(msg) = "roSGNodeEvent"
                if msg.GetField() = "position" then
                else if msg.GetField() = "state" then
                    video_time = value.position
                    curState = msg.GetData()
                    if(curState = "playing") then
                        print "playing"

                        if m.top.PauseBoolean = true
                            Event(getUserIdana(), "POP09", "0", cont.title, getchannelsid(), "", cont.is_live, video_time,"")
                            m.top.PauseBoolean = false
                        end if

                        m.top.GloBoolean = true
                    end if
                    if curState = "stopped" or curState = "paused" then
                        m.top.PauseBoolean = true
                        Event(getUserIdana(), "POP04", "0", cont.title, getchannelsid(), "", cont.is_live, video_time,"")
                        m.top.GloBoolean = false
                        m.Timer.control = "stop"
                    else if curState = "finished" then
                        Event(getUserIdana(), "POP05", "0", cont.title, getchannelsid(), "", cont.is_live, video_time,"")
                        m.top.GloBoolean = false
                        m.Timer.control = "stop"
                    end if
                end if
            end if
        end while
    end if
end function

' function getchannelid() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("channelID")
'         tok = sec.Read("channelID")
'         return tok
'     end if
'     return invalid
' end function
'
' function getchannelname() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("channelNAME")
'         tok = sec.Read("channelNAME")
'         return tok
'     end if
'     return invalid
' end function


sub playerstate()
    print m.top.videos.state
    if m.top.videos.state = "playing"
        '      Event(getUserIdana(),"POP03","0",getchannelname(),getchannelid(),"")
        m.top.GloBoolean = true
    else if m.top.videos.state = "stopped"
        '      Event(getUserIdana(),"POP05","0",getchannelname(),getchannelid(),"")
        m.top.GloBoolean = false
        m.Timer.control = "stop"
    else if m.top.videos.state = "finished"
        '      Event(getUserIdana(),"POP05","0",getchannelname(),getchannelid(),"")
        m.top.GloBoolean = false
        m.Timer.control = "stop"
    end if
end sub

sub change()
    if(m.top.GloBoolean = true) then

        m.EventFetcher.user_id = getUserIdana()
        m.EventFetcher.event_type = "POP03"
        m.EventFetcher.video_id = "0"
        m.EventFetcher.is_live = "1"
        m.EventFetcher.video_title = m.top.videoTitle 'cont.title 'getchannelname()
        m.EventFetcher.channel_id = getchannelsid()
        m.EventFetcher.category = ""
        m.EventFetcher.callFunc("runEventFetcher", "")
    end if
end sub

function loadAdapter() as object
    adapter = RAFX_SSAI({ name: "awsemt" }) ' Required
    if adapter <> invalid
        adapter.init() ' Required
        print "RAFX_SSAI version ";adapter["__version__"]
    end if
    return adapter
end function

function getToken()
    url = CreateObject("roUrlTransfer")
    url.SetUrl("https://poppo.tv/proxy/api/GenerateToken")
    url.AddHeader("access-token", getAuthorisationToken())
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    rsp = url.GetToString()
    responseJSON = ParseJSON(rsp)
    m.token = responseJSON.data
    return m.token
end function


function loadStream(adapter as object) as void
    if invalid = adapter then return
    streamInfo = invalid
    if true
        value = m.top.videos
        cont = value.content
        di = CreateObject("roDeviceInfo")
        displaySize = di.GetDisplaySize()
        macroHeight = Str(displaySize.h).Trim()
        macroWidth = Str(displaySize.w).Trim()
        macroDNT = "true"
        if di.IsRIDADisabled()
            macroDNT = "false"
        end if
        macroIP = di.GetExternalIp()
        version = di.GetVersion()
        version_major = mid(version, 3, 1)
        version_minor = mid(version, 5, 2)
        version_build = mid(version, 8, 5)
        if version_minor.toint() < 10 then
            version_minor = mid(version_minor, 2)
        end if
        macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
        macroADID = di.GetRIDA()
        macroDevModel = di.GetModel()
        macroUUID = di.GetChannelClientId()
        macroCountry = di.GetUserCountryCode()
        macroLang = di.GetCurrentLocale()
        macroRegion = di.GetCurrentLocale()
        randomNumber = GenerateGuid()
        request = {
            type: "vod"',    ' Required, live or vod
            url: cont.ad_pod_url ' Required, master-URL
        }
        requests = {
            params: { "adsParams": {
                    "width": macroWidth,
                    "height": macroHeight,
                    "dnt": macroDNT,
                    "ip": macroIP,
                    "lat": getLatitude().Trim(),
                    "lon": getLongitude().Trim(),
                    "ua": macroUserAgent,
                    "advid": macroUserAgent,
                    "uuid": macroUUID,
                    "country": getCountrycode(),
                    "deviceid": macroUUID,
                    "kwds": getAppTitle(),
                    "device_model": macroDevModel,
                    "device_make": "RA",
                    "device_type": "Roku",
                    "channelid": cont.url,
                    "uid": getUserIdana().trim(),
                    "videoid": "0",
                    "bundleid": getBundleID(),
                    "appname": getAppTitle(),
                    "totalduration": "0",
                    "description_url": getAppTitle(),
                    "cb": randomNumber
            } }
        }
        request["body"] = formatjson(requests.params) ' Optional, {adsParams: {param1,param2,...}}
        requestResult = adapter.requestStream(request) ' Required, requesting Ad Metadata
        if requestResult["error"] <> invalid
            print "Error requesting stream ";requestResult
        else
            streamInfo = adapter.getStreamInfo() ' Required when vod, optional when live
        end if
    else
    end if
    if invalid <> streamInfo
        vidContent = createObject("RoSGNode", "ContentNode")
        vidContent.title = "LIVE TV"
        if invalid <> streamInfo["hls_url"] ' Applicable when vod
            vidContent.url = streamInfo.hls_url
        end if
        vidContent.streamformat = "hls"
        m.top.videos.content = vidContent
        m.top.videos.visible = true
        Event(getUserIdana(), "POP02", "0", getchannelname(), getchannelsid(), "", m.top.video.content.is_live, "")
        m.top.videos.control = "prebuffer"
        m.top.videos.enableUI = "true"
        m.top.videos.enableCookies()
    end if
    adIface = Roku_Ads()
    adIface.enableAdMeasurements(true)
    adIface.setDebugOutput(true)
    adIface.setAdPrefs(true, 1)
end function

function GenerateGuid() as string
    return GetRandomHexString(11)
end function

function GetRandomHexString(length as integer) as string
    hexChars = "0123456789123456"
    hexString = ""
    for i = 1 to length
        hexString = hexString + hexChars.Mid(Rnd(16) - 1, 1)
    next
    return hexString
end function

function runLoop(adapter as object) as void
    if invalid = adapter then return
    addCallbacks(adapter)
    port = CreateObject("roMessagePort")
    adapter.enableAds({ player: { sgnode: m.top.videos, port: port },
        useStitched: true
    })
    m.top.videos.observeFieldScoped("position", port)
    m.top.videos.observeFieldScoped("control", port)
    m.top.videos.observeFieldScoped("state", port)
    m.top.videos.control = "play"
    while true
        msg = wait(1000, port)
        curAd = adapter.onMessage(msg) ' Required
        if invalid = curAd
            m.top.videos.setFocus(false)
        else
            if curAd.adCompleted = true
                m.top.videos.setFocus(false)
            else
                m.top.videos.setFocus(false)
            end if
        end if
        if "roSGNodeEvent" = type(msg)
            if "state" = msg.getField() and "finished" = msg.getData() and msg.getNode() = m.top.videos.id then
                '            Event(getUserIdana(),"POP05","0",getchannelname(),getchannelid(),"")
                m.top.GloBoolean = false
                m.Timer.control = "stop"
                exit while ' stream ended. quit loop
            end if
            if "state" = msg.getField() and "stopped" = msg.getData() and msg.getNode() = m.top.videos.id then
                '            Event(getUserIdana(),"POP05","0",getchannelname(),getchannelid(),"")
                m.top.GloBoolean = false
                m.Timer.control = "stop"
                exit while ' video node stopped. quit loop
            end if
            if "state" = msg.getField() and "playing" = msg.getData() and msg.getNode() = m.top.videos.id then
                '                 Event(getUserIdana(),"POP03","0",getchannelname(),getchannelid(),"")
                m.top.GloBoolean = true
            end if
            if "state" = msg.getField() and "error" = msg.getData() and msg.getNode() = m.top.videos.id then
                '                 Event(getUserIdana(),"POP03","0",getchannelname(),getchannelid(),"")
                ?"PlayerTaskLive error printed:"
                ?msg.getField()
                ?msg.getData()
                ?msg.getNode()
            end if
        end if
    end while
    m.top.videos.unobserveFieldScoped("position")
    m.top.videos.unobserveFieldScoped("control")
    m.top.videos.unobserveFieldScoped("state")
end function

function addCallbacks(adapter) as void
    adapter.addEventListener(adapter.AdEvent.PODS, podsCallback)
    adapter.addEventListener(adapter.AdEvent.POD_START, podStartCallback)
    adapter.addEventListener(adapter.AdEvent.IMPRESSION, adEventCallback)
    adapter.addEventListener(adapter.AdEvent.FIRST_QUARTILE, adEventCallback)
    adapter.addEventListener(adapter.AdEvent.MIDPOINT, adEventCallback)
    adapter.addEventListener(adapter.AdEvent.THIRD_QUARTILE, adEventCallback)
    adapter.addEventListener(adapter.AdEvent.COMPLETE, adEventCallback)
    adapter.addEventListener(adapter.AdEvent.POD_END, podEndCallback)
    '
    m.adPod = invalid
    m.adIndex = 0
    m.COMPLETE = adapter.AdEvent.COMPLETE
end function

function podsCallback(podsInfo as object)
    adPods = podsInfo["adPods"] ' New list of adPods found
    print " Pod count: ";adPods.count()
    for each adPod in adPods
        print "     Ad count: ";adPod.ads.count(); "  renderTime: ";adPod.renderTime; "  endTime: ";adPod.renderTime + adPod.duration
    end for
end function
function podStartCallback(podInfo as object)
    if not m.top.adPlaying
        m.top.adPlaying = True
        m.top.videos.enableTrickPlay = false
    end if
    if not m.useStitched
        m.adPod = podInfo["adPod"]
        if invalid <> m.adPod
            print "  Pod adCount: ";podInfo["adPod"].ads.count()
            adIface = Roku_Ads()
            ' fire Pod pixel
            adIface.fireTrackingEvents(m.adPod, { type: podInfo.event })
            m.adIndex = 0
        end if
    end if
end function
function adEventCallback(adInfo as object) as void
    print "At ";adInfo.position;" from SDK -- " ; adInfo.event
    if invalid <> m.adPod and m.adIndex < m.adPod.ads.count()
        adIface = Roku_Ads()
        ' fire Ad pixel
        ad = m.adPod.ads[m.adIndex]
        adIface.fireTrackingEvents(ad, { type: adInfo.event })
        if m.COMPLETE = adInfo.event
            m.adIndex += 1
        end if
    end if
end function
function podEndCallback(podInfo as object)
    m.top.adPlaying = False
    m.top.videos.enableTrickPlay = true
    m.top.videos.setFocus(true)
    if invalid <> m.adPod
        adIface = Roku_Ads()
        ' fire Pod pixel
        adIface.fireTrackingEvents(m.adPod, { type: podInfo.event })
        m.adIndex = 0
    end if
    m.adPod = invalid
end function

' function getUserIdana() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("USER_ID")
'         tok = sec.Read("USER_ID")
'         return tok
'     end if
'     return invalid
' end function


