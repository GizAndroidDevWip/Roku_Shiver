Library "Roku_Ads.brs"

sub init()
    print "init PlayerTaskForTimeGrid"
    m.EventFetcherForTimeGrid = CreateObject("roSGNode", "EventFetcherForTimeGrid")
    ' m.Autoplay= CreateObject("roSGNode", "Autoplay")
    ' m.AutoTimer = m.top.findNode("AutoTimer")
    ' m.AutoTimer.control="start"
    ' m.AutoTimer.observeField("fire", "autoChange")
    m.Timer = m.top.findNode("Timer")
    m.Timer.control = "start"
    m.Timer.observeField("fire", "change")
    m.top.functionName = "playContentWithAds"
    m.top.id = "PlayerTask"
    m.count = 0
    m.top.PauseBoolean = false
    m.top.timerBoolean = true
    m.videoTimeCalledForPOP03 = -1

end sub

sub playContentWithAds()
    if(m.count = 0)
        m.count = 1
        cate = getcategory().toStr()
        video = m.top.video

        if m.top.scheduletask <> invalid
            scheduletask = m.top.scheduletask
        end if
        ' ?"m.top.scheduletaskUUIII"


        ' ?"m.PlayerTaskForTimeGrid.scheduletask"
        ' ?m.top.video
        ' ?"m.top.video"
        ' ?"video:.."
        ' ?m.top.video.content
        ' ?"?m.top.video.content"
        ' ?m.top.video.content.is_live,
        ' ?m.top.video.content.schedule_id
        ' ?"m.top.video.content.is_live, m.top.video.content.schedule_idddds"
        ' ?video
        view = video.getParent()
        RAF = Roku_Ads()
        RAF.enableJITPods(true)
        RAF.setAdPrefs(true, 1)
        RAF.setDebugOutput(true)
        content = video.content
        RAF.setAdUrl(content.ad_url)
        RAF.enableAdMeasurements(true)
        RAF.setContentGenre(content.categories)
        RAF.setContentLength(content.length)

        'skipad logic
        if m.top.skipAd = false
            adPods = RAF.getAds()
        else
            adPods = invalid
        end if

        keepPlaying = true
        if adPods <> invalid and adPods.count() > 0 'and m.top.skipAd = false 'also checking for watch without ads
            ?"adPods <> invalid and adPods.count() > 0 and m.top.skipAd = false"
            keepPlaying = RAF.showAds(adPods, invalid, view)
        end if
        port = CreateObject("roMessagePort")
        if keepPlaying then
            ' video.AddHeader("token", getToken())
            video.observeField("position", port)
            video.observeField("state", port)
            video.visible = true
            video_time = video.position
            EventForPOP02ForTimeGridScene(getUserIdana().Trim(), "POP02", m.top.video.content.show_id, retrurnTitle(), m.top.video.content.channel_id.ToStr(), m.top.video.content.is_live, retrurnScheduleId())
            video.control = "play"
            ' video.seeMode = "accurate"
            video.seek = m.top.watched_duration
            if not (m.top.video.content.DoesExist("prevent_setting_focus_on_live_player") and m.top.video.content.DoesExist("prevent_setting_focus_on_live_player") = true)
                video.setFocus(true) '
            end if
        end if
        curPos = 0
        adPods = invalid
        isPlayingPostroll = false
        while keepPlaying
            msg = wait(0, port)
            if type(msg) = "roSGNodeEvent"
                if msg.GetField() = "position" then
                    curPos = msg.GetData()
                    ?curPos
                    ?"hjhj"
                    adPods = RAF.getAds(msg)
                    if adPods <> invalid and adPods.count() > 0
                        video.control = "stop"
                    end if
                else if msg.GetField() = "state" then
                    curState = msg.GetData()
                    ?curState
                    ?"curStatessd"

                    if(curState = "playing") then
                        ?curState
                        ?"dswew3"
                        m.Timer.control = "start"
                        if m.top.PauseBoolean = true
                            video_time = video.position
                            ? "video resumed"
                            EventForTimeGridScene(getUserIdana(), "POP09", m.top.video.content.show_id, retrurnTitle(), m.top.video.content.channel_id.ToStr(), m.top.video.content.is_live, video_time, retrurnScheduleId())
                            m.top.PauseBoolean = false
                        end if
                        '                 Event(getUserIdana(),"POP03",getvideoId(),getvideoTitle(),getchannelid(),cate)
                        ?"jkj"
                        m.top.GloBoolean = true
                    end if
                    if(curState = "paused" or curState = "stopped") then
                        m.top.PauseBoolean = true
                        video_time = video.position
                        ? "video paused"
                        EventForTimeGridScene(getUserIdana(), "POP04", m.top.video.content.show_id, retrurnTitle(), m.top.video.content.channel_id.ToStr(), m.top.video.content.is_live, video_time, retrurnScheduleId())

                        m.top.GloBoolean = false
                    end if
                    if curState = "stopped" then
                        ? "video stoppeddddd"
                        m.top.PauseBoolean = true
                        '                  Event(getUserIdana(),"POP05",getvideoId(),getvideoTitle(),getchannelid(),cate)
                        m.top.GloBoolean = false
                        m.Timer.control = "stop"
                        if adPods = invalid or adPods.count() = 0 then
                            exit while
                        end if

                        ' if m.top.skipAd = false
                        '     ?"m.top.skipAd = false"
                        keepPlaying = RAF.showAds(adPods, invalid, view)
                        ' else
                        '     ?"m.top.skipAd = false else"
                        '     keepPlaying = false
                        ' end if

                        adPods = invalid
                        if isPlayingPostroll then
                            exit while
                        end if
                        if keepPlaying then
                            video.AddHeader("token", getToken())
                            video.visible = true
                            video.seek = curPos
                            video.control = "play"
                            video.setFocus(true)
                        end if

                    else if curState = "finished" then
                        video_time = video.position
                        ? "video finisheddddd"
                        EventForTimeGridScene(getUserIdana(), "POP05", m.top.video.content.show_id, retrurnTitle(), m.top.video.content.channel_id.ToStr(), m.top.video.content.is_live, video_time, retrurnScheduleId())
                        m.top.GloBoolean = false
                        m.Timer.control = "stop"
                        adPods = RAF.getAds(msg)
                        if adPods = invalid or adPods.count() = 0 then
                            exit while
                        end if
                        isPlayingPostroll = true
                        m.top.isFinished = true
                        video.control = "stop"

                    else if curState = "error" then
                        ?msg
                        ?"mssg"
                        ?"playerError"
                        ?"msg.getInfo()"
                        ?msg.getInfo()

                        ?"msg.getNode()"
                        ?msg.getNode()



                        ?msg
                        ?msg.getInfo()
                        ?msg.getNode()

                        ' Enhanced error reporting
                        ? "--- VIDEO ERROR REPORT ---"
                        ? "Error Code: "; video.errorCode
                        ? "Error Message: "; video.errorMsg
                        ? "Error Details: "; video.errorStr

                        ' errorInfo often contains the specific HTTP response code
                        if video.errorInfo <> invalid
                            ? "Error Info: "; video.errorInfo
                        end if
                        ? "--- END ERROR REPORT ---"

                        ?video.errorMsg
                        ?"video.errorMsg"

                        ?video.errorStr
                        ?"video.errorStr"

                    end if
                    m.top.playerState = curState
                end if
            end if
        end while
    end if
