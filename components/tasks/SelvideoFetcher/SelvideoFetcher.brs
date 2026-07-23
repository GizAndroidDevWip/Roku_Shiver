sub init()

  m.port = createObject("roMessagePort")
  m.top.observeField("SelectRequest", m.Sport)
  m.top.functionName = "start"
  print "RUN SelvideoFetcher"
 m.top.control = "RUN"
End sub



sub start()
  while true
    msg = wait(0, m.port)
    mt = type(msg)        
            if mt="roSGNodeEvent" and msg.getField()="SelectRequest" then
          getSelectedVideoContent()
    end if 
  end while
end sub



function getSelectedVideoContent()
 params = {}
 params.AddReplace("country_code", getCountrycode()) 
 params.AddReplace("device_id", "roku") 
 params.AddReplace("uid", getUserIdana()) 
 params.AddReplace("pubid",getPubID()) 
    subIDS = []
'    video_index = 0
    for each jsonitem in GetSelectedVodContent(params)
        item={}
           item.TITLESEASON = "" 
           item.user_id = "1"
           item.video_id = jsonitem.video_id
           item.premium_flag = jsonitem.premium_flag
           item.ad_link = jsonitem.ad_link
           item.channel_id = jsonitem.channel_id
           item.video_duration = jsonitem.video_duration
           item.year=jsonitem.year
           item.parental_control=jsonitem.parental_control
           item.resolution=jsonitem.resolution
           item.trailer=jsonitem.trailer
           item.producer=josnitem.producer
           item.URL = jsonitem.video_name
           item.STREAMFORMAT = "m3u8"
           item.TITLE = jsonitem.video_title
           item.RELEASEDATE = ""
           item.DESCRIPTION = jsonitem.video_description
           item.HDPOSTERURL= jsonitem.thumbnail
           item.HDBACKGROUNDIMAGEURL = jsonitem.thumbnail
           videos.push(item)
        print jsonitem
    end for
   
       m.top.SelContent= ParseSelVod(subIDS)
End function
