sub ShowShowPageForUpcomingEventScreenStackLogicScreen(focusedContent)
    m.ShowPageForUpcomingEvent = CreateObject("roSGNode", "ShowPageForUpcomingEvent")
    m.ShowPageForUpcomingEvent.observeField("gotoLandingScene","onGoToLandingScene")
    m.ShowPageForUpcomingEvent.ObserveField("goToPaymentDescriptionScreen","onGoToPaymentDescriptionScree2")
    m.ShowPageForUpcomingEvent.ObserveField("goToPaymentDescriptionScreenForEvent","onGoToPaymentDescriptionScreenforEvent")
    m.ShowPageForUpcomingEvent.ObserveField("rowItemSelected","onGoToShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo")

    ?"showScreenLogic called"
    m.ShowPageForUpcomingEvent.itemType = focusedContent.itemType
    m.ShowPageForUpcomingEvent.upcomingEventId = focusedContent.upcomingEventId
    ShowScreen(m.ShowPageForUpcomingEvent)
end sub



' sub onGoToLandingScreen()
'     ?"onGoToLandingScreencalled"
'     showLandingScreen()
' end sub




' sub onGoToPaymentDescriptionScree2()
'     ?"onGoToPaymentDescriptionScree2called"
'     '**********below is done to prevent an issue - when we created multiple show instance means 
'     'goes from one showdetail to another showdetail and so, coming back from one show page does not give the very previous
'     'show pages's details, so previous show page data is taken from screenstackarray.
'     videoIdOfPeekshowPageInScreenStackArray = m.global.screenStackArray.Peek().goToPaymentDescriptionScreen 
'     videoSubscriptionListScreen(videoIdOfPeekshowPageInScreenStackArray)
' end sub

' sub onGoToPaymentDescriptionScreenforEvent()
'     ?"onGoToPaymentDescriptionScree2called"
'     goToPaymentDescriptionScreenForEvent = m.global.screenStackArray.Peek().goToPaymentDescriptionScreen 
'     videoSubscriptionListScreen(goToPaymentDescriptionScreenForEvent)    
' end sub


' sub onGoToShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo(event as object)
'     rowlist = event.GetRoSGNode().getChild(0).getChild(3).getChild(11).getChild(3) ' to get the rowlist from node by node from show.xml views stack
'     m.selectedIndex = event.GetData()
'     rowContent = rowlist.content.GetChild(m.selectedIndex[0])
'     rowContentItem = rowContent.getChild(m.selectedIndex[1])
'     if rowContentItem.itemType = "shows"  
'         ShowShowDetailsScreen(rowContentItem)
'     end if
' end sub


''this function is for handling issue - when going from showscene to another showscene clicking you may also like, existing show instance is overritten
''this function is to prevent that and preserve the show instances in an array. use this if needed in future
' sub ShowShowDetailsScreen(focusedContent)
'     if m.shows = invalid ' Check if m.shows is not yet created
'         m.shows = CreateObject("roAssociativeArray")
'     end if

'     ' Create a unique key for each instance of m.show
'     key = focusedContent.TITLE + "_" + Str(focusedContent.show_id)

'     ' Check if an instance already exists for the key
'     if m.shows.DoesExist(key)
'         m.show = m.shows.Lookup(key)
'     else
'         m.show = CreateObject("roSGNode", "Show")
'         m.shows.AddReplace(key, m.show)
'         m.show.observeField("gotoLandingScene","onGoToLandingScene")
'         m.show.ObserveField("goToPaymentDescriptionScreen","onGoToPaymentDescriptionScree2")
'         m.show.ObserveField("goToPaymentDescriptionScreenForEvent","onGoToPaymentDescriptionScreenforEvent")
'         m.show.ObserveField("rowItemSelected","onGoToShowScrnFrmShwDtlScrnWhenClckingUMayAlsoLikeVideo")
'     end if

'     ?"showScreenLogic called"
'     m.show.itemType = focusedContent.itemType
'     m.show.upcomingEventId = focusedContent.upcomingEventId
'     m.show.start = focusedContent.show_id
'     ShowScreen(m.show)
' end sub


