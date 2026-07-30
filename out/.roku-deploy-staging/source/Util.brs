function parseResponse(content as object)

  ContentNode = CreateObject("RoSGNode", "ContentNode")
  ContentNode.Title = "Watch For Free"

  ContentRowNode = CreateObject("RoSGNode", "ContentNode")

  for each jsonitem in content
    ContentRowItemNode = CreateObject("RoSGNode", "ContentNode")
    ContentRowItemNode.Title = "Category List Row Item"

    if jsonitem.shows[0].logo_thumb <> invalid
      HDPosterURL = jsonitem.shows[0].logo_thumb
    else
      HDPosterURL = ""
    end if


    ContentRowItemNode.addFields({
      "user_id": jsonitem.show_id,
      "title": jsonitem.show_name,
      "resolution": jsonitem.synopsis,
      "HDPosterURL": HDPosterURL
    })

    ContentRowNode.appendChild(ContentRowItemNode)
  end for

  ContentNode.appendChild(ContentRowNode)
  return ContentNode

end function


function parseHomeListApiContent(content as object, initialLoadOnly as boolean) as object
  BaseContentNode2 = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode2.title = "BaseContentNode2"
  featuredNode = invalid
  rowCount = 0

  for each item in content
    ' If we only want initial load, stop after 2 rows
    if initialLoadOnly and rowCount >= 2 then exit for

    RowContentNode = CreateObject("RoSGNode", "ContentNode")
    if not item.type = "FEATURED"
      RowContentNode.title = item.category_name
    end if

    RowContentNode.addFields({
      "categoryId": item.category_id,
      "item_shape": item.item_shape,
      "visible_items_count": item.visible_items_count,
      "rawCategoryItem": item
    })

    if item.shows <> invalid
      topTrendingOrder = 0
      for each subItem in item.shows
        ItemContentNode = CreateObject("RoSGNode", "ContentNode")

        if subItem.show_name <> "" and subItem.show_name <> invalid
          ItemContentNode.Title = subItem.show_name
        else if subItem.video_title <> "" and subItem.video_title <> invalid
          ItemContentNode.Title = subItem.video_title
        else
          ItemContentNode.Title = ""
        end if

        if subItem.type = "LIVE"
          HDPosterURL = "https://gizmeon.mdc.akamaized.net/thumbnails/show_logo/" + subItem.placeholder
        else
          if subItem.logo_thumb = invalid
            HDPosterURL = subItem.banner
          else
            HDPosterURL = subItem.logo_thumb
          end if
        end if

        if item.type = "TOP_TRENDING"
          topTrendingOrder = topTrendingOrder + 1
        end if

        ItemContentNode.addFields({
          "user_id": subItem.user_id,
          "resolution": subItem.resolution,
          "year": subItem.year,
          "show_id": subItem.show_id,
          "HDPosterURL": subItem.logo_thumb,
          "HDPosterURLPortrait": subItem.logo,
          "HDBACKGROUNDIMAGEURL": HDPosterURL,
          "is_free_video": subItem.is_free_video,
          "is_locked": subItem.is_locked,
          "category_name": subItem.category_name,
          "category_names": subItem.category_names,
          "rating": subItem.rating,
          "synopsis": subItem.synopsis,
          "channel_name": subItem.channel_name,
          "channel_id": subItem.channel_id,
          "linear_channel_id": subItem.linear_channel_id,
          "itemtype": subItem.type,
          "itemType": subItem.type,
          "categoryType": item.type,
          "live_url": subItem.live_url,
          "live_link": subItem.live_link,
          "watched_percentage": subItem.watched_percentage,
          "video_id": subItem.video_id,
          "EVENT_ID": subItem.event_id,
          "duration_text": subItem.duration_text,
          "name": subItem.show_name,
          "url": subItem.url,
          "event_type": subItem.event_type,
          "start_time": subItem.starttime,
          "end_time": subItem.endtime,
          "tumbnail": subItem.thumbnail,
          "thumbnail_350_200": subItem.thumbnail_350_200,
          "type": subItem.type,
          "description": subItem.description,
          "podcast_id": subItem.podcast_id,
          "thumbnail_orientation": item.thumbnail_orientation,
          "topTrendingOrder": topTrendingOrder,
          "ai_type": subItem.ai_type,
          "show_cast": subItem.show_cast,
          "show_trailer": subItem.show_trailer,
          "trailerUrl": subItem.teaser,
          "item_shape ": item.item_shape,
          "image_title": subItem.image_title,
          "live_channel_id": subItem.channel_id,
          "hero_image": subItem.hero_image,
          "key": subItem.key,
          "checkout_qr": subItem.checkout_qr,
          "button_text": subItem.button_text,
          "rental_flag": subItem.rental_flag,
          "payper_flag": subItem.payper_flag,
          "rawItem": subItem
        })
        RowContentNode.appendChild(ItemContentNode)
      end for
    end if

    if item.shows_count <> invalid and item.shows_count > 10 and item.type <> invalid and item.type <> "GENRES" and item.type <> "FEATURED" and item.type <> "TOP_TRENDING" and item.type <> "CONTINUE_WATCHING" and item.type <> "RECENTLY_ADDED" and item.type <> "MY_LIST" and item.type <> "SHORTS" and item.type <> "MICRO_DRAMA"
      showMoreChildNode = CreateObject("RoSGNode", "ContentNode")
      showMoreChildNode.addFields({ "itemtype": "SHOW_MORE_ITEM" })
      RowContentNode.appendChild(showMoreChildNode)
    end if

    if item.type = "FEATURED"
      featuredNode = createObject("roSGNode", "ContentNode")
      featuredNode.addFields({ title: "Featured" }) 
      featuredNode.appendChild(RowContentNode)
    else
      BaseContentNode2.appendChild(RowContentNode)
      rowCount = rowCount + 1 ' Increment processed row count
    end if
  end for

  if featuredNode <> invalid then BaseContentNode2.addFields({ "featuredRowNode": featuredNode })
  return BaseContentNode2
end function


' function parseHomeListApiContent(content as object) as object
'   BaseContentNode0 = CreateObject("RoSGNode", "ContentNode")
'   BaseContentNode = CreateObject("RoSGNode", "ContentNode")
'   BaseContentNode2 = CreateObject("RoSGNode", "ContentNode")
'   BaseContentNode2.title = "BaseContentNode2"
'   featuredNode = invalid

'   for each item in content

'     RowContentNode = CreateObject("RoSGNode", "ContentNode")
'     if not item.type = "FEATURED"
'       RowContentNode.title = item.category_name
'     end if


'     RowContentNode.addFields({
'       "categoryId": item.category_id,
'       "item_shape": item.item_shape,
'       "visible_items_count": item.visible_items_count,
'       "rawCategoryItem": item
'     })
'     ' RowContentNode.title = "RowContentNode"

'     if item.shows <> invalid
'       topTrendingOrder = 0
'       ' if item.shows.count() > 15
'       '   first10 = item.shows.slice(0, 10)
'       ' else
'       '   first10 = item.shows
'       ' end if

'       for each subItem in item.shows
'         ItemContentNode = CreateObject("RoSGNode", "ContentNode")
'         ' ItemContentNode.addField("FHDItemWidth", "float", false)


'         if subItem.show_name <> "" and subItem.show_name <> invalid
'           ItemContentNode.Title = subItem.show_name
'         else if subItem.video_title <> "" and subItem.video_title <> invalid
'           ItemContentNode.Title = subItem.video_title
'         else
'           ItemContentNode.Title = ""
'         end if

'         if subItem.type = "LIVE"
'           HDPosterURL = "https://gizmeon.mdc.akamaized.net/thumbnails/show_logo/" + subItem.placeholder
'         else
'           if subItem.logo_thumb = invalid
'             HDPosterURL = subItem.banner
'           else
'             HDPosterURL = subItem.logo_thumb
'           end if
'         end if



'         if item.type = "TOP_TRENDING"
'           topTrendingOrder = topTrendingOrder + 1
'         end if


'         '  ItemContentNode.FHDItemWidth = 320

'         ' if subItem.DoesExist("ai_type") and subItem.ai_type <> invalid
'         '   ItemContentNode.addFields({
'         '     "ai_type": subItem.ai_type
'         '   })
'         ' else
'         '   ItemContentNode.addFields({
'         '     "ai_type": ""
'         '   })
'         ' end if


'         ItemContentNode.addFields({
'           "user_id": subItem.user_id,
'           "resolution": subItem.resolution,
'           "year": subItem.year,
'           "show_id": subItem.show_id,
'           ' "HDPosterURL": HDPosterURL,
'           "HDPosterURL": subItem.logo_thumb,
'           "HDPosterURLPortrait": subItem.logo,
'           "HDBACKGROUNDIMAGEURL": HDPosterURL,
'           "is_free_video": subItem.is_free_video,
'           "is_locked": subItem.is_locked,
'           "category_name": subItem.category_name,
'           "category_names": subItem.category_names,
'           "rating": subItem.rating,
'           "synopsis": subItem.synopsis,
'           "channel_name": subItem.channel_name,
'           "channel_id": subItem.channel_id,
'           "linear_channel_id": subItem.linear_channel_id,
'           ' "itemType": "categories",
'           "itemtype": subItem.type,
'           "categoryType": item.type,
'           "live_url": subItem.live_url,
'           "live_link": subItem.live_link,
'           "watched_percentage": subItem.watched_percentage,
'           "video_id": subItem.video_id,
'           "EVENT_ID": subItem.event_id,
'           "duration_text": subItem.duration_text,
'           "synopsis": subItem.synopsis,
'           "name": subItem.show_name,
'           "url": subItem.url,
'           "event_type": subItem.event_type
'           "start_time": subItem.starttime,
'           "end_time": subItem.endtime,
'           "tumbnail": subItem.thumbnail,
'           "thumbnail_350_200": subItem.thumbnail_350_200,
'           "type": subItem.type,
'           "description": subItem.description, 'podcast
'           "podcast_id": subItem.podcast_id 'podcast
'           "thumbnail_orientation": item.thumbnail_orientation
'           "topTrendingOrder": topTrendingOrder,
'           "ai_type": subItem.ai_type,
'           "show_cast": subItem.show_cast
'           "show_trailer": subItem.show_trailer,
'           "trailerUrl": subItem.teaser,
'           "item_shape ": item.item_shape,
'           "image_title": subItem.image_title,
'           "live_channel_id": subItem.channel_id,
'           "category_name": subItem.category_name,
'           "hero_image": subItem.hero_image,
'           "key": subItem.key,
'           "checkout_qr": subItem.checkout_qr,
'           "button_text": subItem.button_text,
'           "rental_flag": subItem.rental_flag,
'           "payper_flag": subItem.payper_flag,
'           "rawItem": subItem
'           ' "itemWidth": itemWidth

