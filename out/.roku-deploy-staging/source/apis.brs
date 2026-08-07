

function GetSearchVideos(urlParams = {} as object) as object
    key = urlParams.key.replace(" ", "%20")
    data = {}
    url = getBaseApiURL2() + "search/shows?key=" + key.Trim()
    response = makeRequest(url, urlParams)


    if response <> invalid
        data = response.data
    end if
    return data
end function

function calSearchApiNew(urlParams = {} as object) as object
    data = {}
    if getCustomFiltersRequired() = "true"
        requestBody = {}
        if urlParams.DoesExist("key") and urlParams.key <> ""
            requestBody.key = urlParams.key.Escape()
        end if
        if urlParams.DoesExist("filters") and urlParams.filters <> invalid and urlParams.filters.Count() > 0
            requestBody.filters = urlParams.filters
        end if

        url = getBaseApiURL2() + "show/search"
        response = MakePostRequest(url, requestBody)
        if response <> invalid
            data = response.data
        end if
    else
        key = urlParams.key
        url = getBaseApiURL2() + "show/search?key=" + key.Escape()
        response = makeRequest(url, key)
        if response <> invalid
            data = response.data
        end if
    end if
    return data
end function


' ' ...existing code...
function GetSearchVideoss(urlParams = {} as object) as object
    data = {}
    ' if getCustomFiltersRequired() = "false"
    requestBody = {}
    if urlParams.DoesExist("key") and urlParams.key <> ""
        requestBody.key = urlParams.key
    end if
    if urlParams.DoesExist("filters") and urlParams.filters <> invalid and urlParams.filters.Count() > 0
        requestBody.filters = urlParams.filters
    end if

    url = getBaseApiURL2() + "show/search"
    response = MakePostRequest(url, requestBody)
    if response <> invalid
        data = response.data
    end if

    return data
end function

function getSearchAPiForTagsAndCast(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL2() + "show/search?key=" + urlParams.key
    response = makeRequest(url, urlParams)

    if response <> invalid
        data = response.data
    end if
    return data
end function

function callShowMoreApi(urlParams = {} as object) as object
    data = {}
    if getCustomFiltersRequired() = "true"
        requestBody = {}
        if urlParams.DoesExist("key") and urlParams.key <> ""
            requestBody.key = urlParams.key
        end if
        if urlParams.DoesExist("filters") and urlParams.filters <> invalid and urlParams.filters.Count() > 0
            requestBody.filters = urlParams.filters
        end if

        url = getBaseApiURL2() + "show/search"
        response = MakePostRequest(url, requestBody)
        if response <> invalid
            data = response.data
        end if
    else
        key = urlParams.key
        url = getBaseApiURL2() + "show/search?key=" + key
        response = makeRequest(url, key)
        if response <> invalid
            data = response.data
        end if
    end if
    return data
end function


function GetSearchFiltersApi(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "search/filters"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function


function GetMyListTaskVideos(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL2() + "show/watchlist"
    response = makeRequest(url, urlParams)

    if response <> invalid
        data = response.data
    end if
    return data
end function



function GetChannels(urlParams = {} as object) as object
    data = {}
    url = "https://poppo.tv/platform/bk/api/Getallchannels"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if

    return data
end function

function callCancelSubscriptionApi(subscriptionId, subId = "" as string)
    url = getBaseApiURL() + "subscription/cancel"
    post = { "user_subscription_id": subscriptionId }
    if subId <> "" then post["sub_id"] = subId
    return MakePostRequest(url, post)
end function

function callGetCodeApi(urlParams = {} as object)
    data = {}
    url = getBaseApiURL() + "device/code/generate"
    response = MakePostRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    ' ?"callGetCodeApi called"
    ' ?data
    return data
end function


function callAccountRequest(user_email = {} as object)
    data = {}
    url = getBaseApiURL() + "account/request/send"

    post = {
        email: user_email.Trim(),
    }

    response = MakePostRequest(url, post)
    if response <> invalid
        data = response.data
    end if
    return data

end function


function callAccountCheckApi(id)
    data = {}

    url = getBaseApiURL() + "account/request/check?id=" + id.ToStr()
    response = isLoggedInGetRequest(url)
    if response <> invalid
        data = response
    end if
    return data
end function




function callCheckLoggedInApi(code as string)
    data = {}
    url = getBaseApiURL() + "device/isLinked?code=" + code.Trim()
    response = isLoggedInGetRequest(url)
    if response <> invalid
        data = response
    end if
    return data
end function


function callCalendarVideosApi(daterange as object)
    data = {}
    url = getBaseApiURL() + "calendar/list?start_date=" + daterange.dayStart + "&end_date=" + daterange.dayEnd
    response = MakeGetRequest(url)
    if response <> invalid
        data = response
    end if
    return data
end function



function makeRequest(src as string, params as object, extraHeaders = invalid as object) as object
    request = CreateObject("roUrlTransfer")
    request.RetainBodyOnError(true)
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)

    di = CreateObject("roDeviceInfo")
    deviceid = di.GetChannelClientId()
    url = src


    if url.InStr(0, "https") = 0
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if

        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
        access_token = getAuthorisationToken()

        ?""
        ?"##############################################################################"
        ?""
        ? "[API CALL]: "; url
        if params <> invalid then ? "[PARAMS]: "; FormatJson(params)
        ?""
        ' Consolidate headers for efficiency and easy printing
        headers = {
            "access-token": access_token,
            "pubid": getPubID(),
            "channelid": getchannelsid(),
            "uid": getUserIdana(),
            "country_code": getCountrycode(),
            "device_type": "Roku",
            "dev_id": deviceid,
            "ip": getIp(),
            "ua": userAgent,
            "X-Roku-Reserved-Dev-Id": ""
        }
        if extraHeaders <> invalid
            for each key in extraHeaders
                headers[key] = extraHeaders[key]
            end for
        end if

        ? "--- Request Headers ---"
        for each key in headers
            request.AddHeader(key, headers[key])
            ? key; ": "; headers[key]
        end for
        ? "-----------------------"

        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        request.InitClientCertificates()
    end if

    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                ? "[API RESPONSE CODE]: "; code
                if code = 200
                    responseBody = msg.GetString()
                    response = ParseJson(responseBody)
                    ' ? "[RESPONSE DATA]: "; responseBody
                    ? "[URL]: "; url
                    ?"##############################################################################"
                    ?"                                                                              "
                    return response
                else
                    ? "[ERROR]: Request failed"
                    ? "[URL]: "; url
                    ?"##############################################################################"
                    ?""
                    return invalid
                end if
                exit while
            else if msg = invalid
                request.AsyncCancel()
                exit while
            end if
        end while
    end if

    return invalid
end function

' function makeRequest(src as string, params as object) as object

'     ? "api calling: makeRequest"
'     ? src
'     ? "params:"
'     ? params
'     request = CreateObject("roUrlTransfer")
'     request.RetainBodyOnError(true)
'     port = CreateObject("roMessagePort")
'     request.setMessagePort(port)
'     di = CreateObject("roDeviceInfo")
'     appInfo = CreateObject("roAppInfo")
'     deviceid = di.GetChannelClientId()
'     url = src
'     ' url = AppendParamsToUrl(src, params)
'     if url.InStr(0, "https") = 0
'         di = CreateObject("roDeviceInfo")
'         version = di.GetVersion()
'         version_major = Mid(version, 3, 1)
'         version_minor = Mid(version, 5, 2)
'         version_build = Mid(version, 8, 5)

'         if version_minor.toint() < 10 then
'             version_minor = Mid(version_minor, 2)
'         end if
'         userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
'         request.AddHeader("access-token", getAuthorisationToken())
'         ?getAuthorisationToken() + "getAuthorisationToken()"
'         request.AddHeader("pubid", getPubID())
'         ? getPubID()
'         ?" getPubID()"
'         request.AddHeader("channelid", getchannelsid())
'         ?getchannelsid()
'         ?"getchannelsid()"
'         request.AddHeader("uid", getUserIdana())
'         ?getUserIdana()
'         ?"getUserIdana()"
'         request.AddHeader("country_code", getCountrycode())
'         ?getCountrycode()
'         ?"getCountrycode()"
'         request.AddHeader("device_type", "Roku")
'         request.AddHeader("dev_id", deviceid)
'         ?deviceid
'         ?"deviceid"
'         request.AddHeader("ip", getIp())
'         ?getIp()
'         ?"getIp()"
'         request.AddHeader("ua", userAgent)
'         request.SetCertificatesFile("common:/certs/ca-bundle.crt")
'         request.AddHeader("X-Roku-Reserved-Dev-Id", "")
'         request.InitClientCertificates()

'     end if
'     headerstr = "/" + getAuthorisationToken() + "/" + getPubID() + "/" + getchannelsid() + "/" + getUserIdana().Trim() + "/" + getCountrycode() + "/" + deviceid + "/" + getIp() + "/" + userAgent + "/"


'     request.SetUrl(url)
'     if request.AsyncGetToString()
'         while true
'             msg = Wait(0, port)
'             if Type(msg) = "roUrlEvent"
'                 code = msg.GetResponseCode()
'                 response = ParseJson(msg.GetString())

'                 ?"api response: makeRequest"
'                 ? response

'                 if code = 200
'                     response = ParseJson(msg.GetString())
'                     ?response
'                     ?"responsesdsdeer"
'                     return response
'                 else
'                     return invalid
'                 end if
'                 exit while
'             else if event = invalid
'                 request.AsyncCancel()
'             end if
'         end while
'     end if
'     return invalid
' end function



function updateRating(post as object) as object
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    di = CreateObject("roDeviceInfo")
    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)

    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    http.SetPort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.AddHeader("access-token", getAuthorisationToken())
    http.AddHeader("pubid", getPubID())
    http.AddHeader("channelid", getchannelsid())
    http.AddHeader("uid", getUserIdana())
    http.AddHeader("country_code", getCountrycode())
    http.AddHeader("device_type", "Roku")
    http.AddHeader("dev_id", deviceid)
    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)
    http.InitClientCertificates()
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("Accept", "application/json")
    http.SetUrl(getBaseApiURL() + "user/rating")
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        event = Wait(10000, http.GetPort())
        if Type(event) = "roUrlEvent" then
            response = event.getString()
            responseheaders = event.GetResponseHeaders()
            lastresponsecode = event.GetResponseCode()
            lastresponsefailurereason = event.GetFailureReason()
        else if event = invalid then
            http.asynccancel()
            lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
            lastresponsecode = 0
        else
        end if
    end if
    resp = ParseJson(response)
    if resp.success = true
        data = "success"
        return data
    else
        return invalid
    end if
end function

function MakeRequestDeep(src as string, paramfs as object) as object
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    url = AppendParamsToUrl(src, params)
    ? url
    if url.InStr(0, "https") = 0
        request.AddHeader("access-token", getAuthTokenAPIPlayerDeep())
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if

    return invalid
end function

function playlistaddremove(wflag as string, showid as string, uid as string)
    params = {}
    ' data = {}
    ' di = CreateObject("roDeviceInfo")
    ' appInfo = CreateObject("roAppInfo")
    ' deviceids = di.GetChannelClientId()
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("userIDOtp")
        tok = sec.Read("userIDOtp")
    end if
    params.AddReplace("watchlistflag", wflag)
    params.AddReplace("show_id", showid)
    params.AddReplace("uid", uid)
    params.AddReplace("pubid", getPubID())
    url = getBaseApiURL() + "watchlist/show/" + showid.Trim() + "/" + wflag.Trim()
    response = makeRequest(url, params)
    if response <> invalid
        if response.message = "show added to watchlist"
            return "added"
        else
            return "removed"
        end if
    end if
end function

function MakeRequestNoAuth(src as string, params as object) as object
    ? "api calling: MakeRequestNoAuth"
    ? src
    ? "params: "
    ? params
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()

    url = AppendParamsToUrl(src, params)
    ' ? "url called in MakeRequestNoAuth:"
    ' ? url
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        if getPubID() <> invalid and getchannelsid() <> invalid
            request.AddHeader("pubid", getPubID())
            '    request.AddHeader("uid",params.uid)
            request.AddHeader("channelid", getchannelsid())
            request.AddHeader("country_code", getCountrycode())
            request.AddHeader("device_type", "Roku")
            request.AddHeader("dev_id", deviceid)
            request.AddHeader("ip", getIp())
            request.AddHeader("ua", userAgent)
        end if
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200 or code = 201
                    response = ParseJson(msg.GetString())
                    ?"api response: MakeRequestNoAuth"
                    ?"status: " ; code
                    ?"source: "; src
                    ?"response: " ; response
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

function MakeRequestNoAuthForPubId(src as string, params as object) as object
    ? "api calling: MakeRequestNoAuth"
    ? src
    ? "params: "
    ? params
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()

    url = AppendParamsToUrl(src, params)
    ' ? "url called in MakeRequestNoAuth:"
    ' ? url
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    ?"api response: MakeRequestNoAuthForPubId"
                    ?src
                    ?response
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

function setIsUserSubscribed(usub as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("IsUserSubscribed", usub)
    sec.Flush()
end function


function getIsUserSubscribed() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("IsUserSubscribed")
        usb = ses.Read("IsUserSubscribed")
        return usb
    else
        return "false"
    end if
end function

function GetAppSubscription(urlParams = {} as object) as object
    data = {}
    url = "https://api.gizmott.com/api/v1/subscription/active?type=list"
    response = makeRequest(url, urlParams)
    ?"6ui"
    if response <> invalid
        data = response.data
    end if
    ?"APPSUNSBCRIPTION"
    ?urlParams.video_id
    return data
end function



function MakeRequestNoAuthForIpInfo(src as string, params as object) as object
    ?"api calling: MakeRequestNoAuthForIpInfo"
    ? src
    ? "params: "
    ? params
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()

    url = AppendParamsToUrl(src, params)
    ' ? "url called in MakeRequestNoAuth:"
    ' ? url
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        ' if getPubID() <> invalid and getchannelsid() <> invalid
        '     request.AddHeader("pubid", getPubID())
        '     '    request.AddHeader("uid",params.uid)
        '     request.AddHeader("channelid", getchannelsid())
        '     request.AddHeader("device_type", "Roku")
        '     request.AddHeader("dev_id", deviceid)
        '     request.AddHeader("ip", getIp())
        '     request.AddHeader("ua", userAgent)
        ' end if
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    ?"api response: MakeRequestNoAuthForIpInfo"
                    ?src
                    ?response
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

function MakeRequestNoAuthToken(src as string, params as object) as object
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()

    url = AppendParamsToUrl(src, params)
    ? "api calling: MakeRequestNoAuthToken:"
    ? url
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        if getPubID() <> invalid and getchannelsid() <> invalid
            request.AddHeader("pubid", getPubID())
            if invalid <> params.uid
                request.AddHeader("uid", params.uid)
            end if
            request.AddHeader("channelid", getchannelsid())
            request.AddHeader("country_code", getCountrycode())
            request.AddHeader("device_type", "Roku")
            request.AddHeader("dev_id", deviceid)
            request.AddHeader("ip", getIp())
            request.AddHeader("ua", userAgent)
        end if
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    ?"api response: MakeRequestNoAuthToken"
                    ?src
                    ?response
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

' function MakeGetRequest(src as string) as object
'     ?"MakeGetRequest calling : ";src
'     httprequest = CreateObject("roUrlTransfer")
'     httprequest.RetainBodyOnError(true)
'     port = CreateObject("roMessagePort")
'     httprequest.setMessagePort(port)
'     httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
'     httprequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
'     httprequest.InitClientCertificates()

'     port = CreateObject("roMessagePort")
'     httprequest.setMessagePort(port)
'     di = CreateObject("roDeviceInfo")
'     appInfo = CreateObject("roAppInfo")
'     deviceid = di.GetChannelClientId()
'     if src.InStr(0, "https") = 0
'         httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
'         di = CreateObject("roDeviceInfo")
'         version = di.GetVersion()
'         version_major = Mid(version, 3, 1)
'         version_minor = Mid(version, 5, 2)
'         version_build = Mid(version, 8, 5)

'         if version_minor.toint() < 10 then
'             version_minor = Mid(version_minor, 2)
'         end if
'         userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

'         if getPubID() <> invalid and getchannelsid() <> invalid
'             httprequest.AddHeader("pubid", getPubID())
'             httprequest.AddHeader("uid", getUserIdana())
'             ' httprequest.AddHeader("channelid", getchannelsid())
'             httprequest.AddHeader("channelid", getchannelsid())
'             httprequest.AddHeader("country_code", getCountrycode())
'             httprequest.AddHeader("access-token", getAuthorisationToken())
'             httprequest.AddHeader("device_type", "Roku")
'             httprequest.AddHeader("dev_id", deviceid)
'             httprequest.AddHeader("ip", getIp())
'             httprequest.AddHeader("ua", userAgent)
'         end if
'         httprequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
'         httprequest.InitClientCertificates()
'     end if
'     ?getAuthorisationToken()
'     ?"jhjhjkgetAuthorisationToken()"
'     url = src


'     ? "url = src GET"
'     ? url
'     ? "url = src"
'     responseData = {}
'     httprequest.SetUrl(url)
'     if httprequest.AsyncGetToString()
'         while true
'             event = Wait(0, port)
'             if (Type(event) = "roUrlEvent")
'                 code = event.GetResponseCode()
'                 response = event.GetString()

'                 responsefailurereason = event.GetFailureReason()
'                 ? "start response"
'                 ? code
'                 ' ? response
'                 ? responsefailurereason
'                 ? "start response"

'                 if code = 200 then
'                     response = ParseJson(event.GetString())
'                     responseData["statusCode"] = code
'                     responseData["data"] = response
'                     ?"response printed : 200 : "
'                     ?response
'                     ?"fgfgfgfg"
'                     return responseData
'                 else if code = 400 then
'                     response = ParseJson(event.GetString())
'                     response.statusCode = code
'                     ? "RUN MakeRequest1"
'                     ? response
'                     ? "RUN MakeRequest1"
'                     return response
'                 else
'                     return invalid
'                 end if

'                 exit while
'             else if event = invalid
'                 httprequest.AsyncCancel()
'             end if
'         end while
'     end if
'     return invalid
'     ?"LKLL"
' end function

function MakeGetRequest(src as string) as object
    httprequest = CreateObject("roUrlTransfer")
    httprequest.RetainBodyOnError(true)
    port = CreateObject("roMessagePort")
    httprequest.setMessagePort(port)

    di = CreateObject("roDeviceInfo")
    deviceid = di.GetChannelClientId()
    url = src

    if url.InStr(0, "https") = 0
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if

        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        ? ""
        ? "##############################################################################"
        ? ""
        ? "[API CALL]: "; url
        ? ""

        headers = {
            "access-token": getAuthorisationToken(),
            "pubid": getPubID(),
            "channelid": getchannelsid(),
            "uid": getUserIdana(),
            "country_code": getCountrycode(),
            "device_type": "Roku",
            "dev_id": deviceid,
            "ip": getIp(),
            "ua": userAgent,
            "X-Roku-Reserved-Dev-Id": ""
        }

        ? "--- Request Headers ---"
        for each key in headers
            value = headers[key]
            if value <> invalid
                httprequest.AddHeader(key, value)
                ? key; ": "; value
            end if
        end for
        ? "-----------------------"

        httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
        httprequest.InitClientCertificates()
    end if

    httprequest.SetUrl(url)

    if httprequest.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                ? "[API RESPONSE CODE]: "; code

                responseBody = msg.GetString()

                if code = 200
                    response = ParseJson(responseBody)
                    ' ? "[RESPONSE DATA]: "; responseBody
                    ? "[URL]: "; url
                    ? "##############################################################################"

                    return {
                        "statusCode": code,
                        "data": response
                    }
                else if code = 400
                    response = ParseJson(responseBody)
                    ? "[ERROR 400]: "; responseBody
                    ? "[URL]: "; url
                    ? "##############################################################################"

                    if response <> invalid then response.statusCode = code
                    return response
                else
                    response = ParseJson(responseBody)
                    ? "[ERROR]: Request failed with code "; code
                    ? "[FAILURE REASON]: "; msg.GetFailureReason()
                    ? "[URL]: "; url
                    ? "##############################################################################"

                    if response <> invalid then response.statusCode = code
                    return response
                end if
                exit while
            else if msg = invalid
                httprequest.AsyncCancel()
                exit while
            end if
        end while
    end if

    return invalid
end function

function MakeGetRequest2(src as string) as object
    ?"MakeGetRequest calling : ";src
    httprequest = CreateObject("roUrlTransfer")
    httprequest.RetainBodyOnError(true)
    port = CreateObject("roMessagePort")
    httprequest.setMessagePort(port)
    httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    httprequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
    httprequest.InitClientCertificates()

    port = CreateObject("roMessagePort")
    httprequest.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    if src.InStr(0, "https") = 0
        httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        ' if getPubID() <> invalid and getchannelsid() <> invalid
        '     httprequest.AddHeader("pubid", getPubID())
        '     httprequest.AddHeader("uid", getUserIdana())
        '     ' httprequest.AddHeader("channelid", getchannelsid())
        '     httprequest.AddHeader("channelid", getchannelsid())
        '     httprequest.AddHeader("country_code", getCountrycode())
        '     httprequest.AddHeader("access-token", getAuthorisationToken())
        '     httprequest.AddHeader("device_type", "Roku")
        '     httprequest.AddHeader("dev_id", deviceid)
        '     httprequest.AddHeader("ip", getIp())
        '     httprequest.AddHeader("ua", userAgent)
        ' end if

        if getPubID() <> invalid and getchannelsid() <> invalid 'testchange
            httprequest.AddHeader("access-token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaGVjayI6dHJ1ZSwicHViaWQiOiI1MDE0OCIsInVpZCI6IjY2MTgxOTQiLCJpYXQiOjE3Nzg2Nzc1NTYsImV4cCI6MTc4NjQ1MzU1Nn0.8cFqSLkNW5P2uVSyV2RbZ1aQbEYJeHA24vgssHvVUgs")
            httprequest.AddHeader("uid", "6618207")
            httprequest.AddHeader("country_code", "IN")
            httprequest.AddHeader("pubid", "50148")
            httprequest.AddHeader("device_type", "ios-phone")
            httprequest.AddHeader("dev_id", "BCB34A2B-EB05-4BE8-BD20-05B08B803AA8")
            httprequest.AddHeader("ip", "103.156.209.197")
            httprequest.AddHeader("channelid", "481")
            httprequest.AddHeader("version", "1.0")
            httprequest.AddHeader("ua", "Mozilla/5.0%20(iPhone;%20CPU%20iPhone%20OS%2018_6_1%20like%20Mac%20OS%20X)%20AppleWebKit/605.1.15%20(KHTML,%20like%20Gecko)%20Mobile/15E148")
        end if
        httprequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
        httprequest.InitClientCertificates()
    end if
    ?getAuthorisationToken()
    ?"jhjhjkgetAuthorisationToken()"
    url = src


    ? "url = src GET"
    ? url
    ? "url = src"
    responseData = {}
    httprequest.SetUrl(url)
    if httprequest.AsyncGetToString()
        while true
            event = Wait(0, port)
            if (Type(event) = "roUrlEvent")
                code = event.GetResponseCode()
                response = event.GetString()

                responsefailurereason = event.GetFailureReason()
                ? "start response"
                ? code
                ' ? response
                ? responsefailurereason
                ? "start response"

                if code = 200 then
                    response = ParseJson(event.GetString())
                    responseData["statusCode"] = code
                    responseData["data"] = response
                    ?"response printed : 200 : "
                    ?response
                    ?"fgfgfgfg"
                    return responseData
                else if code = 400 then
                    response = ParseJson(event.GetString())
                    response.statusCode = code
                    ? "RUN MakeRequest1"
                    ? response
                    ? "RUN MakeRequest1"
                    return response
                else if code = 401 then
                    response = ParseJson(event.GetString())
                    response.statusCode = code
                    ? "RUN MakeRequest1"
                    ? response
                    ? "RUN MakeRequest1"
                    return response
                else if code = 403 then
                    response = ParseJson(event.GetString())
                    response.statusCode = code
                    ? "RUN MakeRequest1"
                    ? response
                    ? "RUN MakeRequest1"
                    return response
                else
                    return invalid
                end if

                exit while
            else if event = invalid
                httprequest.AsyncCancel()
            end if
        end while
    end if
    return invalid
    ?"LKLL"
end function

function MakePostRequest(src as string, post as object) as object
    ?"MakePostRequest calling : ";src
    ?"post99j"
    ?post
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()


    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    http.SetPort(messagePort)
    http.setMessagePort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("pubid", getPubID())

    http.AddHeader("channelid", getchannelsid())
    http.AddHeader("country_code", getCountrycode())

    http.AddHeader("device_type", "Roku")

    http.AddHeader("dev_id", deviceids)

    if invalid <> getUserIdana()
        http.AddHeader("uid", getUserIdana())
        ?getUserIdana() + "?getUserIdana()dsdsd"
    end if

    http.AddHeader("access-token", getAuthorisationToken())
    ?getAuthorisationToken() + "?getAuthorisationToken()145555666666"

    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)

    http.AddHeader("Accept", "application/json")
    http.SetUrl(src)
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            ?"MakePostRequest calling : response: "
            ?response
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()



            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200 or lastresponsecode = 201
                resp = ParseJson(response)
                ?"MakePostRequest calling : response: " ; lastresponsecode
                ?resp
                return resp

            else
                return invalid
            end if
        end if
    end if
