'********** Copyright 2017 Roku Inc.  All Rights Reserved. **********
function init()

  m.top.itemComponentName = "SimpleRowListItemSub1"
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

  print "simplerowlist enteredddd"
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
    print "subscriptionlistssss........"
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
  langid: metadata.audio_language_id,
  
}
end function
