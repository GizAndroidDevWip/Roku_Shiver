sub init()
  m.top.functionName = "start"
  print "init playListadd"  
End sub

function runPlayListAdd(param as String)
    print "RUN playListadd"
    m.top.control = "RUN"
end function

function stopPlayListAdd(param as String)
    print "STOP playListadd"
    m.top.control = "STOP"
end function

sub start()
    responseData = playlistaddremove(m.top.wflag,m.top.showid,m.top.uid)
    if responseData <> invalid
        m.top.PlaylistResponse = responseData
    else
        m.top.PlaylistResponse = responseData        
    end if
end sub