end sub


'****POP03 event call
sub change()

    ' schedulefunction()
    video = m.top.video
    if(m.top.GloBoolean = true) then
        m.EventFetcherForTimeGrid.user_id = getUserIdana()
        m.EventFetcherForTimeGrid.event_type = "POP03"
        m.EventFetcherForTimeGrid.video_id = video.content.video_id
        ' m.EventFetcherForTimeGrid.video_title = video.content.TITLE
        m.EventFetcherForTimeGrid.channel_id = m.top.video.content.channel_id.ToStr()

        video_time = video.position
        is_live = video.content.is_live
        show_id = video.content.show_id
        ' if m.top.timerBoolean = true
        if video_time mod 60 = 0.0000000 and not int(video_time) = m.videoTimeCalledForPOP03 and video_time > 59 then
            m.EventFetcherForTimeGrid.video_time = video_time
            dt = CreateObject ("roDateTime")
            timestampdevice = dt.AsSeconds().ToStr()
            ?timestampdevice
            m.EventFetcherForTimeGrid.video_title = retrurnTitle()
            m.EventFetcherForTimeGrid.schedule_id = retrurnScheduleId()
            m.EventFetcherForTimeGrid.is_live = is_live
            m.EventFetcherForTimeGrid.show_id = show_id
            m.EventFetcherForTimeGrid.callFunc("runEventFetcherForTimeGrid", "")
            m.top.timerBoolean = false
            m.videoTimeCalledForPOP03 = int(video_time)
        end if
        ' sleep(3000)
        ' m.top.timerBoolean = true
        ' end if

    end if







end sub