end function

function MakePostRequest2(src as string, post as object) as object
    ?"MakePostRequest calling : ";src
    ?"post99j"
    ?post
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()


    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    http.SetPort(messagePort)
    http.setMessagePort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("pubid", getPubID())

    http.AddHeader("channelid", getchannelsid())
    http.AddHeader("country_code", getCountrycode())

    http.AddHeader("device_type", "Roku")

    http.AddHeader("dev_id", deviceids)

    if invalid <> getUserIdana()
        http.AddHeader("uid", getUserIdana())
        ?getUserIdana() + "?getUserIdana()dsdsd"
    end if

    http.AddHeader("access-token", getAuthorisationToken())
    ?getAuthorisationToken() + "?getAuthorisationToken()145555666666"

    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)

    http.AddHeader("Accept", "application/json")
    http.SetUrl(src)
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            ?"MakePostRequest calling : response: "
            ?response
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()



            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?"MakePostRequest calling : response: 200 :"
                ?resp
                return resp

            else
                return response
            end if
        end if
    end if
end function

function MakeGetRequestTest(src as string) as object
    ?"MakeGetRequest calling : ";src
    httprequest = CreateObject("roUrlTransfer")
    httprequest.RetainBodyOnError(true)
    port = CreateObject("roMessagePort")
    httprequest.setMessagePort(port)
    httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    httprequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
    httprequest.InitClientCertificates()

    port = CreateObject("roMessagePort")
    httprequest.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    if src.InStr(0, "https") = 0
        httprequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"

        httprequest.AddHeader("pubid", "50054")
        httprequest.AddHeader("uid", getUserIdana())
        ' httprequest.AddHeader("channelid", getchannelsid())
        httprequest.AddHeader("channelid", "394")
        httprequest.AddHeader("country_code", getCountrycode())
        httprequest.AddHeader("access-token", getAuthorisationToken())
        httprequest.AddHeader("device_type", "Roku")
        httprequest.AddHeader("dev_id", deviceid)
        httprequest.AddHeader("ip", getIp())
        httprequest.AddHeader("ua", userAgent)
        httprequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
        httprequest.InitClientCertificates()
    end if
    url = src


    ? "url = src GET"
    ? url
    ? "url = src"
    responseData = {}
    httprequest.SetUrl(url)
    if httprequest.AsyncGetToString()
        while true
            event = Wait(0, port)
            if (Type(event) = "roUrlEvent")
                code = event.GetResponseCode()
                response = event.GetString()

                responsefailurereason = event.GetFailureReason()
                ? "start response"
                ? code
                ' ? response
                ? responsefailurereason
                ? "start response"

                if code = 200 then
                    response = ParseJson(event.GetString())
                    responseData["statusCode"] = code
                    responseData["data"] = response
                    ?"response printed : 200 : "
                    ?response
                    ?"fgfgfgfg"
                    return responseData
                else if code = 400 then
                    response = ParseJson(event.GetString())
                    response.statusCode = code
                    ? "RUN MakeRequest1"
                    ? response
                    ? "RUN MakeRequest1"
                    return response
                else
                    return invalid
                end if

                exit while
            else if event = invalid
                httprequest.AsyncCancel()
            end if
        end while
    end if
    ?"LKLL"
    return invalid
end function



function MakePostRequestAccount(url, urlParams)


end function



function isLoggedInGetRequest(url)
    try
        params = {}
        data = {}
        di = CreateObject("roDeviceInfo")
        appInfo = CreateObject("roAppInfo")
        deviceids = di.GetChannelClientId()
        request = CreateObject("roUrlTransfer")
        port = CreateObject("roMessagePort")
        request.setMessagePort(port)
        di = CreateObject("roDeviceInfo")
        appInfo = CreateObject("roAppInfo")
        deviceid = di.GetChannelClientId()
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)
        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
        url = AppendParamsToUrl(url, params)
        ?"url: "
        ?url
        ?getUserIdana()
        if url.InStr(0, "https") = 0
            request.SetCertificatesFile("common:/certs/ca-bundle.crt")
            request.AddHeader("pubid", getPubID())
            request.AddHeader("channelid", getchannelsid())
            request.AddHeader("country_code", getCountrycode())
            request.AddHeader("device_type", "Roku")
            request.AddHeader("dev_id", deviceid)
            request.AddHeader("ip", getIp())
            request.AddHeader("ua", userAgent)
            request.AddHeader("uid", getUserIdana())
            request.AddHeader("access-token", getAuthorisationToken())
            request.AddHeader("X-Roku-Reserved-Dev-Id", "")
            request.InitClientCertificates()
        end if
        request.SetUrl(url)
        if request.AsyncGetToString()
            while true
                msg = Wait(0, port)
                if Type(msg) = "roUrlEvent"
                    code = msg.GetResponseCode()
                    if code = 200
                        response = ParseJson(msg.GetString())

                        ? "login response"
                        ? response
                        Registry = CreateObject("roRegistry")
                        RegistrySection = CreateObject("roRegistrySection", getAppKey())
                        RegistrySection.Delete("templateGuest")
                        SetIsGuest("false")

                        SetLogregular()
                        if checkregtrue1() = "true"
                            ? "checkregtrue1() = true"

                            data = response.data
                            user = data[0].user_id
                            ? "data: "
                            ? data
                            responseSub = getUserSubscriptions1(Str(user))



                            if responseSub = "nosub" 'in case of nosub    ,  user data was not saving if nosub value is true, now it is ok
                                data = response.data
                                user = data[0].user_id
                                if data[0] <> invalid and data[0].user_id <> invalid
                                    user = data[0].user_id
                                    SetUID(Str(user))
                                end if
                                if data[0] <> invalid and data[0].first_name <> invalid
                                    username = data[0].first_name
                                    SetUerName(username)
                                end if
                                Setcount()
                                if data[0] <> invalid and data[0].user_email <> invalid
                                    useremail = LCase(data[0].user_email).trim()
                                    setUserEmail(useremail)
                                end if
                                if data[0] <> invalid and data[0].phone <> invalid
                                    phone = data[0].phone
                                    SetUserPhoneNumber(phone)
                                end if
                                ' callAccessTokenAPI()
                                RegistrySection = CreateObject("roRegistrySection", getAppKey())
                                RegistrySection.Delete("templateInstalled")
                                sec = CreateObject("roRegistrySection", getAppKey())
                                if sec.Exists("templateGuest")
                                else
                                    if sec.Exists("templateInstalled")
                                    else
                                        sec = CreateObject("roRegistrySection", getAppKey())
                                        if sec.Exists("templateGuest")
                                        else
                                            sec.Write("templateInstalled", "1")
                                            sec.Flush()
                                            valuedevice = ipInfoAPICall(Str(user).Trim())
                                        end if
                                    end if
                                end if
                                return "nosub"
                            else ' case for invalid, exceed

                                return responseSub
                            end if
                        else
                            data = response.data
                            user = data[0].user_id
                            if data[0] <> invalid and data[0].user_id <> invalid
                                user = data[0].user_id
                                SetUID(Str(user))
                            end if
                            if data[0] <> invalid and data[0].first_name <> invalid
                                username = data[0].first_name
                                SetUerName(username)
                            end if
                            Setcount()
                            if data[0] <> invalid and data[0].user_email <> invalid
                                useremail = LCase(data[0].user_email).trim()
                                setUserEmail(useremail)
                            end if
                            if data[0] <> invalid and data[0].phone <> invalid
                                phone = data[0].phone
                                SetUserPhoneNumber(phone)
                            end if
                            ' callAccessTokenAPI()
                            RegistrySection = CreateObject("roRegistrySection", getAppKey())
                            RegistrySection.Delete("templateInstalled")
                            sec = CreateObject("roRegistrySection", getAppKey())
                            if sec.Exists("templateGuest")
                            else
                                if sec.Exists("templateInstalled")
                                else
                                    sec = CreateObject("roRegistrySection", getAppKey())
                                    if sec.Exists("templateGuest")
                                    else
                                        sec.Write("templateInstalled", "1")
                                        sec.Flush()
                                        valuedevice = ipInfoAPICall(Str(user).Trim())
                                    end if
                                end if
                            end if
                            return 200
                        end if
                    else if code = 201
                        ? "checkregtrue1() = true case:201"
                        response = ParseJson(msg.GetString())
                        data = response.data
                        userid = data[0].user_id
                        sec = CreateObject("roRegistrySection", getAppKey())
                        sec.Write("userIDOtp", Str(userid))
                        sec.Flush()
                        ' ? "data: " + response.data
                        ' ? "message: " + response.message
                        return 201
                    else if code = 400
                        ?"isloggedIngetrequest : 400"
                        return 400
                    else
                        return 400
                    end if
                    exit while
                else if event = invalid
                    request.AsyncCancel()
                end if
            end while
        end if
    catch e
    end try
end function




function AppendParamsToUrl(src as string, params as object) as string
    url = src
    args = params
    request = CreateObject("roUrlTransfer")

    if args <> invalid and args.count() > 0
        for each a in args
            if url.InStr(0, "?") = -1
                separator = "?"
            else
                separator = "&"
            end if
            url = url + separator + request.escape(a.tostr()) + "=" + request.escape(args[a].tostr())
        end for
    end if

    return url
end function

function getAuthorisationToken() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("Token")
        tok = sec.Read("Token")
        return tok
    else
        token = callAccessTokenAPI()
        return token
    end if
end function

function ParseXMLContent(list as object)
    RowItems = CreateObject("RoSGNode", "ContentNode")

    for each rowAA in list
        row = ContentList2Node(rowAA.ContentList)
        row.Title = rowAA.Title
        RowItems.appendChild(row)
    end for

    return RowItems
end function

function ContentList2Node(contentList as object) as object
    result = CreateObject("roSGNode", "ContentNode")

    for each itemAA in contentList
        item = CreateObject("roSGNode", "ContentNode")
        item.SetFields(itemAA)
        result.appendChild(item)
    end for

    return result
end function



function ipInfoAPICall(user_id as string) as object
    ?"dsdsdsss"
    urlParams = {}
    data = {}
    urlanalytics = getBaseApiURL() + "ipinfo"
    response = MakeRequestNoAuthForIpInfo(urlanalytics, urlParams)
    ?" url called: urlanalytics"
    ? urlanalytics
    ? response
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("latitude", Str(response.lat).Trim())
    sec.Write("longitude", Str(response.lon).Trim())
    sec.Write("ippaddress", response.query.Trim())
    sec.Write("countrycode", response.countryCode.Trim())
    sec.Write("country", response.country.Trim())
    sec.Write("city", response.city.Trim())
    sec.Write("region", response.region.Trim())
    sec.Write("isp", response.isp.Trim())
    sec.Write("timezone", response.timezone.Trim())
    sec.Flush()
    deviceAPICallGuestCheck(user_id)
    if response <> invalid
        data = response.data
    end if
    return data
end function

function getcountries() as object
    try
        urlParams = {}
        data = {}
        urlanalytics = getBaseApiURL() + "ipinfo"
        response = MakeRequestNoAuthForIpInfo(urlanalytics, urlParams)
        if response <> invalid
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("latitude", Str(response.lat).Trim())
            sec.Write("longitude", Str(response.lon).Trim())
            sec.Write("ippaddress", response.query.Trim())
            sec.Write("timezone", response.timezone.Trim())
            sec.Write("countrycode", response.countryCode.Trim())
            sec.Write("country", response.country.Trim())
            sec.Write("city", response.city.Trim())
            sec.Write("region", response.region.Trim())
            sec.Write("isp", response.isp.Trim())
            sec.Flush()
            return response.countryCode
        end if
    catch e
        return ""
    end try
end function

