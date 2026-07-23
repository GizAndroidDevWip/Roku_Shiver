sub init()
    m.focusState = 0
    m.confirmFocusIndex = 0
    m.selectedPlanIndex = 0
    m.subDataArray = []
    m.isConfirmOpen = false

    c = getButtonSelectionColor()
    if Left(c, 1) = "#" then c = Mid(c, 2)
    if Len(c) = 6 then c = c + "FF"
    m.accentColor = "0x" + c
    m.accentHex = getButtonSelectionColor()

    m.planList = m.top.findNode("planList")
    m.panelBg = m.top.findNode("panelBg")
    m.cancelSection = m.top.findNode("cancelSection")
    m.hdrTitle = m.top.findNode("hdrTitle")
    m.hdrSubtitle = m.top.findNode("hdrSubtitle")
    m.billingLabel = m.top.findNode("billingLabel")
    m.priceLabel = m.top.findNode("priceLabel")
    m.renewalLabel = m.top.findNode("renewalLabel")
    m.cancelProvLabel = m.top.findNode("cancelProvLabel")
    m.cancelBtnBg = m.top.findNode("cancelBtnBg")
    m.cancelBtnLabel = m.top.findNode("cancelBtnLabel")
    m.lblCancelProvText = m.top.findNode("lblCancelProvText")

    m.lblBillingValue = m.top.findNode("lblBillingValue")
    m.lblPriceValue = m.top.findNode("lblPriceValue")
    m.lblRenewalValue = m.top.findNode("lblRenewalValue")

    m.cancelVisible = true
    m.qrOverlayGroup = m.top.findNode("qrOverlayGroup")

    m.cancelBtn = m.top.findNode("cancelBtn")
    m.cancelBtnIcon = m.top.findNode("cancelBtnIcon")
    m.noDataLabel = m.top.findNode("noDataLabel")

    m.cancelConfirmGroup = m.top.findNode("cancelConfirmGroup")
    m.cancelConfirmOverlay = m.top.findNode("cancelConfirmOverlay")
    m.cancelConfirmCardBg = m.top.findNode("cancelConfirmCardBg")
    m.cancelConfirmTitle = m.top.findNode("cancelConfirmTitle")
    m.cancelNoBtn = m.top.findNode("cancelNoBtn")
    m.cancelNoBtnBg = m.top.findNode("cancelNoBtnBg")
    m.cancelNoBtnLabel = m.top.findNode("cancelNoBtnLabel")
    m.cancelYesBtn = m.top.findNode("cancelYesBtn")
    m.cancelYesBtnBg = m.top.findNode("cancelYesBtnBg")
    m.cancelYesBtnLabel = m.top.findNode("cancelYesBtnLabel")
    m.qrCardContainer = m.top.findNode("qrCardContainer")
    m.qrPoster = m.top.findNode("qrPoster")
    m.qrPoster.observeField("loadStatus", "onQrPosterLoadStatusChanged")
    m.qrDescriptionLabel = m.top.findNode("qrDescriptionLabel")
    m.okBtn = m.top.findNode("okBtn")
    m.okBtnBg = m.top.findNode("okBtnBg")
    m.okBtn.observeField("focusedChild", "onOkBtnFocused")
    m.okBtnLabel = m.top.findNode("okBtnLabel")
    m.okBtnLabel.text = getTextOf("ok")
    m.okBtnLabel.color = getTextColor()
    m.loadingIndicator = m.top.getScene().findNode("loadingIndicator")
    showLoader(true)

    m.planList.observeField("rowItemFocused", "onRowItemFocused")

    for each nodeId in ["billingIcon", "priceIcon", "renewalIcon", "cancelProvIcon"]
        n = m.top.findNode(nodeId)
        if n <> invalid then n.blendColor = m.accentColor
    next

    setLocalizedTexts()

    bgRect = m.top.findNode("bg")
    if bgRect <> invalid then bgRect.color = getBackGroundColor1()
    if m.panelBg <> invalid then m.panelBg.blendColor = getDefaultCardColor()
    if m.hdrTitle <> invalid then m.hdrTitle.color = getTextColor()
    if m.hdrSubtitle <> invalid then m.hdrSubtitle.color = getSecondaryTextColor()
    if m.billingLabel <> invalid then m.billingLabel.color = getTextColor()
    if m.priceLabel <> invalid then m.priceLabel.color = getTextColor()
    if m.renewalLabel <> invalid then m.renewalLabel.color = getTextColor()
    if m.cancelProvLabel <> invalid then m.cancelProvLabel.color = getTextColor()

    lblBillingVal = m.top.findNode("lblBillingValue")
    if lblBillingVal <> invalid then lblBillingVal.color = getSecondaryTextColor()
    lblPriceVal = m.top.findNode("lblPriceValue")
    if lblPriceVal <> invalid then lblPriceVal.color = getSecondaryTextColor()
    lblRenewalVal = m.top.findNode("lblRenewalValue")
    if lblRenewalVal <> invalid then lblRenewalVal.color = getSecondaryTextColor()
    if m.lblCancelProvText <> invalid then m.lblCancelProvText.color = getSecondaryTextColor()

    for each divId in ["divider1", "divider2", "divider3"]
        div = m.top.findNode(divId)
        if div <> invalid then div.color = getDividerColor()
    next

    if m.cancelBtnIcon <> invalid then m.cancelBtnIcon.blendColor = m.accentHex
    applyConfirmPopupTheme()
    updateConfirmPopupFocus()

    setFocusState(0)
    startLoadingData()
