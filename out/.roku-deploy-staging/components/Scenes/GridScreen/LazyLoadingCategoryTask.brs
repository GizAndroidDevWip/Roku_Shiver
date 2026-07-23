sub init()
    m.top.functionName = "start"
end sub

function runLazyLoadingCategory(param as String)
    m.top.control = "RUN"
end function

function stopLazyLoadingCategory(param as String)
    m.top.control = "STOP"
end function

sub start()
    responseDataLazyLoadingCategoryList = callLazyLoadingCategoryouritesApi( m.top.offsetCount)

     
' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataLazyLoadingCategoryList <> invalid then

        LazyLoadingCategoryList = parseLazyLoadingCategoryContent(responseDataLazyLoadingCategoryList.data.data)

        m.top.LazyLoadingCategoryContent = LazyLoadingCategoryList

        m.top.LazyLoadingCategoryListStatus = true
        ?"responseDataLazyLoadingCategoryList <> invalid"
    else
        m.top.LazyLoadingCategoryContent = invalid
        m.top.LazyLoadingCategoryListStatus = false

    end if

end sub