Library "Roku_Ads.brs"

sub init()
    print "init"
    m.EventFetcher = CreateObject("roSGNode", "EventFetcher")
    m.top.functionName = "playContentWithAds"
    m.top.id = "PlayerTaskForShorts"
    m.count = 0

end sub

sub playContentWithAds()
    if(m.count = 0)
        m.count = 1
        if m.top.video.content.categoriesWithComma <> invalid
            categorieswithcomma = m.top.video.content.categoriesWithComma
        else
            categorieswithcomma = ""
        end if

        video = m.top.video
        view = video.getParent()
        content = video.content
        adPods = invalid
        keepPlaying = true

        port = CreateObject("roMessagePort")
        if keepPlaying then
            ' video.AddHeader("token", getToken())
            video.observeField("position", port)
            video.observeField("state", port)
            video.visible = true
            video_time = video.position
            EventForPOP02(getUserIdana().Trim(), "POP12", m.top.video.content.video_id, m.top.video.content.title, getchannelsid(), "", m.top.video.content.is_live,"")
            video.control = "play"
            ' video.seeMode = "accurate"
            video.seek = m.top.watched_duration
            video.setFocus(true) '
        end if
        curPos = 0
        adPods = invalid
        isPlayingPostroll = false
        while keepPlaying
            msg = wait(0, port)
            if type(msg) = "roSGNodeEvent"
                if msg.GetField() = "position" then
                    curPos = msg.GetData()

                else if msg.GetField() = "state" then
                    curState = msg.GetData()

                    if(curState = "playing") then
                        if m.top.PauseBoolean = true
                            video_time = video.position
                            ? "video resumed"
                            m.top.PauseBoolean = false
                        end if
                    end if
                    if(curState = "paused" or curState = "stopped") then
                        m.top.PauseBoolean = true
                        video_time = video.position
                        ? "video paused"
                        m.top.GloBoolean = false
                    end if
                    if curState = "stopped" then
                        m.top.PauseBoolean = true
                        m.top.GloBoolean = false
                        if adPods = invalid or adPods.count() = 0 then
                            exit while
                        end if

                        adPods = invalid
                        if isPlayingPostroll then
                            exit while
                        end if
                    else if curState = "finished" then
                        video_time = video.position
                        ? "video finished"
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
