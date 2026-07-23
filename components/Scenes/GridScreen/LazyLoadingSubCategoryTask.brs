sub init()
    m.top.functionName = "start"
end sub

function runLazyLoadingSubCategory(param as String)
    m.top.control = "RUN"
end function

function stopLazyLoadingSubCategory(param as String)
    m.top.control = "STOP"
end function

sub start()
    responseDataLazyLoadingSubCategoryList = callLazyLoadingSubCategoryouritesApi(m.top.currentCategoryIdWhichNeedsToUpdate, m.top.offsetCount)

     
' checking if response is not invalid. If it is not invalid,  then saves the response 
    if responseDataLazyLoadingSubCategoryList <> invalid then

        LazyLoadingSubCategoryList = parseLazyLoadingSubCategoryContent(responseDataLazyLoadingSubCategoryList.data.data)

        m.top.LazyLoadingSubCategoryContent = LazyLoadingSubCategoryList

        m.top.LazyLoadingSubCategoryListStatus = true
        ?"responseDataLazyLoadingSubCategoryList <> invalid"
    else
        m.top.LazyLoadingSubCategoryContent = invalid
        m.top.LazyLoadingSubCategoryListStatus = false

    end if

end sub