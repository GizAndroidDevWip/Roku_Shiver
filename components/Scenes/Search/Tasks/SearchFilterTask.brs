sub init()
    m.top.functionName = "getSearchFilters"
    print "init SearchFilterTask"
end sub

function runSearchFilterTask(param as string)
    print "RUN SearchFilterTask"
    m.top.control = "RUN"
end function

function stopSearchFilterTask()
    print "STOP SearchFilterTask"
    m.top.control = "STOP"
end function

sub getSearchFilters()
    m.top.searchFilterContent = parseSearchFilterContent(getSearchFiltersApi())
end sub