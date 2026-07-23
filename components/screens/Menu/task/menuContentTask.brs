sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    content = createObject("roSGNode", "ContentNode")
    createContentData(content)
end sub

sub createContentData(content)
    ' Pre-fetch all data to avoid calling functions inside the loop
    menuOrders = getMenuOrder().Split(",")
    menuTypes  = getMenuType().Split(",")
    menuTitles = getMenuTitle().Split(",")
    menuIcons  = getMenuIcons().Split(",")
    menuKeys   = getMenuKey().Split(",")
    
    isSubscribed = (getIsUserSubscribed() = "true")
    userIsGuest  = (isGuest() = "true")

    ' 1. Process standard menu items
    for i = 0 to menuTypes.count() - 1
        mType = menuTypes[i]
        
        ' Filter logic: Skip SUBSCRIBE if already subbed
        if mType = "SUBSCRIBE" and isSubscribed then continue for

        itemNode = content.createChild("ContentNode")
        itemNode.title = menuTitles[i]
        
        ' Poster Logic
        icon = menuIcons[i]
        if icon <> invalid and icon <> ""
            itemNode.hdgridposterurl = icon
        else
            itemNode.hdgridposterurl = returnMenuPoster(mType)
        end if

        ' Adding custom fields
        itemNode.addFields({ 
            type: mType,
            order: menuOrders[i],
            key: menuKeys[i],
            duration: 0.04 
        })
    end for

    ' 2. Append Login or Logout Button
    authNode = content.createChild("ContentNode")
    if not userIsGuest
        authNode.title = getText3("sign_out")
        mType = "LOGOUT"
    else
        authNode.title = getText3("sign_in")
        mType = "LOGIN"
    end if

    authNode.hdgridposterurl = returnMenuPoster(mType)
    authNode.addFields({
        type: mType,
        order: content.getChildCount(),
        key: "",
        duration: 0.04
    })

    m.top.content = content
end sub

function returnMenuPoster(mType as string) as string
    ' Use an Associative Array for O(1) lookup speed
    posters = {
        "MY_LIST":          "pkg:/images/icons/icons_wishlist.png",
        "ISLANDS":          "pkg:/images/icons/island.png",
        "HOME":             "pkg:/images/icons/home.png",
        "SUBSCRIBE":        "pkg:/images/icons/icons_fairytale.png",
        "SUBSCRIPTION":     "pkg:/images/icons/icons_fairytale.png",
        "SHORTS":           "pkg:/images/icons/icons_shorts.png",
        "CATEGORY":         "pkg:/images/icons/icons_movie.png",
        "GENRE":            "pkg:/images/icons/icons_movie.png",
        "SEARCH":           "pkg:/images/icons/icons_search.png",
        "LIVE":             "pkg:/images/icons/signal-stream.png",
        "SMART_HOME_PAGES": "pkg:/images/icons/channel.png",
        "AUDIO":            "pkg:/images/icons/microphone.png",
        "LANGUAGE":         "pkg:/images/icons/global.png",
        "LANGUAGE_SELECTION": "pkg:/images/icons/global.png",
        "LOGOUT":           "pkg:/images/icons/icons_signout.png",
        "LOGIN":            "pkg:/images/icons/sign-in.png",
        "CALENDAR":         "pkg:/images/icons/calendar.png",
        "ADDITIONAL_DONOR_CONTENT": "pkg:/images/icons/free_icon_menu.png",
        "ACCOUNT":          "pkg:/images/icons/account.png"
    }

    if posters.DoesExist(mType) then return posters[mType]
    return "pkg:/images/icons/hamburgerMenu.png"
end function


function getText3(key as String) as String
    strings = getStrings()

    if m.global.language_keywords <> invalid and m.global.language_keywords[key] <> invalid and m.global.language_keywords[key][getLanguageCodeSelected4()] <> invalid
        return m.global.language_keywords[key][getLanguageCodeSelected4()]
    end if

     if strings <> invalid and strings[key] <> invalid
        return strings[key]
    end if

    return ""   ' safe fallback
end function