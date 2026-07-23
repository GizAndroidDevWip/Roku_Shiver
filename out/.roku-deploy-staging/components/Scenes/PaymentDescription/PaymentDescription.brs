sub init()
    m.ispaid = false
    m.contentRowList = m.top.FindNode("contentRowList")
    m.subscriptionlbl = m.top.findNode("subscriptionlbl")
    m.subscriptionlbl.font.size = 55
    m.AppBackground = m.top.findNode("AppBackground")
    m.AppBackground.color = getBackgroundColor1()
    
        m.subscriptionlbl.text = getText("subscription_title")
  

    m.lbl = m.top.findNode("lbl")
    m.lbl.font.size = 30
    

  
        m.lbl.text = getText("select_package")
    

    m.descri = m.top.findNode("descri")
    m.packimage = m.top.findNode("packimage")
    m.contentRowList.observeField("selectedContent", "onContentSelected")
    m.contentRowList.observeField("descriptionData", "onFocusedContent")
    m.contentRowList.SetFocus(true)
    m.UpdateSubscription = CreateObject("roSGNode", "UpdateSubscription")
    m.UpdateSubscription.observeField("response", "On_rokuSignUp_isSubscribed")
    m.top.observeField("videoID", "DisapalyVideoData")
    m.top.observeField("eventID", "DisapalyVideoDataForEvent")
    m.top.observeField("channelId", "DisplayVideoDataForChannel")
    m.top.visible = false
    m.billingProducts = {}
    m.count = 0
    m.billing = m.top.FindNode("billing")
    m.billing.ObserveField("userData", "On_billing_partialUserData")
    m.billing.ObserveField("catalog", "On_billing_catalog")
    m.billing.ObserveField("purchases", "On_billing_purchases")
    m.billing.ObserveField("orderStatus", "On_billing_purchaseResult")
    m.top.pdialogAuth = CreateObject("roSGNode", "ProgressDialog")
    m.top.pdialogAuth.backgroundUri = "pkg:/images/black.jpg"
    m.top.pdialogAuth.title = "Please wait..."
    m.loginAuthFlow = m.top.FindNode("loginAuthFlow")


    
        m.loginAuthFlow.dialogAuthFailed.title =  getText("login_failed")
  





    m.loginAuthFlow.ObserveField("isAuthorized", "On_loginAuthFlow_isAuthorized")
    m.signupAuthFlow = m.top.FindNode("signupAuthFlow")
    m.signupAuthFlow.kbdialogEmail.title = "Enter the email address for new account creation"
    m.signupAuthFlow.kbdialogPassword.title = "Create the password"
    m.signupAuthFlow.dialogAuthFailed.title = "User account creation failed"
    m.signupAuthFlow.ObserveField("isAuthorized", "On_signupAuthFlow_isAuthorized")
    m.top.dialogSelectSub = CreateObject("roSGNode", "BackDialog")
    m.top.dialogSelectSub.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogSelectSub.title = "Subscription"
    m.top.dialogSelectSub.message = "Please select subscription type"
    m.top.dialogSelectSub.ObserveField("buttonSelected", "On_dialogSelectSub_buttonSelected")
    m.top.dialogNoSubToPurchase = CreateObject("roSGNode", "BackDialog")
    m.top.dialogNoSubToPurchase.backgroundUri = "pkg:/images/black.jpg"
    m.top.dialogNoSubToPurchase.title = "No available subscriptions to purchase"
    m.top.dialogNoSubToPurchase.message = "Please check your Roku account for previously purchased products."
    m.top.dialogNoSubToPurchase.buttons = ["OK"]
    m.top.dialogNoSubToPurchase.ObserveField("buttonSelected", "On_SignupNoSub")
    m.top.dialogBillingNA = CreateObject("roSGNode", "BackDialog")
    m.top.dialogBillingNA.backgroundUri = "pkg:/images/black.jpg"

    
        m.top.dialogBillingNA.title = getText("purchase_failed")
   


   
        m.top.dialogBillingNA.message =  getText("error_message")
    


  
        ok = getText("ok")
    

    m.top.dialogBillingNA.buttons = [ok]
    m.top.dialogBillingNA.ObserveField("buttonSelected", "On_SubscriptionFailed")
    m.top.dialogSuccess = CreateObject("roSGNode", "BackDialog")
    m.top.dialogSuccess.backgroundUri = "pkg:/images/black.jpg"

    
        m.top.dialogSuccess.title = getText("purchased_subscription")
    

    
        m.top.dialogSuccess.message =  getText("payment_success_message")
   

    
        continue = getText("continue")
    

    m.top.dialogSuccess.buttons = [continue]
    m.top.dialogSuccess.ObserveField("buttonSelected", "On_msgDialog_buttonSelected")
    m.top.pdialogCheckSubs = CreateObject("roSGNode", "ProgressDialog")
    m.top.pdialogCheckSubs.backgroundUri = "pkg:/images/black.jpg"
    m.top.pdialogCheckSubs.title = "Checking subscriptions..."
    m.top.pdialogPurchase = CreateObject("roSGNode", "ProgressDialog")
    m.top.pdialogPurchase.backgroundUri = "pkg:/images/black.jpg"
    m.top.pdialogPurchase.title = "Purchasing subscription..."

    m.count = 0

    m.allDialogs = [
        m.loginAuthFlow.kbdialogEmail
        m.loginAuthFlow.kbdialogPassword
        m.loginAuthFlow.dialogErrEmail
        m.loginAuthFlow.dialogErrPassword
        m.loginAuthFlow.dialogAuthFailed

        m.signupAuthFlow.kbdialogEmail
        m.signupAuthFlow.kbdialogPassword
        m.signupAuthFlow.dialogErrEmail
        m.signupAuthFlow.dialogErrPassword
        m.signupAuthFlow.dialogTermsOfUse
        m.signupAuthFlow.dialogAuthFailed

        m.top.dialogSelectSub
        m.top.dialogNoSubToPurchase
        m.top.dialogBillingNA
    ]

    '    m.PaymentDescription.videoID = str(VODcontent.video_id)
    '    m.PaymentDescription.observeField("isSubscribed","OnSubscriptionComplete")
    '    m.PaymentDescription.visible = true
    '    m.PaymentDescription.setFocus(true)
    '    m.RowList.setFocus(false)
    m.subscriptionlbl.color = getTextColor()
    m.lbl.color = "#858585"
    m.descri.color = getTextColor()
    m.contentRowList.color = getTextColor()
    m.contentRowList.focusedColor = getTextColor()
    m.contentRowList.focusBitmapBlendColor = getButtonSelectionColor()
    m.contentRowList.rowLabelColor = getTextColor()
