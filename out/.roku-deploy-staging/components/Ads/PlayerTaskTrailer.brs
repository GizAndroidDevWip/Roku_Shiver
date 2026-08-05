Library "Roku_Ads.brs"

sub init()
    m.Timer = m.top.findNode("Timer")
    m.Timer.control = "start"
    m.Timer.observeField("fire", "change")
    m.top.functionName = "playContentWithAds"
    m.top.id = "PlayerTaskTrailer"
    m.count = 0
end sub

sub playContentWithAds()
    if(m.count = 0)
        m.count = 1
        video = m.top.video
        view = video.getParent()
        content = video.content
        keepPlaying = true
        port = CreateObject("roMessagePort")
        if keepPlaying then
            video.AddHeader("token", getToken(m.top.video.content.video_time))


            video.observeField("position", port)
            ?port

            video.observeField("state", port)
            ?port
            video.visible = true
            video.control = "play"

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
                else if msg.GetField() = "state" then
                    curState = msg.GetData()
                    ?curState
                    if(curState = "playing") then
                    end if
                    if(curState = "paused") then
                    end if
                    print "PlayerTask: state = "; curState
                    if curState = "stopped" then
                        exit while
                    else if curState = "finished" then

                    else if curState = "error" then
                        ?"playertrailer error"

                        ?msg.getInfo()
                        ?msg.getNode()
                        ?video.errorMsg
                        ?video.errorStr

                        exit while
                    end if
                end if
            end if
        end while
    end if
    m.count = 0
end sub


function getToken(urlParams = {} as object) as object
    if urlParams <> invalid and urlParams <> "" then
        data = {}

        url = getBaseApiURL() + "playlistV2/generateToken" + "?id=" + urlParams.Trim()
        ?url

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

    ?m.token


end function




function getAuthTokenAPI()
    urlTfer = CreateObject("roUrlTransfer")
    urlTfer.SetUrl("https://poppo.tv/proxy/authenticate?uid=2")
    urlTfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    urlTfer.setPort(m.port)
    Xrsp = urlTfer.GetToString()
    Xresp = ParseJSON(Xrsp)
    authToken = Xresp.token
    return authToken
end function


function getvideoId() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("videoID")
        tok = sec.Read("videoID")
        return tok
    end if
    return invalid
end function

function getvideoTitle() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("videoTITLE")
        tok = sec.Read("videoTITLE")
        return tok
    end if
    return invalid
end function


function getcategory() as object

    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("category")
        sess = ses.Read("category")
        return sess
    end if
end function




