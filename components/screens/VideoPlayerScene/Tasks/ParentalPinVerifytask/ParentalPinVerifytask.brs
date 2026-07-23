sub init()
    m.top.functionName = "start"
end sub

function runParentalPinVerifytask(param)
    if m.top.control = "RUN" then
        m.top.control = "STOP"
    end if
    m.show_id = param
    m.top.functionName = "start"
    m.top.control = "RUN"
end function

function stopParentalPinVerifytask()
    m.top.control = "STOP"
end function

function start()
    'call the API to verify the parental pin
    responseDataParentalPinVerifytask = callParentalPinVerifytask(m.top.requestBody)
    m.top.parentalPinResponse = responseDataParentalPinVerifytask
end function