end sub


function DisapalyVideoData()
    if m.count = 0
        m.count = 1
        m.ispaid = false
        m.PaymentFetcher = createObject("roSGNode", "PaymentFetcher")
        m.PaymentFetcher.observeField("PayContent", "onContentChanged")
        m.PaymentFetcher.isGoadsFreeclicked = m.top.isGoadsFreeclicked
        m.PaymentFetcher.videoID = m.top.videoID
        m.PaymentFetcher.callFunc("runPaymentFetcherTask", "")
    end if
end function

function DisapalyVideoDataForEvent()
    if m.count = 0
        m.count = 1
        print "on start"
        m.ispaid = false
        m.PaymentFetcher = createObject("roSGNode", "PaymentFetcherForEvent")
        m.PaymentFetcher.observeField("PayContent", "onContentChanged")
        m.PaymentFetcher.eventID = m.top.eventID
        m.PaymentFetcher.callFunc("runPaymentFetcherTask", "")
    end if
end function


function DisapalyVideoDataForAppSubscription()
    if m.count = 0
        m.count = 1
        ' print "onstart122"
        m.ispaid = false
        m.PaymentFetcher = createObject("roSGNode", "PaymentFetcherForAppSubscription")
        m.PaymentFetcher.observeField("PayContent", "onContentChanged")
        ' m.PaymentFetcher.videoID = m.top.videoID
        m.PaymentFetcher.callFunc("runPaymentFetcherTask", "")
        '?"kjkk"
    end if
end function




