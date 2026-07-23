' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

Function init()
    
    m.LayoutGroup = m.top.findNode("LayoutGroup")
    'checks is the node transfer from outside if not 
    'than we create built in node.
    if m.top.title = invalid then
        m.top.title = m.LayoutGroup.createChild("Label")
        m.top.title.id = "title"
    else
        m.top.title.id = "title"
        m.LayoutGroup.appendChild(m.top.title)
        m.top.title = m.LayoutGroup.findNode("title")
    end if
    
    if m.top.ReleaseDate = invalid then
        m.top.ReleaseDate = m.LayoutGroup.createChild("Label")
        m.top.ReleaseDate.id = "ReleaseDate"
    else
        m.top.ReleaseDate.id = "ReleaseDate"
        m.LayoutGroup.appendChild(m.top.ReleaseDate)
        m.top.ReleaseDate = m.LayoutGroup.findNode("ReleaseDate")
    end if
    
    if m.top.description = invalid then
        m.top.description = m.LayoutGroup.createChild("Label")
        m.top.description.id = "description"
    else
        m.top.description.id = "description"
        m.LayoutGroup.appendChild(m.top.description)
        m.top.description = m.LayoutGroup.findNode("description")
    end if
    m.top.description.wrap = true
    
    'set fonts for labels from UIConstants 
    m.UIConstants = m.top.createChild("UIConstants")
    
    m.top.title.font  = m.UIConstants.root.Fonts.Title.node
    m.top.title.color = m.UIConstants.root.Fonts.Title.color
    
    m.top.ReleaseDate.font  = m.UIConstants.root.Fonts.Section.node
    m.top.ReleaseDate.color = m.UIConstants.root.Fonts.Section.color
    
    m.top.description.font  = m.UIConstants.root.Fonts.SubSection.node
    m.top.description.color = m.UIConstants.root.Fonts.SubSection.color
    
    m.LayoutGroup.itemSpacings = m.UIConstants.root.ItemDetails.itemSpacings
End Function

Function OnContentchanged()
    if m.top.content <> invalid 
        item = m.top.content
        
        title = item.title
        if title <> invalid
            m.top.title.text = title
        end if
        
        value = item.description
        if value <> invalid
            m.top.description.text = value
        end if
        
        value = item.ReleaseDate
        if value <> invalid
            m.top.ReleaseDate.text = value
        end if    
    end if
End Function