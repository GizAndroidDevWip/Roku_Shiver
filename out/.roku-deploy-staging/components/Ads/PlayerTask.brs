Library "Roku_Ads.brs"

sub init()
    print "init"
    m.EventFetcher = CreateObject("roSGNode", "EventFetcher")
    m.Timer = m.top.findNode("Timer")
    m.Timer.control = "start"
    m.Timer.observeField("fire", "change")
    m.top.functionName = "playContentWithAds"
    m.top.id = "PlayerTask"
    m.count = 0
    m.top.PauseBoolean = false
    m.top.timerBoolean = true

end sub

sub playContentWithAds()
    if(m.count = 0)
        m.count = 1

        if m.top.video.content = invalid then return
        if m.top.video.content.categoriesWithComma <> invalid
            categorieswithcomma = m.top.video.content.categoriesWithComma
        else
            categorieswithcomma = ""
        end if


        video = m.top.video
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

        if m.top.isTrackChange <> invalid and m.top.isTrackChange = true and adPods <> invalid and adPods.count() > 0
            adPods = filterPrerollAds(adPods) 'filter out prerolls if it's track change to avoid showing prerolls again on track change, but keep midrolls and postrolls
        end if

        keepPlaying = true
        if adPods <> invalid and adPods.count() > 0 'and m.top.skipAd = false 'also checking for watch without ads
            ' ?"adPods <> invalid and adPods.count() > 0 and m.top.skipAd = false"
            keepPlaying = RAF.showAds(adPods, invalid, view)
            ?keepPlaying
            ?"sss"
        end if
        port = CreateObject("roMessagePort")
        if keepPlaying then
            ?keepPlaying
            if m.top <> invalid and m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.video_time <> invalid
                video.AddHeader("token", getToken(m.top.video.content.video_time))
                tokenvalue = getToken(m.top.video.content.video_time)
            end if

            video.observeField("position", port)
            video.observeField("state", port)
            video.visible = true
            video_time = video.position
            if m.top.video.content <> invalid then EventForPOP02(getUserIdana().Trim(), "POP02", getVideoIdOrEventId(), m.top.video.content.title, getchannelsid(), categorieswithcomma, m.top.video.content.is_live, m.top.video.content.ai_type)
            video.control = "play"
            video.seek = m.top.watched_duration
            video.setFocus(true) '
        end if
        curPos = 0
        adPods = invalid
        isPlayingPostroll = false
        while keepPlaying
            msg = wait(0, port)
            ?msg
            if type(msg) = "roSGNodeEvent"
                if msg.GetField() = "position" then
                    curPos = msg.GetData()
                    adPods = RAF.getAds(msg)
                    if adPods <> invalid and adPods.count() > 0
                        video.control = "stop"
                        ?"kko"
                    end if
                else if msg.GetField() = "state" then
                    curState = msg.GetData()
                    ?curState
                    ?"curStateere"

                    if(curState = "playing") then
                        ?"playing"
                        m.Timer.control = "start"
                        if m.top.PauseBoolean = true
                            video_time = video.position
                            ? "video resumed"
                            if m.top.video.content <> invalid then Event(getUserIdana(), "POP09", getVideoIdOrEventId(), m.top.video.content.title, getchannelsid(), categorieswithcomma, m.top.video.content.is_live, video_time, m.top.video.content.ai_type)
                            m.top.PauseBoolean = false
                        end if

                        m.top.GloBoolean = true
                    end if
                    if(curState = "paused" or curState = "stopped") then
                        m.top.PauseBoolean = true
                        video_time = video.position
                        ? "video paused"
                        if m.top.video.content <> invalid then Event(getUserIdana(), "POP04", getVideoIdOrEventId(), m.top.video.content.title, getchannelsid(), categorieswithcomma, m.top.video.content.is_live, video_time, m.top.video.content.ai_type)

                        m.top.GloBoolean = false
                    end if
                    if curState = "stopped" then
                        m.top.PauseBoolean = true
                        m.top.GloBoolean = false
                        m.Timer.control = "stop"
                        if adPods = invalid or adPods.count() = 0 then
                            exit while
                        end if


                        keepPlaying = RAF.showAds(adPods, invalid, view)


                        adPods = invalid
                        if isPlayingPostroll then
                            exit while
                        end if
                        if keepPlaying then
                            video.AddHeader("token", getToken(m.top.video.content.video_time))
                            token = getToken(m.top.video.content.video_time)
                            ?token
                            ?"ddfddf"
                            ?"sds"
                            video.visible = true
                            video.seek = curPos
                            video.control = "play"
                            video.setFocus(true)
                        end if

                    else if curState = "finished" then
                        video_time = video.position
                        ? "video finisheddddd"
                        if m.top.video.content <> invalid then Event(getUserIdana(), "POP05", getVideoIdOrEventId(), m.top.video.content.title, getchannelsid(), categorieswithcomma, m.top.video.content.is_live, video_time, m.top.video.content.ai_type)
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

                        if video.errorMsg = "player: only one playing instance supported."
                            ? "Stopping any existing video instance"
                            ' m.loadingIndicator.visible = false
                            ?"jjuyuttttyyyyuuu"
                            video.control = "stop"
                            video.visible = false
                            ?"y7yuuiij"
                            video.setFocus(false)
                        else

                        end if


                    end if
                    m.top.playerState = curState
                end if
            end if
        end while
    end if
