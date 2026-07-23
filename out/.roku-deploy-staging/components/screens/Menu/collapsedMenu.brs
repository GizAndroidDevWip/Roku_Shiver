sub init()
    ?"menu init"
    m.top.observeField("visible", "onVisibleChange")
    m.markupGrid = m.top.findNode("markupGrid")
    m.markupGrid.observeField("itemSelected", "onItemSelected")
    m.shade = m.top.findNode("shade")
    font = createFont("Roboto-Bold", 33)
    m.uname = m.top.findNode("uname")
    m.uname.font = font
    m.uname.color = getTextColor()

    m.readMarkupGridTask = createObject("roSGNode", "MenuContentTask")
    m.readMarkupGridTask.observeField("content", "showMarkupGrid")
    requestMenuInformation()
end sub

sub jumpToItem()
    m.markupGrid.jumpToItem = m.top.jumpToItemIndexInSideMenu
end sub

sub requestMenuInformation()
    m.readMarkupGridTask.control = "RUN"
end sub

sub showMarkupGrid()
    m.markupGrid.content = m.readMarkupGridTask.content
    m.markupGrid.jumpToItem = 0
    sec = CreateObject("roRegistrySection", getAppKey())

    if isGuest2() = "true"
     
            m.uname.text = ""'"Sign in"'m.global.language_keywords.guest[getLanguageCodeSelected()]
      
            m.uname.text = ""' "Hi Guest"
       

        m.markupGrid.translation = [0, 400]
        m.markupGrid.visible = true
    else
        '**not guest menu
        if sec.Exists("userName")
            userName = sec.Read("userName")
            m.uname.text = "" '"Hi " + userName 
            m.markupGrid.translation = [0, 340]
        else
            m.uname.text = ""
        end if
    end if
    if m.markupGrid.content.getchildCount() = 6
        m.markupGrid.translation = [0, m.markupGrid.translation[1] - 60]
    else if m.markupGrid.content.getchildCount() = 7
        m.markupGrid.translation = [0, m.markupGrid.translation[1] - 130]
    else if m.markupGrid.content.getchildCount() = 8
        m.markupGrid.translation = [0, m.markupGrid.translation[1] - 150]
    else if m.markupGrid.content.getchildCount() > 8
        m.markupGrid.translation = [0, m.markupGrid.translation[1] - 175]
    end if
    m.readMarkupGridTask.control = "STOP"

end sub

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


sub expandMenu()
    ?"menu expandMenu"
    m.markupGrid.itemSize = [320, 50]
    m.markupGrid.setFocus(true)
    ' m.shade.visible = true
    m.uname.visible = true
end sub

sub collapseMenu()
    ?"menu collapseMenu"
    m.markupGrid.itemSize = [100, 50]
    m.markupGrid.setFocus(false)
    m.shade.visible = false
    m.uname.visible = false
end sub

sub onLoginChanged()
    ?"onLoginChanged calleddd"
    requestMenuInformation()
end sub
sub onVisibleChange()
    ' requestMenuInformation()
end sub


sub onItemSelected()
    m.top.itemSelected = m.markupGrid.content.getChild(m.markupGrid.itemSelected) ' setting selected menu itemtype here, so to access from homescreen
end sub

function getBundleID() as object
    return m.global.BUNDLE_ID
end function

function getAppKey() as object
    return m.global.APP_KEY
end function


function createFont(fontName, fontSize)
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/" + fontName + ".ttf"
    font.size = fontSize
    return font
end function
