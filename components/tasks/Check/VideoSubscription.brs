sub init()
  m.videoSubs = false
  m.top.functionName = "start"
  print "init VideoSubscription"  
End sub

function runVideoSubscription(param as String)
    print "RUN VideoSubscription"
    m.top.control = "RUN"
end function

function stopVideoSubscription(param as String)
    print "STOP VideoSubscription"
    m.top.control = "STOP"
end function

sub start()
    m.videoSubs = false
    userSubIDS = getUserSubscriptionsContent()
    videoSubIDS = getVideoSubscriptionsContent()
    m.top.userSubIDS=userSubIDS
    m.top.videoSubIDS=videoSubIDS
 ?"kuioko"   
            for i=0 to videoSubIDS.Count()
                for j=0 to userSubIDS.Count()
                    if userSubIDS[i] = videoSubIDS[j] then
                       m.videoSubs = true
                    end if
                end for 
            end for 
    m.top.videoSubs = m.videoSubs
end sub

function getUserSubscriptionsContent()
 params = {}
 params.AddReplace("country_code", getCountrycode()) 
 params.AddReplace("device_id", "roku") 
 params.AddReplace("uid",getUserIdana()) 
 params.AddReplace("pubid",getPubID()) 
    subIDS = []
    for each jsonitem in GetUserSubscriptions(params)
        subIDS.Push(Str(jsonitem.sub_id))  
    end for
    return subIDS

End function

function getVideoSubscriptionsContent()
 params = {}
 params.AddReplace("country_code", getCountrycode()) 
 params.AddReplace("device_id", "roku") 
 params.AddReplace("uid",getUserIdana().Trim()) 
 params.AddReplace("pubid",getPubID()) 
 params.AddReplace("video_id",Str(m.top.videoID).Trim()) 
 print m.top.videoID
    subIDS = []
    for each jsonitem in GetVideoSubscriptions(params)
        subIDS.Push(Str(jsonitem.subscription_id))  
    end for
    return subIDS

End function
