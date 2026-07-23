'********** Copyright 2017 Roku Inc.  All Rights Reserved. **********
function itemContentChanged() as void
  itemData = m.top.itemContent
'  m.itemPoster.uri = "pkg:/images/premium.png"
  m.itemTitle.text = itemData.subscription_name
  m.itemType.text =  itemData.subscription_type_name
  m.itemPriceDisplay.text = itemData.price
  m.itemTitle.font.size = "24"
  m.itemType.font.size =  "24"
  m.itemPriceDisplay.font.size = "24"
  
end function

function init() as void
  m.itemPoster = m.top.findNode("itemPoster")
  m.itemTitle = m.top.findNode("itemTitle")
  m.itemPriceDisplay = m.top.findNode("itemPriceDisplay")
  m.itemType = m.top.findNode("itemType")
end function

function onFocusPercent() as void
    if m.top.focusPercent = 1.0
      m.top.findNode("focusRect").visible = true
    else if m.top.focusPercent = 0.0
      m.top.findNode("focusRect").visible = false
  end if
end function

function onRowFocusPercent() as void
    if m.top.focusPercent = 1.0
        m.top.findNode("focusRect").visible = true
    else if m.top.focusPercent = 0.0
       m.top.findNode("focusRect").visible = false
   end if
end function
