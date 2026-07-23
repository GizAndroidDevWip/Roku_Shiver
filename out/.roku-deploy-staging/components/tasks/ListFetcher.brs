sub Init()
    m.top.functionName = "start"
    print "init ListFetcher"
End sub

function runListFetcher(param as String)
    print "RUN ListFetcher"
    m.top.control = "RUN"
end function

function stopListFetcher(param as String)
    m.top.control = "STOP"
end function

sub start()
    getUserSubscriptionsContent()
end sub


function getUserSubscriptionsContent() as Boolean 
    params = {}
    params.AddReplace("country_code", getCountrycode()) 
    params.AddReplace("device_id", "roku") 
    params.AddReplace("uid", getUserIdana()) 
    params.AddReplace("pubid",getPubID()) 
    subIDS = []
    video_index = 0
    for each jsonitem in GetUserSubscriptions(params)
        item={}
        print "details"
        print jsonitem
        item.mode_of_payment = jsonitem.mode_of_payment
        item.price = jsonitem.price 
        item.sub_id = jsonitem.sub_id
        item.subscription_name = jsonitem.subscription_name
        item.subscription_type_id = jsonitem.subscription_type_id
        item.subscription_type_name = jsonitem.subscription_type_name
        item.valid_from = jsonitem.valid_from 
        item.valid_to=jsonitem.valid_to
        subIDS.push(item)
        print jsonitem
    end for
   
    if(subIDS.count()= 0) then
        m.top.SubBoolean=false
    else
        m.top.SubBoolean=true
    end if
    m.top.UserSubContent= ParseUserSub(subIDS)
    return true
End function

