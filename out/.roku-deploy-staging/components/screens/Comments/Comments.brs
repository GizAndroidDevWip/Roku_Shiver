sub init()
    m.top.observeField("visible", "onTopVisibleChange")
    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Roboto-Bold.ttf"
    font.size = 200
    m.commentsRowList = m.top.findNode("commentsRowList")
    m.commentsRowList.observeField("itemFocused", "onItemFocused")
    m.commentsRowList.observeField("itemSelected", "onRowSelected")

    m.reply_bg_rect = m.top.findNode("reply_bg_rect")
    m.comment_text = m.top.findNode("comment_text")
    m.userProfilePoster = m.top.findNode("userProfilePoster")
    m.timePosted = m.top.findNode("timePosted")
    m.timePosted.font.size = 22
    m.userName = m.top.findNode("userName")

    m.replyRowList = m.top.findNode("replyRowList")
    m.replyRowList.observeField("itemFocused", "onReplyItemFocused")

    m.comments_bg_rect = m.top.findNode("comments_bg_rect")
    m.reply_bg_rect = m.top.findNode("reply_bg_rect")

    m.noCommentsLabel = m.top.findNode("noCommentsLabel")

    m.comments_open_animation = m.top.findNode("comments_open_animation")
    m.comments_close_animation = m.top.findNode("comments_close_animation")



    m.current_comments_count = -1
    m.current_reply_count = -1

    m.comments_bg_rect.visible = true
    m.reply_bg_rect.visible = false
end sub

function onTopVisibleChange()
    if m.top.visible = true
        ' --- 1. CLEANUP (Defensive) ---
        ' Ensure no old timer is lingering before creating a new one
        if m.commentsFetchTimer <> invalid
            m.commentsFetchTimer.control = "stop"
            m.commentsFetchTimer.unobserveField("fire")
            m.top.removeChild(m.commentsFetchTimer)
            m.commentsFetchTimer = invalid
        end if

        ' --- 2. SETUP ---
        m.comments_open_animation.control = "start"

        ' Create the timer dynamically
        m.commentsFetchTimer = m.top.CreateChild("Timer")
        m.commentsFetchTimer.id = "dynamicCommentsTimer"
        m.commentsFetchTimer.duration = 10 ' Set your desired interval in seconds
        m.commentsFetchTimer.repeat = true
        
        ' Observe and Start
        m.commentsFetchTimer.observeField("fire", "callCommentsFetcherTaskApi")
        m.commentsFetchTimer.control = "start"
        
        ?"Timer Created and Started: "; m.commentsFetchTimer.id
    else
        ' --- 3. TEARDOWN ---
        if m.commentsFetchTimer <> invalid
            m.commentsFetchTimer.control = "stop"
            m.commentsFetchTimer.unobserveField("fire")
            
            ' Completely remove the node from the scene graph
            m.top.removeChild(m.commentsFetchTimer)
            m.commentsFetchTimer = invalid
            
            ?"Timer Stopped and Removed"
        end if

        m.top.closeComments = true
    end if
end function


function callCommentsFetcherTaskApi()
    ?"callCommentsFetcherTaskApi called"
    m.commentsFetcherTask = createObject("roSGNode", "CommentsFetcherTask")
    m.commentsFetcherTask.video_id = m.top.video_id
    m.commentsFetcherTask.callFunc("runCommentsFetcherTask", "")
    m.commentsFetcherTask.observeField("CommentsFetcherTaskStatus", "onCommentsFetcherTaskResponse")
end function

function onCommentsFetcherTaskResponse()
    ?"onCommentsFetcherTaskResponse called"
    m.commentsFetcherTask.callFunc("stopCommentsFetcherTask", "")
    m.commentsFetcherTask.unobserveField("CommentsFetcherTaskResponse")

    if m.comments_bg_rect.visible = true
        if m.commentsFetcherTask.CommentsFetcherTaskStatus = true
            m.noCommentsLabel.visible = false
            if m.commentsFetcherTask <> invalid and m.commentsFetcherTask.CommentsFetcherTaskResponse <> invalid and m.commentsFetcherTask.CommentsFetcherTaskResponse.getchildCount() <> invalid
                if m.commentsFetcherTask.CommentsFetcherTaskResponse.getchildCount() = 0
                    ?"hksjhksdhfkdhfkshdkfhsdkf"
                    m.noCommentsLabel.visible = true
                    return true
                else
                    m.noCommentsLabel.visible = false
                end if
                m.current_comments_count = m.commentsFetcherTask.CommentsFetcherTaskResponse.getchildCount()
                if m.commentsFetcherTask.CommentsFetcherTaskResponse.getchildcount() <> m.current_reply_count
                end if
            end if
            m.commentsRowList.content = m.commentsFetcherTask.CommentsFetcherTaskResponse
            scrollToIndex(m.commentsRowList, m.currentFocusedRowIndex_commentsRowList)
        else
            m.noCommentsLabel.visible = true
        end if
    else if m.reply_bg_rect.visible = true
        onCommentsFetcherTaskResponse2()
    end if
end function

