sub init()
    m.top.functionName = "start"
    print "init ChannelFetcher"
end sub

function runChannelFetcher(param as string)
    print "RUN ChannelFetcher"
    m.top.control = "RUN"
end function

function stopChannelFetcher(param as string)
    print "STOP ChannelFetcher"
    m.top.control = "STOP"
end function

sub start()
    GetChannelVideos()
end sub



sub GetChannelVideos()
    oneRow = getchannelss()
    list = [
        {
            Title: "Live TV"
            ContentList: oneRow
        }
    ]
    m.top.Content = ParseContent(list)
end sub