end sub

sub setLocalizedTexts()
    if m.hdrTitle <> invalid then m.hdrTitle.text = getText("my_plan_details")
    if m.hdrSubtitle <> invalid then m.hdrSubtitle.text = getText("plan_details_subtitle")
    if m.billingLabel <> invalid then m.billingLabel.text = getText("billing_cycle")
    if m.priceLabel <> invalid then m.priceLabel.text = getText("price")
    if m.renewalLabel <> invalid then m.renewalLabel.text = getText("next_renewal")
    if m.cancelProvLabel <> invalid then m.cancelProvLabel.text = getText("cancel_provision")
    if m.cancelBtnLabel <> invalid then m.cancelBtnLabel.text = getText("cancel_plan")
    if m.cancelConfirmTitle <> invalid then m.cancelConfirmTitle.text = getText("cancel_subscription_alert")
    if m.cancelNoBtnLabel <> invalid then m.cancelNoBtnLabel.text = getText("no")
    if m.cancelYesBtnLabel <> invalid then m.cancelYesBtnLabel.text = getText("yes")
end sub

sub setFocusState(state as integer)
    m.focusState = state

    if state = 0
        if m.planList <> invalid then m.planList.setFocus(true)
    else if state = 1
        if m.cancelBtn <> invalid then m.cancelBtn.setFocus(true)
    end if

    if m.cancelBtnBg <> invalid then m.cancelBtnBg.blendColor = getDefaultCardColor()
    if m.cancelBtnLabel <> invalid then m.cancelBtnLabel.color = getTextColor()

    if state = 1
        if m.cancelBtnBg <> invalid then m.cancelBtnBg.blendColor = getFocusedCardColor()
        if m.cancelBtnLabel <> invalid then m.cancelBtnLabel.color = getTextColor()
    end if
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if m.okBtn.hasfocus() = true
        if key = "OK" or key = "back"
            onCancelQRClose()
        end if
        return true
    end if

    if m.isConfirmOpen
        return onCancelConfirmKey(key)
    end if

    if key = "back" and m.cancelQRNode <> invalid
        onCancelQRClose()
        return true
    end if

    if key = "back"
        m.top.goBack = true
        return true
    end if

    if m.focusState = 0
        if key = "right"
            if m.cancelVisible
                setFocusState(1)
            end if
            return true
        end if
    else if m.focusState = 1
        if key = "left"
            setFocusState(0)
            return true
        else if key = "OK"
            showCancelConfirmPopup()
            return true
        end if
    end if

    return false
end function

sub startLoadingData()
    m.subTask = CreateObject("roSGNode", "PlanDetailsTask")
    m.subTask.observeField("subscriptionData", "onSubscriptionDataLoaded")
    m.subTask.control = "RUN"
end sub