'         })
'         RowContentNode.appendChild(ItemContentNode)


'         '############### film of the week banner adding  as next row
'         ' if (subItem.week <> invalid and subItem.week = "THIS WEEK") then
'         '   ?subItem
'         '   ?"subItem123444"
'         '   featuredRow = CreateObject("RoSGNode", "ContentNode")
'         '   featuredRow.title = item.category_name
'         '   featuredItem = CreateObject("RoSGNode", "ContentNode")
'         '   featuredItem.addFields({
'         '     "duration_text": subItem.duration_text,
'         '     "is_free_video": subItem.is_free_video,
'         '     "logo": subItem.logo,
'         '     "HDPosterURL": subItem.logo_thumb,
'         '     "itemType": "FILM_OF_THE_WEEK"'subItem.main_Type,
'         '     "rating": subItem.rating,
'         '     "show_id": subItem.show_id,
'         '     "show_name": subItem.show_name,
'         '     "type": subItem.type,
'         '     "vanity_url": subItem.vanity_url,
'         '     "video_duration": subItem.video_duration,
'         '     "video_length": subItem.video_length,
'         '     "week": subItem.week,
'         '     "year": "",
'         '     "director": ""
'         '     "resolution": "",
'         '     "synopsis":subItem.synopsis
'         '   })
'         '   featuredRow.appendChild(featuredItem)
'         '   BaseContentNode2.insertChild(featuredRow, item.order)
'         ' end if
'       end for
'     end if
'     if item.shows_count <> invalid and item.shows_count > 10 and item.type <> invalid and item.type <> "GENRES" and item.type <> "FEATURED" and item.type <> "TOP_TRENDING" and item.type <> "NEW_RELEASES" and item.type <> "CONTINUE_WATCHING" and item.type <> "RECENTLY_ADDED" and item.type <> "MY_LIST" and item.type <> "SHORTS" and item.type <> "MICRO_DRAMA"
'       showMoreChildNode = CreateObject("RoSGNode", "ContentNode")
'       showMoreChildNode.addFields({
'       "itemtype": "SHOW_MORE_ITEM" })
'       RowContentNode.appendChild(showMoreChildNode)
'     end if


'     if item.type = "FEATURED"
'       featuredNode = createObject("roSGNode", "ContentNode")
'       featuredNode.addFields({ title: "Featured" }) ' add any fields you need
'       featuredNode.appendChild(RowContentNode)
'       ' Store the featured node in BaseContentNode2
'     else
'       BaseContentNode2.appendChild(RowContentNode)
'     end if
'     '   if RowContentNode.getchildCount() > 10
'     '     for i = 0 to 9
'     '       if i >= RowContentNode.getChildCount()
'     '         exit for
'     '       end if
'     '       BaseContentNode2.appendChild(RowContentNode.getChild(i))
'     '     end for
'     '   else
'     '     BaseContentNode2.appendChild(RowContentNode)
'     '   end if
'     ' end for
'   end for
'   if featuredNode <> invalid then BaseContentNode2.addFields({ "featuredRowNode": featuredNode })
'   return BaseContentNode2
' end function


function parseMultiLanguageListApiContent(list as object)
  ?"parseMultiLanguageContent called"

  ParentContentNode = CreateObject("RoSGNode", "ContentNode")

  ' rowContentNode = CreateObject("RoSGNode", "ContentNode")
  ' rowContentNode.Title = rowAA.category_name

  for each itemAA in list

    ?itemAA
    itemContentNode = CreateObject("RoSGNode", "ContentNode")
    itemContentNode.title = itemAA.language_name


    itemContentNode.addFields({
      "language_id": itemAA.language_id
      "short_code": itemAA.short_code
    })
    ?itemContentNode
    ?itemAA
    ParentContentNode.appendChild(itemContentNode)
  end for
  ? ParentContentNode.getChild(0)
  return ParentContentNode
end function


function ParseContentForCategoryListing(list as object)
  ?"ParseContentForCategoryListing called"

  ' The main container for all rows
  ParentContentNode = CreateObject("RoSGNode", "ContentNode")

  ' The list of items is inside the 'children' of the passed object
  if list <> invalid
    items = list.getChildren(-1, 0)
    if items <> invalid and items.count() > 0
      itemsPerRow = 4
      totalItems = items.count()

      ' Loop through all items and group them into rows
      for i = 0 to totalItems - 1 step itemsPerRow
        row = CreateObject("RoSGNode", "ContentNode")

        ' Set title only for the first row
        if i = 0
          row.title = "Channels"
        end if

        for j = i to i + itemsPerRow - 1
          if j >= totalItems
            exit for
          end if

          ' Get each item from the children list
          itemAA = items[j]

          ' Create a new node for the item
          itemContentNode = CreateObject("RoSGNode", "ContentNode")

          ' Set the title from the item's title field (e.g., "Education")
          itemContentNode.title = itemAA.title

          ' Add the id and key from the item
          itemContentNode.addFields({
            "key": itemAA.key,
            "id": itemAA.id,
            "title": itemAA.title,
            "type": itemAA.type
          })

          ' Add the new item node to the current row
          row.appendChild(itemContentNode)
        end for

        ' Add the completed row to the main container
        ParentContentNode.appendChild(row)
      end for
    else
      return invalid ' Return invalid if there are no items
    end if
  else
    return invalid ' Return invalid if the list itself is invalid
  end if

  return ParentContentNode
  ?"df"
end function


function parseSearchContent(list as object)

  if list <> invalid and list.count() <> 0

    if list[0].doesExist("category_name") and list[0].doesExist("shows") then 'this lists shows and videos in seperate rows like in redeemtv
      ParentContentNode = CreateObject("RoSGNode", "ContentNode")

      for each rowAA in list
        rowContentNode = CreateObject("RoSGNode", "ContentNode")
        rowContentNode.Title = rowAA.category_name

        for each itemAA in rowAA.shows
          itemContentNode = CreateObject("RoSGNode", "ContentNode")
          itemContentNode.addFields({
            "video_id": itemAA.video_id,
            "title": itemAA.show_name,
            "name": itemAA.show_name, ' for podcast
            "synopsis": itemAA.synopsis,
            "description": itemAA.description, ' for podcast
            "vanity_url": itemAA.vanity_url,
            "schedule_date": itemAA.schedule_date,
            "HDPosterURLPortrait": itemAA.logo,
            "HDPOSTERURL": itemAA.logo_thumb,
            "show_id": itemAA.show_id,
            "categoryType": rowAA.type,
            "is_free_video": itemAA.is_free_video,
            "event_id": itemAA.event_id,
            "is_locked": itemAA.is_locked,
            "url": itemAA.url, ' for podcast
            "podcast_id": itemAA.podcast_id' for podcast
            "rental_flag": itemAA.rental_flag,
            "payper_flag": itemAA.payper_flag,
            "type": itemAA.type, ' for live
            "channel_id": itemAA.channel_id, ' for live
            "show_name": itemAA.show_name, ' for live
            "logo": itemAA.logo, ' for live
            "logo_thumb": itemAA.logo_thumb, ' for live
            ai_type: itemAA.ai_type

          })
          ' if itemAA.DoesExist("ai_type")
          '   ai_type = itemAA.ai_type
          ' else
          '   ai_type = ""
          ' end if

          ' itemContentNode.addFields({
          '   "ai_type": ai_type
          ' })
          rowContentNode.appendChild(itemContentNode)
        end for

        ParentContentNode.appendChild(rowContentNode) 'setting videos row
      end for
      return ParentContentNode
    else
      ParentContentNode = CreateObject("RoSGNode", "ContentNode")

      if getThumbnailOrientaion2() = "LANDSCAPE"
        itemsPerRow = 3
      else
        itemsPerRow = 4
      end if

      totalItems = list.count()

      for i = 0 to totalItems - 1 step itemsPerRow
        row = CreateObject("RoSGNode", "ContentNode")
        if i = 0
          row.title = "Search Results"
        end if

        for j = i to i + itemsPerRow - 1
          if j >= totalItems
            exit for
          end if

          item = list[j]
          itemContentNode = CreateObject("RoSGNode", "ContentNode")
          itemContentNode.addFields({
            "category_id": item.category_id,
            "title": item.show_name,
            "category_name": item.category_name,
            "director": item.director,
            "languageid": item.languageid,
            "languagename": item.languagename,
            "show_id": item.show_id,
            "video_flag": item.video_flag,
            "HDPosterURLPortrait": item.logo,
            "HDPosterURL": item.logo_thumb,
            "show_name": item.show_name,
            "synopsis": item.synopsis,
            "vanity_url": item.vanity_url,
            "single_video": item.single_video,
            "teaser_duration": item.teaser_duration,
            "year": item.year,
            "show_cast": item.show_cast,
            "categoryType": "SHOWS",
            "rental_flag": item.rental_flag,
            "payper_flag": item.payper_flag,
            "video_id": item.video_id
          })

          row.appendChild(itemContentNode)
        end for

        ParentContentNode.appendChild(row)
      end for

      return ParentContentNode

    end if
  end if
