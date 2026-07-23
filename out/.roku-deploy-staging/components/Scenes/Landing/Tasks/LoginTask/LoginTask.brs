sub init()
    m.top.functionName = "start"
    print "init LoginTask"
end sub

function runLoginTask(param as string)
    print "RUN LoginTask"
    m.top.control = "RUN"
end function

function stopLoginTask(param as string)
    print "STOP LoginTask"
    m.top.control = "STOP"
end function

sub start()
    responseData = Login(m.top.user_email, m.top.password, m.top.device_id)
    ?"lk"

    m.top.LoginResponse = responseData.status
    m.top.message = responseData.message
?"df"
end sub