function DisplayVideoDataForChannel()
    if m.count = 0
        m.count = 1
        print "on start"
        m.ispaid = false
        m.PaymentFetcher = createObject("roSGNode", "PaymentFetcherForTimegrid")
        m.PaymentFetcher.observeField("PayContent", "onContentChanged")
        m.PaymentFetcher.channelId = m.top.channelId
        m.PaymentFetcher.callFunc("runPaymentFetcherTask", "")
    end if
end function

sub On_rokuSignUp_isSubscribed()

    print "rokusignup"

    m.parentScene.dialog = m.top.dialogSuccess
end sub


sub onContentChanged()
    m.count = 0

    'm.count=1
    ? "onContentChanged"
    print m.PaymentFetcher.PayContent
    m.contentRowList.content = m.PaymentFetcher.PayContent
    m.contentRowList.start = "start"

    'end if
    m.PaymentFetcher.callFunc("stopPaymentFetcherTask", "")
end sub


function onContentSelected() as void


    print "oncontentselected.."
    'print m.contentRowList.selectedContent.priceDisplay
    print m.contentRowList.selectedContent.subscription_id
    print m.contentRowList.selectedContent.price
    print m.contentRowList.selectedContent.roku_keyword

    ?"tttyy778878ujkmhhjj"
    if GetParentScene() = invalid then
        return
    end if
    '     m.parentScene.dialog = m.top.pdialogAuth
    ?m.contentRowList.selectedContent.roku_keyword
    ?"m.contentRowList.selectedContent.roku_keyworde3e3"
    PurchaseProduct(m.contentRowList.selectedContent.roku_keyword)
    ' GetUserPurchases()
    'end if
end function

' Function GetUserPurchases() As Object
' ?"GetUserPurchasesinitial"
'     m.store = CreateObject("roChannelStore")
'     purchases = m.store.GetPurchases()
'     if purchases <> invalid then
'         for each item in purchases
'             print "Purchased Product ID: "; item.productId
'             print "Purchase Date: "; item.purchaseDate
'             print "Expiration Date: "; item.expirationDate ' Only applies to subscriptions
'         end for
'     else
'         print "No purchases found."
'     end if
'     return purchases
' End Function



function statusDialogButtonSelected() as void
    print "status dialg"
    m.dialog.close = true
end function

sub On_msgDialog_buttonSelected()
    print "status msg"
    m.parentScene.dialog.close = true
    m.top.isSubscribed = true
end sub




sub On_show()
    m.top.visible = m.top.show
    m.top.setFocus(m.top.show)

    if m.top.show then
        if m.top.isAuthNeeded and not m.top.isAuthorized then

        else
            m.loginAuthFlow.isAuthorized = true
        end if
    end if
end sub


' onChange handler for "regexEmail" field
sub On_regexEmail()
    m.loginAuthFlow.regexEmail = m.top.regexEmail
    m.signupAuthFlow.regexEmail = m.top.regexEmail
end sub


' onChange handler for "regexPassword" field
sub On_regexPassword()
    m.loginAuthFlow.regexPassword = m.top.regexPassword
    m.signupAuthFlow.regexPassword = m.top.regexPassword
end sub


' onChange handler for "textTermsOfUse" field
sub On_textTermsOfUse()
    m.signupAuthFlow.dialogTermsOfUse.message = m.top.textTermsOfUse
end sub


' onChange handler for "dialogsConfig" field
sub On_dialogsConfig()
    if m.allDialogs = invalid or m.top.dialogsConfig = invalid then
        return
    end if

    for each dialog in m.allDialogs
        dialog.SetFields(m.top.dialogsConfig)
    end for
end sub


' onChange handler for "dialogsButtonConfig" field
sub On_dialogsButtonConfig()
    if m.allDialogs = invalid or m.top.dialogsButtonConfig = invalid then
        return
    end if

    for each dialog in m.allDialogs
        dialog.buttonGroup.SetFields(m.top.dialogsButtonConfig)
    end for
end sub


' Handler for processing login flow button selection
sub On_Login()
    m.loginAuthFlow.kbdialogEmail.text = ""
    m.loginAuthFlow.show = true
end sub


' Handler for processing signup flow button selection
sub On_Signup()
    if GetParentScene() = invalid then
        return
    end if

    print ">> Check subscription"
    m.parentScene.dialog = m.top.pdialogCheckSubs
    GetCatalog()