end function


function parseSearchContentForShowMore(_list as object)
  if _list <> invalid and _list.shows <> invalid
    list = _list.shows
    if list <> invalid and list.count() <> 0

      ' if list[0].DoesExist("type") then
      '   ParentContentNode = CreateObject("RoSGNode", "ContentNode")

      '   for each rowAA in list
      '     rowContentNode = CreateObject("RoSGNode", "ContentNode")
      '     rowContentNode.Title = rowAA.category_name

      '     for each itemAA in rowAA.shows
      '       itemContentNode = CreateObject("RoSGNode", "ContentNode")
      '       itemContentNode.addFields({
      '         "video_id": itemAA.video_id,
      '         "title": itemAA.show_name,
      '         "name": itemAA.show_name, ' for podcast
      '         "synopsis": itemAA.synopsis,
      '         "description": itemAA.description, ' for podcast
      '         "vanity_url": itemAA.vanity_url,
      '         "schedule_date": itemAA.schedule_date,
      '         "HDPosterURLPortrait": itemAA.logo,
      '         "HDPOSTERURL": itemAA.logo_thumb,
      '         "show_id": itemAA.show_id,
      '         "categoryType": rowAA.type,
      '         "is_free_video": itemAA.is_free_video,
      '         "event_id": itemAA.event_id,
      '         "is_locked": itemAA.is_locked,
      '         "url": itemAA.url, ' for podcast
      '         "podcast_id": itemAA.podcast_id' for podcast

      '         "type": itemAA.type, ' for live
      '         "channel_id": itemAA.channel_id, ' for live
      '         "show_name": itemAA.show_name, ' for live
      '         "logo": itemAA.logo, ' for live
      '         "logo_thumb": itemAA.logo_thumb, ' for live
      '         ai_type: itemAA.ai_type

      '       })
      '       ' if itemAA.DoesExist("ai_type")
      '       '   ai_type = itemAA.ai_type
      '       ' else
      '       '   ai_type = ""
      '       ' end if

      '       ' itemContentNode.addFields({
      '       '   "ai_type": ai_type
      '       ' })
      '       rowContentNode.appendChild(itemContentNode)
      '     end for

      '     ParentContentNode.appendChild(rowContentNode) 'setting videos row
      '   end for
      '   return ParentContentNode


      ' else
      ParentContentNode = CreateObject("RoSGNode", "ContentNode")

      if _list.thumbnail_orientation <> invalid
        if _list.thumbnail_orientation = "LANDSCAPE"
          itemsPerRow = 5
        else if _list.thumbnail_orientation = "PORTRAIT"
          itemsPerRow = 7 ' ← Changed from 3 to 4
        end if
      end if
      totalItems = list.count()

      for i = 0 to totalItems - 1 step itemsPerRow
        row = CreateObject("RoSGNode", "ContentNode")

        ' if i = 0
        '   row.title = "Search Results"
        ' end if

        for j = i to i + itemsPerRow - 1
          if j >= totalItems
            exit for
          end if

          item = list[j]
          itemContentNode = CreateObject("RoSGNode", "ContentNode")
          itemContentNode.addFields({
            "category_id": item.category_id,
            "title": item.show_name,
            "category_name": item.category_name,
            "director": item.director,
            "languageid": item.languageid,
            "languagename": item.languagename,
            "show_id": item.show_id,
            "video_flag": item.video_flag,
            "HDPosterURLPortrait": item.logo,
            "HDPosterURL": item.logo_thumb,
            "show_name": item.show_name,
            "synopsis": item.synopsis,
            "vanity_url": item.vanity_url,
            "single_video": item.single_video,
            "teaser_duration": item.teaser_duration,
            "year": item.year,
            "show_cast": item.show_cast,
            "categoryType": "SHOWS",
            "video_id": item.video_id,
            "rental_flag": item.rental_flag,
            "payper_flag": item.payper_flag,
            "thumbnail_orientation": _list.thumbnail_orientation
          })

          row.appendChild(itemContentNode)
        end for

        ParentContentNode.appendChild(row)
      end for

      return ParentContentNode


    end if
  end if
end function

function parseSearchContentForShowMore2(list as object)

  if list <> invalid and list.count() <> 0

    ParentContentNode = CreateObject("RoSGNode", "ContentNode")

    if getThumbnailOrientaion2() = "LANDSCAPE"
      itemsPerRow = 5
    else
      itemsPerRow = 7
    end if

    totalItems = list.count()

    for i = 0 to totalItems - 1 step itemsPerRow
      row = CreateObject("RoSGNode", "ContentNode")
      if i = 0
        row.title = "Search Results"
      end if

      for j = i to i + itemsPerRow - 1
        if j >= totalItems
          exit for
        end if

        item = list[j]
        itemContentNode = CreateObject("RoSGNode", "ContentNode")
        itemContentNode.addFields({
          "category_id": item.category_id,
          "title": item.show_name,
          "category_name": item.category_name,
          "director": item.director,
          "languageid": item.languageid,
          "languagename": item.languagename,
          "show_id": item.show_id,
          "video_flag": item.video_flag,
          "HDPosterURLPortrait": item.logo,
          "HDPosterURL": item.logo_thumb,
          "show_name": item.show_name,
          "synopsis": item.synopsis,
          "vanity_url": item.vanity_url,
          "single_video": item.single_video,
          "teaser_duration": item.teaser_duration,
          "year": item.year,
          "show_cast": item.show_cast,
          "categoryType": "SHOWS",
          "rental_flag": item.rental_flag,
          "payper_flag": item.payper_flag,
          "video_id": item.video_id
        })

        row.appendChild(itemContentNode)
      end for

      ParentContentNode.appendChild(row)
    end for

    return ParentContentNode

  end if
  ' end if
end function


function parseSearchFilterContent(list)
  ParentContentNode = CreateObject("RoSGNode", "ContentNode")
  for each itemAA in list
    itemContentNode = CreateObject("RoSGNode", "ContentNode")
    itemContentNode.title = itemAA.filter_title
    itemContentNode.HDLISTITEMICONURL = "pkg:/images/icons/transparent.png"
    itemContentNode.HDLISTITEMICONSELECTEDURL = "pkg:/images/icons/transparent.png"

    'parsing for subcategory
    SubcategoryMainContentNode = CreateObject("RoSGNode", "ContentNode")
    for each item in itemAA.options
      SubcategoryItemContentNode = CreateObject("RoSGNode", "ContentNode")
      SubcategoryItemContentNode.title = item.title
      SubcategoryItemContentNode.addFields({
        "option_id": item.option_id
      })
      SubcategoryMainContentNode.appendChild(SubcategoryItemContentNode)
    end for

    itemContentNode.addFields({
      "filter_id": itemAA.filter_id
      "filter_title": itemAA.filter_title
      "options": itemAA.options,
      "is_selected": false,
      "option_id_selected_currently": -1000,
      "SubcategoryMainContentNode": SubcategoryMainContentNode
    })
    ParentContentNode.appendChild(itemContentNode)
  end for
  return ParentContentNode
end function


function parseLazyLoadingSubCategoryContent(content as object) as object
  BaseContentNode = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode.title = "BaseContentNode"

  RowContentNode = CreateObject("RoSGNode", "ContentNode")
  RowContentNode.title = "RowContentNode"
  ' RowContentNode.title = item.category_name
  ' RowContentNode.addFields({
  '   "categoryId" : item.category_id
  ' })
  ' RowContentNode.title = "RowContentNode"

  for each subItem in content
    ItemContentNode = CreateObject("RoSGNode", "ContentNode")
    ItemContentNode.Title = subItem.show_name
    ItemContentNode.addFields({
      "user_id": subItem.user_id,
      "resolution": subItem.resolution,
      "year": subItem.year,
      "show_id": subItem.show_id,
      "is_free_video": subItem.is_free_video,
      "category_name": subItem.category_name,
      "category_names": subItem.category_names,
      "rating": subItem.rating,
      "synopsis": subItem.synopsis,
      "channel_name": subItem.channel_name,
      ' "itemType": "categories",
      "itemtype": subItem.type,
      "live_url": subItem.live_url,
      "live_link": subItem.live_link,
      "watched_percentage": subItem.watched_percentage,
      "video_id": subItem.video_id,
      "upcomingEventId": subItem.event_id

    })
    RowContentNode.appendChild(ItemContentNode)
  end for

  BaseContentNode.appendChild(RowContentNode)

  return RowContentNode
end function




function parseLazyLoadingCategoryContentTest(content as object) as object
  BaseContentNode = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode.title = "BaseContentNode"


  RowContentNode = CreateObject("RoSGNode", "ContentNode")
  RowContentNode.title = "RowContentNode"
  ' RowContentNode.title = item.category_name
  ' RowContentNode.addFields({
  '   "categoryId" : item.category_id
  ' })
  ' RowContentNode.title = "RowContentNode"

  for each subItem in content
    ItemContentNode = CreateObject("RoSGNode", "ContentNode")
    ItemContentNode.Title = subItem.show_name
    ItemContentNode.addFields({
      "user_id": subItem.user_id,
      "resolution": subItem.resolution,
      "year": subItem.year,
      "HDPosterURL": subItem.logo,
      "HDBACKGROUNDIMAGEURL": subItem.logo,
      "is_free_video": subItem.is_free_video,
      "category_name": subItem.category_name,
      ' "itemType": "categories",
      "itemtype": subItem.type,
      "live_link": subItem.live_link

    })
    RowContentNode.appendChild(ItemContentNode)
  end for

  BaseContentNode.appendChild(RowContentNode)

  return RowContentNode
