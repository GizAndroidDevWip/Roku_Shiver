' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

function init()
    'attaching variables for nodes
    m.background = m.top.findNode("background")
    m.hudGroup = m.top.findNode("hudGroup")
    m.SlideAnimation = m.top.findNode("SlideAnimation")
    m.SlideAnimationInterpolator = m.top.findNode("SlideAnimationInterpolator")
    'Labels
    m.title = m.top.findNode("title")
    m.durationGroup = m.top.findNode("durationGroup")
    
    'extra info
    m.description = m.top.findNode("description")
    
    'setting  ui sizes and fonts for nodes from UIConstants
    m.UIConstants = m.top.createChild("UIConstants")
    
    m.background.width = m.UIConstants.root.background.Size[0]
    m.background.height = m.UIConstants.root.background.Size[1]
    
    m.infoGroup = m.top.findNode("infoGroup")
    m.infoGroup.itemSpacings  = m.UIConstants.root.Hud.infoGroup.itemSpacings
    
    m.description.width =  m.UIConstants.root.Hud.width
    
    m.title.font = m.UIConstants.root.Fonts.Title.node
    m.title.width = m.UIConstants.root.Hud.width
    m.description.font = m.UIConstants.root.Fonts.SubSection.node
    m.description.color = m.UIConstants.root.Fonts.SubSection.color
    m.description.width = m.UIConstants.root.Hud.description.size[0]
    m.description.height = m.UIConstants.root.Hud.description.size[1]
    
end function
    
sub OnOffsetChange()
    m.infoGroup.translation = [m.top.offset[0], m.UIConstants.root.Hud.infoGroup.translation[1]]
end sub

sub OnContentChanged()
    item = m.top.content
        ?"METADATA= "+item.DESCRIPTION
        m.title.text = item.TITLE
        m.description.text= item.DESCRIPTION
end sub

Function onHeightChanged()
    m.hudGroup.translation = [0, m.UIConstants.root.background.Size[1] - m.top.height + 1] 'adjust
End Function

'Animation
Function OnVisibilityChanged()
    if m.top.show then
        m.SlideAnimationInterpolator.keyValue = [m.hudGroup.opacity, 1]
    else
        m.SlideAnimationInterpolator.keyValue = [m.hudGroup.opacity, 0]
    end if        
    m.SlideAnimation.control = "start"
End Function