sub onSubscriptionDataLoaded()
    showLoader(false)
    response = m.subTask.subscriptionData
    if response = invalid or response.data = invalid or response.data.count() = 0
        if m.noDataLabel <> invalid
            m.noDataLabel.visible = true
            m.noDataLabel.text = getText("no_active_paid_subscription")
        end if
        if m.planList <> invalid then m.planList.visible = false
        if m.panelBg <> invalid then m.panelBg.getParent().visible = false
        return
    end if

    if m.noDataLabel <> invalid then m.noDataLabel.visible = false
    if m.planList <> invalid then m.planList.visible = true
    if m.panelBg <> invalid then m.panelBg.getParent().visible = true

    m.subDataArray = response.data

    content = CreateObject("roSGNode", "ContentNode")
    for i = 0 to m.subDataArray.count() - 1
        row = content.CreateChild("ContentNode")
        item = row.CreateChild("ContentNode")
        item.addFields(m.subDataArray[i])
    next

    m.planList.content = content
    if m.subDataArray.count() > 0 then populateUI(m.subDataArray[0])
end sub

sub applyConfirmPopupTheme()
    if m.cancelConfirmOverlay <> invalid then m.cancelConfirmOverlay.color = withAlpha(getBackGroundColor1(), "B8")
    if m.cancelConfirmCardBg <> invalid then m.cancelConfirmCardBg.blendColor = getDefaultCardColor2()
    if m.cancelConfirmTitle <> invalid then m.cancelConfirmTitle.color = getTextColor()
    if m.cancelNoBtnLabel <> invalid then m.cancelNoBtnLabel.color = getTextColor()
    if m.cancelYesBtnLabel <> invalid then m.cancelYesBtnLabel.color = getTextColor()
end sub

sub showCancelConfirmPopup()
    if m.cancelConfirmGroup = invalid then return
    m.isConfirmOpen = true
    m.confirmFocusIndex = 0
    applyConfirmPopupTheme()
    updateConfirmPopupFocus()
    m.cancelConfirmGroup.visible = true
end sub

sub closeCancelConfirmPopup()
    if m.cancelConfirmGroup <> invalid then m.cancelConfirmGroup.visible = false
    m.isConfirmOpen = false
    setFocusState(1)
end sub

function onCancelConfirmKey(key as string) as boolean
    if key = "back"
        closeCancelConfirmPopup()
        return true
    else if key = "left"
        if m.confirmFocusIndex <> 0
            m.confirmFocusIndex = 0
            updateConfirmPopupFocus()
        end if
        return true
    else if key = "right"
        if m.confirmFocusIndex <> 1
            m.confirmFocusIndex = 1
            updateConfirmPopupFocus()
        end if
        return true
    else if key = "OK"
        if m.confirmFocusIndex = 0
            closeCancelConfirmPopup()
        else
            closeCancelConfirmPopup()
            showCancelQROverlay()
        end if
        return true
    end if

    return false
end function

sub updateConfirmPopupFocus()
    if m.cancelNoBtnBg <> invalid then m.cancelNoBtnBg.blendColor = getDefaultCardColor()
    if m.cancelYesBtnBg <> invalid then m.cancelYesBtnBg.blendColor = getDefaultCardColor()
    if m.cancelNoBtnLabel <> invalid then m.cancelNoBtnLabel.color = getTextColor()
    if m.cancelYesBtnLabel <> invalid then m.cancelYesBtnLabel.color = getTextColor()
    if m.cancelNoBtn <> invalid then m.cancelNoBtn.scale = [1.0, 1.0]
    if m.cancelYesBtn <> invalid then m.cancelYesBtn.scale = [1.0, 1.0]

    if m.confirmFocusIndex = 0
        if m.cancelNoBtnBg <> invalid then m.cancelNoBtnBg.blendColor = getFocusedCardColor()
        if m.cancelNoBtn <> invalid then m.cancelNoBtn.scale = [1.04, 1.04]
    else
        if m.cancelYesBtnBg <> invalid then m.cancelYesBtnBg.blendColor = getFocusedCardColor()
        if m.cancelYesBtn <> invalid then m.cancelYesBtn.scale = [1.04, 1.04]
    end if
end sub

function withAlpha(color as dynamic, alpha as string) as string
    if color = invalid then return "0x000000" + alpha

    c = color.ToStr()
    if Left(c, 1) = "#"
        c = Mid(c, 2)
    else if LCase(Left(c, 2)) = "0x"
        c = Mid(c, 3)
    end if

    if Len(c) >= 8 then c = Left(c, 6)
    if Len(c) = 6 then return "0x" + c + alpha
    return "0x000000" + alpha
end function

