sub init()
 m.contentRowList = m.top.FindNode("contentRowList")
 m.contentRowList.observeField("selectedContent", "onContentSelected")
 m.contentRowList.SetFocus(true)
 m.lbl1=m.top.FindNode("lbl1")
 m.top.loading = m.top.CreateChild("Loading") ' loading created this way because loading needs to above every views. some views are defined here in brs file. not in xml
 m.top.loading.visible = false
 m.ListFetcher = createObject("roSGNode","ListFetcher")
 m.ListFetcher.observeField("UserSubContent", "onContentChanged")
 m.ListFetcher.observeField("SubBoolean","onContentEmptyChanged")
 m.top.observeField("begin","onBegin")
 m.top.begin = "start"
end sub


function onContentSelected() as void
    m.selectedContent = m.contentRowList.selectedContent
end function



sub onContentChanged()
? "onContentChanged"
    m.contentRowList.content=m.ListFetcher.UserSubContent
    m.top.loading.visible = false
end sub

sub onContentEmptyChanged()
print "entered boolean"
if(m.ListFetcher.SubBoolean=false) then

   m.lbl1.visible=true
  
else
   m.lbl1.visible=false
   m.contentRowList.SetFocus(true)
end if

end sub

sub onBegin()
    m.top.loading.visible = true
    m.ListFetcher.callFunc("runListFetcher","")
end sub