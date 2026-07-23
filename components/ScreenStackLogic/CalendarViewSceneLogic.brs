sub showCalendarViewScene()
    m.CalendarViewScene = CreateObject("roSGNode", "CalendarViewScene")
    m.CalendarViewScene.observeField("closeThisPage", "closeThisPage5")
    m.CalendarViewScene.observeField("gotovideoplayerscene", "onGotoVideoPlayerScene2")
    ShowScreen(m.CalendarViewScene)
end sub


sub closeThisPage5()
    CloseScreen(m.CalendarViewScene)
end sub

sub onGotoVideoPlayerScene2()
    utilityAssoc = {
        calendarId: m.CalendarViewScene.gotovideoplayerscene.calendar_id.ToStr()
    }
    showVideoPlayerScene(m.CalendarViewScene.gotovideoplayerscene.video_id, "", "", true, utilityAssoc)
end sub