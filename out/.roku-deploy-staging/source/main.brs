

function Main(args)
    screen = CreateObject("roSGScreen")
    m.scene = screen.CreateScene("MainScene")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    m.global = screen.getGlobalNode()
    setAppIDs()
    screen.Show()
    if true = CreateObject("roAppInfo").IsDev() then m.vscode_rdb_odc_node = createObject("roSGNode", "RTA_OnDeviceComponent") ' RDB OnDeviceComponent
    m.scene.signalBeacon("AppDialogInitiate")
    m.scene.signalBeacon("AppLaunchComplete")
    SetTheme()
    SetupAnalytics()
    m.loadingIndicator = m.scene.findNode("loadingIndicator")
    m.scene.observeField("SearchStringText", port)
    m.scene.observeField("appExit", port)
    m.Player = m.scene.findNode("Player")
    deeplink = getDeepLinkParams(args)
    ? "args= "; formatjson(args)
    ' deeplink = getDeepLinks(args)
    ? "deeplink= "; deeplink
    m.global.addField("deeplink", "assocarray", false)
    m.global.deeplink = deeplink

    inputObject = createobject("roInput")
    inputObject.setmessageport(port)

    m.global.addField("language_keywords", "assocarray", false)
    m.global.addField("langauge_id", "integer", false)
    m.global.addField("short_code", "string", false)
    while(true)
        msg = wait(0, port)
        print(type(msg))
        msgType = type(msg)
        if msgType = "roSGNodeEvent" and msg.getField() = "SearchStringText" then
            m.loadingIndicator.control = "start"
            SearchQuery(m.scene.SearchStringText)
            m.loadingIndicator.control = "stop"
            ' else if msg.getField() = "SelContentz"
        else if msgType = "roInputEvent"
            ' info = msg.getInfo()

            inputData = msg.getInfo()
            if inputData.DoesExist("mediaType") and inputData.DoesExist("contentId") ' deeplinking case - if app is already opened (input case)
                deeplink = {
                    id: inputData.contentID
                    type: inputData.mediaType
                }
                setIsFromDeepLinking(deeplink.id.toStr())
                m.global.deeplink = deeplink
                m.scene.launch_show_screen = deeplink.id.ToStr()
            end if



        else if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then
                '            print "terminate"
                '                   m.uid1=getUIDana()
                '                  EventTerminate(m.uid1,"POP07","","","","")
                return true
            else if msgType = "roSGNodeEvent" then
                field = msg.getField()
                if field = "appExit" then
                    print "exit"
                    return true
                end if
            end if
        end if
        if msgType = "roSGNodeEvent" then
            field = msg.getField()
            if field = "appExit" then
                exit while
            end if
        end if

        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then
                print "terminate"
                '                   m.uid1=getUIDana()
                '  EventTerminate(m.uid1,"POP07","","","","")
                exit while
            end if
        end if
    end while
    if screen <> invalid then
        screen.Close()
        screen = invalid
    end if
end function
function getSelectedVideoContent(video_id as string)


    params = {}
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("device_id", "roku")
    params.AddReplace("vid", video_id)
    params.AddReplace("pubid", getPubID())
    subIDS = []
    '    video_index = 0
    'getAuthTokenAPIPlayerdeep()
    for each jsonitem in GetSelectedVodContentDeep(params)
        item = {}
        item.TITLESEASON = ""
        item.user_id = "1"
        item.video_id = jsonitem.video_id
        item.premium_flag = jsonitem.premium_flag
        item.video_duration = jsonitem.video_duration
        item.ad_link = ""
        item.channel_id = getchannelsid()
        item.cate = jsonitem.category_name
        item.URL = jsonitem.video_name
        item.STREAMFORMAT = "m3u8"
        item.TITLE = jsonitem.video_title
        item.RELEASEDATE = ""
        item.DESCRIPTION = jsonitem.video_description
        item.HDPOSTERURL = jsonitem.thumbnail
        item.HDBACKGROUNDIMAGEURL = jsonitem.thumbnail
        subIDS.push(item)
        print "inside loop"
    end for
    print "**outside the loop**"
    print item
    if item <> invalid then
        print m.scene
        print item
        m.scene.deepLinkContent = item
        print m.scene.deepLinkContent
        '     m.scene.deepLinkContent=item
        print "***if item is not invalid**"
        '     print m.scene.deepLinkContent
    end if
end function

sub onselectContent()
end sub


sub SearchQuery(SearchString as string)
    m.scene.searchContent = ParseContent2(GetSearchContent(SearchString))
end sub

sub SetupAnalytics()
    m.global.addField("RSG_analytics", "node", false)
    m.global.RSG_analytics = CreateObject("roSGNode", "Roku_Analytics:AnalyticsNode")
    m.global.RSG_analytics.debug = true
    m.global.RSG_analytics.init = {

        'set data to IQ analytics
        Google: {
            trackingID: "UA-139565658-2"
            defaultParams: {
                an: "RokuAnalyticsClient"
            }
        }
    }
