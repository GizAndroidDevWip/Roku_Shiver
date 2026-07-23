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
    m.top.searchContent = parseSearchContent(calSearchApiNew(params))
end sub

