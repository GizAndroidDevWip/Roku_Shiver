sub init()
    m.top.functionName = "start"
    m.count = 0
    print "init ScheduleFetcher"
end sub

function runScheduleFetcherTask(param as string)
    print "RUN ScheduleFetcher"
    m.top.control = "RUN"
end function

function stopScheduleFetcherTask(param as string)
    print "STOP ScheduleFetcher"
    m.top.control = "STOP"
end function

sub start()
    GetScheduledetails()
end sub

sub GetScheduledetails()
    ' ?"GetScheduledetails called"

    params1 = {}
    params1.AddReplace("fastchannelid", getFastChannelId())
    'live api is calling each minute
    responseData = GetNowPlayingLiveData(params1)

    if responseData[0] <> invalid and responseData[0].now_playing <> invalid and responseData[0].now_playing.video_title <> invalid and responseData[0].now_playing.thumbnail <> invalid
        m.top.video_title = responseData[0].now_playing.video_title
        m.top.video_thumbnail = responseData[0].now_playing.thumbnail
    else
        m.top.video_title  = ""
        m.top.video_thumbnail = ""
    end if

    
        guide = getText("guide")
   


    array = getSelectedLive()
    m.count = 0
    oneRow = GetApiArray(array)
    list = [
        {
            Title: guide
            ContentList: oneRow
        }
    ]
    m.top.content = ParseXMLContent2(list)
end sub

function ParseXMLContent2(list as object)
    ' ?"ParseXMLContent2 called"
    RowItems = createObject("RoSGNode", "ContentNode")
    
        guide = getText("guide")
    

    RowItems.Title = guide
    for each rowAA in list
        row = createObject("RoSGNode", "ContentNode")
        row.Title = rowAA.Title
        for each itemAA in rowAA.ContentList
            item = createObject("RoSGNode", "ContentNode")
            item.SetFields(itemAA)
            ?itemAA
            ?"itemAAerer"
            row.appendChild(item)
            ?item
            ?"itemeeeee"
        end for
        RowItems.appendChild(row)
        ?row
       
        ?"rowdsssssss"
    end for
    ?"pl"
    return RowItems
end function

function GetApiArray(array as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("liveurl")
        tok = sec.Read("liveurl")
    end if
    dim result[2]
    for each element in array
        item = {}
        item.Title = element.Title
        item.STREAMFORMAT = "m3u8"
        ' item.HDPosterUrl = element.logo
        item.HDPosterUrl = element.hdposterurl
        item.ShortDescriptionLine2 = element.starttime
        item.id = element.id
        
        item.description = element.endtime
        item.TitleSeason = "Currently Playing.."
        ' item.Url = tok
        result.push(item)
        ?"jkkk"
    end for
    return result
end function

function getSelectedLive()
    if m.count = 0
        m.count = 1
        params = {}
        ' channelID = m.top.linear_channel_id

        params.AddReplace("channelid", getchannelsid())
        params.AddReplace("linear_channel_id", m.top.linear_channel_id)


        subIDS = []
        respp = GetLive(params)
        ?"respp"
        ?respp
        if(respp = invalid )
        ' if(respp = invalid or respp[0] = invalid)
            sec = CreateObject("roRegistrySection", getAppKey())
            if sec.Exists("livecount")
                tok = sec.Read("livecount")
                if(tok.ToInt() < 1)
                    item = {}
                    item.Title = "Live Channel"
                    item.starttime = "no time"
                    item.endtime = "no time"
                    item.STREAMFORMAT = "m3u8"
                    item.Logo = ""
                    subIDS.push(item)
                end if
            end if
        end if
        for each jsonitem in GetLive(params)
            item = {}
            sec = CreateObject("roRegistrySection", getAppKey())
            if sec.Exists("livecount")
                tok = sec.Read("livecount")
                if(tok.ToInt() < 1)
                    item.Title = "Live Channel"
                    item.starttime = "no time"
                    item.endtime = "no time"
                    item.STREAMFORMAT = "m3u8"
                    item.Logo = ""
                    subIDS.push(item)
                else
                    item.Title = jsonitem.video_title
                    item.starttime = jsonitem.starttime
                    item.endtime = jsonitem.endtime
                    item.STREAMFORMAT = "m3u8"
                    item.id=jsonitem.id
                    if jsonitem.thumbnail_350_200 <> invalid
                        ' item.Logo = jsonitem.thumbnail
                       logourl =jsonitem.thumbnail_350_200

                        ' if jsonitem.thumbnail_350_200
                            if InStr(1,logourl, "https://") > 0 then

                                item.HDPOSTERURL=jsonitem.thumbnail_350_200
                            else
                                item.HDPOSTERURL="https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/"+jsonitem.thumbnail_350_200
                        end if
                        ' jsonitem.thumbnail_350_200="https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/1698073942660.jpg"
                        ' item.HDPOSTERURL= jsonitem.thumbnail_350_200
                    else
                        item.Logo = ""
                    end if

                    subIDS.push(item)
                    ?"hhj"
                end if
            end if
        end for
        return subIDS
    end if
end function

