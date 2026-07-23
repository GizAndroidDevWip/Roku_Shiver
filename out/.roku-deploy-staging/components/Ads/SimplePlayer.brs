sub init()
    print "SimplePlayer init"
    m.top.functionName = "playContent"
    m.top.id = "SimplePlayer"
    m.count = 0
    m.top.PauseBoolean = false
end sub

sub playContent()
    if(m.count = 0)
        m.count = 1

        video = m.top.video
        port = CreateObject("roMessagePort")
        
        ' Set token for video authorization
        if video <> invalid and video.content <> invalid
            video.AddHeader("token", getToken(m.top.video.content.video_time))
            tokenvalue = getToken(m.top.video.content.video_time)
            ? "Token set: " + tokenvalue.ToStr()
        end if

        ' Setup video observers
        video.observeField("position", port)
        video.observeField("state", port)
        video.visible = true
        
        ' Start playing
        video.control = "play"
        video.seek = m.top.watched_duration
        video.setFocus(true)
        
        ' Event tracking for video start
        if video.content <> invalid
            categorieswithcomma = ""
            if video.content.categoriesWithComma <> invalid
                categorieswithcomma = video.content.categoriesWithComma
            end if
            
            EventForPOP02(getUserIdana().Trim(), "POP02", getVideoIdOrEventId(), video.content.title, getchannelsid(), categorieswithcomma, video.content.is_live, video.content.ai_type)
        end if
        
        ' Main playback loop
        while true
            msg = wait(0, port)
            if type(msg) = "roSGNodeEvent"
                if msg.GetField() = "position" then
                    curPos = msg.GetData()
                    
                else if msg.GetField() = "state" then
                    curState = msg.GetData()
                    ? "Player state: " + curState
                    
                    if curState = "playing" then
                        ? "Video playing"
                        if m.top.PauseBoolean = true
                            video_time = video.position
                            Event(getUserIdana(), "POP09", getVideoIdOrEventId(), video.content.title, getchannelsid(), categorieswithcomma, video.content.is_live, video_time, video.content.ai_type)
                            m.top.PauseBoolean = false
                        end if
                        
                    else if curState = "paused" then
                        m.top.PauseBoolean = true
                        video_time = video.position
                        ? "Video paused"
                        Event(getUserIdana(), "POP04", getVideoIdOrEventId(), video.content.title, getchannelsid(), categorieswithcomma, video.content.is_live, video_time, video.content.ai_type)
                        
                    else if curState = "stopped" then
                        m.top.PauseBoolean = true
                        ? "Video stopped"
                        exit while
                        
                    else if curState = "finished" then
                        video_time = video.position
                        ? "Video finished"
                        Event(getUserIdana(), "POP05", getVideoIdOrEventId(), video.content.title, getchannelsid(), categorieswithcomma, video.content.is_live, video_time, video.content.ai_type)
                        exit while
                        
                    else if curState = "error" then
                        ? "Video error: " + video.errorMsg
                        if video.errorMsg = "player: only one playing instance supported."
                            ? "Stopping existing video instance"
                            video.control = "stop"
                            video.visible = false
                            video.setFocus(false)
                        end if
                        exit while
                    end if
                    
                    m.top.playerState = curState
                end if
            end if
        end while
    end if
end sub

function getToken(urlParams = {} as object) as object
    if urlParams <> invalid and urlParams <> "" then
        data = {}
        url = getBaseApiURL() + "playlistV2/generateToken?id=" + urlParams.Trim()
        ? "Token URL: " + url
        
        response = makeRequest(url, urlParams)
        ? "Token response: " + response.ToStr()
        
        if response <> invalid
            m.token = response.data
            ? "Token generated successfully"
        end if
        
    else
        ' Fallback token generation
        url = CreateObject("roUrlTransfer")
        url.SetUrl("https://poppo.tv/proxy/api/GenerateToken")
        url.AddHeader("access-token", getAuthorisationToken())
        url.SetCertificatesFile("common:/certs/ca-bundle.crt")
        rsp = url.GetToString()
        responseJSON = ParseJSON(rsp)
        
        if responseJSON <> invalid and responseJSON.data <> invalid
            m.token = responseJSON.data
            ? "Fallback token generated successfully"
        else
            m.token = getAuthorisationToken()
            ? "Using authorization token as fallback"
        end if
    end if
    
    return m.token
end function

function getVideoIdOrEventId()
    ' Return video id for shows and ended events, eventId for live events
    if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.is_live <> invalid and m.top.video.content.is_live = "0"
        if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.video_id <> invalid
            videoid = m.top.video.content.video_id.ToStr()
        else
            videoid = "0"
        end if
        return videoid
        
    else if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.is_live <> invalid and m.top.video.content.is_live = "1"
        if m.top.video <> invalid and m.top.video.content <> invalid and m.top.video.content.eventId <> invalid
            eventId = m.top.video.content.eventId.ToStr()
        else
            eventId = "0"
        end if
        return eventId
    end if
end function