' Sub autoChange()
'     m.Autoplay.video_id=getvideoId()
'     m.Autoplay.callFunc("runAutoplay","")
' End Sub
function convertTimeToEpoch(timeString)
    date = CreateObject("roDateTime")
    date.FromISO8601String(timeString)
    return date.AsSeconds()
end function


function getCurrentTimeInSeconds()
    ' ?"getCurrentTimeInSeconds called"
    date = CreateObject("roDateTime")
    ' date.ToLocalTime()
    dateInEpoch = date.AsSeconds()
    ?dateInEpoch
    return dateInEpoch
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

' function getAuthTokenAPI()
'     urlTfer = CreateObject("roUrlTransfer")
'     urlTfer.SetUrl("https://poppo.tv/proxy/authenticate?uid=2")
'     urlTfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
'     urlTfer.setPort(m.port)
'     Xrsp = urlTfer.GetToString()
'     Xresp = ParseJSON(Xrsp)
'     authToken = Xresp.token
'     return authToken
' end function

' function getUserIdana() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("USER_ID")
'         tok = sec.Read("USER_ID")
'         return tok
'     end if
'     return invalid
' end function

function getvideoId() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("videoID")
        tok = sec.Read("videoID")
        return tok
    end if
    return 0
end function

function getvideoTitle() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("videoTITLE")
        tok = sec.Read("videoTITLE")
        ' ?"tokkken"
        return tok
    end if
    return ""
end function

' function getchannelid() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("channelID")
'         tok = sec.Read("channelID")
'         return tok
'     end if
'     return invalid
' end function

function getcategory() as string

    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("category")
        sess = ses.Read("category")
        return sess
    else
        return ""
    end if

end function


function retrurnScheduleId()

    if m.top.scheduletask <> invalid

        if m.top.scheduletask.getChild(0) <> invalid and m.top.scheduletask.getChild(0).getChildCount() <> invalid and m.top.scheduletask.getChild(0).getChildCount() > 1

            for i = 0 to m.top.scheduletask.getChild(0).getChildCount() - 1
                ?"kkiiuu"


                if m.top.scheduletask.getChild(0) <> invalid and m.top.scheduletask.getChild(0).getChild(i) <> invalid and m.top.scheduletask.getChild(0).getChild(i).description <> invalid and m.top.scheduletask.getChild(0).getChild(i).shortdescriptionline2 <> invalid
                    start_time = convertTimeToEpoch(m.top.scheduletask.getChild(0).getChild(i).shortdescriptionline2)
                    end_time = convertTimeToEpoch(m.top.scheduletask.getChild(0).getChild(i).description)
                    

                    if start_time < getCurrentTimeInSeconds() and end_time > getCurrentTimeInSeconds()
                        
                        scheduleId = m.top.scheduletask.getChild(0).getChild(i).id

                        return scheduleId
                    else

                        scheduleId = m.top.video.content.schedule_id

                    end if

                end if

            end for
        else
            scheduleId = ""


        end if
    else

        scheduleId = m.top.video.content.schedule_id


    end if

    return scheduleId

end function




function retrurnTitle()

    if m.top.scheduletask <> invalid

        if m.top.scheduletask.getChild(0) <> invalid and m.top.scheduletask.getChild(0).getChildCount() <> invalid and m.top.scheduletask.getChild(0).getChildCount() > 1

            for i = 0 to m.top.scheduletask.getChild(0).getChildCount() - 1

                if m.top.scheduletask.getChild(0) <> invalid and m.top.scheduletask.getChild(0).getChild(i) <> invalid and m.top.scheduletask.getChild(0).getChild(i).description <> invalid and m.top.scheduletask.getChild(0).getChild(i).shortdescriptionline2 <> invalid

                    start_time = convertTimeToEpoch(m.top.scheduletask.getChild(0).getChild(i).shortdescriptionline2)
                    end_time = convertTimeToEpoch(m.top.scheduletask.getChild(0).getChild(i).description)

                    ?start_time
                    ?end_time
                    ?getCurrentTimeInSeconds()

                    if start_time < getCurrentTimeInSeconds() and end_time > getCurrentTimeInSeconds()


                        ?m.top.scheduletask.getChild(0).getChild(i).TITLE
                        scheduleTitle = m.top.scheduletask.getChild(0).getChild(i).TITLE

                        return scheduleTitle
                    else

                        ?m.top.video.content.Title

                        scheduleTitle = m.top.video.content.Title

                    end if

                end if

            end for
        else
            scheduleTitle = ""
        end if
    else


        ?m.top.video.content.Title
        scheduleTitle = m.top.video.content.Title


    end if

    return scheduleTitle

end function
