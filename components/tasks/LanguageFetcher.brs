sub Init()
 m.top.functionName = "start"
  print "init LanguageFetcher"  
End sub

function runLanguageFetcherTask(param as String)
    print "RUN LanguageFetcher"
    m.top.control = "RUN"
end function

function stopLanguageFetcherTask(param as String)
    print "STOP LanguageFetcher"
    m.top.control = "STOP"
end function

sub start()
    getlanguageContent()
end sub


function getlanguageContent()
 params = {}
 params.AddReplace("country_code", getCountrycode()) 
 params.AddReplace("device_id", "roku") 
 params.AddReplace("uid", getUserIdana()) 
 params.AddReplace("pubid",getPubID()) 
    subIDS = []
    video_index = 0
    for each jsonitem in GetLanguages(params)
        item={}
           item.audio_language_id = jsonitem.audio_language_id
           item.audio_language_name = jsonitem.audio_language_name
           subIDS.push(item)
        print jsonitem
    end for
       m.top.UserSubContent1= ParseUserLang(subIDS)
End function

