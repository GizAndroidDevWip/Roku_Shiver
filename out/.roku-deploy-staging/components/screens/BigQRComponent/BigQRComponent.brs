sub init()
  m.card = m.top.findNode("card")

  m.lockIcon = m.top.findNode("lockIcon")
  m.lockIcon.blendColor = getColors().sub_text_color
  if getBackGroundColor() = "#FFFFFF"
    m.lockIcon.uri = "pkg:/images/icons/lock_icon_menu_black.png"
  else
    m.lockIcon.uri = "pkg:/images/icons/lock_icon.png"
  end if
  m.logoPoster = m.top.findNode("logoPoster")
  m.logoPoster.uri = "pkg:/images/logos/watermarklogo.png"' Set default logo
  font = CreateObject("roSGNode", "Font")

  mainFont = CreateObject("roSGNode", "Font")
  mainFont.uri = "pkg:/fonts/Roboto-Bold.ttf"
  m.Main_title = m.top.findNode("Main_title")
  m.Main_title.font = mainFont
  m.Main_title.text = getTextOf("qr_overlay_heading")
  m.Main_title.color = getTextColor()
  mainFont.size = 47
  font.uri = "pkg:/fonts/Roboto-Bold.ttf"

  m.titleLabel = m.top.findNode("titleLabel")
  m.titleLabel.color = getTextColor()
  m.titleLabel.font.size = 44
  m.titleLabel.text = m.top.titleLabel

  m.subscription_title = m.top.findNode("subscription_title")
  m.subscription_title.color = getColors().sub_text_color
  m.subscription_title.text = " " + getTextOf("qr_overlay_subscriber_text")
  m.subscription_title.font.size = 27

  m.qr_title = m.top.findNode("qr_title")
  m.qr_title.color = getColors().sub_text_color
  m.qr_title.text = " " + getTextOf("qr_overlay_description")
  m.qr_title.font.size = 27


  m.label1 = m.top.findNode("label1")
  m.label1.color = getTextColor()

  m.label2 = m.top.findNode("label2")
  m.label2.color = getTextColor()


  m.label3 = m.top.findNode("label3")
  m.label3.color = getTextColor()

  m.label4 = m.top.findNode("label4")
  m.label4.color = getColors().sub_text_color
  m.label4.text = " " + getTextOf("qr_overlay_step_1_description")
  m.label4.font.size = 26
  ' m.label4.font.uri = "pkg:/fonts/Poppins-Medium.ttf"

  m.label5 = m.top.findNode("label5")
  m.label5.color = getColors().sub_text_color
  m.label5.text = " " + getTextOf("qr_overlay_step_2_description")
  m.label5.font.size = 26

  m.label6 = m.top.findNode("label6")
  m.label6.color = getColors().sub_text_color
  m.label6.text = " " + getTextOf("qr_overlay_step_3_description")
  m.label6.font.size = 26

  m.refresh_label = m.top.findNode("refresh_label")
  m.refresh_label.text = getTextOf("refresh")

  m.cancel_label = m.top.findNode("cancel_label")
  m.cancel_label.text = getTextOf("cancel")


  labels = {
    ' "subscription_title": " " + getTextOf("subscription_title"),


    "label1": " " + getTextOf("qr_overlay_step_1_title"),
    "label2": "" + getTextOf("qr_overlay_step_2_title"),
    "label3": " " + getTextOf("qr_overlay_step_3_title"),

  }

  for each id in labels
    node = m.top.findNode(id)
    if node <> invalid
      node.text = labels[id]
      node.font.size = 28
    end if
  end for

  m.qrPoster = m.top.findNode("qrPoster")
  m.qrPoster.uri = m.top.qrUrl
  m.NoButton = m.top.findNode("NoButton")
  m.NoButton.setFocus(true)
  m.NoButton.getChild(0).blendColor = getButtonSelectionColor()
  m.YesButton = m.top.findNode("YesButton")
  m.YesButton.getChild(0).blendColor = getButtonSelectionColor()
  m.NoButton.ObserveField("buttonSelected", "onDialogNoSelected")
  m.YesButton.ObserveField("buttonSelected", "onDialogYesSelected")
end sub

sub onDialogNoSelected()
  m.top.closeQROverlay = true
end sub

sub onDialogYesSelected()
  m.top.refreshRequested = true
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false
  if press
    ?"key pressed"
    if key = "left" then
      m.NoButton.setFocus(true)
      return true

    else if key = "right" then
      m.NoButton.setFocus(false)
      m.YesButton.setFocus(true)
      return true
    end if
  end if
  return handled

end function
