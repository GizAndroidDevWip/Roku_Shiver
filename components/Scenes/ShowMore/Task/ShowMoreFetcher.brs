sub init()
    m.top.functionName = "start"
end sub

function runShowMoreTask(param as string)
    m.top.control = "RUN"
end function

function stopShowMoreTask(param as string)
    m.top.control = "STOP"
end function


sub start()

    ' if  m.top.ITEMTYPE = "SHOW"
    '     responseData = GetShowMoreVideos(m.top.categoryId)
    '     content = parseShowMoreList(responseData.data)

    ' else if m.top.ITEMTYPE = "FEATURED"
    '     responseData = GetShowFeaturedVideos()
    '     content = parseShowMoreListForfeatured(responseData.data)
    ' end if


    ' m.top.ShowMoreContent = content
end sub