end sub


'****POP03 event call
sub change()
    video = m.top.video
    if(m.top.GloBoolean = true) then
        m.EventFetcher.user_id = getUserIdana()
        m.EventFetcher.event_type = "POP03"
        m.EventFetcher.video_id = getVideoIdOrEventId()
        m.EventFetcher.video_title = video.content.TITLE
        m.EventFetcher.channel_id = getchannelsid()
        m.EventFetcher.titleSeason = m.top.video.content.categories
        m.EventFetcher.ai_type = m.top.video.content.ai_type

        video_time = video.position
        is_live = video.content.is_live


        if video_time mod 60 = 0.0000000 and video_time > 59 then
            m.EventFetcher.video_time = video_time
            m.EventFetcher.is_live = is_live
            m.EventFetcher.callFunc("runEventFetcher", "")
        end if
    end if
end sub



function getToken(urlParams = {} as object) as object
    if urlParams <> invalid and urlParams <> "" then
        data = {}
        url = getBaseApiURL() + "playlistV2/generateToken?id=" + urlParams.Trim()
        response = makeRequest(url, urlParams)
        if response <> invalid
            m.token = response.data
        end if
    else
        ' ✅ If urlParams is invalid or empty → use 2nd part
        url = CreateObject("roUrlTransfer")
        url.SetUrl("https://poppo.tv/proxy/api/GenerateToken")
        url.AddHeader("access-token", getAuthorisationToken())
        url.SetCertificatesFile("common:/certs/ca-bundle.crt")
        rsp = url.GetToString()
        responseJSON = ParseJSON(rsp)

        if responseJSON <> invalid and responseJSON.data <> invalid
            m.token = responseJSON.data
        else
            m.token = getAuthorisationToken()
        end if
    end if
    return m.token

end function




function getvideoId() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("videoID")
        tok = sec.Read("videoID")
        return tok
    else
        return 0
    end if
end function

function getvideoTitle() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("videoTITLE")
        tok = sec.Read("videoTITLE")
        return tok
    else
        return ""
    end if
end function


function getcategory() as object

    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("category")
        sess = ses.Read("category")
        return sess
    end if

end function


function getVideoIdOrEventId()'
    ' this will return video id for shows and ended event, and eventId for live event

    if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.is_live <> invalid and m.top.video.content.is_live = "0"
        if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.video_id <> invalid
            videoid = m.top.video.content.video_id.ToStr()
        else
            videoid = "0"
        end if
        ?videoid
        ?"videoidghh"
        return videoid

    else if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.is_live <> invalid and m.top.video.content.is_live = "1"
        if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.eventId <> invalid
            eventId = m.top.video.content.eventId.ToStr()
        else
            eventId = "0"
        end if
        return eventId
        ?eventId
        ?"eventIdjj"
    end if
end function


function filterPrerollAds(adPods)
    if m.top.isTrackChange = true and adPods <> invalid and adPods.count() > 0
        ' this is when sitching speed and language etc. preroll ads play again because player is reloaded, we need to filter out prerolls in this case and only keep midrolls and postrolls
        ?"Refreshing: Filtering out prerolls but keeping midrolls"

        filteredPods = []
        for each pod in adPods
            ' pod.renderTime = 0 means it's a preroll
            ' We only keep it if it's NOT at the very beginning
            if pod <> invalid and pod.renderSequence <> invalid and pod.renderSequence <> "preroll"
                filteredPods.push(pod)
            end if
        end for

        ' Update adPods with the filtered list (minus the preroll)
        adPods = filteredPods
        return adPods
    end if
end function