' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

'cache children nodes for future operations
function Init()
  m.top.categoryRowlist = m.top.FindNode("RowList")
  m.top.observeField("focusedChild", "OnFocusedChildChanged")


end function



'handle categoryRowlist item focus change
function OnFocusedChildChanged()
  if m.top.isInFocusChain() and not m.top.categoryRowlist.hasFocus() then
    m.top.categoryRowlist.setFocus(true)
  end if
end function



sub OnItemFocused()
  itemFocused = m.top.itemFocused

  if itemFocused.Count() = 2 then
    focusedContent = m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
    if focusedContent <> invalid then
      m.top.focusedContent = focusedContent
      m.background.uri = focusedContent.hdBackgroundImageUrl
    end if
  end if
end sub
