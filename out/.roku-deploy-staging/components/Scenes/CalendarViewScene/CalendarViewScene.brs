sub init()
    m.top.observeField("visible", "onTopVisibleChanged")
    m.datesPillRowlist = m.top.findNode("datesPillRowlist")
    m.datesPillRowlist.observeField("rowItemFocused", "onRowItemSelected")
    m.calendarRowList = m.top.findNode("calendarRowList")
    m.calendarRowList.observeField("rowItemSelected", "onRowItemSelected_Calendar")
    m.calendarRowList.color = getTextColor()
    m.calendarRowList.rowLabelColor = getTextColor()
    m.calendarRowList.focusBitmapBlendColor = getButtonSelectionColor()
    m.calendarRowList.focusedColor = getTextColor()
    m.noResultsLabel = m.top.findNode("noResultsLabel")
    m.noResultsLabel.color = getTextColor()
    m.background = m.top.findNode("background")
    m.background.color = getBackgroundColor1()
    m.calendarTitle = m.top.findNode("calendarTitle")
    m.calendarTitle.font.size = 55
    m.calendarTitle.color = getTextColor()
    getCalendarVideosTask()
end sub

function onTopVisibleChanged(event as object)
    if m.top.visible then
        m.datesPillRowlist.setFocus(true)
    else
    end if
end function

sub getCalendarVideosTask()
    ?"getCalendarVideosTask called"
    m.getCalendarVideosTask = CreateObject("roSGNode", "GetCalendarVideosTask")
    m.getCalendarVideosTask.observeField("CalendarVideosListStatus", "onGetCalendarVideosTaskStatus")
    today = createObject("roDateTime")
    currentYear = today.GetYear()
    currentMonth = today.GetMonth()
    m.getCalendarVideosTask.dateRange = getCalendarVisibleDates(currentYear, currentMonth)
    m.getCalendarVideosTask.callFunc("runGetCalendarVideosTask", "")
end sub

function onGetCalendarVideosTaskStatus()
    m.datesPillRowlist.content = m.getCalendarVideosTask.CalendarVideosContent.datesPill
    m.datesPillRowlist.setFocus(true)
    ' updateCalendarRowListByDate("2025-05-08")
    updateCalendarRowListByDate(getTodayDateString())
    ' m.calendarRowList.content = m.getCalendarVideosTask.CalendarVideosContent
    selectTodayInDatesPillRowlist()

end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press then
        if key = "up" then
            if m.calendarRowList.hasFocus() then
                ' Handle up key when calendarRowList has focus
                m.datesPillRowlist.setFocus(true)
                return true
            end if
        else if key = "down" then
            if m.datesPillRowlist.hasFocus() then
                m.calendarRowList.setFocus(true)
                return true
            end if
        else if key = "left" then
            ' Handle left key
            return true
        else if key = "right" then
            ' Handle right key
            return true
        else if key = "OK" then
            ' Handle OK/select key
            return true
        else if key = "back" then
            ' Handle back key
            m.top.closeThisPage = true
            return true
        end if
    end if
    return false
end function

function onRowItemSelected()
    ?"onRowItemSelected called"
    itemSelected = m.datesPillRowlist.rowItemFocused[1]
    if m.datesPillRowlist.content <> invalid and m.datesPillRowlist.content.getchild(0).getchild(itemSelected) <> invalid
        selectedDate = m.datesPillRowlist.content.getchild(0).getchild(itemSelected).title
        updateCalendarRowListByDate(selectedDate)
    end if
end function

sub updateCalendarRowListByDate(selectedDate as string)
    ?"updateCalendarRowListByDate called with selectedDate: "; selectedDate
    'copy the calendar content to a backup variable
    m.calendarContentMainBackup = m.getCalendarVideosTask.CalendarVideosContent.clone(true)
    ' Clear existing content first
    m.calendarRowList.content = invalid

    ' Create a new filtered root node
    filteredRow = createObject("roSGNode", "ContentNode")

    ' Loop through each row in calendarContentMainBackup
    for each row in m.calendarContentMainBackup.getChildren(m.calendarContentMainBackup.getChildCount(), 0)
        newRow = createObject("roSGNode", "ContentNode")
        newRow.title = row.title

        for each item in row.getChildren(row.getChildCount(), 0)
            if item.date = selectedDate
                newRow.appendChild(item)
            end if
        end for

        ' Add the row only if it has matching items
        if newRow.getChildCount() > 0
            filteredRow.appendChild(newRow)
        end if
    end for

    ' Set filtered content to the RowList
    if filteredRow.getChildCount() = 0
        m.noResultsLabel.visible = true
        m.calendarRowList.visible = false
    else
        m.calendarRowList.content = filteredRow
        m.noResultsLabel.visible = false
        m.calendarRowList.visible = true
    end if
    ' m.calendarRowList.setFocus(true)
end sub

function getTodayDateString() as string
    today = createObject("roDateTime")
    year = today.GetYear().ToStr()
    month = today.GetMonth().ToStr()
    day = today.GetDayOfMonth().ToStr()

    ' Pad month and day with leading zeros if needed
    if month.len() = 1 then
        month = "0" + month
    end if

    if day.len() = 1 then
        day = "0" + day
    end if

    return year + "-" + month + "-" + day
end function



