sub init()
    m.titleLabel = m.top.findNode("titleLabel")
    m.appVersion = m.top.findNode("appVersion")
    m.contentLabel = m.top.findNode("contentLabel")
    m.loadingSpinner = m.top.findNode("loadingSpinner")
    m.arrowUp = m.top.findNode("arrowUp")
    m.arrowDown = m.top.findNode("arrowDown")
    m.header = m.top.findNode("header")

    m.top.observeField("contentData", "onContentDataChanged")
    m.titleLabel.observeField("text", "updateHeaderLayout")
    m.appVersion.observeField("text", "updateHeaderLayout")
    m.contentLabel.setFocus(true)

    loadAppVersion()
    applyThemeColors()
end sub

sub updateHeaderLayout()
    spacing = 15
    titleRect = m.titleLabel.boundingRect()
    versionRect = m.appVersion.boundingRect()

    totalWidth = titleRect.width + spacing + versionRect.width
    startX = -totalWidth / 2

    m.titleLabel.translation = [startX, 0]
    m.appVersion.translation = [startX + titleRect.width + spacing, 8]
end sub

sub loadAppVersion()
    appInfo = CreateObject("roAppInfo")
    version = appInfo.GetVersion()
    if version = "" or version = ".."
        major = appInfo.GetValue("major_version")
        minor = appInfo.GetValue("minor_version")
        build = appInfo.GetValue("build_version")
        version = major + "." + minor + "." + build
    end if
    if m.appVersion <> invalid then m.appVersion.text = "v" + version
end sub

sub applyThemeColors()
    bg = m.top.findNode("bg")
    if bg <> invalid then bg.color = getBackGroundColor1()

    backHint = m.top.findNode("backHint")
    if backHint <> invalid then backHint.color = getSecondaryTextColor()

    if m.titleLabel <> invalid then m.titleLabel.color = getTextColor()
    if m.contentLabel <> invalid then m.contentLabel.color = getTextColor()

    if m.arrowUp <> invalid then m.arrowUp.color = getTextColor()
    if m.arrowDown <> invalid then m.arrowDown.color = getTextColor()

    divider = m.top.findNode("divider")
    if divider <> invalid then divider.color = getDividerColor()
end sub

sub onContentDataChanged()
    data = m.top.contentData
    if data = invalid then return

    title = ""
    rawText = ""
    configType = ""
    if data.title <> invalid then title = data.title
    if data.text <> invalid then rawText = data.text
    if data.configType <> invalid then configType = data.configType

    m.titleLabel.text = title

    if rawText <> ""
        displayText(rawText)
    else if configType <> ""
        showLoading(true)
        m.infoTextTask = CreateObject("roSGNode", "InfoTextTask")
        m.infoTextTask.configType = configType
        m.infoTextTask.observeField("textResult", "onInfoTextFetched")
        m.infoTextTask.control = "RUN"
    end if
end sub

sub onInfoTextFetched()
    showLoading(false)
    text = m.infoTextTask.textResult
    if text = invalid then text = ""
    displayText(text)
end sub

sub showLoading(isLoading as boolean)
    m.loadingSpinner.visible = isLoading
    m.contentLabel.visible = not isLoading
    if not isLoading then m.contentLabel.setFocus(true)
    if isLoading
        m.arrowUp.visible = false
        m.arrowDown.visible = false
    end if
end sub

sub displayText(rawText as string)
    cleaned = stripHtml(rawText)
    m.contentLabel.text = cleaned
end sub

function stripHtml(html as string) as string
    if html = invalid or html = "" then return ""

    cleaned = html

    cleaned = cleaned.Replace("</p>", chr(10))
    cleaned = cleaned.Replace("<P>", chr(10))
    cleaned = cleaned.Replace("</P>", chr(10))
    cleaned = cleaned.Replace("<br>", chr(10))
    cleaned = cleaned.Replace("<br/>", chr(10))
    cleaned = cleaned.Replace("<br />", chr(10))
    cleaned = cleaned.Replace("</li>", chr(10))
    cleaned = cleaned.Replace("</h1>", chr(10))
    cleaned = cleaned.Replace("</h2>", chr(10))
    cleaned = cleaned.Replace("</h3>", chr(10))
    cleaned = cleaned.Replace("</h4>", chr(10))
    cleaned = cleaned.Replace("<li>", "• ")

    ' Strip all remaining tags in a single regex pass instead of char-by-char loop
    tagRegex = CreateObject("roRegex", "<[^>]*>", "i")
    result = tagRegex.ReplaceAll(cleaned, "")

    result = result.Replace("&amp;", "&")
    result = result.Replace("&lt;", "<")
    result = result.Replace("&gt;", ">")
    result = result.Replace("&nbsp;", " ")
    result = result.Replace("&#39;", "'")
    result = result.Replace("&apos;", "'")
    result = result.Replace("&quot;", chr(34))

    return result
end function

' function stripHtml(html as string) as string
'     if html = invalid or html = "" then return ""

'     cleaned = html

'     cleaned = cleaned.Replace("</p>", chr(10))
'     cleaned = cleaned.Replace("<P>", chr(10))
'     cleaned = cleaned.Replace("</P>", chr(10))
'     cleaned = cleaned.Replace("<br>", chr(10))
'     cleaned = cleaned.Replace("<br/>", chr(10))
'     cleaned = cleaned.Replace("<br />", chr(10))
'     cleaned = cleaned.Replace("</li>", chr(10))
'     cleaned = cleaned.Replace("</h1>", chr(10))
'     cleaned = cleaned.Replace("</h2>", chr(10))
'     cleaned = cleaned.Replace("</h3>", chr(10))
'     cleaned = cleaned.Replace("</h4>", chr(10))
'     cleaned = cleaned.Replace("<li>", "• ")

'     result = ""
'     inTag = false
'     i = 1
'     total = Len(cleaned)
'     while i <= total
'         ch = Mid(cleaned, i, 1)
'         if ch = "<"
'             inTag = true
'         else if ch = ">"
'             inTag = false
'         else if not inTag
'             result = result + ch
'         end if
'         i = i + 1
'     end while

'     result = result.Replace("&amp;", "&")
'     result = result.Replace("&lt;", "<")
'     result = result.Replace("&gt;", ">")
'     result = result.Replace("&nbsp;", " ")
'     result = result.Replace("&#39;", "'")
'     result = result.Replace("&apos;", "'")
'     result = result.Replace("&quot;", chr(34))

'     return result
' end function

function OnKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "back"
        m.top.goBack = true
        return true
    end if

    return false
end function
