sub init()
    m.top.functionName = "fetchAccountData"
end sub

sub fetchAccountData()
    data = GetAccountDetails()
    ? "Account data fetched: " formatjson(data)
    if data <> invalid
        m.top.accountData = data
    end if
end sub
