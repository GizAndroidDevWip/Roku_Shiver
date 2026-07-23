
' ***********Intial Page**********************
function getIntialPage() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("INITIAL_PAGE")
        intialpage = ses.Read("INITIAL_PAGE")
        return intialpage
    else
        return "HOME"
    end if
end function

function SetIntialPage(intial_page as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("INITIAL_PAGE", intial_page)
    sec.Flush()
end function



'****************LIVE LOGIN CHECK*********************
function getLiveLoginCheck() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("LIVE_LOGIN_REQUIRED")
        liveloginrequired = ses.Read("LIVE_LOGIN_REQUIRED")
        return liveloginrequired
    else
        return "false"
    end if
end function

function setLiveLoginCheck(liveloginrequired as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("LIVE_LOGIN_REQUIRED", liveloginrequired)
    sec.Flush()
end function




'****************TAB TITLE************************
function getTabTitle() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("TAB_TITLE")
        tabtitle = ses.Read("TAB_TITLE")
        return tabtitle
    else
        return ""
    end if
end function

function SetTabTitle(tab_title as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("TAB_TITLE", tab_title)
    sec.Flush()
end function


function setMULTI_CHANNELS_REQUIRED(MULTI_CHANNELS_REQUIRED as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("MULTI_CHANNELS_REQUIRED", MULTI_CHANNELS_REQUIRED)
    sec.Flush()
end function

function getMULTI_CHANNELS_REQUIRED() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MULTI_CHANNELS_REQUIRED")
        MULTI_CHANNELS_REQUIRED = ses.Read("MULTI_CHANNELS_REQUIRED")
        return MULTI_CHANNELS_REQUIRED
    else
        return "false"
    end if
end function


'******************BACKGROUND COLOR******************
function getBackGroundColor1() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("THEME")
        THEME = ses.Read("THEME")
        if THEME = "LIGHT"
            return "#FFFFFF" 'white background for light theme
        else
            return "#000000" 'black background for dark theme '32393d '#1c1f21
        end if
    else
        return "#000000"
    end if
end function

function SetBackGroundColor(background_color as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("BACKGROUND_COLOR", background_color)
    sec.Flush()
end function

'****************REGISTRATION MANDATORY*********************
function getRegisterationMandatory() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("REGISTRATION_MANDATORY")
        registerationMandatory = ses.Read("REGISTRATION_MANDATORY")
        return registerationMandatory
    else
        return "false"
    end if
end function

function SetRegisterationMandatory(registeration_mandatory as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("REGISTRATION_MANDATORY", registeration_mandatory)
    sec.Flush()
end function


'****************REGISTRATION OTP REQUIRED*************************
function getRegisterationOTPRequired() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("REGISTRATION_OTP_REQUIRED")
        registerationOtpRequired = ses.Read("REGISTRATION_OTP_REQUIRED")
        return registerationOtpRequired
    else
        return "false"
    end if
end function

function SetRegisterationOTPMandatory(registeration_otp_required as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("REGISTRATION_OTP_REQUIRED", registeration_otp_required)
    sec.Flush()
end function

'********************GOOGLE ANALYTICS SCRIPT******************************
function getGoogleAnalyticsScript() as dynamic
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("GOOGLE_ANALYTICS_SCRIPT")
        registerationOtpRequired = ses.Read("GOOGLE_ANALYTICS_SCRIPT")
        return registerationOtpRequired
    end if
end function

function SetGoogleAnalyticsScript(google_analytics_script as dynamic)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("GOOGLE_ANALYTICS_SCRIPT", google_analytics_script)
    sec.Flush()
end function

'************************BUTTON SELECTION COLOR*************************
function getButtonSelectionColor() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("BUTTON_SELECTION_COLOR")
        buttonSelectionColor = ses.Read("BUTTON_SELECTION_COLOR")
        return buttonSelectionColor
    else
        return "#ED2B2A"
    end if
end function

function SetButtonSelectionColor(button_selection_color as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("BUTTON_SELECTION_COLOR", button_selection_color)
    sec.Flush()
end function

'*********************TEXT COLOR*******************************
function getTextColor() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("TEXT_COLOR")
        textColor = ses.Read("TEXT_COLOR")
        if ses.Exists("THEME")
            THEME = ses.Read("THEME")
            if THEME = "LIGHT"
                return "#212121" 'dark text for light theme
            else
                return "#FFFFFF" 'white text for dark theme
            end if
        else
            return "#212121"
        end if
    else
        return "#FFFFFF"
    end if
end function

function SetTextColor(text_color as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("TEXT_COLOR", text_color)
    sec.Flush()
end function

function getCurrentTheme() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("THEME")
        return ses.Read("THEME")
    else
        return "DARK"
    end if
end function

function getSecondaryTextColor() as string
    theme = getCurrentTheme()
    if theme = "LIGHT"
        return "#757575"
    else
        return "#AAAAAA"
    end if
end function

function getFocusedCardColor() as string
    theme = getCurrentTheme()
    if theme = "LIGHT"
        return "#D0D0D0"
    else
        return "#464646"
    end if
end function

function getDefaultCardColor() as string
    theme = getCurrentTheme()
    if theme = "LIGHT"
        return "#FAFAFA"
    else
        return "#121212"
    end if
end function

function getDefaultCardColor2() as string
    theme = getCurrentTheme()
    if theme = "LIGHT"
        return "#FAFAFA"
    else
        return "#2b2b2b"
    end if
end function

function getDividerColor() as string
    theme = getCurrentTheme()
    if theme = "LIGHT"
        return "#E0E0E0"
    else
        return "#333333"
    end if
end function

'*********************AD REQUIRED********************************
function getAdRequired() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("AD_REQUIRED")
        adRequired = ses.Read("AD_REQUIRED")
        return adRequired
    else
        return "false"
    end if
end function

function SetAdRequired(ad_required as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("AD_REQUIRED", ad_required)
    sec.Flush()
end function

'***********************SUBSCRIPTION REQUIRED**************************
function getSubscriptionRequired() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("SUBSCRIPTION_REQUIRED")
        subscriptionRequired = ses.Read("SUBSCRIPTION_REQUIRED")
        return subscriptionRequired
    else
        return "false"
    end if
end function

function SetSubscriptionRequired(subscription_required as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("SUBSCRIPTION_REQUIRED", subscription_required)
    sec.Flush()
end function

' *******************************TV Code Url ******************
function getTvCodeUrl() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("TV_ACTIVATION_URL")
        tvActivationUrl = ses.Read("TV_ACTIVATION_URL")
        return tvActivationUrl
    else
        return ""
    end if
end function

function SetTvCodeUrl(tv_activation_url as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("TV_ACTIVATION_URL", tv_activation_url)
    Sec.Flush()
end function

'*******************************LOGO**************************************
function getLogo() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("LOGO")
        logo = ses.Read("LOGO")
        return logo
    end if
end function

function SetLogo(logo as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("LOGO", logo)
    sec.Flush()
end function

'**************************FAVICON*********************************
function getFavICon() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("FAVICON")
        favicon = ses.Read("FAVICON")
        return favicon
    end if
end function

function SetfavIcon(fav_icon as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("FAVICON", fav_icon)
    sec.Flush()
end function


function SetHide_Title_Under_Movies(hide_title_under_movies as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("HIDE_TITLE_UNDER_MOVIES", hide_title_under_movies)
    sec.Flush()
end function

function getHide_Title_Under_Movies() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("HIDE_TITLE_UNDER_MOVIES")
        hide_title_under_movies = ses.Read("HIDE_TITLE_UNDER_MOVIES")
        return hide_title_under_movies
    else
        return "false"
    end if

end function


' *******************************ROKU_CHANNEL_STORE_URL ******************
function getRokuChannelStoreURL() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("ROKU_CHANNEL_STORE_URL")
        tvActivationUrl = ses.Read("ROKU_CHANNEL_STORE_URL")
        return tvActivationUrl
    else
        return ""
    end if
end function

' *******************************ROKU_CHANNEL_STORE_URL ******************
function getAppName() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("TAB_TITLE")
        appName = ses.Read("TAB_TITLE")
        return appName
    else
        return ""
    end if
end function


function getAppTitle() as string
    appInfo = CreateObject("roAppInfo")
    title = appInfo.GetTitle()
    return title
end function




' ***************WEBSITE_META_DESCRIPTION*****************************
function getWebSiteMetaDescription() as dynamic
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("WEBSITE_META_DESCRIPTION")
        websiteMetaDescription = ses.Read("WEBSITE_META_DESCRIPTION")
        return websiteMetaDescription
    end if
end function

function SetWebsiteMetaDescription(website_meta_description as dynamic)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("WEBSITE_META_DESCRIPTION", website_meta_description)
    sec.Flush()
end function




' **************************App Opening First Time***********************
function IsAppOpeningFirstTime() as string
    sec = CreateObject("roRegistrySection", getAppKey2())
    if sec.Exists("IS_APP_OPENING_FIRST_TIME")
        return "false"
    else
        return "true"
    end if
end function

function setIsAppOpeningFirstTime(is_app_opening_first_time as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("IS_APP_OPENING_FIRST_TIME", is_app_opening_first_time)
    sec.Flush()
end function


' **************************App Opening First Time***********************
function getThumbnailOrientaion() as string
    sec = CreateObject("roRegistrySection", getAppKey2())
    if sec.Exists("THUMBNAIL_ORIENTATION")
        websiteMetaDescription = sec.Read("THUMBNAIL_ORIENTATION")
        return websiteMetaDescription
    else
        return "LANDSCAPE"
    end if
end function


function getSKIP_LOGIN_REQUIRED() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("SKIP_LOGIN_REQUIRED")
        SKIP_LOGIN_REQUIRED = ses.Read("SKIP_LOGIN_REQUIRED")
        return SKIP_LOGIN_REQUIRED
    else
        return "false"
    end if
end function

function setSKIP_LOGIN_REQUIRED(SKIP_LOGIN_REQUIRED as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getSKIP_LOGIN_REQUIRED", SKIP_LOGIN_REQUIRED)
    sec.Flush()
end function




' function for login parameter


function getSHORTS_LOGIN_REQUIRED() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("SHORTS_LOGIN_REQUIRED")
        SHORTS_LOGIN_REQUIRED = ses.Read("SHORTS_LOGIN_REQUIRED")
        return SHORTS_LOGIN_REQUIRED
    else
        return "false"
    end if
end function

function setSHORTS_LOGIN_REQUIRED(SHORTS_LOGIN_REQUIRED as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getSHORTS_LOGIN_REQUIRED", SHORTS_LOGIN_REQUIRED)
    sec.Flush()
end function



function getSIGN_UP_REQUIRED() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("SIGN_UP_REQUIRED")
        SIGN_UP_REQUIRED = ses.Read("SIGN_UP_REQUIRED")
        return SIGN_UP_REQUIRED
    else
        return "false"
    end if
end function

function setSIGN_UP_REQUIRED(SIGN_UP_REQUIRED as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getSIGN_UP_REQUIRED", SIGN_UP_REQUIRED)
    sec.Flush()
end function


'BYPASS_SHOW_DETAILS_SCREEN

function getBYPASS_SHOW_DETAILS_SCREEN()
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("BYPASS_SHOW_DETAILS_SCREEN")
        BYPASS_SHOW_DETAILS_SCREEN = ses.Read("BYPASS_SHOW_DETAILS_SCREEN")
        return BYPASS_SHOW_DETAILS_SCREEN
    else
        return "false"
    end if
end function

function setBYPASS_SHOW_DETAILS_SCREEN(BYPASS_SHOW_DETAILS_SCREEN as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getBYPASS_SHOW_DETAILS_SCREEN", BYPASS_SHOW_DETAILS_SCREEN)
    sec.Flush()
end function




function getPLACEHOLDER_IMAGE()
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("PLACEHOLDER_IMAGE")
        PLACEHOLDER_IMAGE = ses.Read("PLACEHOLDER_IMAGE")
        return PLACEHOLDER_IMAGE
    else
        return ""
    end if
end function

function setPLACEHOLDER_IMAGE(PLACEHOLDER_IMAGE as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getPLACEHOLDER_IMAGE", PLACEHOLDER_IMAGE)
    sec.Flush()
end function




function getPLACEHOLDER_IMAGE_PORTRAIT()
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("PLACEHOLDER_IMAGE_PORTRAIT ")
        PLACEHOLDER_IMAGE_PORTRAIT = ses.Read("PLACEHOLDER_IMAGE_PORTRAIT ")
        return PLACEHOLDER_IMAGE_PORTRAIT
    else
        return ""
    end if
end function

function setPLACEHOLDER_IMAGE_PORTRAIT(PLACEHOLDER_IMAGE_PORTRAIT as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getPLACEHOLDER_IMAGE_PORTRAIT", PLACEHOLDER_IMAGE_PORTRAIT)
    sec.Flush()
end function




function getLOGIN_WITH_MAGIC_LINK_REQUIRED() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("LOGIN_WITH_MAGIC_LINK_REQUIRED")
        LOGIN_WITH_MAGIC_LINK_REQUIRED = ses.Read("LOGIN_WITH_MAGIC_LINK_REQUIRED")
        return LOGIN_WITH_MAGIC_LINK_REQUIRED
    else
        return "false"
    end if
end function


function setLOGIN_WITH_MAGIC_LINK_REQUIRED(LOGIN_WITH_MAGIC_LINK_REQUIRED as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("getLOGIN_WITH_MAGIC_LINK_REQUIRED", LOGIN_WITH_MAGIC_LINK_REQUIRED)
    sec.Flush()
end function


function getREVERSE_TV_CODE_FLOW() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("REVERSE_TV_CODE_FLOW")
        REVERSE_TV_CODE_FLOW = ses.Read("REVERSE_TV_CODE_FLOW")
        return REVERSE_TV_CODE_FLOW
    else
        return "false"
    end if
end function


function setREVERSE_TV_CODE_FLOW(REVERSE_TV_CODE_FLOW as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("REVERSE_TV_CODE_FLOW", REVERSE_TV_CODE_FLOW)
    sec.Flush()
end function


function setMULTI_LANGUAGE_REQUIRED(MULTI_LANGUAGE_REQUIRED as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("MULTI_LANGUAGE_REQUIRED", MULTI_LANGUAGE_REQUIRED)
    sec.Flush()
end function



function getMULTI_LANGUAGE_REQUIRED() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MULTI_LANGUAGE_REQUIRED")
        MULTI_LANGUAGE_REQUIRED = ses.Read("MULTI_LANGUAGE_REQUIRED")
        return MULTI_LANGUAGE_REQUIRED
    else
        return "false"
    end if
end function

function setLanguage_id(is_language_id as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("is_language_id", is_language_id)
    ?is_language_id
    ?"is_language_idffedfdf"
    sec.Flush()
end function


function setLanguage_id_first() as string
    sec = CreateObject("roRegistrySection", getAppKey2())
    if not sec.Exists("is_language_id") 'if language setting key does not exist then returns true and call's language listing api
        ?"jikkkkkhhjh"
        return "true"
    else
        return "false"
    end if
end function



function setIsLanguageSettingFirstTime(is_language_setting_first_time as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("Is_Language_Setting_First_Time", is_language_setting_first_time)
    sec.Flush()
end function

function setLanguageSelected(languageSelected as string)


    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("LANGUAGE_SELECTED", languageSelected)

    sec.Flush()
end function


function IsLanguageSettingFirstTime() as string
    sec = CreateObject("roRegistrySection", getAppKey2())
    if not sec.Exists("Is_Language_Setting_First_Time") 'if language setting key does not exist then returns true and call's language listing api
        return "true"
    else
        return "false"
        ' end if
    end if
end function



' ***************************Guest User*************************
function isGuest() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("ISGUEST")
        isguestt = ses.Read("ISGUEST")
        return isguestt
    else
        return "true"
    end if
end function



' ***************************MENU_ITEMS_ORDER*************************
function getMenuOrder() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MENU_ITEMS_ORDER")
        data = ses.Read("MENU_ITEMS_ORDER")
        return data
    else
        return "1,2,3,4,5,6"
    end if
end function




' ***************************MENU_ITEMS_TYPE*************************
function getMenuType() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MENU_ITEMS_TYPE")
        data = ses.Read("MENU_ITEMS_TYPE")
        return data
    else
        return ""
    end if
end function




' ***************************MENU_ITEMS_TITLE*************************
function getMenuTitle() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MENU_ITEMS_TITLE")
        MENU_ITEMS_TITLE = ses.Read("MENU_ITEMS_TITLE")
        return MENU_ITEMS_TITLE
    else
        return ""
    end if
end function

' ***************************MENU_ITEMS_ICON*************************
function getMenuIcons() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MENU_ITEMS_ICON")
        sec = ses.Read("MENU_ITEMS_ICON")
        return sec
    else
        return ""
    end if
end function

' ***************************MENU_ITEMS_TITLE*************************
function getMenuKey() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("MENU_ITEMS_KEY")
        sec = ses.Read("MENU_ITEMS_KEY")
        return sec
    else
        return ""
    end if
end function



function getLanguageCodeSelected() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("LANGUAGE_CODE_SELECTED")
        value = ses.Read("LANGUAGE_CODE_SELECTED")
        return value
    else
        return "en"
    end if
end function



' ***************************LANGUAGE_SELECTED*************************
function getLanguageSelected() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("LANGUAGE_SELECTED")
        value = ses.Read("LANGUAGE_SELECTED")
        return value
    else
        return "English"
    end if
end function

function getAppKey2() as object
    return m.global.APP_KEY
end function

function isFromDeepLinking() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("FROM_DEEPLINK")
        value = ses.Read("FROM_DEEPLINK")
        return value
    else
        return ""
    end if
end function



function setIsFromDeepLinking(isFromDeepLinkingValue as string)
    sec = CreateObject("roRegistrySection", getAppKey2())
    sec.Write("FROM_DEEPLINK", isFromDeepLinkingValue)
    sec.Flush()
end function

function getIsUserSubscribed2() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("IsUserSubscribed")
        usb = ses.Read("IsUserSubscribed")
        return usb
    else
        return "false"
    end if
end function

function IsNotNull2(value as dynamic) as boolean
    return value <> invalid
end function

function IsNotNullThenReturn(value as dynamic)
    if value <> invalid
        return value
    else
        return invalid
    end if
end function

' ***************************THEME*************************
function getTheme2() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("THEME")
        theme = ses.Read("THEME")
        return theme
    else
        return "DARK"
    end if
end function

' @param theme [String] "light" or "dark"
' @param uiArea [String] The specific part of the app (e.g., "default_item", "inverted_header")
' @return [String] Hex color code
function getThemeColor(theme as string, uiArea as string) as string
    ' Define your color palette mapping
    colors = {
        "LIGHT": {
            "default_item": "#000000", ' Black text/icon on light background
            "inverted_area": "#FFFFFF" ' White text/icon on an intentionally dark section
        },
        "DARK": {
            "default_item": "#FFFFFF", ' White text/icon on dark background
            "inverted_area": "#000000" ' Black text/icon on an intentionally light section
        }
    }

    ' Fallback handling in case of typos
    if colors.DoesExist(theme) and colors[theme].DoesExist(uiArea)
        return colors[theme][uiArea]
    end if

    return "#FFFFFF" ' Universal fallback
end function

'******************BACKGROUND COLOR******************
function getOpositeColorOfThemeColor() as string
    ses = CreateObject("roRegistrySection", getAppKey2())
    if ses.Exists("THEME")
        THEME = ses.Read("THEME")
        if THEME = "LIGHT"
            return "#000000" 'black background for light theme
        else
            return "#FFFFFF" 'white background for dark theme
        end if
    else
        return "#000000"
    end if
end function

function getOppositeColorOfInput(color as string) as string
    if getTheme2() = "LIGHT"
        if color = "#FFFFFF"
            return "#000000"
        else if color = "#000000"
            return "#FFFFFF"
        end if
    else if getTheme2() = "DARK"
        return color
    end if
end function

function getParentScene2() as object
    m.parentScene = m.top.GetParent()
    while m.parentScene <> invalid
        grandParent = m.parentScene.GetParent()
        if grandParent = invalid then
            exit while
        end if
        m.parentScene = grandParent
    end while
    return m.parentScene
end function