end sub




function getDeepLinks(args) as object
    deeplink = invalid
    if args.contentid <> invalid and args.mediaType <> invalid
        deeplink = {
            id: args.contentId
            type: args.mediaType
        }
    end if
    print "*****deeplink*******"
    if deeplink <> invalid then
        print deeplink.id
        video_id = deeplink.id
        print "**fetcher video**"
        getSelectedVideoContent(video_id)
    end if
    return deeplink
end function

function playVideo(content as string)
    print content
    print "****************video started..*************************888"
    '    m.FadeIn.control = "start"
    VODcontent = item
    print VODcontent
    di = CreateObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    ? macroHeight
    ? macroWidth
    macroDNT = "true"
    if di.IsRIDADisabled()
        macroDNT = "false"
    end if
    macroIP = di.GetExternalIp()
    version = di.GetVersion()
    version_major = mid(version, 3, 1)
    version_minor = mid(version, 5, 2)
    version_build = mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = mid(version_minor, 2)
    end if
    macroUserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    macroADID = di.GetRIDA()
    macroDevModel = di.GetModel()
    macroUUID = di.GetChannelClientId()
    macroCountry = di.GetUserCountryCode()
    macroLang = di.GetCurrentLocale()
    macroRegion = di.GetCurrentLocale()
    ? "********************"
    ? VODcontent
    ? "********************"
    videoContent = {
        streamFormat: "m3u8",
        '        titleSeason: VODcontent.titleSeason,
        title: VODcontent.title,
        url: VODcontent.url,
        '        categories: VODcontent.categories
        nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
        nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
        nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
        length: VODcontent.video_duration
    }
    content = CreateObject("roSGNode", "VideoContent")
    content.setFields(videoContent)
    content.ad_url = finalAdURL
    if m.Player = invalid:
        m.Player = m.top.CreateChild("Player")
        m.Player.observeField("state", "PlayerStateChanged")
        m.Player.observeField("visible", "onVideoVisibleChange")
    end if

    m.Player.content = content
    m.Player.visible = true
    m.Player.setFocus(true)
    m.Player.control = "play"
    m.Player.observeField("visibility", "onVisibleChange")

end function

function getDeepLinkParams(args) as object
    deeplink = invalid
    if args.contentid <> invalid and args.mediaType <> invalid
        deeplink = {
            contentId: args.contentId
            mediaType: args.mediaType
        }
        if deeplink <> invalid and deeplink["contentId"] <> invalid and deeplink["mediaType"] <> invalid then
            m.global.DEEPLINK_PARAMS = deeplink
        end if
    end if
    return deeplink
end function

function SetTheme()
    m.global.addField("Model", "int", true)
    m.global.addField("Options", "int", true)
    m.global.addField("menu", "int", true)
    m.global.addField("adTracker", "int", true)
    m.global.addField("background_color", "string", false)
    m.global.addField("primary_text_color", "string", false)
    m.global.addField("secondary_text_color", "string", false)
    m.global.addField("loader_uri", "string", false)
    m.global.addField("focus_grid_uri", "string", false)
    m.global.addField("overlay_uri", "string", false)
    m.global.addField("button_focus_uri", "string", false)
    m.global.addField("DEEPLINK_SHOWID", "string", true)
    m.global.addField("MENU_FOR_ISLAND", "string", true)
    m.global.addField("MENU_FOR_SMART_HOME_PAGES", "string", true)
    m.global.addField("DEEPLINK_PARAMS", "assocarray", true)
    m.global.addField("SMART_HOME_PAGES", "array", true)
    m.global.addField("Live_player", "node", true)
    stringsData = getStrings()
    m.global.addFields({ appStrings: stringsData })

    m.global.adTracker = 0
    m.global.Options = 2
    m.global.menu = 2
    m.global.Model = 0

    dev = createObject("roDeviceInfo")
    model = (Left(dev.GetModel(), 1)).toInt()
    if model < 4
        m.global.Model = 1
    end if

    m.global.background_color = "#1f2120"
    m.global.primary_text_color = "#f5f5f5"
    m.global.secondary_text_color = "#a8a8a8"
    m.global.loader_uri = "pkg:/components/screens/LoadingIndicator/lightLoader.png"
    m.global.focus_grid_uri = "pkg:/images/focus_grid.9.png"
    m.global.overlay_uri = "pkg:/images/grey.png"
    m.global.button_focus_uri = "pkg:/images/button-focus-custom.png"
end function

