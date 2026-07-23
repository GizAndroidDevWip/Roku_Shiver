'********** Copyright 2017 Roku Inc.  All Rights Reserved. **********
function init()
  m.top.itemComponentName = "SimpleRowListItemSub"
  m.top.drawFocusFeedback = false
  m.top.numRows = 2
  m.top.itemSize = [1280, 515]
  m.top.rowHeights = [580]
  m.top.rowItemSize = [ [296, 415], [196, 315], [196, 315] ]
  m.top.itemSpacing = [ 0, 80 ]
  m.top.rowItemSpacing = [ [20, 0] ]
  m.top.rowLabelOffset = [ [0, 30] ]
  m.top.showRowLabel = [true, true]
  m.top.rowLabelColor="#FFFFFF"
  m.top.observeField("start","StartLoading")
end function

Function StartLoading()

  print "simplerowlist entered"
'  GetRowListContent()
'  m.top.content = m.data
  m.top.visible = true
  m.top.SetFocus(true)
  m.top.observeField("rowItemSelected", "onRowItemSelected")
  m.top.observeField("rowItemFocused","onRowItemFocused")
end Function

function onRowItemFocused()
  print "focus entered"
     row = m.top.rowItemFocused[0]
     col = m.top.rowItemFocused[1]
    metadata = m.top.content.GetChild(row).GetChild(col)
    print metadata.priceDisplay
    m.top.descriptionData=metadata.title
    m.top.imageNode=metadata.posterUrl
    print   m.top.imageNode
       
end function



function onRowItemSelected() as void         

    row = m.top.rowItemFocused[0]
    col = m.top.rowItemFocused[1]
    metadata = m.top.content.GetChild(row).GetChild(col)
 m.top.selectedContent = {
  price: metadata.price,
  roku_keyword : metadata.roku_keyword,
  subscription_id : metadata.subscription_id,
  title : metadata.title,
  price : metadata.price
  priceDisplay: metadata.cost
}
end function
