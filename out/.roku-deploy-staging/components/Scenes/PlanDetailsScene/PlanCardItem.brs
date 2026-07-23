sub init()
    m.accentColor = "0x" + Mid(getButtonSelectionColor(), 2) + "FF"
    m.cardBg = m.top.findNode("cardBg")
    m.top.findNode("iconBox").blendColor = m.accentColor
    m.top.findNode("cardIcon").blendColor = "0xFFFFFFFF"
    m.top.findNode("lblPlanName").color = getTextColor()
    m.top.findNode("lblPlanSubtitle").color = getSecondaryTextColor()
    m.cardBg.blendColor = getDefaultCardColor()
    m.statusBg = m.top.findNode("statusBg")
    m.lblStatus = m.top.findNode("lblStatus")
end sub

sub onFocusChanged()
    if m.top.itemHasFocus
        m.cardBg.blendColor = getFocusedCardColor()
    else
        m.cardBg.blendColor = getDefaultCardColor()
    end if
end sub

sub onItemContentChanged()
    d = m.top.itemContent
    if d = invalid then return

    m.top.findNode("lblPlanName").text = d.subscription_name
    m.top.findNode("lblPlanSubtitle").text = d.subscription_text

    statusText = ""
    statusColor = "0x00CC44ff"
    statusBg = "0x00CC44ff"

    if d.status <> invalid
        statusText = d.status.status
        if d.status.text_color <> invalid
            c = d.status.text_color
            if Left(c, 1) = "#" then c = Mid(c, 2)
            statusColor = "0x" + c + "FF"
        end if
        if d.status.bg_color <> invalid
            bc = d.status.bg_color
            if Left(bc, 1) = "#" then bc = Mid(bc, 2)
            statusBg = "0x" + bc + "FF"
        end if
    end if

    m.lblStatus.text = statusText
    m.top.findNode("lblStatus").color = statusColor
    m.top.findNode("statusDot").blendColor = statusColor
    m.top.findNode("statusDot").visible = (statusText <> "")
    m.statusBg.blendColor = statusBg
    m.statusBg.visible = (statusText <> "")
    m.statusBg.width = m.lblStatus.boundingRect().width + 40
end sub


