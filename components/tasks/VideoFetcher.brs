sub init()
    m.top.functionName = "start"
    print "init VideoFetcher"
end sub

function runVideoFetcherTask(param as string)
    print "RUN VideoFetcher"
    m.top.control = "RUN"
end function

function stopVideoFetcherTask(param as string)
    print "STOP VideoFetcher"
    m.top.control = "STOP"
end function

sub start()
    if m.top.taskType = "CatRequest" then
        GetLabelContent()
    end if
    if m.top.taskType = "ContentRequest" then
        GetCatVideos(m.top.ContentRequest)
    end if
end sub

sub GetLabelContent() 'label list data / category list data
    Catparams = {}
    ContentNode_object = createObject("RoSGNode", "ContentNode")

    for each jsonitem in GetCategories(Catparams)
        ContentNode_child_object = ContentNode_object.createChild("ContentNode")
        ContentNode_child_object.title = jsonitem.categoryname
        ContentNode_child_object.id = jsonitem.categoryid
        ContentNode_child_object.addFields({
            "key": jsonitem.key,
            "type": jsonitem.type
        })
    end for
    m.top.LabelContent = ContentNode_object

      '********** parsing response
        m.top.CategoryListingParsing = ParseContentForCategoryListing(m.top.LabelContent )

    ?"kj"
end sub


sub GetCatVideos(ContentRequest as string)  'Subcategory list data
    videos = ParseShowContent(getCatVODContent(ContentRequest))
    if videos <> invalid and videos.getChild(0) <> invalid and videos.getChild(0).getChild(0) = invalid
        m.top.CatBoolean = true'
    else
        m.top.CatBoolean = false
    end if
    m.top.content = videos
    ?"nk"
end sub