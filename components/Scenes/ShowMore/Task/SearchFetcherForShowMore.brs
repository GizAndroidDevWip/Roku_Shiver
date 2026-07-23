sub init()
    m.top.functionName = "listenSearch"
    print "init SearchFetcher"
end sub

function runSearchFetcherTask(param as string)
    print "RUN SearchFetcher"
    m.top.control = "RUN"
end function

function stopSearchFetcherTask(param as string)
    print "STOP SearchFetcher"
    m.top.control = "STOP"
end function

sub listenSearch()
    params = {}
    params.AddReplace("key", m.top.SearchRequest)
    params.AddReplace("filters", m.top.searchFilter)
    params.AddReplace("country_code", getCountrycode())
    params.AddReplace("pubid", getPubID())
    if m.top.searchType <> invalid and m.top.searchType <> ""
        if m.top.searchType = "TAGS" or m.top.searchType = "CAST" or m.top.searchType = "CREW"
            m.top.searchContent = parseSearchContentForShowMore2(GetSearchVideoss(params))
        else
            data = GetCategoryVideoss(params)
            if data <> invalid and data.shows <> invalid
                m.top.searchContent = parseSearchContentForShowMore(data)
            else
                m.top.searchContent = CreateObject("RoSGNode", "ContentNode")
            end if
        end if
    end if
end sub


