sub init()
    m.top.functionName = "start"
    print "init MyList"
end sub

function runMyListTask(param as string)
    print "RUN MyList"
    m.top.control = "RUN"
end function

function stopMyListTask(param as string)
    print "STOP MyList"
    m.top.control = "STOP"
end function


sub start()
    m.top.MyListTaskContent = ParseContent2(GetMyListTaskContent())
end sub

function GetMyListTaskContent()

    list = []
    row = {}
    row.Title = ""
    row.ContentList = []

    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("pubid", getPubID())
    videos = []
    video_index = 0
    for each jsonitem in GetMyListTaskVideos(params)
        item = {}
        item.titleSeason = jsonitem.video_title
        item.categories = jsonitem.category_name
        item.user_id = jsonitem.show_id
        item.show_id = jsonitem.show_id
        item.itemType = "SHOW"
        item.single_video = jsonitem.single_video
        item.video_id = jsonitem.video_id
        item.video_url = jsonitem.video_name
        item.ad_link = jsonitem.ad_link
        item.channel_id = jsonitem.channel_id
        item.video_duration = ""
        item.is_free_video = jsonitem.is_free_video
        item.is_locked=jsonitem.is_locked
        item.url = jsonitem.video_name
        item.streamFormat = "m3u8"
        item.title = jsonitem.show_name
        item.ReleaseDate = ""
        item.resolution = jsonitem.synopsis
        item.HDPosterURL = jsonitem.logo_thumb
        item.hdBackgroundImageUrl = jsonitem.logo
        item.rental_flag = jsonitem.rental_flag
        item.payper_flag = jsonitem.payper_flag
        videos.push(item)
    end for
    row.ContentList = videos

    if videos.count() = 0
        m.top.MyListTaskBoolean = true
    else
        m.top.MyListTaskBoolean = false

    end if

    list.Push(row)

    return list
end function