function onCommentsFetcherTaskResponse2()
    ?"onCommentsFetcherTaskResponse called"
    ?"gsjhdgjsd000"
    if m.commentsFetcherTask.CommentsFetcherTaskResponse <> invalid
        ?"gsjhdgjsd111"
        for i = 0 to m.commentsFetcherTask.CommentsFetcherTaskResponse.getchildcount() - 1
            ?"gsjhdgjsd222"
            item = m.commentsFetcherTask.CommentsFetcherTaskResponse.getchild(i)
            if item.getchild(0) <> invalid and item.getchild(0).comment_id = m.current_selected_comment_id
                if item.getchild(0).replies <> invalid
                    ?"gsjhdgjsd4444"
                    ?"Current reply count: "; m.current_reply_count
                    ?"New reply count: "; item.getchild(0).replies.getchildCount()
                    if item.getchild(0).replies.getchildCount() <> m.current_reply_count
                        ?"gsjhdgjsd5555"
                        m.replyRowList.content = item.getchild(0).replies
                        scrollToIndex(m.replyRowList, m.currentFocusedRowIndex_replyRowList)
                    end if
                    exit for
                end if
            end if
        end for
    end if
end function

function scrollToIndex(rowList as object, index)
    ?"m.commentsRowList.RowitemFocused; "m.commentsRowList.RowitemFocused
    if rowList <> invalid and index <> invalid
        ' ?"scrollToIndex: ";index.ToStr() + " commentsRowList count: " + m.commentsRowList.content.getchildCount().ToStr()
        rowList.jumpToItem = index
    end if
end function

function onAquireFocus()
    ?"onAquireFocus called"
    m.commentsRowList.setFocus(true)
end function

function onItemFocused()
    ?"onItemFocused called: coments "m.commentsRowList.itemFocused
    m.currentFocusedRowIndex_commentsRowList = m.commentsRowList.itemFocused
end function


' Function to handle actions when a row is selected in the comments list
function onRowSelected()
    if m.commentsRowList.content <> invalid and m.commentsRowList.content.getchild(m.commentsRowList.itemSelected) <> invalid and m.commentsRowList.content.getchild(m.commentsRowList.itemSelected).getchild(0) <> invalid and m.commentsRowList.content.getchild(m.commentsRowList.itemSelected).getchild(0).replies <> invalid
        ?"onRowSelected called: comments"
        m.comments_close_animation.control = "start"
        selectedComment = m.commentsRowList.content.getchild(m.commentsRowList.itemSelected).getchild(0)
        if selectedComment <> invalid
            m.replyRowList.content = selectedComment.replies
            m.current_reply_count = selectedComment.replies.getchildCount()
            if selectedComment.user_image <> invalid
                m.userProfilePoster.uri = selectedComment.user_image
            end if
            if selectedComment.user_name <> invalid
                m.userName.text = selectedComment.user_name
            end if
            if selectedComment.created_at <> invalid
                m.timePosted.text = selectedComment.created_at'convertToDate(selectedComment.created_at) + " " + convertZTimeToNormalLocalTime(selectedComment.created_at)
            end if
            if selectedComment.comment_text <> invalid
                m.comment_text.text = selectedComment.comment_text
            end if
            if selectedComment.comment_id <> invalid
                m.current_selected_comment_id = selectedComment.comment_id
            end if
        end if
        m.comment_text.setFocus(true)
        m.comments_bg_rect.visible = false
        m.reply_bg_rect.visible = true
        m.comments_open_animation.control = "start"
        ' m.replyFetchTimer.control = "start"
    end if
end function

function onReplyItemFocused()
    m.currentFocusedRowIndex_replyRowList = m.replyRowList.itemFocused
end function

function convertToDate(inputValue)
    date = CreateObject("roDateTime")
    date.FromSeconds(inputValue)
    date.ToLocalTime()
    return date.AsDateString("short-month-no-weekday")
end function

function convertZTimeToNormalLocalTime(input)
    dt = CreateObject("roDateTime")
    dt.FromSeconds(input)
    dt.ToLocalTime()
    shortTime = dt.asTimeStringLoc("short-h12")
    return shortTime
end function

' ' Function to initialize and run the CommentsFetcherTask, and set up an observer for its response. this is for reply refresh case
' function callCommentsFetcherTaskApi_for_fetching_replies()
'     ?"callCommentsFetcherTaskApi_for_fetching_replies called"
'     m.commentsFetcherTask = createObject("roSGNode", "CommentsFetcherTask")
'     m.commentsFetcherTask.video_id = m.top.video_id
'     m.commentsFetcherTask.callFunc("runCommentsFetcherTask", "")
'     m.commentsFetcherTask.observeField("CommentsFetcherTaskResponse", "onCommentsFetcherTaskResponse2")
' end function

' Function to handle the response from the comments fetcher task.
' Updates the visibility of UI elements and populates the reply list if replies are available.



function onKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press then
        if key = "back"
            if m.reply_bg_rect.visible
                m.reply_bg_rect.visible = false
                m.comments_bg_rect.visible = true
                m.commentsRowList.setFocus(true)
                result = true
            else if m.comments_bg_rect.visible
                m.comments_close_animation.control = "start"
                m.commentsFetchTimer.control = "stop"
                m.top.closeComments = true
                result = true
            end if
        else if key = "down"
            if m.reply_bg_rect.visible = true
                if m.comment_text.hasFocus() = true
                    m.replyRowList.setFocus(true)
                    result = true
                else if m.replyRowList.hasFocus() = true
                    return true
                end if
            else if m.comments_bg_rect.visible = true
                return true
            end if
        else if key = "up"
            if m.reply_bg_rect.visible = true
                if m.replyRowList.hasFocus() = true
                    m.comment_text.setFocus(true)
                else if m.comment_text.hasFocus() = true
                    return true
                end if
                return true
            else if m.comments_bg_rect.visible = true
                return true
            end if
        end if
    end if
    return result
end function
