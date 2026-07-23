function Init()
  m.MainRectangle = m.top.findNode("main_rect")
  m.heading = m.top.findNode("heading")
  m.PodCastRowList = m.top.findNode("PodCastRowList")
  m.PodCastRowList.observeField("rowItemSelected", "onRowItemSelected")
  m.top.observeField("visible", "OnTopVisibilityChange")
  runMyListTask()
end function

sub runMyListTask()
  ?"runMyListTask called"
  m.PodCastApiTask = CreateObject("roSGNode", "PodCastApiTask")
  m.PodCastApiTask.observeField("PodCastApiTaskListStatus", "onPodCastApiTask")
  m.PodCastApiTask.callFunc("runPodCastApiTask", "")
end sub

sub onPodCastApiTask()
  ?"onPodCastApiTask called"
  m.PodCastRowList.content = m.PodCastApiTask.PodCastApiTaskContent
  m.PodCastRowList.setFocus(true)
end sub

sub OnTopVisibilityChange()
  if m.top.visible = true
  
      m.PodCastRowList.setFocus(true)

  end if
end sub


