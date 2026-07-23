sub init()
  m.top.functionName = "start"
End sub

function runAutoplay(param as String)
    print "RUN Autoplay"
    m.top.control = "RUN"
end function

function stopAutoplay(param as String)
    print "STOP Autoplay"
    m.top.control = "STOP"
end function

sub start()

       respose = GetAutoplayDetails(m.top.video_id)
         if respose <> invalid
            videoResponse = GetVideoDetails(Str(respose.video_id).trim())
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("Autolog","valid")
                sec.Write("AutovideoID", Str(videoResponse.video_id).trim())
                sec.Write("AutovideoTITLE", videoResponse.video_title.Trim())
                sec.Write("AutovideoUrl", videoResponse.video_name.Trim())
                sec.Write("AutovideoDuration", videoResponse.video_duration.Trim())
                ' sec.Write("premium_flag", videoResponse.premium_flag.Trim())
                ' sec.Write("rental_flag", videoResponse.rental_flag.Trim())
                ' sec.Write("free_video", videoResponse.free_video.Trim())
        catename=videoResponse.category_name
          cat=catename    
    if cat <> invalid then
       category=""
       arrayLength=cat.count()
       lastItem=cat[arrayLength-1]
      for each item in cat
          if(arrayLength<2) 
               category=category+item     
          else
              if(item = lastItem)
                    category=category+item
              else
                    category=category+item+","
              end if
          end if
       end for
          catloc=category
           sec = CreateObject("roRegistrySection", getAppKey())
           sec.Write("autocategory", catloc)
           sec.Flush()
    end if      
    cateid=videoResponse.category_id
          catid=cateid   
    if catid <> invalid then
       categoryid=""
       arrayLength=catid.count()
       lastItem=catid[arrayLength-1]
      for each item in catid
          if(arrayLength<2) 
               categoryid=categoryid+Str(item).Trim()     
          else
              if(item = lastItem)
                    categoryid=categoryid+Str(item).trim()
              else
                    categoryid=categoryid+Str(item).trim()+","
              end if
          end if
       end for
          catlocid=categoryid
           sec = CreateObject("roRegistrySection", getAppKey())
           sec.Write("Autocategoryid", catlocid)
           sec.Flush()
    end if
    
    subtitle=respose.subtitles    
     if subtitle.count()>0
           subArray=[]
           for each subJson in subtitle
                  subItem={}
                  subItem.Language=subJson.code
                  subItem.Description=subJson.language_name
                  subItem.TrackName=subJson.subtitle_url
                  subArray.push(subItem)
               end for
               sec.Write("Autosubtitle",formatjson(subArray))
               else
               sec.Write("Autosubtitle","invalid")
           end if
    sec.Write("Autoshowid",Str(videoResponse.show_id).Trim())
    sec.Write("Autoadlink",videoResponse.ad_link.Trim())
    sec.Write("Autochannelid",Str(videoResponse.channel_id).Trim())
    sec.Write("Autovideothumb",videoResponse.thumbnail.Trim())
                sec.Flush()
           else
           sec = CreateObject("roRegistrySection", getAppKey())
           sec.Write("Autolog","notvalid")
           sec.Flush()
          m.top.AutoResponse ="invalid"
       end if
end sub