sub onRowItemFocused()
    focused = m.planList.rowItemFocused
    if focused <> invalid and focused.count() >= 2
        m.selectedPlanIndex = focused[0]
        if m.subDataArray <> invalid and m.selectedPlanIndex < m.subDataArray.count()
            populateUI(m.subDataArray[m.selectedPlanIndex])
        end if
    end if
end sub

sub populateUI(subData as object)
    if m.lblCancelProvText <> invalid then m.lblCancelProvText.text = subData.subscription_text
    if m.lblBillingValue <> invalid then m.lblBillingValue.text = subData.subscription_type_name
    if m.lblPriceValue <> invalid then m.lblPriceValue.text = subData.price_text
    if m.lblRenewalValue <> invalid then m.lblRenewalValue.text = subData.valid_to_text

    typeName = subData.subscription_type_name
    m.cancelVisible = (subData.cancel_status = false) and (typeName = "Yearly" or typeName = "Monthly" or typeName = "Weekly")
    if m.cancelSection <> invalid then m.cancelSection.visible = m.cancelVisible
    if not m.cancelVisible and m.focusState = 1 then setFocusState(0)
end sub

sub showCancelQROverlay()
    showLoader(true)
    if m.qrOverlayGroup = invalid then return' or m.cancelQRNode <> invalid then return
    if m.subDataArray = invalid or m.selectedPlanIndex >= m.subDataArray.count() then return

    plan = m.subDataArray[m.selectedPlanIndex]
    m.cancelTask = CreateObject("roSGNode", "PlanDetailsTask")
    m.cancelTask.action = "CANCEL"
    m.cancelTask.cancelSubscriptionId = plan.user_subscription_id.ToStr()
    if plan.sub_id <> invalid then m.cancelTask.addFields({ "sub_id": plan.sub_id.ToStr() })

    m.cancelTask.observeField("cancelResponse", "onCancelResult")
    m.cancelTask.control = "RUN"
end sub

sub onCancelResult()
    res = m.cancelTask.cancelResponse
    if res = invalid or res.message = invalid or res.message = "" then return

    qrUrl = ""
    if res.data <> invalid and res.data.qr <> invalid and res.data.qr <> ""
        ? "QR URL: " + res.data.qr
        qrUrl = res.data.qr
    end if

    m.cancelQRNode = m.top.findNode("qrScreen")
    if isNotBlank(qrUrl) then
        m.qrPoster.uri = ""
        m.qrPoster.uri = qrUrl
        m.qrCardContainer.visible = true
        m.qrDescriptionLabel.text = res.message
        ' m.qrDescriptionLabel.translation = [945, 240]
        m.cancelQRNode.visible = true
        m.okBtn.setFocus(true)
    else
        m.qrCardContainer.visible = false
        ' m.qrDescriptionLabel.translation = [615, 240]
        scene = m.top.GetScene()
        scene.showCustomDialog = {
            title: getText("warning"),
            message: res.message,
            buttons: [getText("close")],
            origin: m.top ' Passing this allows MainScene to talk back to this component
        }
    end if

    ' m.cancelQRNode.observeField("closeQROverlay", "onCancelQRClose")
    ' m.qrOverlayGroup.appendChild(m.cancelQRNode)
end sub

sub onCancelQRClose()
    if m.cancelQRNode <> invalid
        m.qrOverlayGroup.removeChild(m.cancelQRNode)
        m.cancelQRNode.visible = false
        m.cancelQRNode = invalid
    end if
    setFocusState(1)
end sub

function getText(key as string) as string
    strings = getStrings()
    if m.global.language_keywords <> invalid and m.global.language_keywords[key] <> invalid and m.global.language_keywords[key][getLanguageCodeSelected()] <> invalid
        return m.global.language_keywords[key][getLanguageCodeSelected()]
    end if
    if strings <> invalid and strings[key] <> invalid
        return strings[key]
    end if
    return ""
end function


sub onOkBtnFocused()
    if m.okBtn.hasFocus() = true
        m.okBtnBg.blendColor = getButtonSelectionColor()
    else
        m.okBtnBg.blendColor = getDefaultCardColor()
    end if
end sub

sub showLoader(boolean as boolean)
    if m.loadingIndicator <> invalid
        m.loadingIndicator.visible = boolean
    end if
end sub

sub onQrPosterLoadStatusChanged()
    if m.qrPoster.loadStatus <> invalid and m.qrPoster.loadStatus = "ready" 
        showLoader(false)
    end if
end sub