sub init()
    m.top.functionName = "listenSearch"
end sub

function runSearchSuggestionFetcherTask(param as string)
    m.top.control = "RUN"
end function

function stopSearchSuggestionFetcherTask(param as string)
    m.top.control = "STOP"
end function

sub listenSearch()
    SearchQuery(m.top.key)
end sub

sub SearchQuery(key as string)

    responseData = getSearchSuggestions(key)
    ?"responseData count"
    ?responseData.data.data.count()

    Catparams = {}
    ContentNode_object = createObject("RoSGNode", "ContentNode")
    for index = 0 to responseData.data.data.count() - 1
        ?"responseData count called"
        ContentNode_child_object = ContentNode_object.createChild("ContentNode")
        ContentNode_child_object.title = responseData.data.data[index]
        ContentNode_child_object.HDLISTITEMICONURL= "pkg:/images/bottom-right.png"
        ContentNode_child_object.HDLISTITEMICONSELECTEDURL= "pkg:/images/bottom-right.png"
        
    end for
    m.LabelContent = ContentNode_object
    m.top.searchSuggestionContent = m.LabelContent
end sub




