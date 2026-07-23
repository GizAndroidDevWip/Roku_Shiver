sub init()
    m.top.functionName = "start"
    print "init DeleteAccountTask"
end sub

function runDeleteAccountTask(param as String)
    print "RUN DeleteAccountTask"
    m.top.control = "RUN"
end function

function stopDeleteAccountTask(param as String)
    print "STOP DeleteAccountTask"
    m.top.control = "STOP"
end function

sub start()
    responseData = deleteAccount()
    if responseData <> invalid
        m.top.deleteAccountResponse = responseData
    else
        m.top.deleteAccountResponse = invalid      
    end if
end sub