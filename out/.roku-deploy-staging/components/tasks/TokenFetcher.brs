sub init()

  m.Pport = createObject("roMessagePort")
  m.top.observeField("TokenRequest", m.Pport)
  m.top.functionName = "startToken"
  print "RUN TokenFetcher"
  m.top.control = "RUN"
End sub

sub startToken()

  while true
    msg = wait(0, m.Pport)
    mt = type(msg)
    if mt = "roSGNodeEvent" and msg.getField()="TokenRequest" then
    ? "ITEM requested"
           GetTokenForPlayer()     
    end if  
  end while
end sub

sub GetTokenForPlayer()
      m.top.Token = getTokenPlayer()
end sub