function setAppIDs()
    m.global.addField("BUNDLE_ID", "string", false)
    m.global.addField("APP_KEY", "string", false)

    ' m.global.BUNDLE_ID = "com.caribcast.roku"
    ' m.global.APP_KEY = "caribcastroku"

    ' m.global.BUNDLE_ID = "com.tvei.roku"
    ' m.global.APP_KEY = "tveiroku"

    ' m.global.BUNDLE_ID = "com.justwatchme.roku"
    ' m.global.APP_KEY = "justwatchmeroku"

    ' m.global.BUNDLE_ID ="com.pipultv.roku"
    ' m.global.APP_KEY="pipultvroku"

    ' m.global.BUNDLE_ID ="com.cinemavault.roku"
    ' m.global.APP_KEY="cinemavaultroku"

    ' m.global.BUNDLE_ID = "com.newvibetv.roku"
    ' m.global.APP_KEY= "newvibetvroku"

    ' m.global.BUNDLE_ID = "com.foundtv.roku"
    ' m.global.APP_KEY= "foundtvroku"

    ' m.global.BUNDLE_ID ="com.solwintv.roku"
    ' m.global.APP_KEY="solwinroku"

    ' m.global.BUNDLE_ID ="com.laughafterdark.roku"
    ' m.global.APP_KEY="laughafterdarkroku"

    ' m.global.BUNDLE_ID = "com.docplus.roku"
    ' m.global.APP_KEY = "docplusroku"

    ' m.global.BUNDLE_ID ="com.mood.roku"
    ' m.global.APP_KEY="moodroku"

    ' m.global.BUNDLE_ID ="com.surfroots.roku"
    ' m.global.APP_KEY="surfrootsroku"

    ' m.global.BUNDLE_ID = "com.mycaribbeanchannels.roku"
    ' m.global.APP_KEY = "mycaribbeanchannelsroku"

    ' m.global.BUNDLE_ID = "com.fwfg.roku"
    ' m.global.APP_KEY = "fwfgroku"

    ' m.global.BUNDLE_ID ="com.diyatv.roku"
    ' m.global.APP_KEY="diyatvroku"

    ' m.global.BUNDLE_ID ="com.kalingotv.roku"
    ' m.global.APP_KEY="kalingotvroku"

    ' m.global.BUNDLE_ID ="com.spttv.roku"
    ' m.global.APP_KEY="spttvvroku"

    ' m.global.BUNDLE_ID ="com.thelaxxnetwork.roku"
    ' m.global.APP_KEY="thelaxxnetworkroku"

    ' m.global.BUNDLE_ID ="com.4biddenknowledge.roku"
    ' m.global.APP_KEY="4biddenknowledgeroku"

    ' m.global.BUNDLE_ID ="reelteve.roku.com"
    ' m.global.APP_KEY="reelteveroku"

      m.global.BUNDLE_ID = "com.shiver.roku"
       m.global.APP_KEY = "shiverroku"


    '    m.global.BUNDLE_ID ="com.powertube.roku"
    '   m.global.APP_KEY="powertuberoku"


    '    m.global.BUNDLE_ID ="com.powertube.roku"
    '   m.global.APP_KEY="powertuberoku"

    '   m.global.BUNDLE_ID = "com.fls.roku"
    ' m.global.APP_KEY = "flsroku"

    ' m.global.BUNDLE_ID = "com.uptowntv.roku"
    ' m.global.APP_KEY = "uptowntvroku"

    ' m.global.BUNDLE_ID = "com.forneyextremetv.roku"
    ' m.global.APP_KEY = "forneyextremetvroku"

    ' m.global.BUNDLE_ID = "com.retroson.roku"
    ' m.global.APP_KEY = "retrosonroku"

    ' m.global.BUNDLE_ID = "com.usweedchannel.roku"
    ' m.global.APP_KEY = "usweedchannelroku"

    ' m.global.BUNDLE_ID = "com.ceyflix.rokkutest"
    ' m.global.APP_KEY = "ceyflixrokku"

    ' m.global.BUNDLE_ID = "com.dupond.roku"
    ' m.global.APP_KEY = "dupondroku"

    ' m.global.BUNDLE_ID = "com.caribcast.roku"
    ' m.global.APP_KEY = "caribcastroku"

    ' m.global.BUNDLE_ID = "com.onstageplus.roku"
    ' m.global.APP_KEY = "onstageplusroku"

    ' m.global.BUNDLE_ID = "com.redeemtv.roku"
    ' m.global.APP_KEY = "redeemtvroku"

    ' m.global.BUNDLE_ID ="com.sparktv.roku"
    ' m.global.APP_KEY="sparktvroku"

    ' m.global.BUNDLE_ID ="com.poppotv.roku"
    ' m.global.APP_KEY="rokupoppotv"

    ' m.global.BUNDLE_ID = "com.4biddenknowledge.roku"
    ' m.global.APP_KEY = "4biddenknowledgeroku"

    ' m.global.BUNDLE_ID = "com.godtvkids.roku"
    ' m.global.APP_KEY = "godtvkidsroku"

    ' m.global.BUNDLE_ID = "com.studiodome.roku"
    ' m.global.APP_KEY = "studiodomeroku"

    ' m.global.BUNDLE_ID ="com.nextlevelsoul.roku"
    ' m.global.APP_KEY="nextlevelsoulroku"
end function


