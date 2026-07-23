
function Init()
  m.top.observeField("focusedChild", "OnFocusedChildChange")
  m.top.observeField("visible", "onVisibleChange")
  m.playListRowlist = m.top.findNode("RowList")
  m.playListRowlist.focusBitmapBlendColor = getButtonSelectionColor()
  m.playListRowlist.rowLabelColor = getTextColor()
  m.playListRowlist.rowLabelFont.size = 28
  m.description = m.top.findNode("Description")
  m.background = m.top.findNode("Background")
  m.Hud = m.top.findNode("Hud")
  m.Hint = m.top.findNode("Hint")
  m.Timer2 = m.top.findNode("Timer")
  m.Timer3 = m.top.findNode("Timer2")
  m.playing = m.top.findNode("playing")
  m.Hint2 = m.top.findNode("Hint2")
  m.screenStack = []
  font = CreateObject("roSGNode", "Font")
  font.uri = "pkg:/fonts/Roboto-Bold.ttf"
  font.size = 26
  m.EventFetcher = CreateObject("roSGNode", "EventFetcher")
  m.count = 0
  m.Title = m.top.findNode("Title")
  m.Description = m.top.findNode("Description")
  m.resolution = m.top.findNode("resolution")
  m.resolution.font.size = 28
  m.Title.font.size = 60
  m.category_name = m.top.findNode("category_name")
  m.director = m.top.findNode("director")
  m.logo = m.top.findNode("PosterOverhang")
  m.loadingIndicator = m.top.findNode("loading")
  m.nolist = m.top.findNode("nolist")
  m.top.observeField("startLoading", "loadHome")
  m.valu = 0
  m.loadingIndicator.visible = true
  m.top.loading = m.top.CreateChild("Loading") ' loading created this way because loading needs to above every views. some views are defined here in brs file. not in xml
  m.top.loading.visible = false
  m.top.startLoading = "loaassd"
  m.sceneTitle = m.top.findNode("sceneTitle")
  m.sceneTitle.font.size = 55
  m.sceneTitle.color = getTextColor()

  m.nolist.color = getTextColor()
  m.Hint.color = getTextColor()
  m.playing.color = getTextColor()
  m.Hint2.color = getTextColor()
  m.Title.color = getTextColor()
  m.resolution.color = getTextColor()
  m.category_name.color = getTextColor()
  m.director.color = getTextColor()
end function


function loadHome()
  sec = CreateObject("roRegistrySection", getAppKey())
  if sec.Exists("Guest")
  else
  end if
  m.device_id = "roku"
  m.pubid = getPubID()
  m.langid = getLanguage()
  m.channelid = getchannelsid()
  m.country_code = getCountrycode()
  m.uid = getUserIdana()
  sec = CreateObject("roRegistrySection", getAppKey())
  if sec.Exists("USER_ID")
    tok = sec.Read("USER_ID")
    valu = tok.Trim()
  end if
  m.HomeTopMenuRowlist = m.top.getScene().findNode("HomeTopMenuRowlist")
  m.top.loading.visible = true
  m.MyListTask = CreateObject("roSGNode", "MyListTask")
  m.MyListTask.observeField("MyListTaskContent", "onContentChanged")
  m.MyListTask.observeField("SearchBoolean", "onContentChanged")
  m.MyListTask.callFunc("runMyListTask", "")

end function


sub onTokenChanged()
end sub


sub onContentChanged()
  ?"onContentChanged called"


  if getThumbnailOrientaion() = "LANDSCAPE"
    rowHeights = [240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240]
    rowItemSize = [[320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180], [320, 180]]
  else if getThumbnailOrientaion() = "PORTRAIT"
    rowHeights = [400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400]
    rowItemSize = [[200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300], [200, 300]]
  end if

  m.playListRowlist.rowHeights = rowHeights
  m.playListRowlist.rowItemSize = rowItemSize

  if m.MyListTask <> invalid and m.MyListTask.MyListTaskContent <> invalid and m.MyListTask.MyListTaskContent.getChild(0) <> invalid and m.MyListTask.MyListTaskContent.getChild(0).getChildCount() > 0 then
    m.playListRowlist.focusBitmapUri = "pkg:/images/focus_grid.9.png"
    m.playListRowlist.showRowLabel = true
    m.top.content = m.MyListTask.MyListTaskContent
    m.resolution.translation = [255, 280]
    m.resolution.font.size = 27
    m.title.visible = true

  else
    m.top.content = invalid
    m.playListRowlist.focusBitmapUri = "pkg:/images/focus_grid.999999.png" ' hiding playListRowlist if empty
    m.playListRowlist.showRowLabel = false
    m.Title.text = getText("no_data")
    m.title.visible = false
    m.resolution.translation = [910, 480]
    m.resolution.font.size = 28
    m.resolution.text = getText("no_data_found")
  end if

  m.loadingIndicator.visible = false
  m.top.visible = true
  m.playListRowlist.observeField("rowItemFocused", "OnItemFocused")
  ' m.playListRowlist.observeField("OnRowItemSelected", "OnItemSelected")
  m.top.loading.visible = false
end sub

sub OnFocusedChildChange()
  m.loadingIndicator.visible = false
  if m.top.isInFocusChain() and not m.playListRowlist.hasFocus() then
    m.playListRowlist.setFocus(true)
  end if
end sub



