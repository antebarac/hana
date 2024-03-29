scroll_up = false
scroll_down = false
last_scroll_top = 0
animating_scroll = false
gutter = 0

scroll_settings = {
  slide_height: 1000,
  top_offset: 0,
  animation_speed: 750
}

hide_initial =->
  $("#blood, #moreblood").hide()
  $("#bkg2, #bkg3, #bkg4, #bkg5").hide()

show_loaded =->
  $("#everything").show()

hide_background = (id)->
  if(id == "#bkg5")
    $(id).slideUp(400)
  else
    $(id).fadeOut()

show_background = (id)->
  if(id == "#bkg5")
    $(id).slideDown(400)
  else
    $(id).fadeIn()




activate_slide = (index, prev_index) ->
  $("html, body").animate({scrollTop: (index - 1) * scroll_settings.slide_height}, scroll_settings.animation_speed, ->
    setTimeout(->
      animating_scroll = false
    , 100)
  )
  #if($(".slide:eq(" + (index - 1) + ")").hasClass("big-slide"))
  #  setTimeout(->
  #    $(".window").addClass("bigger-window")
  #    $(".hide-on-big-window").hide()
  #  , scroll_settings.animation_speed)
  #else
  #  setTimeout(->
  #    $(".window").removeClass("bigger-window")
  #    $(".hide-on-big-window").show()
  #  , scroll_settings.animation_speed)
  #if($(".slide:eq(" + (index - 1) + ")").hasClass("huge-slide"))
  #  $(".hide-on-huge-window").hide()
  #  $(".contents").addClass("huge-contents").css("left", "0")
  #else
  #  $(".hide-on-huge-window").show()
  #  $(".contents").removeClass("huge-contents").css("left", 320 + gutter)
  return if prev_index == -1
  if(index > prev_index)
    show_background("#bkg2") if index == 4
    show_background("#bkg3") if index == 5
    show_background("#bkg4") if index == 6
    show_background("#bkg5") if index == 7
    hide_background("#bkg5") if index == 8
    hide_background("#bkg4") if index == 9
    hide_background("#bkg3") if index == 10
    hide_background("#bkg2") if index == 11
  if(index < prev_index)
    hide_background("#bkg2") if index == 4
    hide_background("#bkg3") if index == 5
    hide_background("#bkg4") if index == 6
    hide_background("#bkg5") if index == 7
    show_background("#bkg5") if index == 8
    show_background("#bkg4") if index == 9
    show_background("#bkg3") if index == 10
    show_background("#bkg2") if index == 11


adjust_scroll = (e)->
  return if $("#simplemodal-data").is(":visible")
  window_height = $(window).height()
  window_height = 750 if window_height < 750
  size_offset = 0
  #(window_height - 750) /2
  scroll_top = $(window).scrollTop()
  return if scroll_top < 0
  return if scroll_top > ($("body").height() - scroll_settings.slide_height)
  scroll_up = scroll_top < last_scroll_top
  scroll_down = scroll_top > last_scroll_top
  last_scroll_top = scroll_top

  slide_count = $(".slide-container .slide").size()
  for active_slide_index in  [1..slide_count]
    slide_offset = scroll_top - ((active_slide_index - 1) * scroll_settings.slide_height)
    $active_slide = $(".slide" + active_slide_index)
    $active_slide.css("top", slide_offset + scroll_settings.top_offset + size_offset)
  visible_slide_index = parseInt((scroll_top + scroll_settings.slide_height/2) / scroll_settings.slide_height) + 1
  if animating_scroll
    scroll_down = false
    scroll_up = false
    return false
  visible_offset = scroll_top - ((visible_slide_index - 1) * scroll_settings.slide_height)
  if scroll_down 
    animating_scroll = true
    activate_slide(visible_slide_index + 1, visible_slide_index)
  if scroll_up 
    animating_scroll = true
    activate_slide(visible_slide_index - 1, visible_slide_index)

resize = ->
  gutter = ($(window).width() - 1140)/2
  gutter = 0 if gutter < 0
  window_height = $(window).height()
  $(".logos img").css("max-height", 0.7 * window_height).css("width", "auto").css("margin", "0 auto")
  window_height = 750 if window_height < 750
  window_width = $(window).width()
  window_width = 940 if window_width < 940
  text_width = 500 +  window_width - 940
  text_width = 700 if text_width > 700
  $(".gradjani").css("width", text_width)
  $("#hana").css("left", gutter)
  $("#hana").css("top", (window_height - 509) /2)
  $("#scroll").css("top", window_height - 120)
  $(".window").css("margin-top", (window_height - 750) /2 + 90)
  $(".gradjani").css("margin-top", (window_height - 750) /2)
  $("ul.language-picker").css("margin-top", (window_height - 750) /2 + 150)
  $(".window .contents, .gradjani, ul.language-picker").css("left", 320 + gutter)
  $(".window .contents").css("left", 220 + gutter)

handle_start = ->
  $("#scroll").show()
  if $(".slide").size() > 0
    $("body").height($(".slide").size() * scroll_settings.slide_height)
  $(window).scroll($.throttle(40, adjust_scroll))
  resize()
  $(window).resize(resize)

page_load = ->
  hide_initial()
  show_loaded()
  handle_start()

goto_href = (href) ->
  index = $("a[name=" + href + "]").closest(".slide").index()
  return false if index == -1
  animating_scroll = true
  $("html, body").animate({scrollTop: (index) * scroll_settings.slide_height}, scroll_settings.animation_speed, ->
    setTimeout(->
      animating_scroll = false
    ,100)
  )
  return true

ready = ->
  hide_initial()
  $(window).load(->
    show_loaded()
  )
  handle_start()
  anchor = window.location.hash.substring(1)
  if(anchor != null && anchor != "")
    goto_href(anchor)
  $("ul.submenu li a").click((e)->
    e.preventDefault() if goto_href($(this).attr("href").split('#')[1])
  )


$(document).ready(ready)
$(document).on('page:load', page_load)
