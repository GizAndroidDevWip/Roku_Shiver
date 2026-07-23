
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    m.count = 0
    m.AdTimer = m.top.findNode("AdTimer")
    m.Video = m.top.findNode("Video")
    m.RowList = m.top.findNode("RowList")
    m.BottomBar = m.top.findNode("BottomBar")
    m.ShowBar = m.top.findNode("ShowBar")
    m.live = m.top.findNode("live")
    m.next = m.top.findNode("next")
    m.title = m.top.findNode("title")
    m.HideBar = m.top.findNode("HideBar")
    m.Hint = m.top.findNode("Hint")

   
        m.Hint.text= getText("press_up_down_for_live_tv_guide")
    
 


    m.playing = m.top.findNode("playing")
    m.Timer = m.top.findNode("Timer")
    m.scheduleTimer = m.top.findNode("scheduleTimer")

    m.Hint.font.size = "20"
    showHint()
    m.live.visible = false
    m.next.visible = false
    m.title.visible = true
    m.AdTimer.control = "start"

    m.RowList.setFocus(true)
    m.RowList.rowLabelFont.size = "24"
    m.Timer.observeField("fire", "hideHint")
    m.AdTimer.observeField("fire", "change")
    m.scheduleTimer.observeField("fire", "OnscheduleTimer")

    m.RowList.observeField("rowItemSelected", "ChannelChange")
end sub

sub onStarted()
    if m.count = 0
        m.count = 1
        m.LoadTask = createObject("roSGNode", "ScheduleFetcher")
        m.LoadTask.linear_channel_id = m.top.linear_channel_id
        m.LoadTask.ScheduleRequest = "run"
        m.LoadTask.callFunc("runScheduleFetcherTask", "")
        m.LoadTask.observeField("content", "onContentChanged")
        ?"onStarted if  called inn LiveTV"
    end if
end sub

sub onContentChanged()
    ?"onContentChanged called  : live tv"
    if m.LoadTask.content <> invalid and m.LoadTask.content.count() <> invalid and m.LoadTask.content.getchildcount() = 1
        m.BottomBar.visible = false
        m.Video.setFocus(true)
    end if

    videoContent = {
        title: m.top.video_title,
        url: m.top.liveUrl,
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        ' length: VODcontent.video_duration
    }



    m.RowList.content = m.LoadTask.content
    m.RowList.observeField("rowItemFocused", "ChannelFocus")

    if m.RowList.content <> invalid and m.RowList.content.getChild(0) <> invalid and m.RowList.content.getChild(0).getChild(0) <> invalid
        m.Video.content = m.RowList.content.getChild(0).getChild(0)
    end if

    content = CreateObject("roSGNode", "VideoContent")
    content.addFields({
        "is_live": 1
    })
    content.setFields(videoContent)
    m.video.content = content
    print m.Video
    m.PlayerTaskLive = CreateObject("roSGNode", "PlayerTaskLive")
    m.PlayerTaskLive.observeField("state", "taskStateChanged")
    m.PlayerTaskLive.enableLiveAvailabilityWindow = true
    m.PlayerTaskLive.videos = m.Video
    ?"PlayerTaskLive"
    m.PlayerTaskLive.videoTitle = m.top.video_title
    m.PlayerTaskLive.control = "RUN"
    m.LoadTask.callFunc("stopScheduleFetcherTask", "")
    m.scheduleTimer.control = "start" ' starting timer for calling  live and live guide api every minute

    ' m.Video.content = m.RowList.content.getChild(0).getChild(0)
    ' print "m.Videom.Videom.Video"
    ' content = CreateObject("roSGNode", "VideoContent")
    ' content.addFields({
    '     "is_live":1
    ' })
    ' content.setFields(videoContent)
    ' m.video.content = content
    ' print m.Video
    ' m.PlayerTaskLive = CreateObject("roSGNode", "PlayerTaskLive")
    ' m.PlayerTaskLive.observeField("state", "taskStateChanged")
    ' m.PlayerTaskLive.enableLiveAvailabilityWindow  = true
    ' m.PlayerTaskLive.videos = m.Video
    ' m.PlayerTaskLive.videoTitle = m.top.video_title
    ' m.PlayerTaskLive.control = "RUN"

    ' m.LoadTask.callFunc("stopScheduleFetcherTask", "")

    ' m.scheduleTimer.control = "start"   ' starting timer for calling  live and live guide api every minute
end sub



sub taskStateChanged(event as object)
    print "PlayerLive : taskStateChanged(), id = "; event.getNode(); ", "; event.getField(); " = "; event.getData()
    state = event.GetData()
    if state = "done" or state = "stop"
        exitPlayer()
    end if
end sub

sub OnscheduleTimer() 'calling schedule and live api every 1 minute


    if m.LoadTask <> invalid
        m.LoadTask.callFunc("stopScheduleFetcherTask", "")
    end if

    m.LoadTask = createObject("roSGNode", "ScheduleFetcher")
    m.LoadTask.ScheduleRequest = "run"
    m.LoadTask.callFunc("runScheduleFetcherTask", "")
    m.LoadTask.observeField("content", "onScheduleFetcherCalled")

end sub