end function

function parseLazyLoadingCategoryContent(content as object) as object
  BaseContentNode0 = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode2 = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode2.title = "BaseContentNode2"
  ?"jkkkkkkjkk"
  for each item in content

    RowContentNode = CreateObject("RoSGNode", "ContentNode")
    RowContentNode.title = item.category_name
    RowContentNode.addFields({
      "categoryId": item.category_id
    })
    ' RowContentNode.title = "RowContentNode"

    if item.shows <> invalid
      for each subItem in item.shows
        ItemContentNode = CreateObject("RoSGNode", "ContentNode")
        ItemContentNode.Title = subItem.show_name
        ItemContentNode.addFields({
          "user_id": subItem.user_id,
          "resolution": subItem.resolution,
          "year": subItem.year,
          "show_id": subItem.show_id,
          "HDPosterURL": subItem.logo_thumb,
          "HDBACKGROUNDIMAGEURL": subItem.logo_thumb,
          "is_free_video": subItem.is_free_video,
          "category_name": subItem.category_name,
          "category_names": subItem.category_names,
          "rating": subItem.rating,
          "synopsis": subItem.synopsis,
          "channel_name": subItem.channel_name,
          ' "itemType": "categories",
          "itemtype": subItem.type,
          "live_url": subItem.live_url,
          "live_link": subItem.live_link,
          "watched_percentage": subItem.watched_percentage,
          "video_id": subItem.video_id,
          "upcomingEventId": subItem.event_id

        })
        RowContentNode.appendChild(ItemContentNode)
      end for
    end if


    BaseContentNode2.appendChild(RowContentNode)
  end for



  BaseContentNode.appendChild(BaseContentNode2)
  BaseContentNode0.appendChild(BaseContentNode)

  return BaseContentNode2

end function

function getCurrentTimeInSeconds()
  ' ?"getCurrentTimeInSeconds called"
  date = CreateObject("roDateTime")
  ' date.ToLocalTime()
  dateInEpoch = date.AsSeconds()
  ' ?dateInEpoch
  return dateInEpoch
end function


function getTodaysSecondsFromMidNight()
  ' ?"getTodaysSecondsFromMidNight called"
  date = CreateObject("roDateTime")
  date.ToLocalTime()
  hours = date.GetHours()
  hoursInSeconds = hours * 3600

  minutes = date.GetMinutes()
  minutesInSeconds = minutes * 60

  secondsInCurrentMinute = date.GetSeconds()

  todaysSecondsFromMidNight = hoursInSeconds + minutesInSeconds + secondsInCurrentMinute
  ' ?hours.ToStr() + " " + minutes.ToStr() + " " + secondsInCurrentMinute.ToStr()
  return todaysSecondsFromMidNight
end function





function parseTimeGridApiContent(list as object)
  ?"parseTimeGridApiContent called"
  dt = CreateObject ("roDateTime")
  BaseContentnode = CreateObject("RoSGNode", "ContentNode")
  for each item in list.schedule
    RowContentNode = CreateObject("RoSGNode", "ContentNode")
    RowContentNode.TITLE = item.channel_name
    RowContentNode.HDSMALLICONURL = item.logo
    RowContentNode.id = item.id
    RowContentNode.addFields({
      "live_link": item.live_link,
      "categories": item.categories
    })

    for each subItem in item.schedule
      titleText = ""
      if subItem.title <> invalid and ((subItem.end - subItem.start) > 900)
        titleText = subItem.title
      end if
      ItemContentNode = CreateObject("RoSGNode", "ContentNode")
      ItemContentNode.TITLE = titleText
      todayTwelveAMInSeconds = getCurrentTimeInSeconds() - getTodaysSecondsFromMidNight()
      ItemContentNode.PLAYSTART = todayTwelveAMInSeconds + subItem.start
      ItemContentNode.PLAYDURATION = subItem.end - subItem.start
      ItemContentNode.hdposterurl = subItem.thumbnail

      ItemContentNode.addFields({
        "schedule_id": subItem.id,
        "text": subItem.text,
        "title2": subItem.title
      })
      RowContentNode.appendChild(ItemContentNode)
    end for
    BaseContentnode.appendChild(RowContentNode)

  end for
  return BaseContentnode
end function












function parsePodCastApiContent(content as object) as object
  BaseContentNode0 = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode2 = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode2.title = BaseContentNode2
  for each item in content
    RowContentNode = CreateObject("RoSGNode", "ContentNode")
    RowContentNode.title = item.category_name
    RowContentNode.addFields({
      "categoryId": item.category_id
    })
    for each subItem in item.shows
      ItemContentNode = CreateObject("RoSGNode", "ContentNode")
      ItemContentNode.Title = subitem.show_name
      ItemContentNode.addFields({
        "description": subitem.description,
        "name": subitem.name,
        "podcast_id": subitem.podcast_id,
        "HDPosterURL": subitem.image,
        "HDBACKGROUNDIMAGEURL": subitem.image,
        "url": subitem.url,
        "show_id": subitem.show_id

      })
      RowCOntentNode.appendChild(ItemContentNode)
    end for
    BaseContentNode2.appendChild(RowContentNode)
  end for
  BaseContentNode.appendChild(BaseContentNode2)
  BaseContentNode0.appendChild(BaseContentNode)
  return BaseContentNode2
end function


