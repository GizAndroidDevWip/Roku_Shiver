' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
 'setting top interfaces

Sub Init()
    m.top.Title             = m.top.findNode("Title")
    m.top.Description       = m.top.findNode("Description")
    m.resolution            =m.top.findNode("resolution")
    m.resolution.translation=[30,80]

'    m.top.Description.DescFont=font
    m.category_name                 =m.top.findNode("category_name")

    m.year                  =m.top.findNode("year")
'    m.producer              =m.top.findNode("producer")
           
           
'    m.top.ReleaseDate       = m.top.findNode("ReleaseDate")
End Sub

' Content change handler
' All fields population
Sub OnContentChanged()
    item = m.top.content
    print "description itemm"
    print item.year
    print item.resolution    
    print item.title.toStr()
    print item.resolution.toStr()
    
        
        
     sec = CreateObject("roRegistrySection", getAppKey())
    sec.Write("partnertitle", item.title.toStr())
    sec.Write("partnerdescription", item.resolution.toStr())
    sec.Flush()
    
      if item.year <> invalid
      m.year.visible=true
      else
            m.year.visible=false
      
      end if
     
     if item.resolution <> invalid
      m.resolution.visible=true
      else
            m.resolution.visible=false
      
      end if
     
    title = item.title.toStr()
    
    if title <> invalid then
         if(item.year <> invalid)
          m.top.Title.text = title.toStr()+" "+"("+item.year.toStr()+")"
          
          else
          m.top.Title.text = title.toStr()
         end if
        
    end if
    
'    value = item.description
'    if value <> invalid then
'        if value.toStr() <> "" then
'           
'            m.top.description.text = value.toStr()
'           
'        else
'            m.top.description.text = ""
'        end if
'    end if
    
    value1 = item.resolution
    if value1 <> invalid then
        if value1.toStr() <> "" then
           m.resolution.visibility=true
            m.resolution.text =value1.toStr()
        else
            m.resolution.text = ""
            
        end if
    end if
    
    
'     value2 =item.producer
'    if value2 <> invalid then
'        if value2.toStr() <> "" then
'             m.producer.visibility=true
'            m.producer.text ="Producer:"+" "+value2.toStr()
'        else
'            m.producer.text = ""
'        end if
'    end if
    
    
     value3 = item.year
    if value3 <> invalid then
        if value3.toStr() <> "" then
             m.year.visibility=true
'            m.year.text ="Year:"+" "+value3.toStr()
        else
'            m.year.text = ""
        end if
    end if
    
    value4 = item.category_name
    if value4 <> invalid then
'        if value4.toStr() <> "" then
       category=""
       arrayLength=value4.count()
       lastItem=value4[arrayLength-1]
       
      for each item in value4
          if(arrayLength<2) 
               category=category+item     
          else
              if(item = lastItem)
                    category=category+item
              else
                    category=category+item+" "+","
              end if
               
              
          end if
       end for
          
          print 'category listinggggg'
          print category
            m.category_name.visibility=true
            m.category_name.text = ""
            m.category_name.translation=[100,555]
        else
            m.category_name.text = ""
                 
'        end if
    end if
      
'    value = item.ReleaseDate
'    if value <> invalid then
'        if value <> ""
'            m.top.ReleaseDate.text = value.toStr()
'        else
'            m.top.ReleaseDate.text = "No release date"
'        end if
'    end if
End Sub

function getBundleID() as object
    return m.global.BUNDLE_ID
end function

function getAppKey() as object
    return m.global.APP_KEY
end function