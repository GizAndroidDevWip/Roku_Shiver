sub ShowPlanDetailsScreen()
    m.planDetailsScene = CreateObject("roSGNode", "PlanDetailsScene")
    m.planDetailsScene.observeField("goBack", "onPlanDetailsGoBack")
    ShowScreen(m.planDetailsScene)
end sub

sub onPlanDetailsGoBack()
    CloseScreen(m.planDetailsScene)
end sub