end sub

' Handler for processing signup flow without subscribtion avaliable
sub On_SignupNoSub()
    m.signupAuthFlow.kbdialogEmail.text = ""
    m.signupAuthFlow.show = true
end sub




' Handler for processing partialUserData returned from user data sharing dialog
sub On_billing_partialUserData()
    ? "On_billing_partialUserData"
    userEmail = ""
    if m.billing.userData <> invalid then
        ?m.billing

        ? m.billing.userData
        ?" m.billing.userDatasdwdd"
        userEmail = m.billing.userData.email
    end if
    m.signupAuthFlow.kbdialogEmail.text = userEmail
    m.signupAuthFlow.show = true
    print "<< Getting User Data"
end sub


' Handler for processing authorization by login API (also invoked if only Roku Billing subscription used)
sub On_loginAuthFlow_isAuthorized()
    ?"uuuuhddfghjjj"
    m.top.isAuthorized = m.loginAuthFlow.isAuthorized
    m.top.isAfterLoginAuthFlow = true
end sub


' Handler for processing authorization by signup API
sub On_signupAuthFlow_isAuthorized()
    ?"ii87uijkmndswdf"
    m.top.isAuthorized = m.signupAuthFlow.isAuthorized
    m.top.isAfterLoginAuthFlow = true
end sub


' Handler for processing completion of authorization flow using login/signup API
sub On_isAfterLoginAuthFlow()
    ? "Use auth complete"
    if GetParentScene() = invalid then
        return
    end if

    if m.top.isAuthorized and m.billing.catalog <> invalid and m.billing.purchases <> invalid then
        if m.top.dialogSelectSub <> invalid and m.top.dialogSelectSub.buttonSelected <> invalid then
            m.parentScene.dialog = m.top.pdialogPurchase
            PurchaseProduct(m.top.dialogSelectSub.buttonSelected)
        end if
    end if
end sub


' Handler for processing catalog result.
' Catalog field is ContentNode containing command completion status.
' If successful, the catalog field's ContentNode will have child ContentNode's containing information about each available item.
' Then we need to requests the list of purchases associated with the current user account.
sub On_billing_catalog()
    ? "On_billing_catalog"
    if m.billing.catalog = invalid or m.billing.catalog.status = invalid then
        m.top.isSubscribed = false
        return
    end if

    if m.billing.catalog.status = 1 then
        m.billing.command = "getPurchases"
    else
        m.top.isSubscribed = false
    end if
end sub


' Handler for processing purchases result.
' When the command completes,the purchases field will be set to a ContentNode
' containing information about the command's completion as shown in the table below.
' In addition, that ContentNode will have child ContentNode's that contain information about each purchased item.
sub On_billing_purchases(event)
    ?event
    ?"event1234"
    print "on billing purchases"
    if m.ispaid = false
        if m.billing.purchases = invalid or m.billing.purchases.status = invalid then
            m.top.isSubscribed = false
            return
        end if

        if m.billing.purchases.status = 1 then
            On_billing_products()
        else
            m.top.isSubscribed = false
        end if
    end if
end sub


' Handler for processing Roku Billing subscription products
sub On_billing_products()
    if GetParentScene() = invalid then
        return
    end if

    m.billingProducts = GetParsedProducts()

    if m.bAfterAuthLogin <> invalid and m.bAfterAuthLogin and m.billingProducts.validPurchased.list.Count() > 0 then
        m.top.isSubscribed = true
        On_rokuSignUp_isSubscribed()
    else if m.billingProducts.availForPurchase.list.Count() > 0 then
        subscriptions = []
        for each item in m.billingProducts.availForPurchase.list
            ? "***************BILLING*****************"
            ? item
            ? "***************BILLING*****************"
            subscriptions.Push(item.name + " " + item.cost)
        end for
        m.top.dialogSelectSub.buttons = subscriptions
        m.parentScene.dialog = m.top.dialogSelectSub
    else if m.billingProducts.validPurchased.list.Count() > 0 then
        m.parentScene.dialog = m.top.dialogNoSubToPurchase
    else
        m.parentScene.dialog = m.top.dialogBillingNA
    end if