'prasing for upcoming events and live events
function ParseContentForUpcomingEvent(list as object)
  ?list
  ?"lisssssssstn"
  ?list[0]
  ?list[0].ContentList[0]

  item = {}
  itemdetails = []

  ' RowItems = CreateObject("RoSGNode", "ContentNode")
  ' seasonsCount = 0

  for each rowAA in list
    ?"hjj"
    ' row = CreateObject("RoSGNode", "ContentNode")

    for each showdetails in rowAA.ContentList
      ?"hhh"
      item.event_id = showdetails.event_id
      item.show_name = showdetails.show_name
      item.synopsis = showdetails.synopsis
      item.schedule_time = showdetails.schedule_time
      item.logo_thumb = showdetails.thumbnail
      item.logo = showdetails.thumbnail_350_200
      item.itemType = showdetails.itemType

      itemdetails.push(item)
      ?"jhjjj"
    end for
  end for
  return itemdetails


  ' seasonsCount++
  ' seasonWiseRow = CreateObject("RoSGNode", "ContentNode")



  ' if seasonWiseRowItem[0].isSingleVideo = 0
  '   seasonWiseRow.Title = seasonWiseRowItem[0].season_name'"Season " + Str(seasonsCount)
  ' else if seasonWiseRowItem[0].isSingleVideo = 1
  '   seasonWiseRow.Title = "Videos"
  ' end if

  ' seasonIndex = 0
  ' for each itemAA in seasonWiseRowItem
  '   ?itemAA
  '   ?"itemAAAAAAA"

  ' *****************subscriptionData adding***************
  ' subscriptionBaseNode = CreateObject("RoSGNode", "ContentNode")
  ' subscriptionRowNode = CreateObject("RoSGNode", "ContentNode")

  ' subscriptionRowNode.title = "subscription Data"
  ' for each subscriptionitem in itemAA.subscriptions
  '   ?subscriptionitem
  '   ?"subscriptionitemmmmmmmm"
  '   subscriptionItemContentNode = CreateObject("RoSGNode", "ContentNode")
  '   subscriptionItemContentNode.title = "subscriptionItemContentNode"
  '   ?"rtrt"
  '   subscriptionItemContentNode.addFields({

  '     "subscription_text": subscriptionitem.subscription_text,
  '     "price": subscriptionitem.price,
  '     "subscription_id": subscriptionitem.subscription_id
  '     "subscription_name": subscriptionitem.subscription_name

  '   })
  '   ?"fggkhhhgkh"
  '   subscriptionRowNode.appendChild(subscriptionItemContentNode)
  ' end for
  ' subscriptionBaseNode.appendChild(subscriptionRowNode)



  ' ' **************genre adding*****************
  ' TagsBaseNode = CreateObject("RoSGNode", "ContentNode")
  ' if itemAA.categories <> invalid and itemAA.categories.count() <> 0
  '   ?"itemAA.video_tags.Count()"
  '   ?itemAA
  '   for i = 0 to itemAA.categories.Count() - 1 step 4
  '     GenreRowNode = CreateObject("RoSGNode", "ContentNode")
  '     if i = 0
  '       GenreRowNode.title = "Tags"
  '     end if
  '     GenreRowNode.addFields({ "type": "TAGS" })

  '     for j = i to i + 2
  '       GenreItemNode = CreateObject("RoSGNode", "ContentNode")
  '       tagName = ""
  '       if itemAA.video_tags[j] <> invalid
  '         tagName = itemAA.video_tags[j]
  '       end if
  '       GenreItemNode.title = tagName
  '       GenreItemNode.addFields({
  '         "name": tagName,
  '         "type": "TAGS"
  '       })
  '       GenreItemNode.addField("FHDItemWidth", "float", false)
  '       GenreItemNode.FHDItemWidth = backgroundPosterLength(Len(tagName))
  '       ' GenreItemNode.addField("HDItemWidth", 1000, false)
  '       if GenreItemNode.title <> ""
  '         GenreRowNode.appendChild(GenreItemNode)

  '       end if
  '       ?"GenreItemNode.title"
  '       ?GenreItemNode.title
  '       ?i
  '       ?j
  '     end for
  '     TagsBaseNode.appendChild(GenreRowNode)
  '   end for
  ' end if




  ' **************TagsData adding*****************
  ' TagsBaseNode = CreateObject("RoSGNode", "ContentNode")
  ' if itemAA.video_tags <> invalid and itemAA.video_tags.count() <> 0
  '   ?"itemAA.video_tags.Count()"
  '   ?itemAA
  '   for i = 0 to itemAA.video_tags.Count() - 1 step 4
  '     VideoTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
  '     if i = 0
  '       VideoTagsItemRowNode.title = "Tags"
  '     end if
  '     VideoTagsItemRowNode.addFields({ "type": "TAGS" })

  '     for j = i to i + 2
  '       VideoTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
  '       tagName = ""
  '       if itemAA.video_tags[j] <> invalid
  '         tagName = itemAA.video_tags[j]
  '       end if
  '       VideoTagsItemContentNode.title = tagName
  '       VideoTagsItemContentNode.addFields({
  '         "name": tagName,
  '         "type": "TAGS"
  '       })
  '       VideoTagsItemContentNode.addField("FHDItemWidth", "float", false)
  '       VideoTagsItemContentNode.FHDItemWidth = backgroundPosterLength(Len(tagName))
  '       ' VideoTagsItemContentNode.addField("HDItemWidth", 1000, false)
  '       if VideoTagsItemContentNode.title <> ""
  '         VideoTagsItemRowNode.appendChild(VideoTagsItemContentNode)

  '       end if
  '       ?"VideoTagsItemContentNode.title"
  '       ?VideoTagsItemContentNode.title
  '       ?i
  '       ?j
  '     end for
  '     TagsBaseNode.appendChild(VideoTagsItemRowNode)
  '   end for
  ' end if



  '*************Cast nodes for tags listing

  ' if itemAA.cast <> invalid and itemAA.cast.count() <> 0
  '   for i = 0 to itemAA.cast.count() - 1
  '     CastTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
  '     CastTagsItemRowNode.addFields({ "type": "CAST" })
  '     CastTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
  '     CastTagsItemContentNode.title = itemAA.cast[i].name + "   -   " + itemAA.cast[i].role
  '     CastTagsItemContentNode.addFields({
  '       "id": itemAA.cast[i].id,
  '       "name": itemAA.cast[i].name,
  '       "role": itemAA.cast[i].role,
  '       "type": "CAST"
  '     })
  '     CastTagsItemRowNode.appendChild(CastTagsItemContentNode)
  '     if i = 0
  '       CastTagsItemRowNode.Title = "Cast"
  '     end if
  '     TagsBaseNode.appendChild(CastTagsItemRowNode)
  '   end for
  ' end if


  '*************crew nodes for tags listing
  ' for i = 0 to itemAA.crew.Count() - 1
  '   CrewTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
  '   CrewTagsItemRowNode.addFields({
  '     "type": "CREW"
  '   })
  '   CrewTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
  '   if invalid <> itemAA.crew[i].name and invalid <> itemAA.crew[i].role
  '     CrewTagsItemContentNode.title = itemAA.crew[i].name + "   -   " + itemAA.crew[i].role
  '   end if
  '   CrewTagsItemContentNode.addFields({
  '     "id": itemAA.crew[i].id,
  '     "name": itemAA.crew[i].name,
  '     "role": itemAA.crew[i].role,
  '     "type": "CREW"
  '   })
  '   CrewTagsItemRowNode.appendChild(CrewTagsItemContentNode)
  '   if i = 0
  '     CrewTagsItemRowNode.Title = "Crew"
  '   end if
  '   TagsBaseNode.appendChild(CrewTagsItemRowNode)
  ' end for




  ' item = CreateObject("RoSGNode", "ContentNode")
  ' item.addFields({ "user_id": "1",
  '   "video_id": itemAA.video_id,
  '   "ad_link": itemAA.ad_link,
  '   "channel_id": itemAA.channel_id,
  '   "premium_flag": itemAA.premium_flag,
  '   "video_duration": itemAA.video_duration,
  '   "duration_text": itemAA.duration_text,
  '   "teaser": itemAA.teaser,
  '   "maturity_name": itemAA.maturity_name,
  '   "image_title": itemAA.image_title,
  '   "year": itemAA.year,
  '   "director": itemAA.director,
  '   "payper_flag": itemAA.payper_flag,
  '   "rental_flag": itemAA.rental_flag,
  '   "free_video": itemAA.free_video,
  '   "is_free_video": itemAA.is_free_video,
  '   "watched_duration": itemAA.watched_duration,
  '   "producer": itemAA.producer,
  '   "show_cast": itemAA.show_cast,
  '   "show_id": itemAA.show_id,
  '   "categories_id": itemAA.categories_id,
  '   "rateFlag": itemAA.rateFlag,
  '   "userRating": itemAA.userRating,
  '   "subtitles": itemAA.subtitles,
  '   "audio_languages": itemAA.audio_languages,
  '   "our_take": itemAA.our_take,
  '   "cast": itemAA.cast,
  '   "itemType": "videos",
  '   "sub_Title": itemAA.role,
  '   "free_video": itemAA.free_video,
  '   "watched_percentage": itemAA.watched_percentage,
  '   ' "hdposterurl": "https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/" + itemAA.HDPOSTERURL,
  '   ' "HDPOSTERURL": "https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/" + itemAA.HDPOSTERURL
  '   "DESCRIPTION": itemAA.synopsis,
  '   "thumbnail": itemAA.thumbnail,
  '   "thumbnail": itemAA.logo_thumb,
  '   "live_url": itemAA.live_url,
  '   "HDPOSTERURL": itemAA.hdposterurl,
  '   "HDPosterURLPortrait": itemAA.HDPosterURLPortrait,
  '   "day": itemAA.day,
  '   "schedule_time": itemAA.schedule_time,
  '   "URL": itemAA.URL,
  '   "show_name": itemAA.show_name,
  '   "single_video": itemAA.single_video,
  '   "issinglevideo": itemAA.issinglevideo,
  '   "resolution": itemAA.resolution,
  '   "categories": itemAA.categories,
  '   "categoriesWithComma": itemAA.TITLESEASON,
  '   "RELEASEDATE": itemAA.RELEASEDATE,
  '   "subscriptionData": subscriptionBaseNode,
  '   "seasonIndex": seasonIndex,
  '   "video_order": itemAA.video_order,
  '   "season": itemAA.season,
  '   "TagsContent": TagsBaseNode
  ' ' })
  ' item.SetFields(itemAA)

  ' "HDPOSTERURL":"https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/"+ itemAA.hdposterurl
  ' "HDPOSTERURL": itemAA.hdposterurl,
  '     seasonWiseRow.appendChild(item)
  '     seasonIndex = seasonIndex + 1
  '   end for
  '   RowItems.appendChild(seasonWiseRow)
  ' end for
  ' RowItems.appendChild(row)
  ' end for

  ' return RowItems
end function