function GetUserSubscriptions(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "subscription/user"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if

    return data
end function

function GetUserSubscriptions3(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "subscription/user"
    response = makeRequest(url, urlParams)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function GetLanguages(urlParams = {} as object) as object
    data = {}
    url = "https://poppo.tv/platform/bk/api/GetallLanguagesCeyflix?pubid=" + getPubID().ToStr() + ""
    response = makeRequest(url, urlParams)
    ? response
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetAccountDetails(urlParams = {} as object) as object
    urlParams = {}
    data = {}
    url = getBaseApiURL() + "account/details"
    response = MakeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function


function GetAutoplayDetails(videoID as string, show_id as string)
    urlParams = {}
    data = {}
    url = getBaseApiURL2() + "video/autoplay/" + videoID.Trim()
    if show_id <> invalid and show_id.Trim() <> ""
        url = url + "?show_id=" + show_id.Trim()
    end if
    response = MakeGetRequest(url)
    if response <> invalid
        data = response.data
        return data
    else
        return invalid
    end if
end function

function GetVideoDetails(videoID as string, show_id)
    urlParams = {}
    data = {}
    url = getBaseApiURL2() + "video/details/" + videoID.Trim()
    if show_id <> invalid and show_id.Trim() <> ""
        url = url + "?show_id=" + show_id.Trim()
    end if
    response = MakeRequest(url, urlParams)
    if response <> invalid
        data = response.data
        ?"sdsd"
    end if
    return data
end function

function GetVideoDetails2(videoID as string, show_id)
    urlParams = {}
    data = {}
    ' url = getTestApi() + "video/" + videoID.Trim()
    url = getBaseApiURL2() + "video/details/" + videoID.Trim()
    if show_id <> invalid and show_id.Trim() <> ""
        url = url + "?show_id=" + show_id.Trim()
    end if
    response = makeRequestThatReturnsTheResponseAsItAs(url, urlParams)
    if response <> invalid
        data = response
    else
        data = invalid
    end if
    return data
end function



function GetshortsDetails(shortsId as string)
    ' urlParams = {}
    data = {}
    url = getBaseApiURL2() + "shorts/" + shortsId.Trim()
    response = MakeGetRequest(url)
    if response <> invalid and response.data <> invalid and response.data.data <> invalid
        data = response.data.data
        ?"dd"
    end if
    return data
end function





function callShortsApiTask()
    url = getBaseApiURL2() + "shorts/list" 'getBaseApiURL2() + "home"
    response = MakeGetRequest(url)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function callMicroDramaApiTask(param)
    ' if param.show_id <> invalid then url = getBaseApiURL2() + "verticalShows/list?show_id=" + param.show_id.ToStr() 'getBaseApiURL2() + "home" testchange
    if param.show_id <> invalid then url = getBaseApiURL2() + "verticalShows/" + param.show_id.ToStr()
    ' url = getBaseApiURL2() + "verticalShows/64982"
    response = MakeGetRequest(url)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function updateCoinsUsage(body as object)
    data = {}
    url = getBaseApiURL() + "coins/record-usage"
    response = MakePostRequest(url, body)
    if response <> invalid
        data = response.data
    end if
    ?"updateCoinsUsage called"
    ?data
    return data
end function

function callParentalPinVerifytask(body as object)
    data = {}
    url = getBaseApiURL() + "user/parentalPin/verify"
    response = MakePostRequest2(url, body)
    if response <> invalid
        data = response
    end if
    return data
end function


function GetShowDetails(showID as string)
    urlParams = {}
    data = {}
    url = getBaseApiURL2() + "show/details/" + showID.Trim()
    response = MakeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetVideoSubscriptions(urlParams = {} as object) as object
    data = {}
    ? "urlParams"
    ? urlParams
    url = getBaseApiURL() + "subscription/active?video_id=" + urlParams.video_id.Trim()
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
        ?" GetVideoSubscriptionssssss"
    end if
    ?"m.autoplayVideoId printed222"
    ?urlParams.video_id
    return data
end function

function GetLinearEventSubscriptions(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "subscription/active?event_id=" + urlParams.eventId.Trim()
    if urlParams.IS_LISTING <> invalid and urlParams.IS_LISTING = true
        url = url + "&type=list"
    end if
    response = makeRequest(url, urlParams)
    if response <> invalid and response.data <> invalid
        data = response.data
    end if
    return data
end function

function GetVideoSubscriptions1(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "subscription/active?video_id=" + urlParams.video_id.Trim() + "&type=list"
    if urlParams.isGoadsFreeclicked <> invalid and urlParams.isGoadsFreeclicked = true
        url = url + "&is_go_ad_free=true"
    end if
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetChannelSubscriptions(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "subscription/active?channel_id=" + urlParams.channel_id.Trim()
    'url = getBaseApiURL() + "subscription/channel"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
        ?data
        ?"data4455"
    end if
    return data
end function

function getTimeRgidChannelSubscription(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "subscription/active?channel_id=" + urlParams.channelId.Trim() + "&type=list"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function



function deviceAPICallGuestCheck(user_id as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("templateGuest")
        deviceAPICall(user_id.Trim(), "guestemail", "guestphone", "guestusername")
    else
        phoneNumber = getUserPhoneNumber().ToStr()
        deviceAPICall(user_id.Trim(), getuseremail(), phoneNumber, getUserName())
    end if
end function

' function getuseremailreg() as object
'     ses = CreateObject("roRegistrySection", getAppKey())
'     if ses.Exists("emailReg")
'         sess = ses.Read("emailReg")
'         return sess
'     end if
' end function

' function getnamereg() as object
'     ses = CreateObject("roRegistrySection", getAppKey())
'     if ses.Exists("nameReg")
'         sess = ses.Read("nameReg")
'         return sess
'     end if
' end function

' function getphonereg() as object
'     ses = CreateObject("roRegistrySection", getAppKey())
'     if ses.Exists("phoneReg")
'         sess = ses.Read("phoneReg")
'         return sess
'     end if
' end function

' function getuseridreg() as object
'     ses = CreateObject("roRegistrySection", getAppKey())
'     if ses.Exists("userIDReg")
'         sess = ses.Read("userIDReg")
'         return sess
'     end if
' end function

function deviceAPICall(user_id as string, mail as string, phone as string, uname as string)
    appsid = Applicationid(user_id.trim())
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    model = di.GetModel()
    version = di.GetVersion()
    Appid = di.GetChannelClientId()
    advid = di.GetRIDA()
    channelclientid = di.GetChannelClientId()
    deviceid = di.GetChannelClientId()
    model1 = di.GetModelType()
    country = getCountry()
    appsid = getappId()
    city = getCity()
    ip = getIp()
    lat = getLatitude()
    lon = getLongitude()
    channel_id = getchannelsid()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    UserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    dt = CreateObject ("roDateTime")
    timestampdevice = dt.AsSeconds().ToStr()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sessionidis = sessioniddevice + deviceid
    app = CreateObject("roRegistrySection", getAppKey())
    if app.Exists("appID")
        apps = app.Read("appID")
        return apps
    end if
    sess = getsess()
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    request = CreateObject("roUrlTransfer")
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")
    request.AddHeader("Accept", "application/json")
    ' body = "&channel_id=" + request.Escape(channel_id) + "&session_id=" + request.Escape(sess.ToStr()) + "&timestamp=" + request.Escape(timestampdevice) + "&user_id=" + request.Escape(user_id.trim()) + "&device_id=" + request.Escape(deviceid) + "&latitude=" + request.Escape(lat) + "&longitude=" + request.Escape(lon) + "&country=" + request.Escape(country) + "&city=" + request.Escape(city) + "&ua=" + request.Escape(UserAgent) + "&ip_address=" + request.Escape(ip) + "&advertiser_id=" + request.Escape(advid) + "&app_id=" + request.Escape(appsid) + "&device_type=" + request.Escape("roku") + "&device_make=" + request.Escape("roku") + "&device_model=" + request.Escape(model1) + "&user_name=" + request.Escape(uname) + "&user_email=" + request.Escape(mail) + "&user_contact_number=" + request.Escape(phone) + "&width=" + request.Escape(macroWidth) + "&height=" + request.Escape(macroHeight) + "&publisherid=" + request.Escape(getPubID().trim())
    request.SetUrl("https://analytics.poppo.tv/device")
    messagePort = CreateObject("roMessagePort")
    request.SetPort(messagePort)
    request.setMessagePort(messagePort)
    body = {
        channel_id: request.Escape(channel_id)
        session_id: request.Escape(sess.ToStr())
        timestamp: request.Escape(timestampdevice)
        user_id: request.Escape(user_id.trim())
        device_id: request.Escape(deviceid)
        latitude: request.Escape(lat)
        longitude: request.Escape(lon)
        country: request.Escape(country)
        city: request.Escape(city)
        ua: request.Escape(UserAgent)
        ip_address: request.Escape(ip)
        advertiser_id: request.Escape(advid)
        app_id: request.Escape(appsid)
        device_type: request.Escape("roku")
        device_make: request.Escape(model1)
        user_name: request.Escape(uname)
        user_email: request.Escape(mail)
        user_contact_number: request.Escape(phone)
        width: request.Escape(macroWidth)
        height: request.Escape(macroHeight)
        publisherid: request.Escape(getPubID().trim())
    }

    ? "device body"
    ? body
    postJSON = FormatJson(body)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if request.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?"resp 200"
                ?resp
                return resp
            else
                return invalid
            end if
        end if
    end if
end function

function Event(user_id as string, event_type as string, VIDEO_ID_OR_EVENT_ID as string, video_title as string, channel_id as string, category as string, is_live as string, video_time as integer, ai_type as string)
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)

    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    model = di.GetModel()
    version = di.GetVersion()
    Appid = di.GetChannelClientId()
    advid = di.GetRIDA()
    channelclientid = di.GetChannelClientId()
    deviceid = di.GetChannelClientId()
    model1 = di.GetModelType()
    country = getCountry()
    city = getCity()
    ip = getIp()
    lat = getLatitude()
    lon = getLongitude()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    UserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    dt = CreateObject ("roDateTime")
    timestampdevice = dt.AsSeconds().ToStr()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sess = getsess()
    '  appsid=Applicationid(user_id.trim())
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    deviceid = di.GetChannelClientId()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sessionidis = sessioniddevice + deviceid
    appsid = getappId()
    video_timeString = video_time.ToStr()
    request = CreateObject("roUrlTransfer")
    ' post = "&channel_id=" + request.Escape(channel_id) + "&session_id=" + request.Escape(sess.ToStr()) + "&timestamp=" + request.Escape(timestampdevice) + "&user_id=" + request.Escape(user_id.trim()) + "&device_id=" + request.Escape(deviceid) + returnVideoIDOrEventid(request, is_live, video_id) + "&event_type=" + request.Escape(event_type) + "&video_title=" + request.Escape(video_title) + "&app_id=" + request.Escape(appsid) + "&category=" + request.Escape(category) + "&publisherid=" + request.Escape(getPubID().trim()) + "&is_live=" + request.Escape(is_live.ToStr()) + "&video_time=" + request.Escape(video_timeString)

    if is_live = "0"
        post = {
            channel_id: request.Escape(channel_id),
            session_id: request.Escape(sess.ToStr()),
            timestamp: request.Escape(timestampdevice),
            user_id: request.Escape(user_id.trim()),
            device_id: request.Escape(deviceid),
            video_id: request.Escape(VIDEO_ID_OR_EVENT_ID),
            event_type: request.Escape(event_type),
            video_title: request.Escape(video_title),
            app_id: request.Escape(appsid),
            category: request.Escape(category),
            publisherid: request.Escape(getPubID().trim()),
            is_live: request.Escape(is_live),
            video_time: request.Escape(video_timeString)
        }
        if ai_type <> invalid and ai_type <> "" then
            post.AddReplace("ai_type", request.Escape(ai_type))
        end if
    else if is_live = "1"
        post = {
            channel_id: request.Escape(channel_id),
            session_id: request.Escape(sess.ToStr()),
            timestamp: request.Escape(timestampdevice),
            user_id: request.Escape(user_id.trim()),
            device_id: request.Escape(deviceid),
            event_id: request.Escape(VIDEO_ID_OR_EVENT_ID),
            event_type: request.Escape(event_type),
            video_title: request.Escape(video_title),
            app_id: request.Escape(appsid),
            category: request.Escape(category),
            publisherid: request.Escape(getPubID().trim()),
            is_live: request.Escape(is_live),
            video_time: request.Escape(video_timeString)
        }
    end if


    ?"event body"
    ?post

    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")
    request.AddHeader("Accept", "application/json")
    request.SetUrl("https://analytics.poppo.tv/event")
    response = "https://analytics.poppo.tv/event"
    messagePort = CreateObject("roMessagePort")
    request.SetPort(messagePort)
    request.setMessagePort(messagePort)

    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if request.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?"resp 200"
                ?resp
                return resp
            else
                return invalid
            end if
        end if
    end if

end function



function EventForPOP02(user_id as string, event_type as string, VIDEO_ID_OR_EVENT_ID as string, video_title as string, channel_id as string, category as string, is_live as string, ai_type as string)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    model = di.GetModel()
    version = di.GetVersion()
    Appid = di.GetChannelClientId()
    advid = di.GetRIDA()
    channelclientid = di.GetChannelClientId()
    deviceid = di.GetChannelClientId()
    model1 = di.GetModelType()
    country = getCountry()
    city = getCity()
    ip = getIp()
    lat = getLatitude()
    lon = getLongitude()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    UserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    dt = CreateObject ("roDateTime")
    timestampdevice = dt.AsSeconds().ToStr()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sess = getsess()
    '  appsid=Applicationid(user_id.trim())
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    deviceid = di.GetChannelClientId()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sessionidis = sessioniddevice + deviceid
    appsid = getappId()
    request = CreateObject("roUrlTransfer")
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")
    request.AddHeader("Accept", "application/json")
    request.SetUrl("https://analytics.poppo.tv/event")
    messagePort = CreateObject("roMessagePort")
    request.SetPort(messagePort)
    request.setMessagePort(messagePort)
    if is_live = "0"
        post = {
            channel_id: request.Escape(channel_id),
            session_id: request.Escape(sess.ToStr()),
            timestamp: request.Escape(timestampdevice),
            user_id: request.Escape(user_id.trim()),
            device_id: request.Escape(deviceid),
            video_id: request.Escape(VIDEO_ID_OR_EVENT_ID),
            event_type: request.Escape(event_type),
            video_title: request.Escape(video_title),
            publisherid: request.Escape(getPubID().trim()),
            app_id: request.Escape(appsid),
            category: request.Escape(category),
            is_live: request.Escape(is_live),

        }
        if ai_type <> invalid and ai_type <> "" then
            post.AddReplace("ai_type", request.Escape(ai_type))
        end if
    else if is_live = "1"
        post = {
            channel_id: request.Escape(channel_id),
            session_id: request.Escape(sess.ToStr()),
            timestamp: request.Escape(timestampdevice),
            user_id: request.Escape(user_id.trim()),
            device_id: request.Escape(deviceid),
            event_id: request.Escape(VIDEO_ID_OR_EVENT_ID),
            event_type: request.Escape(event_type),
            publisherid: request.Escape(getPubID().trim()),
            video_title: request.Escape(video_title),
            app_id: request.Escape(appsid),
            category: request.Escape(category),
            is_live: request.Escape(is_live)
        }
    end if

    ?"event body"
    ?post
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if request.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?resp
                return resp
            else
                return invalid
            end if
        end if
    end if
end function


function Eventlaunch(user_id as string, event_type as string)
    appsid = getappId()
    if appsid = invalid
        appsid = ""
    end if
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    model = di.GetModel()
    version = di.GetVersion()
    Appid = di.GetChannelClientId()
    advid = di.GetRIDA()
    channelclientid = di.GetChannelClientId()
    deviceid = di.GetChannelClientId()
    model1 = di.GetModelType()
    country = getCountry()
    city = getCity()
    ip = getIp()
    lat = getLatitude()
    lon = getLongitude()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    UserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    dt = CreateObject ("roDateTime")
    timestampdevice = dt.AsSeconds().ToStr()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    '  appsid=getappId()
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()


    sess = getsess()
    sec = CreateObject("roRegistrySection", getAppKey())
    toks = getchannelsid()
    request = CreateObject("roUrlTransfer")
    ' body = "&channel_id=" + request.Escape(toks) + "&session_id=" + request.Escape(sess) + "&timestamp=" + request.Escape(timestampdevice) + "&user_id=" + request.Escape(user_id.Trim()) + "&device_id=" + request.Escape(deviceid) + "&video_id=" + request.Escape(video_id) + "&event_type=" + request.Escape(event_type) + "&video_title=" + request.Escape(video_title) + "&app_id=" + request.Escape(appsid) + "&publisherid=" + request.Escape(getPubID().trim())
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")
    request.AddHeader("Accept", "application/json")
    request.SetUrl("https://analytics.poppo.tv/event")
    url = "https://analytics.poppo.tv/event"
    messagePort = CreateObject("roMessagePort")

    post = {
        channel_id: request.Escape(getchannelsid()),
        session_id: request.Escape(sess),
        timestamp: request.Escape(timestampdevice),
        user_id: request.Escape(user_id.Trim()),
        device_id: request.Escape(deviceid),
        ' video_id: request.Escape(video_id),
        event_type: request.Escape(event_type),
        ' video_title: request.Escape(video_title),
        app_id: request.Escape(appsid),
        publisherid: request.Escape(getPubID().trim())
    }

    request.SetPort(messagePort)
    request.setMessagePort(messagePort)
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    ?"event body"
    ?post
    if request.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?resp
                ?"responof stopped video"
                return resp
            else
                return invalid
            end if
        end if
    end if
end function

function getUserIdana() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("USER_ID")
        tok = sec.Read("USER_ID")
        return tok
    else
        return ""
    end if
    return invalid
end function


function Applicationid1(user_id as string)
    ?"cddcdcd"
    params = {}
    data = {}
    params.AddReplace("uid", user_id)
    params.AddReplace("app_bundle_id", getBundleID())
    params.AddReplace("app_key", getAppKey())
    url = getBaseApiURL() + "account/authenticate"
    response = MakeRequestNoAuthToken(url, params)
    ?response
    ?"applicationid"
    if response <> invalid
        token = response.token
        if token <> invalid
            SetToken(token)
        end if


        if response.user_coins <> invalid
            if response.user_coins.current_balance <> invalid
                setCurrentCoinBalance(response.user_coins.current_balance.ToStr())
            end if
            if response.user_coins.token_symbol <> invalid
                setTokenSymbol(response.user_coins.token_symbol)
            end if
        end if

        if response.user_language <> invalid and response.user_language.short_code <> invalid
            m.global.short_code = response.user_language.short_code
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("LANGUAGE_CODE_SELECTED", m.global.short_code)
            sec.Flush()
        end if

        if response.language_id <> invalid
            m.global.langauge_id = response.language_id
            language_id = response.language_id
            return language_id
        else
            return invalid

        end if
        ' return data
    else
        return invalid
    end if
end function



function Applicationid(user_id as string)
    ?"cddcdcd"
    params = {}
    data = {}
    params.AddReplace("uid", user_id)
    params.AddReplace("app_bundle_id", getBundleID())
    params.AddReplace("app_key", getAppKey())
    url = getBaseApiURL() + "account/authenticate"
    response = MakeRequestNoAuthToken(url, params)
    ?response
    ?"applicationid"
    if response <> invalid
        token = response.token
        if token <> invalid
            SetToken(token)
        end if
        if response.application_id <> invalid
            data = Str(response.application_id).Trim()
        end if
        m.global.langauge_id = response.language_id

        if response.user_coins <> invalid
            if response.user_coins.current_balance <> invalid
                setCurrentCoinBalance(response.user_coins.current_balance.ToStr())
            end if
            if response.user_coins.token_symbol <> invalid
                setTokenSymbol(response.user_coins.token_symbol)
            end if
        end if

        if response.user_language <> invalid and response.user_language.short_code <> invalid
            m.global.short_code = response.user_language.short_code
            ? response.user_language.short_code
            ?"short_code1234apicall"
            sec = CreateObject("roRegistrySection", getAppKey())


            sec.Write("LANGUAGE_CODE_SELECTED", m.global.short_code)
            ?m.global.short_code
            sec.Flush()
            ?"j"
        end if

        if data <> invalid
            SetappID(data)
        end if
        return data
    else
        return invalid
    end if
end function



function authenticateApiTask()
    params = {
        uid: getUserIdana(),
        app_bundle_id: getBundleID(),
        app_key: getAppKey()
    }
    data = {}
    url = getBaseApiURL() + "account/authenticate"
    response = MakeRequestNoAuthToken(url, params)

    if response <> invalid
        token = response.token

        if token <> invalid
            SetToken(token)
        end if

        if response.application_id <> invalid
            data = Str(response.application_id).Trim()
        end if
        m.global.langauge_id = response.language_id

        if response.user_coins <> invalid
            if response.user_coins.current_balance <> invalid
                setCurrentCoinBalance(response.user_coins.current_balance.ToStr())
            end if
            if response.user_coins.token_symbol <> invalid
                setTokenSymbol(response.user_coins.token_symbol)
            end if
        end if

        if response.user_language <> invalid and response.user_language.short_code <> invalid
            m.global.short_code = response.user_language.short_code
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("LANGUAGE_CODE_SELECTED", m.global.short_code)
            sec.Flush()
        end if

        if response.user_language <> invalid and response.user_language.short_code <> invalid
            response = response.user_language.short_code
        else
            response = "en" ' Default to English if no language code is available
        end if

        return m.global.short_code
    else
        return invalid
    end if

end function



function ParseSubscription(list as object) ' old subscription parsing. this is horizontal rowlist parsing which is no more in use. we are using ParseSubscription2 function which is dynamic and can be used for any type of rowlist parsing by just passing the list and it will create the fields dynamically based on the keys in the list.
    m.data = CreateObject("RoSGNode", "ContentNode")
    m.row = m.data.CreateChild("ContentNode")
    m.row.Title = ""
    m.row.translation = "[5,170]"
    for each itemAA in list
        item = CreateObject("RoSGNode", "SimpleRowListItemData")
        item.subscription_name = itemAA.subscription_name
        item.subscription_id = itemAA.subscription_id
        item.price = itemAA.price
        ' item.price = itemAA.symbol + " " + Str(itemAA.price).trim()
        ' item.cost = Str(itemAA.price).trim()
        ' item.symbol = itemAA.symbol
        ' item.logo = "pkg:/images/premium.png"
        if itemAA.subscription_type_name = "Pay Per View"
            item.subscription_type_name = "Buy"
        end if
        if itemAA.subscription_type_name = "Rental"
            item.subscription_type_name = "Rent"
        end if
        if itemAA.subscription_type_name = "Yearly"
            item.subscription_type_name = itemAA.subscription_type_name
        end if
        if itemAA.subscription_type_name = "Monthly"
            item.subscription_type_name = itemAA.subscription_type_name
        end if
        item.roku_keyword = itemAA.roku_keyword
        item.description = itemAA.description
        item.subscription_text = itemAA.subscription_text
        m.row.appendChild(item)
    end for
    return m.data
end function

function ParseSubscription2(list as object)
    m.data = CreateObject("RoSGNode", "ContentNode")

    for each itemAA in list

        ' Create a ROW (one row per item)
        row = m.data.CreateChild("ContentNode")
        row.Title = ""

        ' Create item inside that row
        item = row.CreateChild("SimpleRowListItemData")

        for each key in itemAA
            val = itemAA[key]

            if val <> invalid
                if not item.hasField(key) then item.addField(key, "string", false)

                if type(val) = "roArray" or type(val) = "roAssociativeArray"
                    item[key] = FormatJson(val)
                else
                    item[key] = val.toStr()
                end if
            end if
        end for

    end for

    return m.data
end function


function ParseUserSub(list as object)
    m.data = CreateObject("RoSGNode", "ContentNode")
    m.row = m.data.CreateChild("ContentNode")

    my_subscriptions = getText("my_subscriptions")


    m.row.Title = my_subscriptions
    m.row.font = "font:LargeBoldSystemFont"
    for each itemAA in list
        item = CreateObject("RoSGNode", "SimpleRowListItemDataSub")
        item.mode_of_payment = itemAA.mode_of_payment
        symbol = ""
        if itemAA.symbol <> invalid
            symbol = itemAA.symbol.ToStr()
        end if
        price = ""
        if itemAA.price <> invalid
            price = itemAA.price.ToStr()
        end if
        item.price = symbol + price
        item.sub_id = itemAA.sub_id
        item.subscription_name = itemAA.subscription_name
        item.subscription_type_id = itemAA.subscription_type_id
        item.subscription_type_name = itemAA.subscription_type_name
        item.valid_from = itemAA.valid_from
        item.valid_to = itemAA.valid_to
        m.row.appendChild(item)
    end for
    return m.data
end function

function ParseUserLang(list as object)
    m.data = CreateObject("RoSGNode", "ContentNode")
    m.row = m.data.CreateChild("ContentNode")
    m.row.Title = "Languages"
    for each itemAA in list
        item = CreateObject("RoSGNode", "SimpleRowListItemDataSub1")
        item.audio_language_id = itemAA.audio_language_id
        item.audio_language_name = itemAA.audio_language_name
        m.row.appendChild(item)
    end for
    return m.data
end function

function GetCategories(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL2() + "category/list"
    if m.global.MENU_FOR_ISLAND <> invalid and m.global.MENU_FOR_ISLAND <> "" and m.global.MENU_FOR_ISLAND = "true"
        url = url + "?type=island"

    else if m.global.MENU_FOR_SMART_HOME_PAGES <> invalid and m.global.MENU_FOR_SMART_HOME_PAGES <> "" and m.global.MENU_FOR_SMART_HOME_PAGES = "true"

        url = url + "?type=home"
    end if

    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.categories
        ?"fdf"
        return data
    end if
end function

function GetCategoryVideos(urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "category/" + urlParams.genre_id.Trim() + "/shows"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if

    return data
end function

function GetCategoryVideoss(urlParams = {} as object) as object
    key = urlParams.key.replace(" ", "%20")
    data = {}
    url = getBaseApiURL2() + "category/" + urlParams.key.Trim().Escape()
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
        ?url
        ?"jdm"
        return data
    end if
end function


function GetChannelsVODContents(urlParams = {} as object) as object
    data = {}
    url = "https://poppo.tv/platform/bk/api/GetvideoList"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data

    end if
    return data
end function

function GetShowVODContents(urlParams = {} as object) as object
    data = {}
    ' url = getBaseApiURL2() + "show/" + urlParams.show_id.Trim()
    ' url = "https://sandbox.gizmott.com/api/v2/" + "show/details/" + urlParams.show_id.Trim()
    ' url = "https://api.gizmott.com/test/v2/" + "show/" + urlParams.show_id.Trim()
    url = getBaseApiURL2() + "show/details/" + urlParams.show_id.Trim()
    response = makeRequest(url, urlParams)
    getTokenPlayer()
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetShowVODContentsForUpComingEvents(upcomingEventId as integer, urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "event/" + upcomingEventId.ToStr()
    response = makeRequest(url, urlParams)
    getTokenPlayer()
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetShowVODContentsForOngoingEvents(OngoingEvent as integer, urlParams = {} as object) as object
    data = {}
    url = getBaseApiURL() + "event/" + OngoingEvent.ToStr()
    response = makeRequest(url, urlParams)
    getTokenPlayer()
    if response <> invalid
        ' response.data.thumbnail = "https://cdn.pixabay.com/photo/2022/01/28/18/32/leaves-6975462_1280.png"
        data = response.data
    end if
    return data
end function

function GetShowsPartner(urlParams = {} as object) as object
    data = {}
    url = "https://poppo.tv/platform/bk/api/partnerVideos"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetSelectedVodContent(urlParams = {} as object) as object
    data = {}
    url = "https://poppo.tv/platform/bk/api/GetSelectedVideoUpdated2"
    response = makeRequest(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function

function GetSelectedVodContentDeep(urlParams = {} as object) as object
    data = {}
    url = "https://poppo.tv/platform/bk/api/GetSelectedVideoUpdated2"
    response = MakeRequestDeep(url, urlParams)
    if response <> invalid
        data = response.data
    end if
    return data
end function

function HttpEncode(str as string) as string
    o = CreateObject("roUrlTransfer")
    return o.Escape(str)
end function

function getCatVODContent(CatString as string)
    params = {}

    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("key", CatString)
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    videos = []
    video_index = 0
    data = GetCategoryVideoss(params)
    title = data.category_name
    for each jsonitem in data.shows
        item = {}
        item.TITLESEASON = ""
        item.user_id = jsonitem.show_id
        item.show_id = jsonitem.show_id
        item.itemType = jsonitem.type
        item.STREAMFORMAT = "m3u8"
        item.show_name = jsonitem.show_name
        item.title = jsonitem.show_name
        item.RELEASEDATE = ""
        item.resolution = jsonitem.resolution
        item.category_name = jsonitem.category_name
        item.year = jsonitem.year
        item.producer = jsonitem.producer
        item.DESCRIPTION = jsonitem.video_description
        item.thumbnail = jsonitem.thumbnail
        item.HDPOSTERURL = jsonitem.logo_thumb
        item.HDPosterURLPortrait = jsonitem.logo
        item.is_free_video = jsonitem.is_free_video
        item.is_locked = jsonitem.is_locked
        item.thumbnail_orientation = data.thumbnail_orientation
        item.video_id = jsonitem.video_id
        item.ai_type = jsonitem.ai_type
        item.rental_flag = jsonitem.rental_flag
        item.payper_flag = jsonitem.payper_flag
        item.title = title

        ' if jsonitem.ai_type <> invalid
        '     item.ai_type = jsonitem.ai_type
        ' else
        '     item.ai_type = ""
        ' end if
        videos.push(item)
        ?"kj"
    end for
    return videos
end function

' ////////////////Login
function Login(user_email as string, password as string, device_id as string)
    params = {}
    data = {}
    returnResponse = {}
    langauge_id = Applicationid1(getUserIdana())

    ?"jkjk"
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()
    params.AddReplace("user_email", user_email)
    params.AddReplace("password", password)
    params.AddReplace("device_id", deviceids)
    params.AddReplace("pubid", getPubID())
    params.AddReplace("langauge_id", langauge_id)
    url = getBaseApiURL() + "account/login"
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    di = CreateObject("roDeviceInfo")
    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    url = AppendParamsToUrl(url, params)
    ?"url: "
    ?url
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        request.AddHeader("pubid", getPubID())
        request.AddHeader("channelid", getchannelsid())
        request.AddHeader("country_code", getCountrycode())
        request.AddHeader("device_type", "Roku")
        request.AddHeader("dev_id", deviceid)
        request.AddHeader("ip", getIp())
        request.AddHeader("ua", userAgent)
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())

                    ? "login response"
                    ? response
                    Registry = CreateObject("roRegistry")
                    RegistrySection = CreateObject("roRegistrySection", getAppKey())
                    RegistrySection.Delete("templateGuest")
                    SetIsGuest("false")
                    ' data = response.data
                    ' user = data[0].user_id
                    ' SetUID(Str(user))
                    SetLogregular()
                    if checkregtrue1() = "true"

                        data = response.data
                        user = data[0].user_id

                        responseSub = getUserSubscriptions1(Str(user))

                        if responseSub = "nosub" 'in case of nosub    ,  user data was not saving if nosub value is true, now it is ok

                            data = response.data
                            user = data[0].user_id
                            if data[0] <> invalid and data[0].user_id <> invalid
                                user = data[0].user_id
                                SetUID(Str(user))
                            end if
                            if data[0] <> invalid and data[0].first_name <> invalid
                                username = data[0].first_name
                                SetUerName(username)
                            end if
                            Setcount()
                            if data[0] <> invalid and data[0].user_email <> invalid
                                useremail = LCase(data[0].user_email).trim()
                                setUserEmail(useremail)
                            end if
                            if data[0] <> invalid and data[0].phone <> invalid
                                phone = data[0].phone
                                SetUserPhoneNumber(phone)
                            end if
                            ' callAccessTokenAPI()
                            setSessionId1()
                            RegistrySection = CreateObject("roRegistrySection", getAppKey())
                            RegistrySection.Delete("templateInstalled")
                            sec = CreateObject("roRegistrySection", getAppKey())
                            if sec.Exists("templateGuest")
                            else
                                if sec.Exists("templateInstalled")
                                else
                                    sec = CreateObject("roRegistrySection", getAppKey())
                                    if sec.Exists("templateGuest")
                                    else
                                        sec.Write("templateInstalled", "1")
                                        sec.Flush()
                                        valuedevice = ipInfoAPICall(Str(user).Trim())
                                        authenticateapi1()
                                    end if
                                end if
                            end if
                            returnResponse.AddReplace("status", "nosub")
                            return returnResponse
                        else ' case for invalid, exceed

                            return responseSub
                        end if
                    else
                        data = response.data
                        user = data[0].user_id
                        if data[0] <> invalid and data[0].user_id <> invalid
                            user = data[0].user_id
                            SetUID(Str(user))
                        end if
                        if data[0] <> invalid and data[0].first_name <> invalid
                            username = data[0].first_name
                            SetUerName(username)
                        end if
                        Setcount()
                        if data[0] <> invalid and data[0].user_email <> invalid
                            useremail = LCase(data[0].user_email).trim()
                            setUserEmail(useremail)
                        end if
                        if data[0] <> invalid and data[0].phone <> invalid
                            phone = data[0].phone
                            SetUserPhoneNumber(phone)
                        end if
                        ' callAccessTokenAPI()
                        setSessionId1()
                        RegistrySection = CreateObject("roRegistrySection", getAppKey())
                        RegistrySection.Delete("templateInstalled")
                        sec = CreateObject("roRegistrySection", getAppKey())
                        if sec.Exists("templateGuest")
                        else
                            if sec.Exists("templateInstalled")
                            else
                                sec = CreateObject("roRegistrySection", getAppKey())
                                if sec.Exists("templateGuest")
                                else
                                    sec.Write("templateInstalled", "1")
                                    sec.Flush()
                                    valuedevice = ipInfoAPICall(Str(user).Trim())
                                end if
                            end if
                        end if
                        returnResponse.AddReplace("status", "valid")
                        returnResponse.AddReplace("message", response.message)
                        return returnResponse
                    end if
                else if code = 201
                    ? "checkregtrue1() = true case:201"
                    response = ParseJson(msg.GetString())
                    data = response.data
                    userid = data[0].user_id
                    sec = CreateObject("roRegistrySection", getAppKey())
                    sec.Write("userIDOtp", Str(userid))
                    sec.Flush()
                    ' ? "data: " + response.data
                    ' ? "message: " + response.message
                    returnResponse.AddReplace("status", "needotp")
                    return returnResponse

                else if code = 202
                    response = ParseJson(msg.GetString())
                    message = response.message
                    returnResponse.AddReplace("status", "invalid")
                    returnResponse.AddReplace("message", response.message)
                    return returnResponse
                    ' sec = CreateObject("roRegistrySection", getAppKey())
                    ' sec.Write("userIDOtp", Str(userid))
                    ' sec.Flush()


                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
end function

function authenticateapi1()
    m.AuthenticateApi = CreateObject("roSGNode", "AuthenticateApi")
    m.AuthenticateApi.callFunc("runauthenticateApiTask", "")
end function

function LoginCode(code as string)
    ?"api calling: https://api.gizmott.com/api/v1/account/code/validate/" + code.Trim()
    emptyS = []
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()
    post = {
    }
    di = CreateObject("roDeviceInfo")
    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)

    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    http.SetPort(messagePort)
    http.setMessagePort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("pubid", getPubID())
    http.AddHeader("channelid", getchannelsid())
    http.AddHeader("Access-Control-Allow-Origin", "true")
    http.AddHeader("crossorigin", "true")
    http.AddHeader("country_code", getCountrycode())
    http.AddHeader("device_type", "Roku")
    http.AddHeader("dev_id", deviceids)
    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)
    http.AddHeader("Accept", "application/json")
    http.SetUrl(getBaseApiURL() + "account/code/validate/" + code.Trim())
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = ParseJson(msg.getString())
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                Registry = CreateObject("roRegistry")
                RegistrySection = CreateObject("roRegistrySection", getAppKey())
                RegistrySection.Delete("templateGuest")
                SetIsGuest("false")
                SetLogregular()
                data = response.data
                user = data[0].user_id
                if data[0] <> invalid and data[0].user_id <> invalid
                    user = data[0].user_id
                    SetUID(Str(user))
                end if
                if data[0] <> invalid and data[0].first_name <> invalid
                    username = data[0].first_name
                    SetUerName(username)
                end if
                Setcount()
                if data[0] <> invalid and data[0].user_email <> invalid
                    useremail = LCase(data[0].user_email).trim()
                    setUserEmail(useremail)
                end if
                if data[0] <> invalid and data[0].phone <> invalid
                    phone = data[0].phone
                    SetUserPhoneNumber(phone)
                end if
                ' callAccessTokenAPI()
                setSessionId1()
                RegistrySection = CreateObject("roRegistrySection", getAppKey())
                RegistrySection.Delete("templateInstalled")
                sec = CreateObject("roRegistrySection", getAppKey())
                if sec.Exists("templateGuest")
                else
                    if sec.Exists("templateInstalled")
                    else
                        sec = CreateObject("roRegistrySection", getAppKey())
                        if sec.Exists("templateGuest")
                        else
                            sec.Write("templateInstalled", "1")
                            sec.Flush()
                            ipInfoAPICall(Str(user).Trim())
                        end if
                    end if
                end if
                return "valid"
            else
                return invalid
            end if
        else if msg = invalid then
            http.asynccancel()
            lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
            lastresponsecode = 0
        else
        end if
    end if
end function

' function getchannelsid() as object
'     sec = CreateObject("roRegistrySection", getAppKey())
'     if sec.Exists("channelsids")
'         tok = sec.Read("channelsids")
'         ?"getchannelsid: "
'         ?tok
'         return tok
'     else
'         ?"getchannelsid: "
'         return ""
'     end if
' end function

function checkregtrue1() as dynamic
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("subtrue")
        return invalid ' this is subscription mandatory condition  i.e, redirecting to subscription page .  now its not there so commenting out
    else
        return invalid
    end if
end function

function GetLive(urlParams = {} as object) as object
    data = {}
    arr = []

    'here live guide of other channels can come, thats why we are passing linear_channel_id to get lveguide of other channels
    if urlParams.linear_channel_id <> invalid and urlParams.linear_channel_id <> ""
        url = getBaseApiURL() + "schedule/guide/" + getchannelsid() + "?linear_channel_id=" + urlParams.linear_channel_id.ToStr().Trim()
    else
        url = getBaseApiURL() + "schedule/guide/" + getFastChannelId()
    end if

    ' url = "https://staging.poppo.tv/api/v1/schedule/guide/373"
    response = makeRequest(url, urlParams)
    if response <> invalid
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("livecount", Str(response.data.count()))
        sec.Flush()
        data = response.data
    end if
    return data
end function




function GetNowPlayingLiveData(urlParams = {} as object) as object
    data = {}
    arr = []

    url = getBaseApiURL() + "fastchannel/" + urlParams.fastchannelid
    ' url = "https://staging.poppo.tv/api/v1/schedule/guide/373"
    response = makeRequest(url, urlParams)
    if response <> invalid
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("livecount", Str(response.data.count()))
        sec.Flush()
        data = response.data
    end if
    return data
end function

function getUserSubscriptions1(user_id as string)
    params = {}
    data = {}
    params.AddReplace("uid", user_id)
    params.AddReplace("pubid", getPubID())
    params.AddReplace("is_from_tv", "true")
    params.AddReplace("country_code", getCountrycode())
    SetSubUID(user_id)
    url = getBaseApiURL() + "subscription/user"
    response = makeRequest(url, params)
    if response <> invalid
        if response.forcibleLogout = true
            ? "getUserSubscriptions1: response.forcibleLogout = true"
            return "exceed"
        else if response.data.count() = 0
            ? "getUserSubscriptions1: response.data.count() = 0"
            return "nosub"
        else
            ? "getUserSubscriptions1: valid"
            return "valid"
        end if
    else
        return invalid
    end if
end function

function getUserSubscriptions2()
    params = {}
    data = {}
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("pubid", getPubID())
    params.AddReplace("is_from_tv", "true")
    params.AddReplace("country_code", getCountrycode())
    url = getBaseApiURL() + "subscription/user"
    response = makeRequest(url, params)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function Logout()
    params = {}
    data = {}
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("device_id", deviceid)
    params.AddReplace("pubid", getPubID())
    url = getBaseApiURL() + "account/logout"
    response = MakeRequestNoAuth(url, params)
    ? "logout response"
    ? response
    if response <> invalid
        if response.success = true
            data = response.data
            message = response.message
            ? "logout response data: "
            ? data
            SetGuest()
            setIsGuest("true")
            ?"sdksjhdkjshkdjhs354351111"
            ?isGuest2()
            return message
        else
            return invalid
        end if
    end if
    return invalid
end function

function Logoutall()
    params = {}
    data = {}
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("device_id", deviceid)
    params.AddReplace("pubid", getPubID())
    url = getBaseApiURL() + "account/logoutall"
    response = makeRequest(url, params)
    if response <> invalid
        if response.success = true
            SetGuest()
            setIsGuest("true")
            return response
        else
            return invalid
        end if
    end if
end function

function deleteAccount()
    ?"deleteAccount called"
    url = getBaseApiURL() + "user/delete"
    post = {}
    response = MakePostRequest(url, post)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function GetForgotPassword(user_email as string)
    params = {}
    params.AddReplace("user_email", user_email)
    params.AddReplace("device_id", "roku")
    params.AddReplace("pubid", getPubID())
    url = getBaseApiURL() + "account/passwordReset"
    response = MakeRequestNoAuth(url, params)
    return response
end function

function GuestRegister() as object
    print "guest register method entered"
    ?"api calling:"
    ?getBaseApiURL() + "account/register/guest"
    emptyS = []
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()
    post = {
        country_code: getCountrycode(),
        device_id: deviceids,
        latitude: "lat",
        longitude: "lon",
        pubid: getPubID()
    }
    di = CreateObject("roDeviceInfo")
    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    http.SetPort(messagePort)
    http.setMessagePort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("pubid", getPubID())
    http.AddHeader("channelid", getchannelsid())
    ' http.AddHeader("country_code", getCountrycode())
    http.AddHeader("device_type", "Roku")
    http.AddHeader("dev_id", deviceids)
    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)
    http.AddHeader("Accept", "application/json")
    http.SetUrl(getBaseApiURL() + "account/register/guest")
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            ?"api response:"
            ?getBaseApiURL() + "account/register/guest"
            ?response
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
        else if msg = invalid then
            http.asynccancel()
            lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
            lastresponsecode = 0
        else
        end if
    end if
    resp = ParseJson(response)
    if resp.success = true
        data = resp
        if data <> invalid and data.user_id <> invalid
            user = data.user_id
            SetUID(Str(user))

            SetGuest()
            SetIsGuest("true")
            callAccessTokenAPI()
            setSessionId1()
            ipInfoAPICall(Str(user).Trim())
            return user
        else
            return invalid
        end if
    else
        return invalid
    end if
end function

function GetConfigText(configType as string) as string
    params = {}
    url = getBaseApiURL() + "config?type=" + configType.Trim()
    response = makeRequest(url, params, { "website": getWebsiteURL() })
    if response <> invalid and response.data <> invalid and response.data.value <> invalid
        val = response.data.value
        if val <> invalid then return val.ToStr()
    end if
    return ""
end function


function Getpubidcheck() as object


    params = {}
    data = {}
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    params.AddReplace("app_key", getAppKey())
    params.AddReplace("app_bundle_id", getBundleID())
    url = getBaseApiURL() + "config?package=" + getBundleID()
    resp = MakeRequestNoAuthForPubId(url, params)

    if resp <> invalid
        if resp.data <> invalid and resp.data.config <> invalid 'and resp.message = "Configuration data"
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("PubID", Str(resp.data.pubid).Trim())
            sec.Write("channelsids", Str(resp.data.channelid).Trim())

            if resp.data.config?.SIGN_UP_REQUIRED <> invalid
                sec.Write("SIGN_UP_REQUIRED", resp.data.config.SIGN_UP_REQUIRED.Trim())
            end if

            if resp.data.config?.PLACEHOLDER_IMAGE <> invalid
                sec.Write("PLACEHOLDER_IMAGE", resp.data.config.PLACEHOLDER_IMAGE.Trim())
            end if

            if resp.data.config?.PLACEHOLDER_IMAGE_PORTRAIT <> invalid
                sec.Write("PLACEHOLDER_IMAGE_PORTRAIT ", resp.data.config.PLACEHOLDER_IMAGE_PORTRAIT.Trim())
            end if

            if resp.data.config?.SHORTS_LOGIN_REQUIRED <> invalid
                sec.Write("SHORTS_LOGIN_REQUIRED", resp.data.config.SHORTS_LOGIN_REQUIRED.Trim())
            end if

            if resp.data.config?.LIVE_LOGIN_REQUIRED <> invalid
                sec.Write("LIVE_LOGIN_REQUIRED", resp.data.config.LIVE_LOGIN_REQUIRED.Trim())
            end if

            if resp.data.config?.BYPASS_SHOW_DETAILS_SCREEN <> invalid
                sec.Write("BYPASS_SHOW_DETAILS_SCREEN", resp.data.config.BYPASS_SHOW_DETAILS_SCREEN.Trim())
            end if

            if resp.data.config?.SKIP_LOGIN_REQUIRED <> invalid
                sec.Write("SKIP_LOGIN_REQUIRED", resp.data.config.SKIP_LOGIN_REQUIRED.Trim())
            end if

            if resp.data.config?.MULTI_LANGUAGE_REQUIRED <> invalid
                sec.Write("MULTI_LANGUAGE_REQUIRED", resp.data.config.MULTI_LANGUAGE_REQUIRED.Trim())
            end if

            if resp.data.config?.LOGIN_WITH_MAGIC_LINK_REQUIRED <> invalid
                sec.Write("LOGIN_WITH_MAGIC_LINK_REQUIRED", resp.data.config.LOGIN_WITH_MAGIC_LINK_REQUIRED.Trim())
            end if

            if resp.data.config?.LOGIN_WITH_MAGIC_LINK_REQUIRED <> invalid
                sec.Write("LOGIN_WITH_MAGIC_LINK_REQUIRED", resp.data.config.LOGIN_WITH_MAGIC_LINK_REQUIRED.Trim())
            end if

            if resp.data.config?.REVERSE_TV_CODE_FLOW <> invalid
                sec.Write("REVERSE_TV_CODE_FLOW", resp.data.config.REVERSE_TV_CODE_FLOW.Trim())
            end if

            if resp.data.config?.MULTI_LANGUAGE_REQUIRED <> invalid
                sec.Write("MULTI_LANGUAGE_REQUIRED", resp.data.config.MULTI_LANGUAGE_REQUIRED.Trim())
            end if

            ' FETCHING THE PARAMETER MULTI_CHANNELS_REQUIRED
            if resp.data.config?.MULTI_CHANNELS_REQUIRED <> invalid
                sec.Write("MULTI_CHANNELS_REQUIRED", resp.data.config.MULTI_CHANNELS_REQUIRED.Trim())
            end if

            if resp.data.config?.INITIAL_PAGE <> invalid
                sec.Write("INITIAL_PAGE", resp.data.config.INITIAL_PAGE.Trim())
            end if
            if resp.data.config?.BACKGROUND_COLOR <> invalid
                sec.Write("BACKGROUND_COLOR", resp.data.config.BACKGROUND_COLOR.Trim())
            end if
            if resp.data.config?.REGISTRATION_MANDATORY <> invalid
                sec.Write("REGISTRATION_MANDATORY", resp.data.config.REGISTRATION_MANDATORY.Trim())
            end if
            if resp.data.config?.REGISTRATION_OTP_REQUIRED <> invalid
                sec.Write("REGISTRATION_OTP_REQUIRED", resp.data.config.REGISTRATION_OTP_REQUIRED.Trim())
            end if
            if resp.data.config?.BUTTON_SELECTION_COLOR <> invalid
                sec.Write("BUTTON_SELECTION_COLOR", resp.data.config.BUTTON_SELECTION_COLOR.Trim())
            end if
            if resp.data.config?.TEXT_COLOR <> invalid
                sec.Write("TEXT_COLOR", resp.data.config.TEXT_COLOR.Trim())
            else
                sec.Write("TEXT_COLOR", "#212121")
            end if
            if resp.data.config?.AD_REQUIRED <> invalid
                sec.Write("AD_REQUIRED", resp.data.config.AD_REQUIRED.Trim())
            end if
            if resp.data.config?.SUBSCRIPTION_REQUIRED <> invalid
                sec.Write("SUBSCRIPTION_REQUIRED", resp.data.config.SUBSCRIPTION_REQUIRED.Trim())
            end if
            if resp.data.config?.LOGO <> invalid
                sec.Write("LOGO", resp.data.config.LOGO.Trim())
            end if

            if resp.data.config?.ROKU_SUBSCRIPTION_REQUIRED <> invalid
                sec.Write("ROKU_SUBSCRIPTION_REQUIRED", resp.data.config.ROKU_SUBSCRIPTION_REQUIRED)
            end if

            if resp.data.config?.TV_ACTIVATION_URL <> invalid
                sec.Write("TV_ACTIVATION_URL", resp.data.config.TV_ACTIVATION_URL.Trim())
            end if
            if resp.data.config?.ROKU_CHANNEL_STORE_URL <> invalid
                sec.Write("ROKU_CHANNEL_STORE_URL", resp.data.config.ROKU_CHANNEL_STORE_URL.Trim())
            end if
            if resp.data.config?.TAB_TITLE <> invalid
                sec.Write("TAB_TITLE", resp.data.config.TAB_TITLE.Trim())
            end if
            if resp.data.config?.THUMBNAIL_ORIENTATION <> invalid
                sec.Write("THUMBNAIL_ORIENTATION", resp.data.config.THUMBNAIL_ORIENTATION.Trim())
            end if

            if resp.data.config?.FAST_CHANNEL_ID <> invalid
                sec.Write("FAST_CHANNEL_ID", resp.data.config.FAST_CHANNEL_ID.Trim())
            end if

            if resp.data.config?.SIGN_IN_MESSAGE <> invalid
                sec.Write("SIGN_IN_MESSAGE", resp.data.config.SIGN_IN_MESSAGE)
            end if

            if resp.data.config?.CAST_CREW_IMAGE_REQUIRED <> invalid
                sec.Write("CAST_CREW_IMAGE_REQUIRED", resp.data.config.CAST_CREW_IMAGE_REQUIRED)
            end if

            if resp.data.config?.HIDE_TITLE_UNDER_MOVIES <> invalid
                sec.Write("HIDE_TITLE_UNDER_MOVIES", resp.data.config.HIDE_TITLE_UNDER_MOVIES.Trim())
            end if

            if resp.data.config?.CUSTOM_FILTERS_REQUIRED <> invalid
                sec.Write("CUSTOM_FILTERS_REQUIRED", resp.data.config.CUSTOM_FILTERS_REQUIRED)
            end if

            if resp.data.config?.COMMENTS_REQUIRED <> invalid
                sec.Write("COMMENTS_REQUIRED", resp.data.config.Comments_Required)
            end if

            SHOW_MORE_COUNT = ""
            if resp.data.config?.SHOW_MORE_COUNT <> invalid
                SHOW_MORE_COUNT = resp.data.config.SHOW_MORE_COUNT
            end if
            sec.Write("SHOW_MORE_COUNT", SHOW_MORE_COUNT)

            if resp.data.config?.LOGO <> invalid
                sec.Write("APP_LOGO", resp.data.config.LOGO)
                m.top.getScene().findNode("BrandingLogo").uri = resp.data.config.LOGO 'setting logo in global scene brandinglogo node
            end if

            if resp.data.config?.THEME <> invalid
                sec.Write("THEME", resp.data.config.THEME)
            else
                sec.Write("THEME", "DARK")
            end if

            dynamicSideMenuInitialising(sec, resp.data.config?.TAB_BAR_ITEMS)
            m.global.SMART_HOME_PAGES = resp.data.config?.SMART_HOME_PAGES


            if resp.data.config?.LANGUAGE_KEYWORDS <> invalid
                m.global.language_keywords = resp.data.config?.LANGUAGE_KEYWORDS
                ?m.global.language_keywords
            end if

            if resp.data.config?.ACCOUNT_ITEMS <> invalid
                sec.Write("ACCOUNT_ITEMS", FormatJson(resp.data.config.ACCOUNT_ITEMS))
            end if

            if resp.data.config?.ABOUT_US_TEXT <> invalid
                sec.Write("ABOUT_US_TEXT", resp.data.config.ABOUT_US_TEXT)
            end if

            if resp.data.website_url <> invalid
                sec.Write("WEBSITE_URL", resp.data.website_url)
            end if

            sec.Flush()
            regflag = resp.registration_mandatory_flag
            subflag = resp.subscription_mandatory_flag
            if subflag = false
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("subtrue", "false")
                sec.Flush()
            else
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("subtrue", "true")
                sec.Flush()
            end if
            if regflag = false
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("regtrue", "false")
                sec.Flush()
            else
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("regtrue", "true")
                sec.Flush()
            end if
            return resp
        else
            return invalid
        end if
    else
        return invalid
    end if
end function






function dynamicSideMenuInitialising(sec, input)
    if input <> invalid
        fields = {
            order: [],
            type: [],
            title: [],
            icon: [],
            key: []
        }

        for each item in input
            for each key in fields
                if item[key] <> invalid
                    value = item[key].ToStr()
                else
                    value = ""
                end if
                fields[key].Push(value)
            end for
        end for

        sec.Write("MENU_ITEMS_ORDER", fields.order.Join(","))
        sec.Write("MENU_ITEMS_TYPE", fields.type.Join(","))
        sec.Write("MENU_ITEMS_TITLE", fields.title.Join(","))
        sec.Write("MENU_ITEMS_ICON", fields.icon.Join(","))
        sec.Write("MENU_ITEMS_KEY", fields.key.Join(","))
    end if
end function





' Register///////////////////////////////////////////////
function Register(fullName as string, user_email as string, password as string, device_id as string) as object
    emptyS = []
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()
    post = {
        user_email: user_email.Trim(),
        password: password,
        first_name: fullName,
        device_id: deviceids,
        facebook_id: "",
        last_name: "",
        phone: "",
        device_type: "Roku",
        login_type: "",
        verified: "0",
        c_code: getCountrycode(),
        pubid: getPubID(),
        ipaddress: getIp()
    }
    di = CreateObject("roDeviceInfo")
    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)

    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    http.SetPort(messagePort)
    http.setMessagePort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("pubid", getPubID())
    http.AddHeader("channelid", getchannelsid())
    http.AddHeader("country_code", getCountrycode())
    http.AddHeader("device_type", "Roku")
    http.AddHeader("dev_id", deviceids)
    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)
    http.AddHeader("Accept", "application/json")
    http.SetUrl(getBaseApiURL() + "account/register")
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            ?"response123"
            ?response
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            ?lastresponsecode
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 201
                resp = ParseJson(response)
                user = resp.user_id
                sec = CreateObject("roRegistrySection", getAppKey())
                sec.Write("userIDOtp", Str(user))
                sec.Flush()
                return resp
            else if lastresponsecode = 200
                resp = ParseJson(response)
                Registry = CreateObject("roRegistry")
                RegistrySection = CreateObject("roRegistrySection", getAppKey())
                RegistrySection.Delete("templateGuest")
                SetIsGuest("false")
                data = resp.data
                user = data[0].user_id
                if data[0] <> invalid and data[0].user_id <> invalid
                    user = data[0].user_id
                    SetUID(Str(user))
                end if
                if data[0] <> invalid and data[0].first_name <> invalid
                    username = data[0].first_name
                    SetUerName(username)
                end if
                Setcount()
                if data[0] <> invalid and data[0].user_email <> invalid
                    useremail = LCase(data[0].user_email).trim()
                    setUserEmail(useremail)
                end if
                if data[0] <> invalid and data[0].phone <> invalid
                    phone = data[0].phone
                    SetUserPhoneNumber(phone)
                end if
                ' callAccessTokenAPI()
                setSessionId1()
                RegistrySection = CreateObject("roRegistrySection", getAppKey())
                RegistrySection.Delete("templateInstalled")
                sec = CreateObject("roRegistrySection", getAppKey())
                if sec.Exists("templateGuest")
                else
                    if sec.Exists("templateInstalled")
                    else
                        sec = CreateObject("roRegistrySection", getAppKey())
                        if sec.Exists("templateGuest")
                        else
                            sec.Write("templateInstalled", "1")
                            sec.Flush()
                            ipInfoAPICall(user.ToStr().Trim())
                        end if
                    end if
                end if
                return resp

            else
                return emptyS
            end if
        else if msg = invalid then
            http.asynccancel()
            lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
            lastresponsecode = 0
        else
        end if
    end if
end function

function verifyOtpFromEmail(otp as string)
    params = {}
    data = {}
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("userIDOtp")
        tok = sec.Read("userIDOtp")
    end if
    params.AddReplace("otp", otp)
    params.AddReplace("user_id", tok)
    params.AddReplace("pubid", getPubID())
    url = getBaseApiURL() + "account/otp/verify"
    response = MakeRequestNoAuthTokenVerify(url, params)
    if response <> invalid
        if response.success = true
            Registry = CreateObject("roRegistry")
            RegistrySection = CreateObject("roRegistrySection", getAppKey())
            RegistrySection.Delete("templateGuest")
            SetRegregular()
            SetIsGuest("false")
            resp = response
            data = resp.data
            user = data[0].user_id
            if data[0] <> invalid and data[0].user_id <> invalid
                user = data[0].user_id
                SetUID(Str(user))
            end if
            if data[0] <> invalid and data[0].first_name <> invalid
                username = data[0].first_name
                SetUerName(username)
            end if
            Setcount()
            if data[0] <> invalid and data[0].user_email <> invalid
                useremail = LCase(data[0].user_email).trim()
                setUserEmail(useremail)
            end if
            if data[0] <> invalid and data[0].phone <> invalid
                phone = data[0].phone
                SetUserPhoneNumber(phone)
            end if
            ' callAccessTokenAPI()
            setSessionId1()
            RegistrySection = CreateObject("roRegistrySection", getAppKey())
            RegistrySection.Delete("templateInstalled")
            sec = CreateObject("roRegistrySection", getAppKey())
            if sec.Exists("templateGuest")
            else
                if sec.Exists("templateInstalled")
                else
                    sec = CreateObject("roRegistrySection", getAppKey())
                    if sec.Exists("templateGuest")
                    else
                        sec.Write("templateInstalled", "1")
                        sec.Flush()
                        ipInfoAPICall(tok.Trim())
                    end if
                end if
            end if
            return true
        else
            return invalid
        end if
    end if
    return invalid
end function

function MakeRequestNoAuthTokenVerify(src as string, params as object) as object
    ?"api calling: MakeRequestNoAuthTokenVerify"
    ?src
    ?params
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()

    url = AppendParamsToUrl(src, params)
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
        if getPubID() <> invalid and getchannelsid() <> invalid
            request.AddHeader("pubid", getPubID())
            request.AddHeader("uid", params.user_id)
            request.AddHeader("channelid", getchannelsid())
            request.AddHeader("country_code", getCountrycode())
            request.AddHeader("device_type", "Roku")
            request.AddHeader("dev_id", deviceid)
            request.AddHeader("ip", getIp())
            request.AddHeader("ua", userAgent)
        end if
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    ?"api response: MakeRequestNoAuthTokenVerify"
                    ?src
                    ?response
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

function resendOtp()
    params = {}
    data = {}
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceids = di.GetChannelClientId()
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("userIDOtp")
        tok = sec.Read("userIDOtp")
    end if
    params.AddReplace("ipaddress", getIp())
    params.AddReplace("device_id", deviceids)
    params.AddReplace("user_id", tok)
    params.AddReplace("pubid", getPubID())
    url = getBaseApiURL() + "account/otp/resend"
    response = MakeRequestNoAuthTokenResend(url, params)
    if response <> invalid
        if response.success = true
            return true
        else
            return invalid
        end if
    end if
end function

function MakeRequestNoAuthTokenResend(src as string, params as object) as object
    ?"api calling: MakeRequestNoAuthTokenResend"
    ?src
    ?params
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    url = AppendParamsToUrl(src, params)
    if url.InStr(0, "https") = 0
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)
        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
        if getPubID() <> invalid and getchannelsid() <> invalid
            request.AddHeader("pubid", getPubID())
            request.AddHeader("uid", params.user_id)
            request.AddHeader("channelid", getchannelsid())
            request.AddHeader("country_code", getCountrycode())
            request.AddHeader("device_type", "Roku")
            request.AddHeader("dev_id", deviceid)
            request.AddHeader("ip", getIp())
            request.AddHeader("ua", userAgent)
        end if
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()
    end if
    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 201
                    response = ParseJson(msg.GetString())
                    ?"api response: MakeRequestNoAuthTokenResend"
                    ?src
                    ?response
                    return response
                else
                    return invalid
                end if
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

' function SetUserIdReg(userid as string)
'     sec = CreateObject("roRegistrySection", getAppKey())
'     sec.Write("userIDReg", userid)
'     sec.Flush()
' end function

' function SetPhoneReg(phone as string)
'     sec = CreateObject("roRegistrySection", getAppKey())
'     sec.Write("phoneReg", phone)
'     sec.Flush()
' end function

' function SetFirstNameReg(name as string)
'     sec = CreateObject("roRegistrySection", getAppKey())
'     sec.Write("nameReg", name)
'     sec.Flush()
' end function

' function SetUmailReg(user_email as string)
'     sec = CreateObject("roRegistrySection", getAppKey())
'     sec.Write("emailReg", user_email)
'     sec.Flush()
' end function

'****************CAST and CREW IMAGE REQUIRED*********************

function getCastandCrewImage() as string
    ses = CreateObject("roRegistrySection", getAppKey3())
    if ses.Exists("CAST_CREW_IMAGE_REQUIRED")
        cast_crew_image_required = ses.Read("CAST_CREW_IMAGE_REQUIRED")
        return cast_crew_image_required
    else
        return "false"
    end if

end function

function SetCastandCrewImage(cast_crew_image_required as string)
    sec = CreateObject("roRegistrySection", getAppKey3())
    sec.Write("CAST_CREW_IMAGE_REQUIRED", cast_crew_image_required)
    sec.Flush()
end function



function getCustomFiltersRequired() as string
    ses = CreateObject("roRegistrySection", getAppKey3())
    if ses.Exists("CUSTOM_FILTERS_REQUIRED")
        custom_filters_required = ses.Read("CUSTOM_FILTERS_REQUIRED")
        return custom_filters_required
    else
        return "false"
    end if

end function

function setCustomFiltersRequired(custom_filters_required as string)
    sec = CreateObject("roRegistrySection", getAppKey3())
    sec.Write("CUSTOM_FILTERS_REQUIRED", custom_filters_required)
    sec.Flush()
end function



function getCommentsRequired() as string
    ses = CreateObject("roRegistrySection", getAppKey3())
    if ses.Exists("COMMENTS_REQUIRED")
        comments_required = ses.Read("COMMENTS_REQUIRED")
        return comments_required
    else
        return "false"
    end if

end function


function setCommentsRequired(comments_required as string)
    sec = CreateObject("roRegistrySection", getAppKey3())
    sec.Write("COMMENTS_REQUIRED", comments_required)
    sec.Flush()
end function



function SetUID(uid as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("USER_ID", uid)
    sec.Flush()
    ? "SetUID: "
    ? uid
end function

function SetSubUID(uid as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("usersubID", uid)
    sec.Flush()
end function

function SetGuest()
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("templateGuest", "123")
    sec.Flush()
end function

function setIsGuest(is_guest as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("ISGUEST", is_guest)
    sec.Flush()
end function

' ***************************Guest User*************************
function isGuest2() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("ISGUEST")
        isguestt = ses.Read("ISGUEST")
        return isguestt
    else
        return "true"
    end if
end function

function setRegregular()
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("regularreg", "123")
    sec.Flush()
end function

function SetLogregular()
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("regularlog", "123")
    sec.Flush()
end function

function getAppLogo() as string
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("APP_LOGO")
        appLogo = sec.Read("APP_LOGO")
        return appLogo
    else
        return ""
    end if
end function



'api calls

function updateSubscriptionTransaction(post as object) as object
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    messagePort = CreateObject("roMessagePort")
    di = CreateObject("roDeviceInfo")
    version = di.GetVersion()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
    deviceid = di.GetChannelClientId()
    http.SetPort(messagePort)
    http.setCertificatesFile("common:/certs/ca-bundle.crt")
    http.AddHeader("access-token", getAuthorisationToken())
    http.InitClientCertificates()
    http.AddHeader("pubid", getPubID())
    http.AddHeader("uid", getUserIdana())
    http.AddHeader("channelid", getchannelsid())
    http.AddHeader("country_code", getCountrycode())
    http.AddHeader("device_type", "Roku")
    http.AddHeader("dev_id", deviceid)
    http.AddHeader("ip", getIp())
    http.AddHeader("ua", userAgent)
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("Accept", "application/json")
    http.SetUrl("https://api.gizmott.com/api/v1/subscription/updateTransaction") 'https://poppo.tv/platform/bk/api/updateTransaction
    postJSON = FormatJson(post)
    ? postJSON
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if http.AsyncPostFromString(postJSON) then
        event = Wait(10000, http.GetPort())
        if Type(event) = "roUrlEvent" then
            response = event.getString()
            responseheaders = event.GetResponseHeaders()
            lastresponsecode = event.GetResponseCode()
            lastresponsefailurereason = event.GetFailureReason()
        else if event = invalid then
            http.asynccancel()
            lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
            lastresponsecode = 0
        else
            ? "AsyncPostFromString unknown event"
        end if
    end if
    ? "Response Headers: "; responseheaders
    ? "Response Code: "; lastresponsecode
    ? "Failure Reason: "; lastresponsefailurereason
    ? "Response: "; response
    resp = ParseJson(response)
    if resp.success = true
        data = "success"
        return data
        ?data
        ?"dataupdatetransaction"
    else
        ?"invalid123e44"
        return invalid
    end if
end function


' function updateSubscriptionTransaction(post as object) as object
'     http = CreateObject("roUrlTransfer")
'     http.RetainBodyOnError(true)
'     messagePort = CreateObject("roMessagePort")
'     http.SetPort(messagePort)
'     http.setCertificatesFile("common:/certs/ca-bundle.crt")
'     http.AddHeader("access-token", getAuthorisationToken())
'     http.InitClientCertificates()
'     http.AddHeader("Content-Type", "application/json")
'     http.AddHeader("Accept", "application/json")
'    ' http.SetUrl("https://poppo.tv/platform/bk/api/updateTransaction")
'     http.SetUrl("https://api.gizmott.com/api/v1/subscription/updateTransaction") 'https://poppo.tv/platform/bk/api/updateTransaction
'     postJSON = FormatJson(post)
'     ? postJSON
'     response = ""
'     lastresponsecode = ""
'     lastresponsefailurereason = ""
'     responseheaders = []
'     if http.AsyncPostFromString(postJSON) then
'         event = Wait(10000, http.GetPort())
'         if Type(event) = "roUrlEvent" then
'             response = event.getString()
'             responseheaders = event.GetResponseHeaders()
'             lastresponsecode = event.GetResponseCode()
'             lastresponsefailurereason = event.GetFailureReason()
'         else if event = invalid then
'             http.asynccancel()
'             lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
'             lastresponsecode = 0
'         else
'             ? "AsyncPostFromString unknown event"
'         end if
'     end if
'     ? "Response Headers: "; responseheaders
'     ? "Response Code: "; lastresponsecode
'     ? "Failure Reason: "; lastresponsefailurereason
'     ? "Response: "; response
'     resp = ParseJson(response)
'     if resp.success = true
'         data = "success"
'         return data
'     else
'         return invalid
'     end if
' end function


function EventForPOP02ForTimeGridScene(user_id as string, event_type as string, show_id as string, video_title as string, channel_id as string, is_live as string, schedule_id as string)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    model = di.GetModel()
    version = di.GetVersion()
    Appid = di.GetChannelClientId()
    advid = di.GetRIDA()
    channelclientid = di.GetChannelClientId()
    deviceid = di.GetChannelClientId()
    model1 = di.GetModelType()
    country = getCountry()
    city = getCity()
    ip = getIp()
    lat = getLatitude()
    lon = getLongitude()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    UserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    dt = CreateObject ("roDateTime")
    timestampdevice = dt.AsSeconds().ToStr()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sess = getsess()
    '  appsid=Applicationid(user_id.trim())
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    deviceid = di.GetChannelClientId()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sessionidis = sessioniddevice + deviceid
    appsid = getappId()
    request = CreateObject("roUrlTransfer")
    ' body = "&channel_id=" + request.Escape(channel_id) + "&session_id=" + request.Escape(sess.ToStr()) + "&timestamp=" + request.Escape(timestampdevice) + "&user_id=" + request.Escape(user_id.trim()) + "&device_id=" + request.Escape(deviceid) + "&event_id=" + request.Escape(event_id) + "&event_type=" + request.Escape(event_type) + "&video_title=" + request.Escape(video_title) + "&app_id=" + request.Escape(appsid) + "&category=" + request.Escape(category) + "&publisherid=" + request.Escape(getPubID().trim()) + "&schedule_id=" + request.Escape(schedule_id) + "&is_live=" + request.Escape(is_live.ToStr())
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")
    request.AddHeader("Accept", "application/json")
    request.SetUrl("https://analytics.poppo.tv/event")
    messagePort = CreateObject("roMessagePort")
    request.SetPort(messagePort)
    request.setMessagePort(messagePort)


    ' Initialize the parameters
    channel_id = request.Escape(channel_id)
    session_id = request.Escape(sess.ToStr())
    timestamp = request.Escape(timestampdevice)
    user_id = request.Escape(user_id.trim())
    device_id = request.Escape(deviceid)
    show_id = request.Escape(show_id)
    event_type = request.Escape(event_type)
    video_title = request.Escape(video_title)
    app_id = request.Escape(appsid)
    publisherid = request.Escape(getPubID().trim())
    schedule_id = request.Escape(schedule_id)
    is_live_param = request.Escape(is_live)

    ' Create a BrightScript associative array (JSON-like structure)
    post = {
        channel_id: request.Escape(channel_id),
        session_id: session_id,
        timestamp: timestamp,
        user_id: user_id,
        device_id: device_id,
        event_type: event_type,
        show_id: show_id,
        video_title: video_title,
        app_id: app_id,
        publisherid: publisherid,
        schedule_id: schedule_id,
        is_live: is_live_param
    }

    ' Now 'post' is a BrightScript associative array containing your parameters


    ? "event body"
    ? post
    ' request.PostFromString(post)
    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if request.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?"resp POP02"
                ?resp
                ' return resp
            else
                ' return invalid
            end if
        end if
    end if
end function

function EventForTimeGridScene(user_id as string, event_type as string, show_id as string, video_title as string, channel_id as string, is_live as string, video_time as integer, schedule_id as string)
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)

    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    model = di.GetModel()
    version = di.GetVersion()
    Appid = di.GetChannelClientId()
    advid = di.GetRIDA()
    channelclientid = di.GetChannelClientId()
    deviceid = di.GetChannelClientId()
    model1 = di.GetModelType()
    country = getCountry()
    city = getCity()
    ip = getIp()
    lat = getLatitude()
    lon = getLongitude()
    version_major = Mid(version, 3, 1)
    version_minor = Mid(version, 5, 2)
    version_build = Mid(version, 8, 5)
    if version_minor.toint() < 10 then
        version_minor = Mid(version_minor, 2)
    end if
    UserAgent = "Roku/DVP-" + version_major + "." + version_minor + "(" + version + ")"
    dt = CreateObject ("roDateTime")
    timestampdevice = dt.AsSeconds().ToStr()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sess = getsess()
    '  appsid=Applicationid(user_id.trim())
    displaySize = di.GetDisplaySize()
    macroHeight = Str(displaySize.h).Trim()
    macroWidth = Str(displaySize.w).Trim()
    deviceid = di.GetChannelClientId()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    sessionidis = sessioniddevice + deviceid
    appsid = getappId()
    request = CreateObject("roUrlTransfer")

    ' post = "channel_id=" + request.Escape(channel_id) + "&session_id=" + request.Escape(sess.ToStr()) + "&timestamp=" + request.Escape(timestampdevice) + "&user_id=" + request.Escape(user_id.trim()) + "&device_id=" + request.Escape(deviceid) + "&event_id=" + request.Escape(event_id) + "&event_type=" + request.Escape(event_type) + "&video_title=" + request.Escape(video_title) + "&app_id=" + request.Escape(appsid) + "&category=" + request.Escape(category) + "&publisherid=" + request.Escape(getPubID().trim()) + "&is_live=" + request.Escape(is_live.ToStr()) + "&schedule_id=" + request.Escape(schedule_id) + "&video_time=" + request.Escape(video_timeString)

    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")
    request.AddHeader("Accept", "application/json")
    request.SetUrl("https://analytics.poppo.tv/event")
    response = "https://analytics.poppo.tv/event"
    messagePort = CreateObject("roMessagePort")
    request.SetPort(messagePort)
    request.setMessagePort(messagePort)

    channel_id = request.Escape(channel_id)
    session_id = request.Escape(sess.ToStr())
    timestamp = request.Escape(timestampdevice)
    user_id = request.Escape(user_id.trim())
    device_id = request.Escape(deviceid)
    show_id = request.Escape(show_id)
    event_type = request.Escape(event_type)
    video_title = request.Escape(video_title)
    app_id = request.Escape(appsid)
    publisherid = request.Escape(getPubID().trim())
    schedule_id = request.Escape(schedule_id)
    video_time_Param = request.Escape(video_time.ToStr())

    ' Create a BrightScript associative array (JSON-like structure)
    post = {
        channel_id: channel_id,
        session_id: session_id,
        timestamp: timestamp,
        user_id: user_id,
        device_id: device_id,
        event_type: event_type,
        video_title: video_title,
        show_id: show_id,
        app_id: app_id,
        publisherid: publisherid,
        is_live: is_live,
        schedule_id: schedule_id,
        video_time: video_time_Param
    }
    ?"event body"
    ?post

    postJSON = FormatJson(post)
    response = ""
    lastresponsecode = ""
    lastresponsefailurereason = ""
    responseheaders = []
    if request.AsyncPostFromString(postJSON) then
        msg = messagePort.waitMessage(10000)
        if Type(msg) = "roUrlEvent" then
            response = msg.getString()
            responseheaders = msg.GetResponseHeaders()
            lastresponsecode = msg.GetResponseCode()
            lastresponsefailurereason = msg.GetFailureReason()
            if lastresponsecode = 200
                resp = ParseJson(response)
                ?"resp 200"
                ?resp
                return resp
            else
                return invalid
            end if
        end if
    end if
end function



function getchannelss()
    params = {}
    params.AddReplace("pubid", getPubID())
    params.AddReplace("country_code", getCountrycode())
    videos = []
    video_index = 0
    for each jsonitem in GetChannels(params)
        item = {}
        item.TITLESEASON = ""
        item.user_id = "1"
        item.video_id = jsonitem.video_id
        item.ad_link = jsonitem.ad_link
        item.channel_id = jsonitem.channel_id
        videos.push(item)
    end for
    return videos
end function

function getSHOWResponse(showID)
    params = {}
    params.AddReplace("pubid", getPubID())
    params.AddReplace("show_id", showID)
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("country_code", getCountrycode())

    showResponse = GetShowVODContents(params)
    return showResponse
end function

function getSHOWResponseForNews(showID)
    params = {}
    params.AddReplace("pubid", getPubID())
    params.AddReplace("show_id", showID)
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("country_code", getCountrycode())


    showResponse = GetShowVODContents(params)
    return showResponse
end function

function getUPCOMINGEVENTResponse(showID, upcomingEventId)
    params = {}
    params.AddReplace("pubid", getPubID())
    params.AddReplace("show_id", showID)
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("country_code", getCountrycode())

    showResponse = GetShowVODContentsForUpComingEvents(upcomingEventId, params)
    ?"shoresponse"
    return showResponse
end function

function getONGOINGEVENTResponse(OngoingEvent)
    params = {}
    params.AddReplace("pubid", getPubID())
    ' params.AddReplace("show_id", showID)
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("country_code", getCountrycode())

    showResponse = GetShowVODContentsForOngoingEvents(OngoingEvent, params)
    return showResponse
end function


' upcoming events parsing

function getShowVODForIfUpcomingEventExists(showID as string, showResponse)
    if showResponse <> invalid
        ?"jhjj"
        item = {}
        showDetails = []
        item.itemType = showResponse.type
        item.event_id = showResponse.event_id
        item.show_name = showResponse.event_name
        item.schedule_time = showResponse.schedule_time
        ' item.HDPOSTERURL = showResponse.thumbnail
        item.thumbnail = showResponse.thumbnail
        item.thumbnail_350_200 = showResponse.thumbnail_350_200
        item.synopsis = showResponse.description

        showDetails.push(item)
        ?"jjhj"
        return showDetails


    end if

end function





function getShowVODForIfSeasonNotExits(showID as string, showResponse)
    seasons = []
    videos = []
    video_index = 0
    ?showResponse
    ' ?"showResponse"
    ' ?showResponse
    try
        if showResponse <> invalid and showResponse.videos <> invalid and showResponse.videos.count() > 0

            showResponseCount = 1
            if showResponse.videos <> invalid and showResponse.videos.count() <> invalid
                showResponseCount = showResponse.videos.count()
            end if
            for seasonIndex = 0 to showResponseCount - 1

                item = {}
                item.user_id = showResponse.single_video
                item.show_id = showID
                item.isSingleVideo = showResponse.single_video
                item.video_id = showResponse.videos[seasonIndex].video_id
                item.premium_flag = showResponse.premium_flag
                item.free_video = showResponse.videos[seasonIndex].free_video
                item.is_free_video = showResponse.videos[seasonIndex].is_free_video
                item.watched_percentage = showResponse.videos[seasonIndex].watched_percentage

                item.watched_duration = showResponse.videos[seasonIndex].watched_duration

                item.ad_link = showResponse.ad_link
                item.channel_id = showResponse.videos[seasonIndex].channel_id
                if showResponse.videos[seasonIndex].video_duration <> invalid
                    item.video_duration = Str(showResponse.videos[seasonIndex].video_duration)
                else
                    item.video_duration = ""
                end if

                if showResponse.videos[seasonIndex].duration_text <> invalid
                    item.duration_text = showResponse.videos[seasonIndex].duration_text
                else
                    item.duration_text = ""
                end if

                if showResponse.videos[seasonIndex].checkout_qr <> invalid
                    item.checkout_qr = showResponse.videos[seasonIndex].checkout_qr
                else
                    item.checkout_qr = ""
                end if

                if showResponse.videos[seasonIndex].video_order <> invalid
                    item.video_order = showResponse.videos[seasonIndex].video_order
                else
                    item.video_order = ""
                end if

                if showResponse.videos[seasonIndex].season <> invalid
                    item.season = showResponse.videos[seasonIndex].season
                else
                    item.season = ""
                end if

                if showResponse.resolution <> invalid
                    item.resolution = showResponse.resolution
                else
                    item.resolution = ""
                end if

                if showResponse.synopsis <> invalid
                    item.synopsis = showResponse.synopsis
                else
                    item.synopsis = ""
                end if

                category = ""
                for j = 0 to showResponse.categories.count() - 1
                    if j = showResponse.categories.count() - 1
                        category = category + showResponse.categories[j].category_name
                    else
                        category = category + showResponse.categories[j].category_name + ","
                    end if
                end for

                item.TITLESEASON = category
                categoryid = ""
                for j = 0 to showResponse.categories.count() - 1
                    if j = showResponse.categories.count() - 1
                        categoryid = categoryid + Str(showResponse.categories[j].category_id).Trim()
                    else
                        categoryid = categoryid + Str(showResponse.categories[j].category_id).trim() + ","
                    end if
                end for

                ' if showResponse.videos[seasonIndex].subscriptions <> invalid and showResponse.videos[seasonIndex].subscriptions.count() > 0      'taking show level subscription for subscription tag
                if showResponse.subscriptions <> invalid and showResponse.subscriptions.count() > 0
                    subArraySub = []
                    for each subJson in showResponse.subscriptions
                        ?"vbnbnbn"
                        subItem = {}
                        subItem.subscription_text = subJson.subscription_text
                        subItem.price = subJson.price
                        subItem.subscription_id = subJson.subscription_id
                        subItem.subscription_name = subJson.subscription_name
                        subArraySub.push(subItem)
                    end for
                    ?subItem
                    ?subArraySub
                    ?"subbarya"
                    item.subscriptions = subArraySub
                else
                    item.subscriptions = invalid
                end if

                if showResponse.videos[seasonIndex].subtitles <> invalid and showResponse.videos[seasonIndex].subtitles.count() > 0
                    subArray = []
                    for each subJson in showResponse.videos[seasonIndex].subtitles
                        subItem = {}
                        subItem.Language = subJson.code
                        subItem.Description = subJson.language_name
                        subItem.TrackName = subJson.subtitle_url
                        subArray.push(subItem)
                    end for
                    item.subtitles = subArray
                else
                    item.subtitles = invalid
                end if

                item.categories_id = categoryid
                item.categories = showResponse.categories
                item.teaser = showResponse.teaser
                item.rateFlag = showResponse.user_rated
                item.userRating = showResponse.user_rating
                item.image_title = invalid
                item.year = showResponse.year
                if (showResponse.watchlist_flag <> invalid)
                    item.RELEASEDATE = Str(showResponse.watchlist_flag).Trim()
                else
                    item.RELEASEDATE = showResponse.watchlist_flag
                end if

                if (showResponse.rating <> invalid)
                    item.maturity_name = showResponse.rating.Trim()
                else
                    item.maturity_name = ""
                end if

                item.payper_flag = showResponse.videos[seasonIndex].payper_flag
                item.rental_flag = showResponse.videos[seasonIndex].rental_flag
                item.URL = showResponse.videos[seasonIndex].video_name
                item.STREAMFORMAT = "m3u8"
                item.TITLE = showResponse.videos[seasonIndex].video_title
                item.free_video = showResponse.videos[seasonIndex].free_video
                item.DESCRIPTION = showResponse.videos[seasonIndex].video_description
                item.is_locked = showResponse.videos[seasonIndex].is_locked
                item.our_take = showResponse.our_take
                item.checkout_qr = showResponse.checkout_qr


                if showResponse.producer <> invalid
                    item.producer = showResponse.producer
                else
                    item.producer = ""
                end if

                if showResponse.director <> invalid
                    item.director = showResponse.director
                else
                    item.director = ""
                end if

                if showResponse.show_cast <> invalid
                    item.show_cast = showResponse.show_cast
                else
                    item.show_cast = ""
                end if

                if showResponse.video_tags <> invalid
                    item.video_tags = showResponse.video_tags
                else
                    item.video_tags = invalid
                end if

                item.cast = showResponse.cast
                item.crew = showResponse.crew
                item.key_art_work = showResponse.key_art_work
                item.itemType = showResponse.type
                item.show_name = showResponse.show_name

                if showResponse.videos[seasonIndex].thumbnail_350_200 <> invalid
                    item.HDPOSTERURL = showResponse.videos[seasonIndex].thumbnail_350_200
                else if showResponse.logo_thumb <> invalid
                    item.HDPOSTERURL = showResponse.logo_thumb
                end if

                if showResponse.videos[seasonIndex].thumbnail <> invalid
                    item.HDPosterURLPortrait = showResponse.videos[seasonIndex].thumbnail
                else if showResponse.logo_thumb <> invalid
                    item.HDPosterURLPortrait = showResponse.logo_thumb
                end if
                videos.push(item)

            end for
            seasons.push(videos)
        end if
        return seasons
    catch e
        return seasons
    end try
end function

function getShowVODForIfSeasonsExists(showID, showResponse)
    seasons = []
    videos = []
    video_index = 0

    try

        for seasonIndex = 0 to showResponse.videos.count() - 1
            for i = 0 to showResponse.videos[seasonIndex].videos.count() - 1
                item = {}
                item.user_id = showResponse.single_video
                item.show_id = showID
                item.isSingleVideo = showResponse.single_video
                item.video_id = showResponse.videos[seasonIndex].videos[i].video_id
                item.premium_flag = showResponse.premium_flag
                item.free_video = showResponse.videos[seasonIndex].videos[i].free_video
                item.is_free_video = showResponse.videos[seasonIndex].videos[i].is_free_video
                item.watched_percentage = showResponse.videos[seasonIndex].videos[i].watched_percentage

                item.watched_duration = showResponse.videos[seasonIndex].videos[i].watched_duration

                item.ad_link = showResponse.ad_link
                item.channel_id = showResponse.videos[seasonIndex].videos[i].channel_id
                if showResponse.videos[seasonIndex].videos[i].video_duration <> invalid
                    item.video_duration = Str(showResponse.videos[seasonIndex].videos[i].video_duration)
                else
                    item.video_duration = ""
                end if

                if showResponse.videos[seasonIndex].videos[i].duration_text <> invalid
                    item.duration_text = showResponse.videos[seasonIndex].videos[i].duration_text
                else
                    item.duration_text = ""
                end if

                if showResponse.videos[seasonIndex].videos[i].resolution <> invalid
                    item.resolution = showResponse.videos[seasonIndex].videos[i].resolution
                else
                    item.resolution = ""
                end if

                if showResponse.videos[seasonIndex].videos[i].synopsis <> invalid
                    item.synopsis = showResponse.videos[seasonIndex].videos[i].synopsis
                else
                    item.synopsis = ""
                end if

                if showResponse.videos[seasonIndex].videos[i].checkout_qr <> invalid
                    item.checkout_qr = showResponse.videos[seasonIndex].videos[i].checkout_qr
                else
                    item.checkout_qr = ""
                end if

                category = ""
                for j = 0 to showResponse.categories.count() - 1
                    if j = showResponse.categories.count() - 1
                        category = category + showResponse.categories[j].category_name
                    else
                        category = category + showResponse.categories[j].category_name + ","
                    end if
                end for

                item.TITLESEASON = category
                categoryid = ""
                for j = 0 to showResponse.categories.count() - 1
                    if j = showResponse.categories.count() - 1
                        categoryid = categoryid + Str(showResponse.categories[j].category_id).Trim()
                    else
                        categoryid = categoryid + Str(showResponse.categories[j].category_id).trim() + ","
                    end if
                end for


                ' if showResponse.videos[seasonIndex].videos[i].subscriptions <> invalid and showResponse.videos[seasonIndex].videos[i].subscriptions.count() > 0  'taking show level subscription for subscription tag
                ' if showResponse.subscriptions <> invalid and showResponse.subscriptions.count() > 0
                '     subArraySub = []
                '     for each subJson in showResponse.subscriptions
                '         subItem = {}
                '         ?"rtrtrtr"
                '         subItem.subscription_name = subJson.subscription_name
                '         subItem.subscription_text = subJson.subscription_text
                '         subItem.price = subJson.price
                '         subItem.subscription_id = subJson.subscription_id
                '         subArraySub.push(subItem)
                '     end for
                '     item.subscriptions = subArraySub
                ' else
                '     item.subscriptions = invalid
                ' end if


                if showResponse.videos[seasonIndex].videos[i].subscriptions <> invalid and showResponse.videos[seasonIndex].videos[i].subscriptions.count() > 0
                    subArray = []
                    for each subJson in showResponse.videos[seasonIndex].videos[i].subscriptions
                        subItem = {}
                        subItem.subscription_name = subJson.subscription_name
                        subItem.subscription_text = subJson.subscription_text
                        subItem.price = subJson.price
                        subItem.subscription_id = subJson.subscription_id
                        subArray.push(subItem)
                    end for
                    item.subscriptions = subArray
                else
                    item.subscriptions = invalid
                end if



                if showResponse.videos[seasonIndex].videos[i].subtitles <> invalid and showResponse.videos[seasonIndex].videos[i].subtitles.count() > 0
                    subArray = []
                    for each subJson in showResponse.videos[seasonIndex].videos[i].subtitles
                        subItem = {}
                        subItem.Language = subJson.code
                        subItem.Description = subJson.language_name
                        subItem.TrackName = subJson.subtitle_url
                        subArray.push(subItem)
                    end for
                    item.subtitles = subArray
                else
                    item.subtitles = invalid
                end if

                item.categories_id = categoryid
                item.categories = showResponse.categories
                item.teaser = showResponse.teaser
                item.rateFlag = showResponse.user_rated
                item.userRating = showResponse.user_rating
                item.image_title = invalid
                item.year = showResponse.year
                if (showResponse.watchlist_flag <> invalid)
                    item.RELEASEDATE = Str(showResponse.watchlist_flag).Trim()
                else
                    item.RELEASEDATE = showResponse.watchlist_flag
                end if
                if (showResponse.rating <> invalid)
                    item.maturity_name = showResponse.rating.Trim()
                else
                    item.maturity_name = ""
                end if
                item.payper_flag = showResponse.videos[seasonIndex].videos[i].payper_flag
                item.rental_flag = showResponse.videos[seasonIndex].videos[i].rental_flag

                item.URL = showResponse.videos[seasonIndex].videos[i].video_name
                item.STREAMFORMAT = "m3u8"
                item.TITLE = showResponse.videos[seasonIndex].videos[i].video_title
                item.free_video = showResponse.videos[seasonIndex].videos[i].free_video
                item.DESCRIPTION = showResponse.videos[seasonIndex].videos[i].video_description
                item.our_take = showResponse.our_take
                item.thumbnail = showResponse.videos[seasonIndex].videos[i].thumbnail
                item.HDPOSTERURL = showResponse.videos[seasonIndex].videos[i].hdposterurl
                item.is_locked = showResponse.videos[seasonIndex].videos[i].is_locked

                if showResponse.producer <> invalid
                    item.producer = showResponse.producer
                else
                    item.producer = ""
                end if

                if showResponse.director <> invalid
                    item.director = showResponse.director
                else
                    item.director = ""
                end if

                if showResponse.show_cast <> invalid
                    item.show_cast = showResponse.show_cast
                else
                    item.show_cast = ""
                end if

                if showResponse.video_tags <> invalid
                    item.video_tags = showResponse.video_tags
                else
                    item.video_tags = invalid
                end if

                item.cast = showResponse.cast
                item.crew = showResponse.crew
                item.key_art_work = showResponse.key_art_work
                item.itemType = showResponse.type
                item.show_name = showResponse.show_name


                if showResponse.videos[seasonIndex].videos[i].thumbnail_350_200 <> invalid
                    item.HDPOSTERURL = showResponse.videos[seasonIndex].videos[i].thumbnail_350_200
                else
                    item.HDPOSTERURL = showResponse.logo_thumb
                end if

                if showResponse.videos[seasonIndex].videos[i].thumbnail <> invalid
                    item.HDPosterURLPortrait = showResponse.videos[seasonIndex].videos[i].thumbnail
                else
                    item.HDPosterURLPortrait = showResponse.logo_thumb
                end if

                if showResponse.videos[seasonIndex].videos[i].video_order <> invalid
                    item.video_order = showResponse.videos[seasonIndex].videos[i].video_order
                else
                    item.video_order = ""
                end if

                if showResponse.videos[seasonIndex].videos[i].season <> invalid
                    item.season = showResponse.videos[seasonIndex].videos[i].season
                else
                    item.season = ""
                end if

                if showResponse.videos[seasonIndex] <> invalid
                    item.season_name = showResponse.videos[seasonIndex].season
                else
                    item.season_name = ""
                end if


                videos.push(item)
            end for
            seasons.push(videos) 'adding videos to seasons
            videos = []
        end for

        return seasons
    catch e
        return seasons
    end try
end function

' function GetShowVODForUpComingEvents(showID as string, showResponse)

' end function

function getShowVODForIfSeasonsAndEpisodeNotExists(showID, showResponse)
    videos = []

    for each video in showResponse.videos
        item = {} ' Create an object for each video

        ' Extract video properties correctly from the "video" object
        item.channel_id = video.channel_id
        item.duration_text = video.duration_text
        item.free_video = video.free_video
        item.hide_subscription = video.hide_subscription
        item.is_free_video = video.is_free_video
        item.is_locked = video.is_locked
        item.watched_percentage = video.watched_percentage
        item.thumbnail_350_200 = video.thumbnail_350_200
        item.thumbnail = video.thumbnail
        item.video_description = video.video_description
        item.video_id = video.video_id
        item.video_name = video.video_name
        item.video_title = video.video_title
        item.watchlist_flag = video.watchlist_flag
        item.watched_duration = video.watched_duration
        item.checkout_qr = video.checkout_qr

        ' Check if subscriptions exist for this video
        subArraySub = [] ' Initialize an array for subscriptions

        if video.subscriptions <> invalid and video.subscriptions.count() > 0
            for each subJson in video.subscriptions
                subArraySub.push(subJson.subscription_id)
            end for
        end if

        item.subscriptions = subArraySub ' Store subscription IDs in item

        videos.push(item) ' Add the processed video object to the videos array
    end for
    return videos
    ' for each video in showResponse.videos
    '     videos=[]
    '     item = {}
    '     item.channel_id = showResponse.channel_id
    '     item.duration_text = showResponse.duration_text
    '     item.free_video = showResponse.free_video
    '     item.hide_subscription = showResponse.hide_subscription
    '     item.is_free_video = showResponse.is_free_video
    '     item.is_locked = showResponse.is_locked
    '     item.is_free_video = showResponse.is_free_video
    '     item.watched_percentage = showResponse.watched_percentage
    '     item.thumbnail_350_200 = showResponse.thumbnail_350_200
    '     item.thumbnail = showResponse.thumbnail
    '     item.video_description =  showResponse.video_description
    '     item.video_id = showResponse.video_id
    '     item.video_name = showResponse.video_name
    '     item.watched_percentage = showResponse.watched_percentage

    '         '      for each subJson in showResponse.videos.subscriptions
    '         '          subItem = {}
    '         '          ?"rtrtrtr"
    '         '          subItem.subscription_name = subJson.subscription_name
    '         '          subItem.subscription_text = subJson.subscription_text
    '         '          subItem.price = subJson.price
    '         '          subItem.subscription_id = subJson.subscription_id
    '         '          subArraySub.push(subItem)
    '         '      end for
    '         '      item.subscriptions = subArraySub
    '         '  else
    '         '      item.subscriptions = invalid
    '         '  end if
    '         for each video in showResponse.videos
    '             if video.subscriptions <> invalid and video.subscriptions.count() > 0
    '                 for each subJson in video.subscriptions
    '                     subArraySub.push(subJson.subscription_id)
    '                 end for
    '             end if
    '         end for
    '     end if
    '          item.watchlist_flag = showResponse.watchlist_flag
    '          item.video_title = showResponse.video_title
    '          item.watched_duration = showResponse.watched_duration
    '          item.watched_percentage = video.watched_percentage


    '          videos.push(item)

    ' end for


end function




function getShowResponseForUpcomingEventIfSeasonsAvailable(showId, showResponse)
    ?"fgfgfg"
    seasons = []
    videos = []
    item = {}
    item.itemType = showResponse.type
    item.type = showResponse.type
    item.event_id = showResponse.event_id
    item.show_name = showResponse.event_name
    item.day = showResponse.day
    item.schedule_time = showResponse.schedule_time
    item.duration = showResponse.schedule_time
    item.resolution = showResponse.schedule_time
    item.HDPOSTERURL = showResponse.thumbnail
    item.logo = showResponse.thumbnail
    item.logo_thumb = showResponse.thumbnail_350_200
    item.synopsis = showResponse.description
    item.day = showResponse.day
    item.subscriptions = showResponse.subscriptions
    videos.push(item)
    seasons.push(videos) 'adding videos to seasons
    videos = []

    return seasons
end function

function getShowResponseForOngoingEventIfSeasonsAvailable(showId, showResponse)
    seasons = []
    videos = []
    item = {}
    item.itemType = showResponse.type
    item.type = showResponse.type
    item.event_id = showResponse.event_id
    item.show_name = showResponse.event_name
    item.day = showResponse.day
    item.schedule_time = showResponse.schedule_time
    item.duration = showResponse.duration
    item.logo_thumb = showResponse.thumbnail
    item.synopsis = showResponse.synopsis
    item.day = showResponse.day
    item.schedule_time = showResponse.schedule_time
    item.subscriptions = showResponse.subscriptions
    item.live_url = showResponse.live_url
    item.description = showResponse.description
    videos.push(item)
    seasons.push(videos) 'adding videos to seasons
    videos = []
    ?"jhjj"
    return seasons
end function

' function ParseCHContent(list as object)
'     RowItems = CreateObject("RoSGNode", "ContentNode")
'     for each rowAA in list
'         ' for index = 0 to 1
'         row = CreateObject("RoSGNode", "ContentNode")
'         row.Title = rowAA.Title
'         for each itemAA in rowAA.ContentList
'             item = CreateObject("RoSGNode", "ContentNode")
'             item.addFields({ "user_id": "1", "ad_pod_url": itemAA.ad_pod_url, "video_id": itemAA.video_id, "ad_link": itemAA.ad_link, "premium_flag": "1", "channel_id": itemAA.channel_id, "video_duration": itemAA.video_duration })
'             item.SetFields(itemAA)
'             row.appendChild(item)
'         end for
'         RowItems.appendChild(row)
'     end for
'     return RowItems
' end function

' function ParseVODContent(list as object)
'     Parent = CreateObject("RoSGNode", "ContentNode")
'     for i = 0 to list.count() step 4
'         row = CreateObject("RoSGNode", "ContentNode")
'         for j = i to i + 2
'             if list[j] <> invalid
'                 item = CreateObject("RoSGNode", "ContentNode")
'                 item.addFields({ "user_id": "1", "video_id": list[j].video_id, "ad_link": list[j].ad_link, "channel_id": list[j].channel_id, "premium_flag": list[j].premium_flag, "video_duration": list[j].video_duration })
'                 item.SetFields(list[j])
'                 item.STREAMFORMAT = "m3u8"
'                 row.appendChild(item)
'             end if
'         end for
'         Parent.appendChild(row)
'     end for
'     return Parent
' end function



function ParseSelVod(list as object)
    Parent = CreateObject("RoSGNode", "ContentNode")
    for i = 0 to list.count() step 4
        row = CreateObject("RoSGNode", "ContentNode")
        for j = i to i + 2
            if list[j] <> invalid
                item = CreateObject("RoSGNode", "ContentNode")
                item.addFields({ "user_id": "1", "video_id": list[j].video_id, "ad_link": list[j].ad_link, "channel_id": list[j].channel_id, "premium_flag": list[j].premium_flag, "video_duration": list[j].video_duration, "video_title": list[j].video_title, "video_description": list[j].video_description, "year": list[j].year, "parental_control": list[j].parental_control, "resolution": list[j].resolution, "trailer": list[j].trailer, "producer": list[j].producer })
                item.SetFields(list[j])
                item.STREAMFORMAT = "m3u8"
                row.appendChild(item)
            end if
        end for
        Parent.appendChild(row)
    end for
    return Parent
end function



' function regUSER()
'     di = CreateObject("roDeviceInfo")
'     UUID = di.GetChannelClientId()
'     post = {
'         device_id: UUID
'     }

'     http = CreateObject("roUrlTransfer")
'     http.RetainBodyOnError(true)
'     messagePort = CreateObject("roMessagePort")
'     http.SetPort(messagePort)
'     http.setCertificatesFile("common:/certs/ca-bundle.crt")
'     http.InitClientCertificates()
'     http.AddHeader("Content-Type", "application/json")
'     http.AddHeader("Accept", "application/json")
'     http.SetUrl("https://poppo.tv/platform/bk/GuestRegister")
'     postJSON = FormatJson(post)
'     ? postJSON

'     response = ""
'     lastresponsecode = ""
'     lastresponsefailurereason = ""
'     responseheaders = []
'     if http.AsyncPostFromString(postJSON) then
'         event = Wait(10000, http.GetPort())
'         if Type(event) = "roUrlEvent" then
'             response = event.getString()
'             responseheaders = event.GetResponseHeaders()
'             lastresponsecode = event.GetResponseCode()
'             lastresponsefailurereason = event.GetFailureReason()
'         else if event = invalid then
'             http.asynccancel()
'             lastresponsefailurereason = "HTTP timed out. Configured Timeout: 10s"
'             lastresponsecode = 0
'         else
'             ? "AsyncPostFromString unknown event"
'         end if
'     end if

'     ? "Response Headers: "; responseheaders
'     ? "Response Code: "; lastresponsecode
'     ? "Failure Reason: "; lastresponsefailurereason
'     ? "Response: "; response
' end function

function getTokenPlayer()
    url = CreateObject("roUrlTransfer")
    url.SetUrl("https://poppo.tv/proxy/api/GenerateToken")
    url.AddHeader("access-token", getAuthorisationToken())
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    rsp = url.GetToString()
    responseJSON = ParseJson(rsp)
    token = responseJSON.data
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("tokplayy", token)
    sec.Flush()
    return token
end function

function callAccessTokenAPI()
    params = {}
    data = {}
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("usersubID")
        tok = sec.Read("usersubID")
        params.AddReplace("uid", tok)
    else
        params.AddReplace("uid", getUserIdana())
    end if
    params.AddReplace("app_bundle_id", getBundleID())
    params.AddReplace("app_key", getAppKey())
    url = getBaseApiURL() + "account/authenticate"
    response = MakeRequestNoAuthToken(url, params)
    if response <> invalid
        token = response.token

        if token <> invalid
            SetToken(token)
        end if

        if response.application_id <> invalid
            data = Str(response.application_id).Trim()
        end if
        if response.language_id <> invalid
            language = Str(response.language_id).Trim()
        else
        end if

        if response.user_coins <> invalid
            if response.user_coins.current_balance <> invalid
                setCurrentCoinBalance(response.user_coins.current_balance.ToStr())
            end if
            if response.user_coins.token_symbol <> invalid
                setTokenSymbol(response.user_coins.token_symbol)
            end if
        end if

        m.global.langauge_id = response.language_id

        if response.user_language <> invalid and response.user_language.short_code <> invalid
            m.global.short_code = response.user_language.short_code
            sec = CreateObject("roRegistrySection", getAppKey())
            sec.Write("LANGUAGE_CODE_SELECTED", m.global.short_code)
            sec.Flush()
        end if

        if data <> invalid
            SetappID(data)
        end if
        return token
    else
        return invalid
    end if
end function

function SetToken(token as string) as void
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("Token", token)
    sec.Flush()
end function


function getAuthTokenAPIPlayerDeep()
    params = {}
    data = {}
    params.AddReplace("uid", getUserIdana())
    params.AddReplace("app_bundle_id", getBundleID())
    params.AddReplace("app_key", getAppKey())
    url = getBaseApiURL() + "account/authenticate"
    response = MakeRequestNoAuthToken(url, params)
    if response <> invalid
        if response.user_coins <> invalid
            if response.user_coins.current_balance <> invalid
                setCurrentCoinBalance(response.user_coins.current_balance.ToStr())
            end if
            if response.user_coins.token_symbol <> invalid
                setTokenSymbol(response.user_coins.token_symbol)
            end if
        end if
        token = response.token
        return token
    else
        return invalid
    end if
end function



function getBundleID() as object
    return m.global.BUNDLE_ID
end function

function getAppKey() as object
    ' ?m.global.APP_KEY
    ' ?"mglobalkey"

    return m.global.APP_KEY
end function



function ParseContent(list as object)
    RowItems = CreateObject("RoSGNode", "ContentNode")

    for each rowAA in list
        row = CreateObject("RoSGNode", "ContentNode")
        row.Title = rowAA.Title

        for each itemAA in rowAA.ContentList
            row.Title = "Videos"
            item = CreateObject("RoSGNode", "ContentNode")
            item.addFields({ "user_id": "1", "video_id": itemAA.video_id, "show_name": itemAA.show_name, "ad_link": itemAA.ad_link, "URL": itemAA.URL,
                "channel_id": itemAA.channel_id, "premium_flag": itemAA.premium_flag,
                "video_duration": itemAA.video_duration, "duration_text": itemAA.duration_text, "teaser": itemAA.teaser, "maturity_name": itemAA.maturity_name,
                "image_title": itemAA.image_title, "year": itemAA.year, "director": itemAA.director,
                "payper_flag": itemAA.payper_flag, "rental_flag": itemAA.rental_flag, "free_video": itemAA.free_video,
                "watched_duration": itemAA.watched_duration, "producer": itemAA.producer,
                "show_cast": itemAA.show_cast, "show_id": itemAA.show_id,
                "categories_id": itemAA.categories_id, "rateFlag": itemAA.rateFlag,
                "userRating": itemAA.userRating, "subtitles": itemAA.subtitles, "our_take": itemAA.our_take, "cast": itemAA.cast, "HDPOSTERURL": itemAA.logo_thumb,
                "DESCRIPTION": itemAA.synopsis, "day": itemAA.day, "schedule_time": itemAA.schedule_time
                "itemType": itemAA.itemType, "sub_Title": itemAA.role, "free_video": itemAA.free_video, "watched_percentage": itemAA.watched_percentage })
            item.SetFields(itemAA)
            row.appendChild(item)
        end for
        RowItems.appendChild(row) 'setting videos row
    end for
    return RowItems
end function


function ParseContentForSeasonWiseShowContentTest(list as object)
    RowItems = CreateObject("RoSGNode", "ContentNode")
    seasonsCount = 0

    for each episodes in list.videos
        row = CreateObject("RoSGNode", "ContentNode")

        for each seasonWiseRowItem in episodes
            seasonsCount++
            seasonWiseRow = CreateObject("RoSGNode", "ContentNode")
            seasonWiseRow.Title = "Season " + Str(seasonsCount)

            for each itemAA in seasonWiseRowItem
                item = CreateObject("RoSGNode", "ContentNode")
                item.addFields({ "user_id": "1", "video_id": itemAA.video_id, "ad_link": itemAA.ad_link,
                    "channel_id": itemAA.channel_id, "premium_flag": itemAA.premium_flag,
                    "video_duration": itemAA.video_duration, "duration_text": itemAA.duration_text, "teaser": itemAA.teaser, "maturity_name": itemAA.maturity_name,
                    "image_title": itemAA.image_title, "year": itemAA.year, "director": itemAA.director,
                    "payper_flag": itemAA.payper_flag, "rental_flag": itemAA.rental_flag, "free_video": itemAA.free_video,
                    "watched_duration": itemAA.watched_duration, "producer": itemAA.producer,
                    "show_cast": itemAA.show_cast, "show_id": itemAA.show_id,
                    "categories_id": itemAA.categories_id, "rateFlag": itemAA.rateFlag,
                    "userRating": itemAA.userRating, "subtitles": itemAA.subtitles, "our_take": itemAA.our_take, "cast": itemAA.cast,
                    "itemType": "videos", "sub_Title": itemAA.role, "free_video": itemAA.free_video, "watched_percentage": itemAA.watched_percentage, "HDPOSTERURL": itemAA.logo_thumb,
                    "DESCRIPTION": itemAA.synopsis, "day": itemAA.day, "schedule_time": itemAA.schedule_time, "URL": itemAA.URL, })
                item.SetFields(itemAA)
                seasonWiseRow.appendChild(item)
            end for
            RowItems.appendChild(seasonWiseRow)
        end for
        ' RowItems.appendChild(row)
    end for

    return RowItems
end function



function ParseContent2(list as object)
    RowItems = CreateObject("RoSGNode", "ContentNode")

    for each rowAA in list
        contentList = rowAA.ContentList
        itemsPerRow = 4
        totalItems = contentList.count()

        for i = 0 to totalItems - 1 step itemsPerRow
            row = CreateObject("RoSGNode", "ContentNode")
            if i = 0
                row.Title = "Videos"
            end if

            for j = i to i + itemsPerRow - 1
                if j >= totalItems
                    exit for
                end if

                itemAA = contentList[j]
                item = CreateObject("RoSGNode", "ContentNode")
                item.addFields({
                    "user_id": "1",
                    "video_id": itemAA.video_id,
                    "ad_link": itemAA.ad_link,
                    "channel_id": itemAA.channel_id,
                    "premium_flag": itemAA.premium_flag,
                    "video_duration": itemAA.video_duration,
                    "teaser": itemAA.teaser,
                    "maturity_name": itemAA.maturity_name,
                    "image_title": itemAA.image_title,
                    "year": itemAA.year,
                    "director": itemAA.director,
                    "payper_flag": itemAA.payper_flag,
                    "rental_flag": itemAA.rental_flag,
                    "free_video": itemAA.free_video,
                    "watched_duration": itemAA.watched_duration,
                    "producer": itemAA.producer,
                    "show_cast": itemAA.show_cast,
                    "show_id": itemAA.show_id,
                    "categories_id": itemAA.categories_id,
                    "rateFlag": itemAA.rateFlag,
                    "resolution": itemAA.resolution,
                    "userRating": itemAA.userRating,
                    "subtitles": itemAA.subtitles,
                    "our_take": itemAA.our_take,
                    "cast": itemAA.cast,
                    "itemType": "SHOW",
                    "sub_Title": itemAA.role,
                    "is_free_video": itemAA.is_free_video,
                    "watched_percentage": itemAA.watched_percentage,
                    "single_video": itemAA.single_video,
                    "synopsis": itemAA.synopsis,
                    "thumbnail": itemAA.thumbnail,
                    "HDPOSTERURL": itemAA.hdposterurl,
                    "HDPosterURLPortrait": itemAA.hdBackgroundImageUrl,
                    "is_locked": itemAA.is_locked
                })

                item.SetFields(itemAA)
                row.appendChild(item)
            end for

            RowItems.appendChild(row)
        end for
    end for

    return RowItems

end function


function parseSimilarShows(list as object)
    RowItems = CreateObject("RoSGNode", "ContentNode")


    RowItems.Title = getText("you_may_also_like")' Use the backend title as fallback

    BaseNode = CreateObject("RoSGNode", "ContentNode")
    for each itemAA in list
        item = CreateObject("RoSGNODE", "ContentNode")
        ' if itemAA.DoesExist("ai_type") and itemAA.ai_type <> invalid
        '     item.addFields({
        '         "ai_type": itemAA.ai_type
        '     })
        ' else
        '     item.addFields({
        '         "ai_type": ""
        '     })
        ' end if
        item.addFields({
            "ai_type": itemAA.ai_type
            "show_id": itemAA.show_id,
            "vanity_url": itemAA.vanity_url,
            "director": itemAA.director,
            "synopsis": itemAA.synopsis,
            "show_name": itemAA.show_name,
            "HDPosterURL": itemAA.logo,
            "rating": itemAA.rating,
            "HDPosterURL": itemAA.logo_thumb,
            "HDPosterURLPortrait": itemAA.logo,
            "video_duration": itemAA.video_duration,
            "category_names": itemAA.category_names,
            "year": itemAA.year,
            "watchlist_flag": itemAA.watchlist_flag,
            "producer": itemAA.producer,
            "teaser": itemAA.teaser,
            "duration_text": itemAA.duration_text,
            "is_free_video": itemAA.is_free_video,
            "itemType": "shows",
            "rental_flag": itemAA.rental_flag,
            "payper_flag": itemAA.payper_flag,
            "isthisSimilarvideos": true
        })
        RowItems.appendChild(item)
    end for

    BaseNode.appendChild(RowItems)
    return BaseNode
end function



function getappId() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("appid")
        tok = sec.Read("appid")
        return tok
    else
        return ""
    end if
    return invalid
end function

function SetappID(data)
    if data <> invalid and type(data) <> "roAssociativeArray"
        sec = CreateObject("roRegistrySection", getAppKey())
        try
            sec.Write("appid", data)
            sec.Flush()
        catch e
            ?"Error writing appid: "; e.Message
        end try
    end if
end function


function getsess() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("session")
        sess = ses.Read("session")
        return sess
    else
        setSessionId1()
    end if
end function


sub setSessionId1()
    di = CreateObject("roDeviceInfo")
    deviceid = di.GetChannelClientId()
    dt = CreateObject ("roDateTime")
    sessioniddevice = dt.AsSeconds().ToStr()
    ?"sessionId created"; sessioniddevice + deviceid
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("session", sessioniddevice + deviceid)
    sec.Flush()
end sub



function Setcount()
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("count", "0")
    sec.Flush()
end function

'create get and set for CURRENT_COIN_BALANCE string
function getCurrentCoinBalance() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("CURRENT_COIN_BALANCE")
        value = ses.Read("CURRENT_COIN_BALANCE")
        return value
    else
        return "0"
    end if
end function

function setCurrentCoinBalance(currentCoinBalanceValue as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("CURRENT_COIN_BALANCE", currentCoinBalanceValue)
    sec.Flush()
end function

function setTokenSymbol(tokenSymbol as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("TOKEN_SYMBOL", tokenSymbol)
    sec.Flush()
end function

function getTokenSymbol() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("TOKEN_SYMBOL")
        value = ses.Read("TOKEN_SYMBOL")
        return value
    else
        return ""
    end if
end function


' function SetUphone(phone as string)
'     sec = CreateObject("roRegistrySection", getAppKey())
'     sec.Write("userPhone", phone)
'     sec.Flush()
' end function


function callMultiLanguageListApiTask()
    url = getBaseApiURL2() + "language/list"
    response = MakeGetRequest(url)
    if response <> invalid
        return response
    else
        return invalid
    end if

end function

function callMultiLanguageUserUpdateApiTask(language_id)
    url = getBaseApiURL() + "user/language/update"
    post = {
        "language_id": language_id.ToStr()
    }

    response = MakePostRequest(url, post)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function



function callHomeListApiTaskApi(homeType as string)
    if homeType <> invalid and homeType <> "" and homeType <> "LOAD_HOME" and homeType <> "home" and homeType <> "Home" and homeType <> "searchIcon"
        url = getBaseApiURL2() + "smarthome/" + homeType
    else
        url = getBaseApiURL2() + "home"
    end if

    response = MakeGetRequest(url)
    getTokenPlayer()
    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function callSimilarShowsApiTask(show_id as string)
    url = getBaseApiURL2() + "show/similar/" + show_id
    response = MakeGetRequest(url)
    if response <> invalid
        return response
    else
        return invalid
    end if
end function



function callTimeGridApiTask()
    registry = CreateObject("roRegistrySection", getAppKey())
    if registry.Exists("timezone")
        timezone = registry.Read("timezone")
    else
        timezone = ""
    end if
    url = getBaseApiURL() + "schedule/fastchannels" + "?timezone=" + timezone

    response = MakeGetRequest(url)

    if response <> invalid
        return response
    else
        return invalid
    end if
end function







function callLazyLoadingSubCategoryouritesApi(categoryId, offsetCount)
    ' url = "https://staging.poppo.tv/test/api/category/" + categoryId.ToStr() + "/shows/list?offset=" + offsetCount.ToStr()
    url = getBaseApiURL() + "category/" + categoryId.ToStr() + "/shows/list?offset=" + offsetCount.ToStr()

    ?"jkkk"
    response = MakeGetRequest(url)

    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function callLazyLoadingCategoryouritesApi(offsetCount)
    url = getBaseApiURL() + "show/home?offset=" + offsetCount.ToStr()


    response = MakeGetRequest(url)

    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function getSearchSuggestions(key)
    SpaceReplacedKey = key.replace(" ", "%20")
    url = getBaseApiURL() + "search/suggestions?key=" + SpaceReplacedKey.ToStr()


    response = MakeGetRequest(url)

    if response <> invalid
        return response
    else
        return invalid
    end if
end function

' Podcast
function callPodCastApi()
    url = getBaseApiURL() + "podcast/list?pubid=" + getPubID() + "&channelid=" + getchannelsid()

    response = MakeGetRequest(url)

    if response <> invalid
        return response
    else
        return invalid
    end if
end function

function callCommentsFetcherAPI(videoId)
    url = getBaseApiURL2() + "video/" + videoId.ToStr() + "/comments"

    response = MakeGetRequest(url)

    if response <> invalid
        return response
    else
        return invalid
    end if
end function




' function returnVideoIDOrEventid(is_live, ID)
'     if is_live = 0
'         return
'     else if is_live = 1
'     end if
' end function

function returnvideoIdOrEventIdTitle(request, is_live, ID)
    if is_live = 0
        return "video_id"
    else if is_live = 1
        return "event_id"
    end if
end function

function callCompletedApi(params)
    url = getBaseApiURL() + "calendar/video/complete"
    post = {
        "calendar_id": params.calendarId,
        "completed": params.completed
    }

    response = MakePostRequest(url, post)
    if response <> invalid and response.success <> invalid
        return response.success
    else
        return invalid
    end if
end function


function callLikeDislikeApi(params)
    if params.action = invalid or params.showid = invalid then return invalid

    base = getBaseApiURL()
    actionMap = {
        "LIKE_CLICKED": "like/show/",
        "LIKE_UNCLICKED": "like/show/",
        "DISLIKE_CLICKED": "dislike/show/",
        "DISLIKE_UNCLICKED": "dislike/show/"
    }

    flagMap = {
        "LIKE_CLICKED": "1",
        "LIKE_UNCLICKED": "0",
        "DISLIKE_CLICKED": "1",
        "DISLIKE_UNCLICKED": "0"
    }

    if actionMap.doesExist(params.action)
        url = base + actionMap[params.action] + params.showid + "/" + flagMap[params.action]
        response = MakeGetRequest(url)
        if response <> invalid and response.data <> invalid and response.data.success = true
            return {
                success: true,
                action: params.action
            }
        end if
    end if

    return {
        success: false,
        action: params.action
    }

end function



'****************************Base URL*****************************
'***********************************************************************

function getBaseApiURL()
    return "https://api.gizmott.com/api/v1/" 'LIVE
    ' return "https://api.gizmott.com/frontend/api" 'LIVE
    ' return "https://staging.poppo.tv/test/api/"        'STAGING
    ' return "https://api.gizmott.com/test/v2/"    'test api
    ' return "https://api.gizmott.com/test"    'test api
    ' return "https://dev.gizmott.com/ruksana-dev/v2/" 'dev api
    ' return "https://sandbox.gizmott.com/api/v1/"
end function

function getBaseApiURL2()
    return "https://api.gizmott.com/api/v2/" 'LIVE
    ' return "https://api.gizmott.com/frontend/" 'LIVE
    ' return "https://staging.poppo.tv/test/api/"        'STAGING
    ' return "https://dev.gizmott.com/ruksana-dev/v2/" 'dev api
    ' return "https://sandbox.gizmott.com/api/v2/"
end function

function getTestApi()
    return "https://api.gizmott.com/test/v2/" 'test api
    ' return "https://dev.gizmott.com/ruksana-dev/v2/" 'dev api
end function





' *****************************PubID*****************
function getPubID() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("PubID")
        pub_id = ses.Read("PubID")
        return pub_id
    else
        return ""
    end if
end function

function setPubID(pubid as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("PubID", pubid)
    sec.Flush()
end function

function getWebsiteURL() as string
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("WEBSITE_URL")
        return sec.Read("WEBSITE_URL")
    else
        return ""
    end if
end function

'*******************Channel Id***********************************
function getchannelsid() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("channelsids")
        ChannelId = sec.Read("channelsids")
        return ChannelId
    else
        return ""
    end if
end function

function SetChannelId(channel_id as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("channelsids", channel_id)
    sec.Flush()
end function

' ****************************userid**********************************


'********************************country Code*********************
function getCountrycode() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("countrycode")
        countryCode = sec.Read("countrycode")
        return countryCode
    else
        return ""
    end if
end function

function SetCountryCode(Country_Code as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("countrycode", Country_Code)
    sec.Flush()
end function

' ******************************IP Addresses***************************
function getIp() as object
    ip = CreateObject("roRegistrySection", getAppKey())
    if ip.Exists("ippaddress")
        ipp = ip.Read("ippaddress")
        return ipp
    else
        return ""
    end if
end function

function setIp(ip_address as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("ippaddress", ip_address)
    sec.Flush()
end function

' ***************************language******************
function getLanguage() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("LANGUAGE")
        language = sec.Read("LANGUAGE")
        return language
    else
        return "ENGLISH"
    end if
end function

function setLanguage(lang_uage as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("LANGUAGE", "lang_uage")
    sec.Flush()
end function

' ****************************userName*************************
function getUserName() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("userName")
        user_name = ses.Read("userName")
        return user_name
    else
        return ""
    end if
end function

function SetUerName(username as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("userName", username)
    sec.Flush()
end function

' *****************************Country*************
function getCountry() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("country")
        CounTry = sec.Read("country")
        return CounTry
    else
        return ""
    end if
end function

function setCountry(coun_try as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("country", coun_try)
    sec.Flush()
end function


' *****************City*************************
function getCity() as object
    city = CreateObject("roRegistrySection", getAppKey())
    if city.Exists("city")
        cit = city.Read("city")
        return cit
    else
        return ""
    end if
end function

function setCity(ci_ty as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("city", ci_ty)
    sec.Flush()
end function
' ************************************Latitude**************************
function getLatitude() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("latitude")
        LatiTude = ses.Read("latitude")
        return LatiTude
    else
        return ""
    end if
end function

function setLatitude(Lati_tude as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("latitude", Lati_tude)
    sec.Flush()
end function

' *********************Longitude*************************
function getLongitude() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("longitude")
        Longitude = ses.Read("longitude")
        return Longitude
    else
        return ""
    end if
end function

function setLongitude(longi_tude as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("longitude", longi_tude)
    sec.Flush()
end function
' ***********************User PhoneNumber*****************
function getUserPhoneNumber() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("userPhone")
        userPhone = ses.Read("userPhone")
        return userPhone
    else
        return ""
    end if
end function

function SetUserPhoneNumber(phone as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("userPhone", phone)
    sec.Flush()
end function
' ****************************UserEmail*************************
function getUserEmail() as object
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("userEmail")
        user_email = ses.Read("userEmail")
        return user_email
    else
        return ""
    end if
end function

function SetUseremail(useremail as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("userEmail", useremail)
    sec.Flush()
end function

' ********************************Channel Name********************************
function getchannelname() as object
    sec = CreateObject("roRegistrySection", getAppKey())
    if sec.Exists("channelNAME")
        channel_name = sec.Read("channelNAME")
        return channel_name
    else
        return ""
    end if
end function

function setChannelName(ChannelName as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("channelNAME", ChannelName)
    sec.Flush()
end function

function getRegion() as object
    region = CreateObject("roRegistrySection", getAppKey())
    if region.Exists("region")
        reg = region.Read("region")
        return reg
    else
        return ""
    end if
end function

function setRegion(REGION as object)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("region", REGION)
    sec.Flush()
end function

function getIsp() as object
    isp = CreateObject("roRegistrySection", getAppKey())
    if isp.Exists("isp")
        output = isp.Read("isp")
        return output
    else
        return ""
    end if
end function

function getFastChannelId() as string
    data = CreateObject("roRegistrySection", getAppKey())
    if data.Exists("FAST_CHANNEL_ID")
        output = data.Read("FAST_CHANNEL_ID")
        return output
    else
        return "0"
    end if
end function

function getSignInMessage() as object
    data = CreateObject("roRegistrySection", getAppKey())
    if data.Exists("SIGN_IN_MESSAGE")
        output = data.Read("SIGN_IN_MESSAGE")
        return output
    else
        return ""
    end if
end function


function getAppKey3() as object
    return m.global.APP_KEY
end function

function getIsSubscriptionRequiredInRoku() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("ROKU_SUBSCRIPTION_REQUIRED")
        ROKU_SUBSCRIPTION_REQUIRED = ses.Read("ROKU_SUBSCRIPTION_REQUIRED")
        return ROKU_SUBSCRIPTION_REQUIRED
    else
        return "true"
    end if
end function

function getBackGroundColor() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("THEME")
        THEME = ses.Read("THEME")
        if THEME = "LIGHT"
            return "#FFFFFF" 'white background for light theme //FFFDF6
        else
            return "#000000" 'black background for dark theme '32393d '#1c1f21
        end if
    else
        return "#000000"
    end if
end function

function getTheme() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("THEME")
        THEME = ses.Read("THEME")
        return THEME
    else
        return "DARK"
    end if
end function


function getLanguageCodeSelected4() as string
    ses = CreateObject("roRegistrySection", getAppKey3())
    if ses.Exists("LANGUAGE_CODE_SELECTED")
        value = ses.Read("LANGUAGE_CODE_SELECTED")
        return value
    else
        return "en"
    end if
end function

function getLanguageCodeSelectedForSelectionMenu() as string
    ses = CreateObject("roRegistrySection", getAppKey3())
    if ses.Exists("LANGUAGE_CODE_SELECTED")
        value = ses.Read("LANGUAGE_CODE_SELECTED")
        return value
    end if
end function

sub setLanguageCodeSelected(lang_code as string)
    sec = CreateObject("roRegistrySection", getAppKey3())
    sec.Write("LANGUAGE_CODE_SELECTED", lang_code)
    sec.Flush()
end sub

' function GetLanguageKeywordsAsObject(response)
'     ' Create the main storage associative array
'     storedData = CreateObject("roAssociativeArray")

'     ' Iterate through all keywords and their translations in the response
'     for each keywordKey in response
'         translation = response[keywordKey]

'         ' Create an associative array for the translations of this keyword
'         translations = CreateObject("roAssociativeArray")

'         for each langKey in translation
'             ' Add each language and its translation to the translations array
'             translations[langKey] = translation[langKey]
'         end for

'         ' Add the translations array to the main storage under the keyword key
'         storedData[keywordKey] = translations
'     end for

'     ' Return the structured data
'     return storedData
'     ?"k"
' end function





function makeRequestThatReturnsTheResponseAsItAs(src as string, params as object) as object
    request = CreateObject("roUrlTransfer")
    request.RetainBodyOnError(true)
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    di = CreateObject("roDeviceInfo")
    appInfo = CreateObject("roAppInfo")
    deviceid = di.GetChannelClientId()
    url = src
    ' url = AppendParamsToUrl(src, params)
    if url.InStr(0, "https") = 0
        di = CreateObject("roDeviceInfo")
        version = di.GetVersion()
        version_major = Mid(version, 3, 1)
        version_minor = Mid(version, 5, 2)
        version_build = Mid(version, 8, 5)

        if version_minor.toint() < 10 then
            version_minor = Mid(version_minor, 2)
        end if
        userAgent = "Roku/DVP-" + version_major + "." + version_minor + " (" + version + ")"
        request.AddHeader("access-token", getAuthorisationToken())
        request.AddHeader("pubid", getPubID())
        request.AddHeader("channelid", getchannelsid())
        request.AddHeader("uid", getUserIdana())
        request.AddHeader("country_code", getCountrycode())
        request.AddHeader("device_type", "Roku")
        request.AddHeader("dev_id", deviceid)
        request.AddHeader("ip", getIp())
        request.AddHeader("ua", userAgent)
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
        request.AddHeader("X-Roku-Reserved-Dev-Id", "")
        request.InitClientCertificates()

    end if
    headerstr = "/" + getAuthorisationToken() + "/" + getPubID() + "/" + getchannelsid() + "/" + getUserIdana().Trim() + "/" + getCountrycode() + "/" + deviceid + "/" + getIp() + "/" + userAgent + "/"


    request.SetUrl(url)
    if request.AsyncGetToString()
        while true
            msg = Wait(0, port)
            if Type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                response = ParseJson(msg.GetString())

                ?"api response: makeRequestThatReturnsTheResponseAsItAs"
                ? response

                ' Add response code into the response object
                if response = invalid then
                    response = {}
                else
                end if
                if response <> invalid and response.data <> invalid then
                    response.data.AddReplace("responseCode", code)
                    response.data.AddReplace("success", response.success)
                end if
                response.AddReplace("responseCode", code)

                return response
                exit while
            else if event = invalid
                request.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function

' Inline helper for localization
function getText(key as string) as string

    return getTextOf(key)

    ' appStrings = m.global.appStrings

    ' if m.global.language_keywords <> invalid and m.global.language_keywords[key] <> invalid and m.global.language_keywords[key][getLanguageCodeSelected4()] <> invalid
    '     return m.global.language_keywords[key][getLanguageCodeSelected4()]
    ' end if

    ' if appStrings <> invalid and appStrings[key] <> invalid
    '     return appStrings[key]
    ' end if

    ' return "" ' safe fallback
end function

function IsNotBlank2(value as dynamic) as boolean
    return value <> invalid and value <> ""
end function

'******************HAS IP INFO DATA******************
function getHasIPInfoData() as string
    ses = CreateObject("roRegistrySection", getAppKey())
    if ses.Exists("HAS_IP_INFO_DATA")
        hasipinfodata = ses.Read("HAS_IP_INFO_DATA")
        return hasipinfodata
    else
        return "false"
    end if
end function

function setHasIPInfoData(hasipinfodata as string)
    sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("HAS_IP_INFO_DATA", hasipinfodata)
    sec.Flush()
end function

sub DeleteRegistryCommon()
    print "Starting Delete Registry"
    Registry = CreateObject("roRegistry")
    i = 0
    for each section in Registry.GetSectionList()
        RegistrySection = CreateObject("roRegistrySection", section)
        for each key in RegistrySection.GetKeyList()
            i = i + 1
            if key <> "templateInstalled" and key <> "templateGuestEvent" and key <> "country_code" and key <> "ippaddress" and key <> "channelsids" and key <> "PubID" and key <> "countrycode" and key <> "channelID" and key <> "MENU_ITEMS_TITLE" and key <> "MENU_ITEMS_ORDER" and key <> "MENU_ITEMS_TYPE" and key <> "Is_Language_Setting_First_Time"
                print "Deleting " section + ":" key
                RegistrySection.Delete(key)
            else
                ?key + " not deleted"
            end if
        end for
        RegistrySection.flush()
    end for
    print i.toStr() " Registry Keys Deleted"
end sub