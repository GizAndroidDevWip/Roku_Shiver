sub init()
    m.top.functionName = "start"
end sub

function runMultiLanguageUserUpdateApiTask(languageselected as integer)
  
 m.top.language_id= languageselected
    m.top.control = "RUN"
end function

function stopMultiLanguageUserUpdateApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataMultiLanguageUserUpdateApiTaskList = callMultiLanguageUserUpdateApiTask(m.top.language_id)

       ' checking if response is not invalid. If it is not invalid,  then saves the response
        if responseDataMultiLanguageUserUpdateApiTaskList <> invalid then
        
        m.top.MultiLanguageUserUpdateApiTaskContent =  responseDataMultiLanguageUserUpdateApiTaskList

        m.top.MultiLanguageUserUpdateApiTaskListStatus = true
        ?" responseDataMultiLanguageUserUpdateApiTaskList <> invalid"
    else
        m.top.MultiLanguageUserUpdateApiTaskContent = invalid
        m.top.MultiLanguageUserUpdateApiTaskListStatus = false
        ?" responseDataMultiLanguageUserUpdateApiTaskList <> invalid else"

    end if

end sub