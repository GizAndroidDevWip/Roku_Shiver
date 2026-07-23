sub init()
    m.top.functionName = "fetchConfigText"
end sub

sub fetchConfigText()
    configType = m.top.configType
    if configType = invalid or configType = "" then return
    m.top.textResult = GetConfigText(configType)
end sub