'*************this parsing is for shows, events, news etc,..
function ParseContentForSeasonWiseShow(list as object)

  RowItems = CreateObject("RoSGNode", "ContentNode")
  seasonsCount = 0

  for each rowAA in list
    row = CreateObject("RoSGNode", "ContentNode")

    for each seasonWiseRowItem in rowAA.ContentList
      seasonsCount++
      seasonWiseRow = CreateObject("RoSGNode", "ContentNode")

      if seasonWiseRowItem[0].isSingleVideo = 0
        seasonWiseRow.Title = seasonWiseRowItem[0].season_name'"Season " + Str(seasonsCount)
      else if seasonWiseRowItem[0].isSingleVideo = 1
        seasonWiseRow.Title = "Videos"
      else if seasonWiseRowItem[0].isSingleVideo = 3
        seasonWiseRow.Title = rowAA.title
      end if
      seasonWiseRow.addFields({
        "type": "VIDEOS",
      })

      seasonIndex = 0
      for each itemAA in seasonWiseRowItem

        ' *****************subscriptionData adding***************
        subscriptionBaseNode = CreateObject("RoSGNode", "ContentNode")
        subscriptionRowNode = CreateObject("RoSGNode", "ContentNode")

        subscriptionRowNode.title = "subscription Data"
        if itemAA <> invalid and itemAA.subscriptions <> invalid
          for each subscriptionitem in itemAA.subscriptions
            subscriptionItemContentNode = CreateObject("RoSGNode", "ContentNode")
            subscriptionItemContentNode.title = "subscriptionItemContentNode"
            subscriptionItemContentNode.addFields({

              "subscription_text": subscriptionitem.subscription_text,
              "price": subscriptionitem.price,
              "subscription_id": subscriptionitem.subscription_id
              "subscription_name": subscriptionitem.subscription_name

            })
            subscriptionRowNode.appendChild(subscriptionItemContentNode)
          end for
          subscriptionBaseNode.appendChild(subscriptionRowNode)

        end if

        ' **************genre adding*****************
        TagsBaseNode = CreateObject("RoSGNode", "ContentNode")
        if itemAA.categories <> invalid and itemAA.categories.count() <> 0

          for i = 0 to itemAA.categories.Count() - 1 step 4
            if i < 30
              GenreRowNode = CreateObject("RoSGNode", "ContentNode")
              if i = 0


                genres = getText("genres")




                GenreRowNode.title = genres
              end if
              GenreRowNode.addFields({ "type": "GENRE" })

              for j = i to i + 2

                if itemAA.categories[j] <> invalid
                  GenreItemNode = CreateObject("RoSGNode", "ContentNode")
                  tagName = ""
                  if itemAA.categories[j] <> invalid and itemAA.categories[j].category_name <> invalid
                    tagName = itemAA.categories[j].category_name
                  end if
                  GenreItemNode.title = tagName
                  GenreItemNode.addFields({
                    "name": tagName,
                    "type": "GENRE",
                    "category_id": itemAA.categories[j].category_id,
                    "category_name": itemAA.categories[j].category_name,
                    "key": itemAA.categories[j].key,
                  })
                  GenreItemNode.addField("FHDItemWidth", "float", false)
                  GenreItemNode.FHDItemWidth = backgroundPosterLength(tagName)
                  ' GenreItemNode.addField("HDItemWidth", 1000, false)
                  if GenreItemNode.title <> ""
                    GenreRowNode.appendChild(GenreItemNode)
                  end if
                end if

              end for
              TagsBaseNode.appendChild(GenreRowNode)
            end if
          end for
        end if




        ' **************TagsData adding*****************
        ' TagsBaseNode = CreateObject("RoSGNode", "ContentNode")
        if itemAA.video_tags <> invalid and itemAA.video_tags.count() <> 0

          for i = 0 to itemAA.video_tags.Count() - 1 step 4
            if i < 11
              VideoTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
              if i = 0


                tags = getText("tags")


                VideoTagsItemRowNode.title = tags
              end if
              VideoTagsItemRowNode.addFields({ "type": "TAGS" })

              for j = i to i + 2
                VideoTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
                tagName = ""
                if itemAA.video_tags[j] <> invalid
                  tagName = itemAA.video_tags[j]
                end if
                VideoTagsItemContentNode.title = tagName
                VideoTagsItemContentNode.addFields({
                  "name": tagName,
                  "type": "TAGS"
                })
                VideoTagsItemContentNode.addField("FHDItemWidth", "float", false)
                VideoTagsItemContentNode.FHDItemWidth = backgroundPosterLength(tagName)
                ' VideoTagsItemContentNode.addField("HDItemWidth", 1000, false)
                if VideoTagsItemContentNode.title <> ""
                  VideoTagsItemRowNode.appendChild(VideoTagsItemContentNode)

                end if

              end for
              TagsBaseNode.appendChild(VideoTagsItemRowNode)
            end if
          end for
        end if



        '*************Cast nodes for tags listing

        if itemAA.cast <> invalid and itemAA.cast.count() <> 0
          for i = 0 to itemAA.cast.count() - 1
            if i < 30
              CastTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
              CastTagsItemRowNode.addFields({ "type": "CAST" })
              CastTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
              CastTagsItemContentNode.title = itemAA.cast[i].name + "   -   " + itemAA.cast[i].role
              CastTagsItemContentNode.addFields({
                "id": itemAA.cast[i].id,
                "name": itemAA.cast[i].name,
                "role": itemAA.cast[i].role,
                "type": "CAST"
              })
              CastTagsItemRowNode.appendChild(CastTagsItemContentNode)

              if i = 0

                cast1 = tags = getText("cast")




                CastTagsItemRowNode.Title = cast1
                ? CastTagsItemRowNode.Title
                ?" CastTagsItemRowNode.Title"
              end if
              TagsBaseNode.appendChild(CastTagsItemRowNode)
            end if
          end for
        end if


        '*************crew nodes for tags listing
        for i = 0 to itemAA.crew.Count() - 1
          if i < 30
            CrewTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
            CrewTagsItemRowNode.addFields({
              "type": "CREW"
            })
            CrewTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
            if invalid <> itemAA.crew[i].name and invalid <> itemAA.crew[i].role
              CrewTagsItemContentNode.title = itemAA.crew[i].name + "   -   " + itemAA.crew[i].role
            end if
            CrewTagsItemContentNode.addFields({
              "id": itemAA.crew[i].id,
              "name": itemAA.crew[i].name,
              "role": itemAA.crew[i].role,
              "type": "CREW"
            })
            CrewTagsItemRowNode.appendChild(CrewTagsItemContentNode)
            if i = 0


              ?"334"


              ?"4545"
              crew = getText("crew")


              if CrewTagsItemRowNode.Title <> invalid then CrewTagsItemRowNode.Title = crew
            end if
            TagsBaseNode.appendChild(CrewTagsItemRowNode)
          end if
        end for




        item = CreateObject("RoSGNode", "ContentNode")
        item.addFields({ "user_id": "1",
          "video_id": itemAA.video_id,
          "ad_link": itemAA.ad_link,
          "channel_id": itemAA.channel_id,
          "premium_flag": itemAA.premium_flag,
          "video_duration": itemAA.video_duration,
          "duration_text": itemAA.duration_text,
          "teaser": itemAA.teaser,
          "maturity_name": itemAA.maturity_name,
          "image_title": itemAA.image_title,
          "year": itemAA.year,
          "director": itemAA.director,
          "payper_flag": itemAA.payper_flag,
          "rental_flag": itemAA.rental_flag,
          "free_video": itemAA.free_video,
          "is_free_video": itemAA.is_free_video,
          "watched_duration": itemAA.watched_duration,
          "producer": itemAA.producer,
          "show_cast": itemAA.show_cast,
          "show_id": itemAA.show_id,
          "categories_id": itemAA.categories_id,
          "rateFlag": itemAA.rateFlag,
          "userRating": itemAA.userRating,
          "subtitles": itemAA.subtitles,
          "audio_languages": itemAA.audio_languages,
          "our_take": itemAA.our_take,
          "cast": itemAA.cast,
          "itemType": "videos",
          "sub_Title": itemAA.role,
          "free_video": itemAA.free_video,
          "watched_percentage": itemAA.watched_percentage,
          ' "hdposterurl": "https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/" + itemAA.HDPOSTERURL,
          ' "HDPOSTERURL": "https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/" + itemAA.HDPOSTERURL
          "DESCRIPTION": itemAA.synopsis,
          "thumbnail": itemAA.thumbnail,
          "thumbnail": itemAA.logo_thumb,
          "live_url": itemAA.live_url,
          "HDPOSTERURL": itemAA.hdposterurl,
          "HDPosterURLPortrait": itemAA.HDPosterURLPortrait,
          "day": itemAA.day,
          "schedule_time": itemAA.schedule_time,
          "URL": itemAA.URL,
          "show_name": itemAA.show_name,
          "single_video": itemAA.single_video,
          "issinglevideo": itemAA.issinglevideo,
          "resolution": itemAA.resolution,
          "categories": itemAA.categories,
          "categoriesWithComma": itemAA.TITLESEASON,
          "RELEASEDATE": itemAA.RELEASEDATE,
          "subscriptionData": subscriptionBaseNode,
          "seasonIndex": seasonIndex,
          "video_order": itemAA.video_order,
          "season": itemAA.season,
          "image_title": itemAA.image_title,
          "is_locked": itemAA.is_locked,
          "checkout_qr1": itemAA.checkout_qr,
          "TagsContent": TagsBaseNode
        })
        item.SetFields(itemAA)


        CastItemRowNode = invalid
        if itemAA.cast <> invalid and itemAA.cast.count() <> 0
          CastItemRowNode = CreateObject("RoSGNode", "ContentNode")
          CastItemRowNode.addFields({ "type": "CAST" })
          for i = 0 to itemAA.cast.count() - 1
            if i < 30
              CastItemContentNode = CreateObject("RoSGNode", "ContentNode")
              CastItemContentNode.title = itemAA.cast[i].name
              CastItemContentNode.addFields({
                "id": itemAA.cast[i].id,
                "Title": itemAA.cast[i].name,
                "role": itemAA.cast[i].role,
                "HDPosterURL": itemAA.cast[i].image
                "itemType": "CAST"
              })
              CastItemRowNode.appendChild(CastItemContentNode)
            end if
            if i = 0

              cast = getText("cast")

              CastItemRowNode.Title = cast
            end if
          end for
        end if

        CrewItemRowNode = invalid
        if itemAA.crew <> invalid and itemAA.crew.count() <> 0
          CrewItemRowNode = CreateObject("RoSGNode", "ContentNode")
          CrewItemRowNode.addFields({ "type": "CREW" })
          for i = 0 to itemAA.crew.count() - 1
            if i < 30
              CrewItemContentNode = CreateObject("RoSGNode", "ContentNode")
              CrewItemContentNode.title = itemAA.crew[i].name
              CrewItemContentNode.addFields({
                "id": itemAA.crew[i].id,
                "Title": itemAA.crew[i].name,
                "role": itemAA.crew[i].role,
                "HDPosterURL": itemAA.crew[i].image
                "itemType": "CREW"
              })
              CrewItemRowNode.appendChild(CrewItemContentNode)
            end if
            if i = 0

              crew = getText("crew")

              CrewItemRowNode.Title = crew
            end if
          end for
        end if

        ' "HDPOSTERURL":"https://gizmeon.s.llnwi.net/vod/thumbnails/thumbnails/"+ itemAA.hdposterurl
        ' "HDPOSTERURL": itemAA.hdposterurl,
        seasonWiseRow.appendChild(item)
        seasonIndex = seasonIndex + 1
      end for
      RowItems.appendChild(seasonWiseRow)
    end for

    if (getCastandCrewImage() = "true")

      if CastItemRowNode <> invalid
        RowItems.appendChild(CastItemRowNode)
      end if
      if CrewItemRowNode <> invalid
        RowItems.appendChild(CrewItemRowNode)
      end if
      ' RowItems.appendChild(row)
    end if
  end for

  return RowItems
end function