end sub


' Handler for processing subscription selected from subscription selection dialog
sub On_dialogSelectSub_buttonSelected()

    print "<< Check subscription"
    if m.top.dialogSelectSub.buttonSelected = invalid then
        On_SubscriptionFailed()
    else
        print ">> Getting User Data"
        m.billing.requestedUserData = "email"
        m.billing.command = "getUserData"
    end if
end sub


' Handler for processing subscription failure
sub On_SubscriptionFailed()
    print "on purchase failed!!"
    m.parentScene.dialog.close = true
    m.top.isSubscribed = false
end sub


' Handler for processing subscription product purchase result
sub On_billing_purchaseResult()
    print "on billing purchase result"

    print m.billing.orderStatus
    if m.billing.orderStatus = invalid or m.billing.orderStatus.status = invalid then
        m.top.isSubscribed = false
        return
    end if
    if m.billing.orderStatus.status = 1 then

    section = CreateObject("roRegistrySection", getAppKey()) ' to mainly notify homescreen to refresh homescreen
       section.Write("isJustLoggedIn", "yes")

        if m.parentScene.dialog <> invalid
            m.parentScene.dialog.close = true
        end if
        m.ispaid = true
        m.billing.command = "getPurchases"
        m.UpdateSubscription.subid = m.contentRowList.selectedContent.subscription_id
        m.UpdateSubscription.amount = m.contentRowList.selectedContent.price
        m.UpdateSubscription.keyword = m.contentRowList.selectedContent.roku_keyword
        m.UpdateSubscription.callFunc("runUpdateSubscriptionTask", "")

    else
        m.parentScene.dialog = m.top.dialogBillingNA
    end if
end sub


' Requests the list of In-Channel products that are linked to the running channel.
sub GetCatalog()
    print ">> Getting Products (Catalog and Purchases)"
    m.billing.command = "getCatalog"
end sub


' Filter catalog and purchases and show avaliable products.
function GetParsedProducts() as object
    print "getparsedproduct"
    result = {
        availForPurchase: {
            list: []
            map: {}
        }
        validPurchased: {
            list: []
            map: {}
        }
    }

    allProducts = []
    if m.billing <> invalid and m.billing.catalog <> invalid then
        catalogCount = m.billing.catalog.getChildCount()
        for i = 0 to catalogCount - 1
            catalogItem = m.billing.catalog.getChild(i).getFields()
            if catalogItem <> invalid then allProducts.push(catalogItem)
        end for
    end if

    purchasedProducts = []
    if m.purchases <> invalid and m.billing.purchases <> invalid then
        purchasesCount = m.billing.purchases.getChildCount()
        for i = 0 to purchasesCount - 1
            purchasesItem = m.billing.purchases.getChild(i).getFields()
            if purchasesItem <> invalid then purchasedProducts.push(purchasesItem)
        end for
    end if

    datetime = CreateObject("roDateTime")
    utimeNow = datetime.AsSeconds()

    for each product in allProducts
        bAddToAvail = true
        for each purchase in purchasedProducts
            if purchase.code = product.code then
                bAddToAvail = false
                if purchase.expirationDate <> invalid then
                    datetime.FromISO8601String(purchase.expirationDate)
                    utimeExpire = datetime.AsSeconds()
                    if utimeExpire > utimeNow then
                        result.validPurchased.list.Push(purchase)
                        result.validPurchased.map[purchase.code] = purchase
                    end if
                end if
                exit for
            end if
        end for

        if bAddToAvail then
            result.availForPurchase.list.Push(product)
            result.availForPurchase.map[product.code] = product
        end if
    end for

    return result
end function

' Purchasing Roku Billing product specified by "indexPurchase".
sub PurchaseProduct(index as string)
    ?index
    ?"index1233"
    ' clear order\
    print "purchase product"
    print index
    m.billing.order = invalid
    myOrder = CreateObject("roSGNode", "ContentNode")
    myFirstItem = myOrder.createChild("ContentNode")
    myFirstItem.addFields({ "code": index, "qty": 1 })
    m.billing.order = myOrder
    m.billing.command = "doOrder"
    m.count = 0
end sub



