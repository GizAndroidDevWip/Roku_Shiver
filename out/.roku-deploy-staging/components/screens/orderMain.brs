function Init()
    m.onceGuestRegisterCalled = 0
    ' //////////PubId
    m.pubIdTask = CreateObject("roSGNode", "PubIdTask")
    m.PubIdTask.callFunc("runPubIdTask", "")
    m.pubIdTask.observeField("PubIdResponse", "OnIpInfoResponse")
    '////////Country Details
    m.ipInfoTask = CreateObject("roSGNode","IpInfoTask")
    m.ipInfoTask.callFunc("runIpInfoTask","")
    m.ipInfoTask.observeField("IpInfoResponse","OnIpInfoResponse")
    sec = CreateObject("roRegistrysection",getAppKey())
    sec.Write("publish","Template")
    sec.Flush()
    ' //////////Guest Register
    m.GuestFetcher = CreateObject("roSGNode","GuestFetcher")
    m.GuestFetcher.observeField("GuestResponse","OnGuestResponse")
    m.LaunchCheck = CreateObject("roSGNode","LaunchCheck")
    m.LaunchCheck.observeField("LaunchResponse","onLaunchResponse")

    m.top.dialogAuthExceed = CreateObject("roSGNode", "BackDialog")
    m.top.dialogAuthExceed.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogAuthExceed.title = "You are no longer Logged in this device. Please Login again to access."
    m.top.dialogAuthExceed.buttons = ["Press OK to Login Again"]
    m.top.dialogAuthExceed.ObserveField("buttonSelected", "On_dialogAuthExceed_buttonSelected")

    m.LogoutTaskAll = CreateObject("roSGNode", "LogoutTaskAll")
    m.LogoutTaskAll.observeField("LogoutResponse", "OnLogoutResponse")
    m.LogoutTaskAll.callFunc("runLogoutTask", "")
    
end function

function getBundleID() as object
    return m.global.BUNDLE_ID
end function

function getAppKey() as object
    return m.global.APP_KEY
end function