function parseVideoDetails(list as object)
  ?"parseVideoDetails called"
  ' **************TagsData adding*****************

  TagsBaseNode = CreateObject("RoSGNode", "ContentNode")

  if list.video_tags <> invalid
    for i = 0 to list.video_tags.Count() - 1 step 4
      if i < 11
        VideoTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
        if i = 0


          tags = getText("tags")




          VideoTagsItemRowNode.title = tags
        end if
        VideoTagsItemRowNode.addFields({ "type": "TAGS" })

        for j = i to i + 2
          VideoTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
          tagName = ""
          if list.video_tags[j] <> invalid
            tagName = list.video_tags[j]
          end if
          VideoTagsItemContentNode.title = tagName
          VideoTagsItemContentNode.addFields({
            "name": tagName,
            "type": "TAGS"
          })
          VideoTagsItemContentNode.addField("FHDItemWidth", "float", false)
          VideoTagsItemContentNode.FHDItemWidth = backgroundPosterLength(tagName)
          ' VideoTagsItemContentNode.addField("HDItemWidth", 1000, false)
          if VideoTagsItemContentNode.title <> ""
            VideoTagsItemRowNode.appendChild(VideoTagsItemContentNode)
          end if

        end for
        TagsBaseNode.appendChild(VideoTagsItemRowNode)
      end if
    end for
  end if


  '*************CAst nodes for tags listing

  if list.cast <> invalid and list.cast.count() <> 0
    for i = 0 to list.cast.count() - 1
      if i < 30
        CastTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
        CastTagsItemRowNode.addFields({ "type": "CAST" })
        CastTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
        CastTagsItemContentNode.title = list.cast[i].name + "   -   " + list.cast[i].role
        CastTagsItemContentNode.addFields({
          "id": list.cast[i].id,
          "name": list.cast[i].name,
          "role": list.cast[i].role,
          "type": "CAST"
        })
        ' ?"CastTagsItemContentNode.title"
        ' ?CastTagsItemContentNode.title
        if CastTagsItemContentNode.title <> ""
          CastTagsItemRowNode.appendChild(CastTagsItemContentNode)
        end if
        if i = 0

          cast1 = getText("cast")

          CastTagsItemRowNode.Title = cast1
        end if
        TagsBaseNode.appendChild(CastTagsItemRowNode)
      end if
    end for
  end if


  '*************crew nodes for tags listing
  if list.crew <> invalid
    for i = 0 to list.crew.Count() - 1
      if i < 30
        CrewTagsItemRowNode = CreateObject("RoSGNode", "ContentNode")
        CrewTagsItemRowNode.addFields({
          "type": "CREW"
        })
        CrewTagsItemContentNode = CreateObject("RoSGNode", "ContentNode")
        CrewTagsItemContentNode.title = list.crew[i].name + "   -   " + list.crew[i].role
        CrewTagsItemContentNode.addFields({
          "id": list.crew[i].id,
          "name": list.crew[i].name,
          "role": list.crew[i].role,
          "type": "CREW"
        })
        CrewTagsItemRowNode.appendChild(CrewTagsItemContentNode)
        if i = 0

          crew = getText("crew")

          CrewTagsItemRowNode.title = crew
        end if
        TagsBaseNode.appendChild(CrewTagsItemRowNode)
      end if
    end for
  end if

  return TagsBaseNode
end function

function backgroundPosterLength(input)
  m.global.textMeasurer.text = input
  textWidth = m.global.textMeasurer.boundingRect().width ' boundingRect() gives you the width and height of the rendered text
  return textWidth + 35 ' Adding some padding to the width for better aesthetics
end function

' function backgroundPosterLength(input)

'   for inputValue = 1 to 200
'     returnValue = calculateReturn(inputValue)
'     if input = inputValue

'       return returnValue
'     end if
'   end for
' end function

function calculateReturn(inputValue as integer) as integer
  ?inputValue

  if inputValue < 1 or inputValue > 200

    return invalid ' Input out of range
  end if


  return 60 + (inputValue - 1) * 15
end function

function parseTagsContent(list)
  ?"parseTagsContent called"
end function


' function ParseShowContent(list as object)

'   Parent = CreateObject("RoSGNode", "ContentNode")
'   for i = 0 to list.count() - 1 step 4
'     row = CreateObject("RoSGNode", "ContentNode")

'     if list[i].thumbnail_orientation = "LANDSCAPE"
'       parseStepNumber = 2
'     else if list[i].thumbnail_orientation = "PORTRAIT"
'       parseStepNumber = 3
'     else
'       parseStepNumber = 2
'     end if

'     for j = i to i + parseStepNumber '************* this is for modifying  the category listing item count in an row when thumbnail orientation changes from portrait to landscape,
'       if list[j] <> invalid
'         item = CreateObject("RoSGNode", "ContentNode")
'         item.addFields({
'           "user_id": list[j].user_id,
'           "show_id": list[j].show_id,
'           "video_id": list[j].video_id,
'           "itemType": list[j].itemType,
'           "show_name": list[j].show_name,
'           "year": list[j].year,
'           "category_name": list[j].category_name,
'           "producer": list[j].producer,
'           "resolution": list[j].resolution,
'           "premium_flag": list[j].premium_flag
'           "thumbnail": list[j].thumbnail
'           "HDPOSTERURL": list[j].hdposterurl
'           "HDPosterURLPortrait": list[j].HDPosterURLPortrait
'           "is_free_video": list[j].is_free_video
'           "is_locked": list[j].is_locked
'           "thumbnail_orientation": list[j].thumbnail_orientation
'         })
'         item.SetFields(list[j])
'         item.STREAMFORMAT = "m3u8"
'         row.appendChild(item)
'       end if
'     end for
'     Parent.appendChild(row)
'   end for
'   return Parent
' end function
' function ParseShowContent(list as object)
'   Parent = CreateObject("RoSGNode", "ContentNode")
'   for i = 0 to list.count() - 1 step 3
'       row = CreateObject("RoSGNode", "ContentNode")
'       stepSize = 3
'       if list[i].thumbnail_orientation = "LANDSCAPE"
'           stepSize = 3
'       else if list[i].thumbnail_orientation = "PORTRAIT"
'           stepSize = 4
'       else
'           stepSize = 3 ' Default case, assume 3 items per row
'       end if
'       for j = i to i + stepSize - 1
'           if j < list.count() and list[j] <> invalid
'               item = CreateObject("RoSGNode", "ContentNode")
'               item.addFields({
'                   "user_id": list[j].user_id,
'                   "show_id": list[j].show_id,
'                   "video_id": list[j].video_id,
'                   "itemType": list[j].itemType,
'                   "show_name": list[j].show_name,
'                   "year": list[j].year,
'                   "category_name": list[j].category_name,
'                   "producer": list[j].producer,
'                   "resolution": list[j].resolution,
'                   "premium_flag": list[j].premium_flag,
'                   "thumbnail": list[j].thumbnail,
'                   "HDPOSTERURL": list[j].hdposterurl,
'                   "HDPosterURLPortrait": list[j].HDPosterURLPortrait,
'                   "is_free_video": list[j].is_free_video,
'                   "is_locked": list[j].is_locked,
'                   "thumbnail_orientation": list[j].thumbnail_orientation
'               })
'               item.SetFields(list[j])
'               item.STREAMFORMAT = "m3u8"
'               row.appendChild(item)
'           end if
'       end for
'       Parent.appendChild(row)
'   end for
'   return Parent
' end function

function ParseShowContent(list as object)
  Parent = CreateObject("RoSGNode", "ContentNode")

  ' Set a single title for the entire content
  if list.count() > 0 and list[0] <> invalid and list[0].DoesExist("title")
    Parent.Title = list[0].title
  else
    Parent.Title = "Movies & Shows"
  end if

  currentOrientation = ""
  i = 0
  if list.count() <> invalid
    while i < list.count()
      if currentOrientation <> list[i].thumbnail_orientation
        currentOrientation = list[i].thumbnail_orientation
        if currentOrientation = "LANDSCAPE"
          stepSize = 2
        else if currentOrientation = "PORTRAIT"
          stepSize = 3
        else
          stepSize = 3 ' Default case, assume 3 items per row
        end if
      end if

      row = CreateObject("RoSGNode", "ContentNode")
      ' No title set for individual rows

      for j = i to i + stepSize - 1
        if j < list.count() and list[j] <> invalid
          item = CreateObject("RoSGNode", "ContentNode")

          ai_type = ""
          if list[j].DoesExist("ai_type")
            ai_type = list[j].ai_type
          end if

          item.addFields({
            "user_id": list[j].user_id,
            "show_id": list[j].show_id,
            "video_id": list[j].video_id,
            "itemType": list[j].itemType,
            "show_name": list[j].show_name,
            "year": list[j].year,
            "category_name": list[j].category_name,
            "producer": list[j].producer,
            "resolution": list[j].resolution,
            "premium_flag": list[j].premium_flag,
            "thumbnail": list[j].thumbnail,
            "HDPOSTERURL": list[j].hdposterurl,
            "HDPosterURLPortrait": list[j].HDPosterURLPortrait,
            "is_free_video": list[j].is_free_video,
            "is_locked": list[j].is_locked,
            "thumbnail_orientation": list[j].thumbnail_orientation,
            "ai_type": list[j].ai_type,
            "rental_flag": list[j].rental_flag,
            "payper_flag": list[j].payper_flag,
            "title": list[j].title
          })
          item.SetFields(list[j])
          item.STREAMFORMAT = "m3u8"

          row.appendChild(item)
        end if
      end for
      Parent.appendChild(row)
      i = i + stepSize
    end while
  end if
  return Parent
end function


function parseCategoryVideosListApiTaskList(list as object)
  ?"nj"
  ParentNode = CreateObject("RoSGNode", "ContentNode")
  for i = 0 to list.Count() - 1 step 4
    RowNode = CreateObject("RoSGNode", "ContentNode")

    for j = i to i + 3
      ChildNode = CreateObject("RoSGNode", "ContentNode")
      ' ai_type = ""
      ' if list[j].DoesExist("ai_type")
      ' ai_type = list[j].ai_type
      ' end if
      ChildNode.addFields({
        "video_id": list[j].video_id,
        "title": list[j].show_name,
        "synopsis": list[j].show_name,
        "vanity_url": list[j].vanity_url,
        "schedule_date": list[j].schedule_date,
        "HDPosterURLPortrait": list[j].logo,
        "HDPOSTERURL": list[j].logo_thumb,
        "show_id": list[j].show_id,
        ' "ai_type":ai_type
      })
      RowNode.appendChild(ChildNode)
    end for
    ParentNode.appendChild(RowNode)
  end for
  ?"jj"
  return ParentNode
