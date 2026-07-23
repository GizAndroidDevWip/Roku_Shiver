'********** Copyright 2017 Roku Inc.  All Rights Reserved. **********

function init() as void
  ' m.itemPoster = m.top.findNode("itemPoster")
  m.itemTitle = m.top.findNode("itemTitle")
  m.bgPoster = m.top.findNode("bgPoster")
  m.mainRect = m.top.findNode("mainRect")
  m.itemTitle.color = getTextColor()
  m.itemPriceDisplay = m.top.findNode("itemPriceDisplay")
  m.rightIcon = m.top.findNode("rightIcon")
  m.rightIcon.blendColor = getButtonSelectionColor()
  if getTextColor() = "#FFFFFF"
    m.itemPriceDisplay.color = "#858585"
  else
    m.itemPriceDisplay.color = getTextColor()
  end if
end function



function itemContentChanged() as void
  itemData = m.top.itemContent
  ' m.itemPoster.uri = itemData.logo
  m.itemTitle.text = itemData.subscription_name
  'm.itemType.text =  itemData.subscription_name
  m.itemPriceDisplay.text = itemData.subscription_text
  m.itemTitle.font.size = "35"
  'm.itemType.font.size =  "24"
  m.itemPriceDisplay.font.size = "30"

end function

function onFocusPercent() as void
  if m.top.focusPercent = 1.0
  else if m.top.focusPercent = 0.0
  end if
end function

function onRowFocusPercent() as void
  if m.top.focusPercent = 1.0 then m.rightIcon.opacity = 0.3 else if m.top.focusPercent = 0.0 then m.rightIcon.opacity = 1
end function

function updateLayout()
  m.bgPoster.width = m.top.width
  m.bgPoster.height = m.top.height

  m.mainRect.width = m.top.width
  m.mainRect.height = m.top.height

  m.itemTitle.width = m.top.width - 60
  m.itemTitle.translation = [30, m.top.height - 150]
  m.itemTitle.maxWidth = m.top.width - 60
  m.itemPriceDisplay.width = m.top.width - 60
  m.itemPriceDisplay.translation = [30, m.top.height - 100]

  ' ---- Right Poster ----
  iconSize = 60 ' smaller
  padding = 40

  m.rightIcon.width = iconSize
  m.rightIcon.height = iconSize

  x = m.top.width - iconSize - padding
  y = (m.top.height - iconSize) / 2

  m.rightIcon.translation = [x, y]
end function