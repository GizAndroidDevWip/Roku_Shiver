'********** Copyright 2017 Roku Inc.  All Rights Reserved. **********
function init()
  m.top.itemComponentName = "SimpleRowListItem"
  m.top.focusBitmapUri="pkg:/images/focus_grid.9.png"
  m.top.numRows = 3
  m.top.itemSize = [1920, 200]
  m.top.rowHeights = [230, 230, 230, 230, 230]
  m.top.rowItemSize = [[1560, 200]]
  m.top.itemSpacing = [10, 10]
  m.top.rowItemSpacing = [[5, 5]]
  m.top.rowFocusAnimationStyle = "floatingfocus"
  m.top.vertFocusAnimationStyle="floatingfocus"
  m.top.showRowLabel = [true, true]
  m.top.rowLabelColor = getTextColor()
  m.top.observeField("start", "StartLoading")
end function

function StartLoading()
  m.top.visible = true
  m.top.SetFocus(true)
  m.top.observeField("rowItemSelected", "onRowItemSelected")
  m.top.observeField("rowItemFocused", "onRowItemFocused")
end function


function onRowItemSelected() as void
  row = m.top.rowItemFocused[0]
  col = m.top.rowItemFocused[1]
  metadata = m.top.content.GetChild(row).GetChild(col)
  print metadata
  m.top.selectedContent = {
    price: metadata.price,
    roku_keyword: metadata.roku_keyword,
    subscription_id: metadata.subscription_id,
    title: metadata.title,
    ' price : metadata.cost
    priceDisplay: metadata.price
  }
  print "cco"
  print m.top.selectedContent

end function