sub ShowScreen(node)
  prev = m.screenStack.peek()
  if prev <> invalid
    prev.visible = false
  end if
  node.visible = true
  node.setFocus(true)
  m.screenStack.push(node)
end sub



'''''''''
' OnItemFocused:
'
'''''''''
sub OnItemFocused()
  ?"OnItemFocused : mylistScene called"
  di = CreateObject("roDeviceInfo")
  appInfo = CreateObject("roAppInfo")
  deviceids = di.GetChannelClientId()
  m.count = 0
  m.playListRowlist.visible = true
  itemFocused = m.top.itemFocused
  m.loadingIndicator.visible = false
  m.top.focusedRow = itemFocused
  if itemFocused[0] = 0
  else
  end if
  if itemFocused.Count() = 2 then
    focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
    ?focusedContent
    if focusedContent <> invalid then
      m.background.visible = false
      m.nolist.visible = false
      m.background.uri = focusedContent.hdBackgroundImageUrl
      m.resolution.text = focusedContent.resolution
      m.top.focusedContent = focusedContent
      m.Title.text = focusedContent.title
      if itemFocused[0] = 2
      end if
      m.resolution.text = focusedContent.resolution
      if focusedContent.maturity <> invalid
        m.category_name.text = focusedContent.maturity
      else
        m.category_name.text = ""
      end if
      m.background.uri = focusedContent.hdBackgroundImageUrl
      if focusedContent.director <> invalid
        value2 = focusedContent.director
        m.director.text = value2.toStr()
      else
        m.director.text = ""
      end if
      cat = focusedContent.category_name
      if cat <> invalid then
        category = ""
        arrayLength = cat.count()
        lastItem = cat[arrayLength - 1]
        for each item in cat
          if(arrayLength < 2)
            category = category + item
          else
            if(item = lastItem)
              category = category + item
            else
              category = category + item + ","
            end if
          end if
        end for
        catloc = category
        sec = CreateObject("roRegistrySection", getAppKey())
        sec.Write("category", catloc)
        sec.Flush()
      end if
    else
      m.nolist.visible = false


      m.Title.text = getText("no_data")








      m.resolution.text = getText("no_data_found")



    end if
  end if
end sub


function onKeyEvent(key as string, bPressed as boolean) as boolean
  result = false
  if bPressed
    if m.HomeTopMenuRowlist.isInFocusChain() 'HomeTopMenuRowlist key handling
      if key = "right" or key = "left"
        return true
      else if key = "down"
        m.playListRowlist.setFocus(true)
        return true
      end if
    else if key = "up" and m.playListRowlist.hasFocus()
      m.HomeTopMenuRowlist.SET_FOCUS = true
      return true
    end if


    if(key = "options")
      result = true
    else if key = "down" then
      m.playListRowlist.setFocus(true)
      result = true
    else if key = "up" then
      result = true
    else if key = "options" then
      result = true
    else if key = "back"

    end if
  end if

  return result
end function

function setVideo() as void
  videoContent = createObject("RoSGNode", "ContentNode")
  VODcontent = m.playListRowlist.content.getChild(m.playListRowlist.rowItemFocused[0]).getChild(m.playListRowlist.rowItemFocused[1])
  videoContent = {
    streamFormat: "hls",
    title: "LIVE TV",
    url: VODcontent.url,
    categories: "live"
    nielsenProgramId: "CBAA", 'String identifying content program for Nielsen DAR tags.
    nielsenAppId: "P2871BBFF-1A28-44AA-AF68-C7DE4B148C32", 'String identifying Nielsen-assigned application ID.
    nielsenGenre: "GV" 'String identifying primary content genre for Nielsen DAR tags.
  }
  content = CreateObject("roSGNode", "VideoContent")
  content.setFields(videoContent)
  m.EventFetcher.user_id = getUserIdana()
  m.EventFetcher.event_type = "POP02"
  m.EventFetcher.video_id = "0"
  m.EventFetcher.video_title = getchannelname()
  m.EventFetcher.channel_id = getchannelsid()
  m.EventFetcher.category = ""
  m.EventFetcher.callFunc("runEventFetcher", "")
  m.Timer = m.top.findNode("Timer")
  m.Timer.control = "start"
  m.Timer.observeField("fire", "change")
  m.playListRowlist.visible = false
end function



sub change()
  if(m.top.GloBoolean = true) then
    m.EventFetcher.user_id = getUserIdana()
    m.EventFetcher.event_type = "POP03"
    m.EventFetcher.video_id = "0"
    m.EventFetcher.video_title = getchannelname()
    m.EventFetcher.channel_id = getchannelsid()
    m.EventFetcher.category = ""
    m.EventFetcher.callFunc("runEventFetcher", "")
  end if
end sub

sub change2()
  m.logo.visible = false
end sub

sub change3()
  m.loadingIndicator.visible = true
  loadHome()
  m.valu = 0
end sub

sub onVisibleChange()
  ?"onVisibleChange : playlist 1"
  if m.top.visible = true then
    ?"onVisibleChange : playlist 2"
    loadHome()
    m.playListRowlist.setFocus(true)
  else
    m.background.visible = true
  end if

end sub

function getTokenForPlay() as dynamic
  sec = CreateObject("roRegistrySection", getAppKey())
  if sec.Exists("UserRegistrationToken")
    return sec.Read("UserRegistrationToken")
  end if
  return invalid
end function

sub onSetDefaultFocus()
  m.playListRowlist.setFocus(true)
end sub


