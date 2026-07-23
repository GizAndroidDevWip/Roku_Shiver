sub init()
    m.top.functionName = "start"
end sub

function runHomeListApiTask(homeType as string)
    m.homeType = homeType
    ?"sdjkasjgds5454"
    ?m.homeType 
    m.top.control = "RUN"
end function

function stopHomeListApiTask(param as string)
    m.top.control = "STOP"
end function

sub start()
    responseDataHomeListApiTaskList = callHomeListApiTaskApi(m.homeType)
    
    if responseDataHomeListApiTaskList <> invalid and responseDataHomeListApiTaskList.data <> invalid and responseDataHomeListApiTaskList.data.data <> invalid then
        rawContent = responseDataHomeListApiTaskList.data.data
        
        ' Phase 1: Initial 2 rows
        HomeListApiTaskList = parseHomeListApiContent(rawContent, true)
        m.top.HomeListApiTaskContent = HomeListApiTaskList
        m.top.HomeListApiTaskListStatus = true ' Triggers onSetDataToRowList() the 1st time
        
        ' Phase 2: Rest of the rows processed on background
        remainingDataNode = getRemainingRowsNode(rawContent)
        if remainingDataNode <> invalid and remainingDataNode.getChildCount() > 0
            ' Pass them via a separate field to trigger updates explicitly
            m.top.HomeListApiTaskAdditionalRows = remainingDataNode
        end if
    else
        m.top.HomeListApiTaskContent = invalid
        m.top.HomeListApiTaskListStatus = false
    end if
end sub

function getRemainingRowsNode(content as Object) as Object
    remainingRootNode = CreateObject("RoSGNode", "ContentNode")
    rowCount = 0
    
    for each item in content
        if item.type <> "FEATURED"
            rowCount = rowCount + 1
            if rowCount <= 2 then continue for
        end if
        
        tempArray = [item]
        parsedNode = parseHomeListApiContent(tempArray, false)
        if parsedNode.getChildCount() > 0
            remainingRootNode.appendChild(parsedNode.getChild(0))
        end if
    end for
    return remainingRootNode
end function