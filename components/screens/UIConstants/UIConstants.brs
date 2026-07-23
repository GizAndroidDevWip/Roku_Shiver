' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********
sub init()
    m.DeviceInfo = CreateObject("roDeviceInfo")
    m.displaySize = m.DeviceInfo.GetUIResolution()
    m.top.SCREEN_WIDTH = m.displaySize.width 
    m.top.SCREEN_HEIGHT = m.displaySize.height
    m.top.displayType = m.displaySize.name
    m.top.isFHD = (m.top.displayType = "FHD") 
    m.top.isHD  = (m.top.displayType = "HD")
    m.top.isSD  = (m.top.displayType = "SD")
    
    if m.top.isHD or m.top.isFHD then
        'Title font        
        m.TitleFont = createObject("roSGNode","Font")
        m.TitleFont.id="titleFont"
        m.TitleFont.size = "42"
        m.TitleFont.uri = "pkg:/fonts/Gotham-Bold-Lat.ttf"
        
        'Section font
        m.SectionFont = createObject("roSGNode","Font")
        m.SectionFont.id="SectionFont"
        m.SectionFont.size = "24"
        m.SectionFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        'SubSection font
        m.SubSectionFont = createObject("roSGNode","Font")
        m.SubSectionFont.id="SubSectionFont"
        m.SubSectionFont.size = "28"
        m.SubSectionFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        'Text font
        m.TextFont = createObject("roSGNode","Font")
        m.TextFont.id="TextFont"
        m.TextFont.size = "30"
        m.TextFont.uri = "pkg:/fonts/Gotham-Bold-Lat.ttf"
        
        'LabelFont
        m.LabelFont = createObject("roSGNode","Font")
        m.LabelFont.id="LabelFont"
        m.LabelFont.size = "34"
        m.LabelFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        'FocusedFont
        m.FocusedFont = createObject("roSGNode","Font")
        m.FocusedFont.id="LabelFont"
        m.FocusedFont.size = "34"
        m.FocusedFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        gridItemNum = 4
        gridNumRows = 5
        m.top.root = {
            Fonts : {
                Title: {
                    node : m.TitleFont
                    color : "0xFFFFFFFF"
                    }
                Section : {
                    node : m.SectionFont
                    color : "0xCCCCCCFF"
                    }
                SubSection : {
                    node : m.SubSectionFont
                    color: "0xFFFFFFFF"
                    }
                Text : {
                    node : m.TextFont
                    color: "0xFFFFFFFF"
                    }
                Label : {
                    node : m.LabelFont
                    color: "0xFFFFFFFF"
                    }
                FocusedLabel : {
                    node : m.FocusedFont
                    color: "0xFFFFFFFF"
                    }               
                }
            Grid : {
                itemSize : [397 * gridItemNum + 30 * gridItemNum, 307]
                NumRows : gridNumRows
                RowSpacings : [100, 100, 100, 100]
                RowItemSize : [[400, 300]]
                RowItemSpacing : [[30, 0]]
                }
            LiveVideo : {
                Size : [824, 462]
                }        
            LayoutItemGroup : {
                translation  : [15, 0]
                }
            LabelList : {
                itemSize : [340, 105]
                }
            ItemDetails : {
                itemSpacings : [17, 17]
                width        : 800
                widthExp     : 1100
                height       : 200
                heightExp    : 120
                }
            background : {
                size : [1920, 1080]
                }
            Hud : {
                height       :  322
                width        :  1560
                infoGroup    : {
                    translation  : [200, 38]
                    itemSpacings : [40]
                    }
                description  : {
                    size : [1560, 150]
                    }
                }           
            }       
    else if m.top.isSD then
        'Title font        
        m.TitleFont = createObject("roSGNode","Font")
        m.TitleFont.id="titleFont"
        m.TitleFont.size = "18"
        m.TitleFont.uri = "pkg:/fonts/Gotham-Bold-Lat.ttf"
        
        'Section font
        m.SectionFont = createObject("roSGNode","Font")
        m.SectionFont.id="SectionFont"
        m.SectionFont.size = "12"
        m.SectionFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        'SubSection font
        m.SubSectionFont = createObject("roSGNode","Font")
        m.SubSectionFont.id="SubSectionFont"
        m.SubSectionFont.size = "14"
        m.SubSectionFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        'Text font
        m.TextFont = createObject("roSGNode","Font")
        m.TextFont.id="SubSectionFont"
        m.TextFont.size = "15"
        m.TextFont.uri = "pkg:/fonts/Gotham-Bold-Lat.ttf"
        
        'LabelFont
        m.LabelFont = createObject("roSGNode","Font")
        m.LabelFont.id="LabelFont"
        m.LabelFont.size = "15"
        m.LabelFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        'FocusedFont
        m.FocusedFont = createObject("roSGNode","Font")
        m.FocusedFont.id="LabelFont"
        m.FocusedFont.size = "15"
        m.FocusedFont.uri = "pkg:/fonts/Gotham-Book-Lat.ttf"
        
        gridItemNum = 3
        gridNumRows = 6
        
        m.top.root = {
            Fonts : {
                Title: {
                    node : m.TitleFont
                    color : "0xFFFFFFFF"
                    }
                Section : {
                    node : m.SectionFont
                    color : "0xCCCCCCFF"
                    }
                SubSection : {
                    node : m.SubSectionFont
                    color: "0xFFFFFFFF"
                    }
                Text : {
                    node : m.TextFont
                    color: "0xFFFFFFFF"
                    }
                Label : {
                    node : m.LabelFont
                    color: "0xFFFFFFFF"
                    }
                FocusedLabel : {
                    node : m.FocusedFont
                    color: "0xFFFFFFFF"
                    }               
                }
            Grid : {
                itemSize : [199 * gridItemNum + 26 * gridItemNum, 155]
                NumRows : gridNumRows
                RowSpacings : [14, 14, 14, 14]
                RowItemSize : [[199, 155]]
                RowItemSpacing : [[12, 0]]
                }
            LiveVideo : {
                Size : [310, 174]
                }
            LayoutItemGroup : {
                translation  : [6, 0]
                }
            LabelList : {
                itemSize : [170, 45]
                }
            ItemDetails : {
                itemSpacings : [10, 10]
                width        : 300
                widthExp     : 400
                height       : 75
                heightExp    : 50
                }
            background : {
                size : [720, 480]
                }
            Hud : {
                height       :  150
                width        :  550
                infoGroup    : {
                    translation  : [75, 15]
                    itemSpacings : [15]
                    }
                description  : {
                    size : [550, 70]
                    }
                }           
            }
    else
        ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
        ? ">>>>>>>>>>>>>>>>>Unsupported screen format<<<<<<<<<<<<<<<<<<<<"
        ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    end if
end sub