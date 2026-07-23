Function Init()
    spinner = m.top.FindNode("spinner")
    appBackground = m.top.FindNode("AppBackground")
    appBackground.color = getBackgroundColor1()
    spinner.poster.uri="pkg:/images/loading.png"
    spinner.poster.blendColor = getTextColor()
End Function 