end function


' **************************App Opening First Time***********************
function getThumbnailOrientaion2() as string
  sec = CreateObject("roRegistrySection", getAppKey())
  if sec.Exists("THUMBNAIL_ORIENTATION")
    websiteMetaDescription = sec.Read("THUMBNAIL_ORIENTATION")
    return websiteMetaDescription
  else
    return "LANDSCAPE"
  end if
end function


function parseSubscriptionListData(list)
  ' *****************subscriptionData adding***************
  subscriptionBaseNode = CreateObject("RoSGNode", "ContentNode")
  subscriptionRowNode = CreateObject("RoSGNode", "ContentNode")

  subscriptionRowNode.title = "subscription Data"
  for each subscriptionitem in list
    subscriptionItemContentNode = CreateObject("RoSGNode", "ContentNode")
    subscriptionItemContentNode.title = "subscriptionItemContentNode"
    subscriptionItemContentNode.addFields({

      "subscription_text": subscriptionitem.subscription_text,
      "price": subscriptionitem.price,
      "subscription_id": subscriptionitem.subscription_id,
      "subscription_name": subscriptionitem.subscription_name

    })
    subscriptionRowNode.appendChild(subscriptionItemContentNode)
  end for
  subscriptionBaseNode.appendChild(subscriptionRowNode)

  return subscriptionBaseNode
end function


function getLanguageCodeSelected3() as string
  ses = CreateObject("roRegistrySection", getAppKey())
  if ses.Exists("LANGUAGE_CODE_SELECTED")
    value = ses.Read("LANGUAGE_CODE_SELECTED")
    return value
  else
    return "en"
  end if
end function


function parseCommentsFetcherTaskResponse(list as object)
  ?"parseCommentsFetcherTaskResponse called"
  BaseContentnode = CreateObject("RoSGNode", "ContentNode")
  BaseContentnode.title = "Comments"

  for each item in list.data

    RowContentNode = CreateObject("RoSGNode", "ContentNode")
    itemContentNode = CreateObject("RoSGNode", "ContentNode")


    'replies adding
    ReplyBaseContentNode = CreateObject("RoSGNode", "ContentNode")
    ReplyBaseContentNode.title = "Replies"
    if item.replies <> invalid and item.replies.count() <> 0
      for each replyItem in item.replies
        ReplyRowContentNode = CreateObject("RoSGNode", "ContentNode")
        ReplyItemContentNode = CreateObject("RoSGNode", "ContentNode")
        ReplyItemContentNode.TITLE = replyItem.channel_name
        ReplyItemContentNode.addFields({
          "comment_id": replyItem.comment_id,
          "user_name": replyItem.user_name,
          "user_image": replyItem.user_image,
          "user_id": replyItem.user_id,
          "reply_count": replyItem.reply_count,
          "replies": replyItem.replies,
          "like_count": replyItem.like_count,
          "delete_status": replyItem.delete_status,
          "created_at": replyItem.time_ago,
          "comment_text": replyItem.comment_text,
          "comment_id": replyItem.comment_id,
          "itemType": "REPLIES"
        })
        ReplyRowContentNode.appendChild(ReplyItemContentNode)
        ReplyBaseContentNode.appendChild(ReplyRowContentNode)
      end for
    end if



    'comments adding
    itemContentNode.TITLE = item.channel_name
    itemContentNode.addFields({
      "comment_id": item.comment_id,
      "user_name": item.user_name,
      "user_image": item.user_image,
      "user_id": item.user_id,
      "reply_count": item.reply_count,
      "replies": ReplyBaseContentNode,
      "like_count": item.like_count,
      "delete_status": item.delete_status,
      "created_at": item.time_ago,
      "comment_text": item.comment_text,
      "comment_id": item.comment_id,
      "itemType": "COMMENTS"
    })

    RowContentNode.appendChild(itemContentNode)
    BaseContentnode.appendChild(RowContentNode)
  end for

  ' if BaseContentnode.getChild(0) <> invalid and BaseContentnode.getChild(0).getChild(0) <> invalid then
  '   ?"kkk"
  '   BaseContentnode.getChild(0).getChild(0).addFields({
  '     "replies": BaseContentnode,
  '     "reply_count": BaseContentnode.getchildCount()
  '   })
  ' else

  '   ?"hhjjjj"

  ' end if
  return BaseContentnode
end function



function parsedPlayListVideosResponse(data)
  ParentNode = CreateObject("RoSGNode", "ContentNode")
  RowNode = CreateObject("RoSGNode", "ContentNode")
  RowNode.title = "Playlist Videos"

  for each item in data
    ItemNode = CreateObject("RoSGNode", "ContentNode")
    ItemNode.addFields({
      "video_id": item.video_id,
      "title": item.video_title,
      "synopsis": item.synopsis,
      "vanity_url": item.vanity_url,
      "schedule_date": item.schedule_date,
      "HDPosterURLPortrait": item.thumbnail,
      "HDPOSTERURL": item.thumbnail_350_200,
      "show_id": item.show_id,
      "categoryType": item.type,
      "is_free_video": item.is_free_video,
      "is_locked": item.is_locked,
      "categoryType": "videos",
      "checkout_qr": item.checkout_qr,
      ' "video_type" : item.video_type,
      "itemType": "videos"
    })
    RowNode.appendChild(ItemNode)
  end for

  ParentNode.appendChild(RowNode)
  return ParentNode
end function

function parseResolutionLabelList(data as object) as object
  ParentNode = CreateObject("RoSGNode", "ContentNode")
  ParentNode.title = "Select the resolution"

  for each item in data
    ItemNode = CreateObject("RoSGNode", "ContentNode")
    ItemNode.title = item.name
    ItemNode.addFields({
      "title": item.name,
      "description": item.description,
      "type": item.type,
      "url": item.url
    })
    ParentNode.appendChild(ItemNode)
  end for

  return ParentNode
end function

function parseCalendarVideosResponse(list as object) as object
  ?"parseCalendarVideosResponse called"

  BaseContentNodeFordatesPill = CreateObject("RoSGNode", "ContentNode")
  RowPillDateContentNode = CreateObject("RoSGNode", "ContentNode")

  BaseContentNode = CreateObject("RoSGNode", "ContentNode")
  BaseContentNode.title = "Calendar Videos"

  for each dayItem in list



    ItemPillDateContentNode = CreateObject("RoSGNode", "ContentNode")
    ItemPillDateContentNode.title = dayItem.date
    ItemPillDateContentNode.addFields({
      "is_streak_start": dayItem.is_streak_start,
      "is_streak_end": dayItem.is_streak_end,
      "streak_id": dayItem.streak_id,
      "is_break": dayItem.is_break,
      "readable_date": dayItem.date_text,
      "isToday": isToday(dayItem.date)
    })

    if dayItem.videos <> invalid and dayItem.videos.count() > 0
      for each videoItem in dayItem.videos
        RowContentNode = CreateObject("RoSGNode", "ContentNode")
        RowContentNode.title = dayItem.date

        ItemContentNode = CreateObject("RoSGNode", "ContentNode")
        ItemContentNode.title = videoItem.title
        ItemContentNode.addFields({
          "video_id": videoItem.video_id,
          "calendar_id": videoItem.calendar_id,
          "completed": videoItem.completed,
          "thumbnail": videoItem.thumbnail,
          "description": videoItem.description,
          "date": dayItem.date,
          "duration_text": videoItem.duration_text,
          "order": videoItem.order,
          "is_user_video": videoItem.is_user_video
        })

        if videoItem.partner <> invalid and type(videoItem.partner) = "roAssociativeArray"
          if videoItem.partner.name <> invalid
            ItemContentNode.addFields({ "partner_name": videoItem.partner.name })
          end if
          if videoItem.partner.image <> invalid
            ItemContentNode.addFields({ "partner_image": videoItem.partner.image })
          end if
        end if

        RowContentNode.appendChild(ItemContentNode)
        BaseContentNode.appendChild(RowContentNode)
      end for
    end if

    RowPillDateContentNode.appendChild(ItemPillDateContentNode)
  end for

  BaseContentNodeFordatesPill.appendChild(RowPillDateContentNode)
  BaseContentNode.addFields({
    "datesPill": BaseContentNodeFordatesPill
  })
  return BaseContentNode
end function


function isToday(dateStr as string) as boolean
  ' Get today's date in YYYY-MM-DD format
  today = createObject("roDateTime")
  year = today.GetYear()
  month = today.GetMonth()
  day = today.GetDayOfMonth()

  if month < 10 then monthStr = "0" + month.ToStr() else monthStr = month.ToStr()
  if day < 10 then dayStr = "0" + day.ToStr() else dayStr = day.ToStr()
  todayStr = year.ToStr() + "-" + monthStr + "-" + dayStr

  ' Compare with input date string
  return dateStr = todayStr
end function


' Inline helper for localization
function getText2(key as string) as string
  strings = GetStrings()

  if m.global.language_keywords <> invalid and m.global.language_keywords[key] <> invalid and m.global.language_keywords[key][getLanguageCodeSelected4()] <> invalid
    return m.global.language_keywords[key][getLanguageCodeSelected4()]
  end if

  if strings <> invalid and strings[key] <> invalid
    return strings[key]
  end if

  return "" ' safe fallback
end function



function getShowMoreCount()
  ses = CreateObject("roRegistrySection", getAppKey())
  if ses.Exists("SHOW_MORE_COUNT")
    showMoreCount = ses.Read("SHOW_MORE_COUNT")
    return showMoreCount
  else
    return invalid
  end if
end function

function IsNotBlank(value as dynamic) as boolean
  return value <> invalid and value <> ""
end function
