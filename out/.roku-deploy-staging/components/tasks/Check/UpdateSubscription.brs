sub init()
  m.videoSubs = false
  m.top.functionName = "start"
  print "init UpdateSubscription"
end sub

function runUpdateSubscriptionTask(param as string)
  print "RUN UpdateSubscription"
  m.top.control = "RUN"
end function

function stopUpdateSubscriptionTask(param as string)
  print "STOP UpdateSubscription"
  m.top.control = "STOP"
end function

sub start()
  purchaseID()
end sub


function purchaseID()
  print "receiptidis00"
  port = CreateObject("roMessagePort")
  channelStore = CreateObject("roChannelStore")
  channelStore.SetMessagePort(port)
  channelStore.GetPurchases()
  while true
    msg = wait(0, port)
    ?msg
    ?"msg12345print"
    if (type(msg) = "roChannelStoreEvent")
      print "***** success:****** "
      ?msg.isRequestSucceeded()
      ?"msgisRequestSucceeded()3434"

      ?msg.GetResponse()
      ?"msg.GetResponse()e3434"


      if (msg.isRequestSucceeded())
        for each item in msg.GetResponse()

          ?item
          ?"item6777787878"
          ?item.code 
          ?"itemcode4348"
          if item.code = m.top.keyword then
            m.top.purchaseid = item.purchaseId
        ?m.top.purchaseid
        ?"hhm.top.purchaseid"

            ?item.purchaseId
            ?"item3purchaseId"
            print "receiptidis"
            print m.top.purchaseid
            updateVideoSubscriptionsContent()
            exit while
          end if
        end for
      end if
      exit while
    else if (msg.isRequestFailed())
      ?msg.isRequestFailed()
      ?"msg.isRequestFailedsddd"
      print "***** Failure: "
      updateVideoSubscriptionsContentFailure()
    end if
  end while
end function

function updateVideoSubscriptionsContent()
  ses = CreateObject("roRegistrySection", getAppKey())
  if ses.Exists("countrycode")
    stok = ses.Read("countrycode")
  end if
  post = {
    mode_of_payment: "roku-in-app",
    transaction_type: "1",
    subscription_id: m.top.subid,
    receiptid: m.top.purchaseid,
    product_id: m.top.keyword,
    status: "success",
    ' device_type: "Roku",
    ' uid: getUserIdana(),
    amount: m.top.amount,
    ' pubid: getPubID(),
    ' country_code: stok
  }
  ?post
  ?"post1234"
  m.top.response = updateSubscriptionTransaction(post)
?m.top.response 
?"m.top.responsewqwqwe"


end function

function updateVideoSubscriptionsContentFailure()
  ses = CreateObject("roRegistrySection", getAppKey())
  if ses.Exists("countrycode")
    stok = ses.Read("countrycode")
  end if
  post = {
    mode_of_payment: "roku-in-app",
    transaction_type: "1",
    subscription_id: m.top.subid,
    receiptid: "",
    product_id: m.top.keyword,
    status: "failed",
    ' device_type: "Roku",
    ' uid:getUserIdana(),
    amount: m.top.amount
    ' pubid: getPubID(),
    ' country_code: stok
  }
  ?post
  ?"post1233"
  updateSubscriptionTransaction(post)
end function



' function getUIDS() as object
'   sec = CreateObject("roRegistrySection", getAppKey())
'   if sec.Exists("USER_ID")
'     tok = sec.Read("USER_ID")
'     return tok
'   end if
'   return invalid
' end function

' function getPubIDS() as object
'   sec = CreateObject("roRegistrySection", getAppKey())
'   if sec.Exists("PubID")
'     tok = sec.Read("PubID")
'     return "50030"
'   end if
'   return "50030"
' end function