sub onScheduleFetcherCalled() 'liveguide:  setting video title and refreshing liveguide rowlist every 1 minute
    m.playing.text = "Now Playing: " + chr(10) + m.LoadTask.video_title
    m.RowList.content = m.LoadTask.content

    ?"m.playing.text and liveguide rowlist updated"
    ?m.playing.text

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

sub channelfocus()
    timecontent = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    m.playing.text = "Now Playing: " + chr(10) + m.top.video_title
    print "timecontent"
    print timecontent
    if(timecontent <> invalid)
        starttime = timecontent.ShortDescriptionLine2
        endtime = timecontent.description
        starttimes = Mid (starttime, 1, 19)
        endtimes = Mid (endtime, 1, 19)
        title = timecontent.TITLE
        dtstart = timeConvertstart (starttimes)
        dtend = timeConvertend(endtimes)
        logo = timecontent.HDPOSTERURL
        ' logo=  "https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/"+timecontent.thumbnail
        ?"kjkkk"




    end if
end sub

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


function timeConvertstart(estString as string) as object
    ' An roDateTime by default gives current time in UTC
    dt = CreateObject ("roDateTime")
    ' Set the time from the EST string input
    dt.FromISO8601String (estString)
    dt.ToLocalTime ()
    chour = dt.GetHours()
    cminute = dt.GetMinutes()
    if chour = 0
        chour = 12
        ampm = "AM"
    else
        if chour = 12
            chour = 12
            ampm = "PM"
        else
            if chour > 12
                chour = chour - 12
                ampm = "PM"
            else
                if chour < 12
                    chour = chour
                    ampm = "AM"
                end if
            end if
        end if
    end if
    if dt.getMinutes() < 10
        cminute = "0" + str(dt.getMinutes()).Trim()
    else
        cminute = str(dt.getMinutes()).Trim()
    end if
    ctime = str(chour) + ":" + cminute + " " + ampm
    ' Return the local time representation of the EST input
    return ctime
end function

function timeConvertend(estString as string) as object
    ' An roDateTime by default gives current time in UTC
    dt = CreateObject ("roDateTime")
    ' Set the time from the EST string input
    dt.FromISO8601String (estString)
    ' Convert to local time
    dt.ToLocalTime ()
    ' Return the local time representation of the EST input
    chour = dt.GetHours()
    cminute = dt.GetMinutes()
    if chour = 0
        chour = 12
        ampm = "AM"
    else
        if chour = 12
            chour = 12
            ampm = "PM"
        else
            if chour > 12
                chour = chour - 12
                ampm = "PM"
            else
                if chour < 12
                    chour = chour
                    ampm = "AM"
                end if
            end if
        end if
    end if
    if dt.getMinutes() < 10
        cminute = "0" + str(dt.getMinutes()).Trim()
    else
        cminute = str(dt.getMinutes()).Trim()
    end if
    ctime = str(chour) + ":" + cminute + " " + ampm
    ' Return the local time representation of the EST input
    return ctime
end function


sub change()
    m.global.Adtracker = 0
end sub


sub hideHint()
    m.Hint.visible = false
    m.playing.visible = false
end sub

sub showHint()
    m.Hint.visible = true
    m.playing.visible = true
    m.Timer.control = "start"
end sub

sub optionsMenu()
    if m.global.Options = 0
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("livecount")
            tok = sec.Read("livecount")
            if(tok.ToInt() < 1)
                m.BottomBar.visible = false
                m.Video.setFocus(true)
                m.live.visible = false
                m.next.visible = false
                m.title.visible = false
            else
                m.ShowBar.control = "start"
                m.live.visible = true
                m.next.visible = true
                m.title.visible = true
                m.RowList.setFocus(true)
                hideHint()
            end if
        end if

    else
        sec = CreateObject("roRegistrySection", getAppKey())
        if sec.Exists("livecount")
            tok = sec.Read("livecount")
            if(tok.ToInt() < 1)
                m.BottomBar.visible = false
                m.Video.setFocus(true)
                m.live.visible = false
                m.next.visible = false
                m.title.visible = false
            else
                m.HideBar.control = "start"
                m.live.visible = false
                m.next.visible = false
                m.title.visible = true
                m.Video.setFocus(true)
                showHint()
            end if
        end if
    end if
end sub

' function getUserIdana() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("USER_ID")
'         tok = sec.Read("USER_ID")
'         return tok
'     end if
'     return invalid
' end function

' function getChannelid() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("channelID")
'         tok = sec.Read("channelID")
'         return tok
'     end if
'     return invalid
' end function

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "back"
            m.count = 0
            m.video.control = "stop"
            m.scheduleTimer.control = "stop"

            'these lines are added to avoid a bug : when live tv was just starting, pressing back closes live TV, but player plays in the background
            m.top.liveUrl = ""
            onContentChanged()
            ' m.top.LoginFinish = "finished"
        end if
        if key = "up" or key = "down"
            if m.global.Options = 0
                m.global.Options = 1
                optionsMenu()
            else if key = "back"
                m.video.control = "stop"
                m.video.visible = false
                m.top.visibility = false
            else
                m.global.Options = 0
                optionsMenu()
            end if
            handled = true
        end if
    end if
    return handled
end function


sub rowListContentChanged()
    m.RowList.content = m.LoadTask.content
    if m.count = 0
        m.Video.content = m.RowList.content.getChild(0).getChild(0)
        m.Video.control = "play"
        m.count = 1
    end if
end sub

