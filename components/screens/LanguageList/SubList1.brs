sub init()
 m.contentRowList1 = m.top.FindNode("contentRowList1")
 m.contentRowList1.observeField("selectedContent", "onContentSelected")
 m.contentRowList1.SetFocus(true)
 m.lbl1=m.top.FindNode("lbl1")
 
 m.languagefetcher = createObject("roSGNode","LanguageFetcher")
 m.LanguageFetcher.observeField("UserSubContent1", "onContentChanged")
 m.top.observeField("begin","onBegin")
end sub


function onContentSelected() as void
  print "sublist1 entered....."
'    m.selectedContent = m.contentRowList1.selectedContent
     
       print m.contentRowList1.selectedContent
    
    
      langid=m.contentRowList1.selectedContent.langid
      
      print "****langg"
      print langid
      sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("langid", langid)
    sec.Flush()
'      
      
      
   m.top.selectedlangid=langid
   
     
    
       
      
    
    
    
'     SetLang()
  'SetAuthData(lan)
    
    
'    appId = createObject("roAppInfo").getID()
'  url = substitute("http://localhost:8060/launch/{0}?restart=true", appId)
'  launchRequest = createObject("roUrlTransfer")
'  launchRequest.setUrl(url)
'  launchRequest.postFromString("")
    
   
   
end function


 
 
' Function SetAuthData(lan As String) As Void
'  lan = m.contentRowList1.selectedContent
'    sec = CreateObject("roRegistrySection", getAppKey())
'    sec.Write("setLang", lan)
'    sec.Flush()
'End Function




sub onContentChanged()
print "haalo"
? "onContentChanged"
    m.contentRowList1.content=m.LanguageFetcher.UserSubContent1
    m.contentRowList1.start="start"
    m.LanguageFetcher.callFunc("stopLanguageFetcherTask","")
end sub

sub onBegin()

    m.LanguageFetcher.callFunc("runLanguageFetcherTask","")
end sub

function getBundleID() as object
  return m.global.BUNDLE_ID
end function

function getAppKey() as object
  return m.global.APP_KEY
end function