function getCalendarVisibleDates(year as integer, month as integer) as object
    ' ' Format start date string (1st of the month)
    ' monthStr = ""
    ' if month < 10
    '     monthStr = "0" + month.ToStr()
    ' else
    '     monthStr = month.ToStr()
    ' end if

    ' startDateStr = year.ToStr() + "-" + monthStr + "-01"
    ' startDate = createObject("roDateTime")
    ' startDate.FromISO8601String(startDateStr + "T00:00:00Z") ' Use full ISO string

    ' ' Determine next month and year
    ' if month = 12
    '     nextMonth = 1
    '     nextYear = year + 1
    ' else
    '     nextMonth = month + 1
    '     nextYear = year
    ' end if

    ' nextMonthStr = ""
    ' if nextMonth < 10
    '     nextMonthStr = "0" + nextMonth.ToStr()
    ' else
    '     nextMonthStr = nextMonth.ToStr()
    ' end if

    ' nextMonthDateStr = nextYear.ToStr() + "-" + nextMonthStr + "-01"
    ' nextMonthDate = createObject("roDateTime")
    ' nextMonthDate.FromISO8601String(nextMonthDateStr + "T00:00:00Z")

    ' ' Subtract one day (86400 seconds) to get the last day of the current month
    ' lastDaySeconds = nextMonthDate.AsSeconds() - 86400
    ' endDate = createObject("roDateTime")
    ' endDate.FromSeconds(lastDaySeconds)

    ' ' Format day string
    ' endMonthStr = ""
    ' if endDate.GetMonth() < 10
    '     endMonthStr = "0" + endDate.GetMonth().ToStr()
    ' else
    '     endMonthStr = endDate.GetMonth().ToStr()
    ' end if

    ' endDayStr = ""
    ' if endDate.GetDayOfMonth() < 10
    '     endDayStr = "0" + endDate.GetDayOfMonth().ToStr()
    ' else
    '     endDayStr = endDate.GetDayOfMonth().ToStr()
    ' end if

    ' endDateStr = endDate.GetYear().ToStr() + "-" + endMonthStr + "-" + endDayStr

    ' return {
    '     daystart: startDateStr,
    '     dayend: endDateStr
    ' }
    ' Format start date string (1st of the month)
    monthStr = ""
    if month < 10
        monthStr = "0" + month.ToStr()
    else
        monthStr = month.ToStr()
    end if

    startDateStr = year.ToStr() + "-" + monthStr + "-01"
    startDate = createObject("roDateTime")
    startDate.FromISO8601String(startDateStr + "T00:00:00Z") ' Use full ISO string

    ' Determine next month and year
    if month = 12
        nextMonth = 1
        nextYear = year + 1
    else
        nextMonth = month + 1
        nextYear = year
    end if

    ' --- CHANGE: Get NEXT NEXT month for last day ---
    if nextMonth = 12
        nextNextMonth = 1
        nextNextYear = nextYear + 1
    else
        nextNextMonth = nextMonth + 1
        nextNextYear = nextYear
    end if

    nextNextMonthStr = ""
    if nextNextMonth < 10
        nextNextMonthStr = "0" + nextNextMonth.ToStr()
    else
        nextNextMonthStr = nextNextMonth.ToStr()
    end if

    ' Use 1st of next-next month
    nextNextMonthDateStr = nextNextYear.ToStr() + "-" + nextNextMonthStr + "-01"
    nextNextMonthDate = createObject("roDateTime")
    nextNextMonthDate.FromISO8601String(nextNextMonthDateStr + "T00:00:00Z")

    ' Subtract one day (86400 seconds) to get the last day of NEXT month
    lastDaySeconds = nextNextMonthDate.AsSeconds() - 86400
    endDate = createObject("roDateTime")
    endDate.FromSeconds(lastDaySeconds)

    ' Format day string
    endMonthStr = ""
    if endDate.GetMonth() < 10
        endMonthStr = "0" + endDate.GetMonth().ToStr()
    else
        endMonthStr = endDate.GetMonth().ToStr()
    end if

    endDayStr = ""
    if endDate.GetDayOfMonth() < 10
        endDayStr = "0" + endDate.GetDayOfMonth().ToStr()
    else
        endDayStr = endDate.GetDayOfMonth().ToStr()
    end if

    endDateStr = endDate.GetYear().ToStr() + "-" + endMonthStr + "-" + endDayStr

    return {
        daystart: startDateStr, ' 1st of current month
        dayend: endDateStr ' Last day of next month
    }

end function

sub selectTodayInDatesPillRowlist()
    ' Get today's date in YYYY-MM-DD format
    today = createObject("roDateTime")
    year = today.GetYear()
    month = today.GetMonth()
    day = today.GetDayOfMonth()

    ' Format as "YYYY-MM-DD"
    if month < 10 then monthStr = "0" + month.ToStr() else monthStr = month.ToStr()
    if day < 10 then dayStr = "0" + day.ToStr() else dayStr = day.ToStr()
    todayStr = year.ToStr() + "-" + monthStr + "-" + dayStr

    ' Get the row of pill items
    pillRow = m.datesPillRowlist.content.getChild(0)

    ' Loop through items to find today's date
    for i = 0 to pillRow.getChildCount() - 1
        itemDate = pillRow.getChild(i).title
        if itemDate = todayStr
            m.datesPillRowlist.jumpToRowItem = [0, i] ' Scroll to the item
            onRowItemSelected()
            exit for
        end if
    end for
end sub


sub onRowItemSelected_Calendar()
    ?"onRowItemSelected_Calendar called"
    if m.calendarRowList <> invalid and m.calendarRowList.content <> invalid and m.calendarRowList.content.getChildCount() > 0 and m.calendarRowList.content.getChild(0) <> invalid and m.calendarRowList.rowItemFocused <> invalid and m.calendarRowList.rowItemFocused.Count() > 1 and m.calendarRowList.content.getChild(0).getChildCount() > m.calendarRowList.rowItemFocused[1] and m.calendarRowList.content.getChild(0).getChild(m.calendarRowList.rowItemFocused[1]) <> invalid
        m.top.gotovideoplayerscene = m.calendarRowList.content.getchild(0).getchild(m.calendarRowList.rowItemFocused[1])
    end if

end sub