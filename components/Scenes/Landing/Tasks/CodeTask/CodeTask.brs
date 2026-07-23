sub init()
  m.top.functionName = "start"
  print "init CodeTask"  
End sub

function runCodeTask(param as String)
    print "RUN CodeTask"
    m.top.control = "RUN"
end function

function stopCodeTask(param as String)
    print "STOP CodeTask"
    m.top.control = "STOP"
end function

sub start()
      print m.top.code
       responseData = LoginCode(m.top.code)
       ?"print responseData: codeTask"
       ?responseData
       if responseData = invalid
       m.top.CodeResponse ="invalid" 
           else
          m.top.CodeResponse ="valid"
       end if
end sub