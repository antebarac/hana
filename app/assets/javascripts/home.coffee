scroll_up = false
scroll_down = false
last_scroll_top = 0
animating_scroll = false

scroll_settings = {
  slide_height: 1000,
  top_offset: 90,
  animation_speed: 500
}

hide_initial =->
  $("#blood, #moreblood").hide()
  $("#bkg2, #bkg3, #bkg4, #bkg5").hide()

show_loaded =->
  $("#everything").show()

hide_background = (id)->
  if(id == "#bkg5")
    $(id).slideUp(500)
  else
    $(id).fadeOut()

show_background = (id)->
  if(id == "#bkg5")
    $(id).slideDown(300)
  else
    $(id).fadeIn()

activate_slide = (index, prev_index) ->
  $("html, body").animate({scrollTop: (index - 1) * scroll_settings.slide_height}, scroll_settings.animation_speed, ->
    setTimeout(->
      animating_scroll = false
    , 1000)
  )
  if(index > prev_index)
    show_background("#bkg2") if index == 3
    show_background("#bkg3") if index == 4
    show_background("#bkg4") if index == 5
    show_background("#bkg5") if index == 6
    hide_background("#bkg5") if index == 7
    hide_background("#bkg4") if index == 8
    hide_background("#bkg3") if index == 9
    hide_background("#bkg2") if index == 10
  if(index < prev_index)
    hide_background("#bkg2") if index == 2
    hide_background("#bkg3") if index == 3
    hide_background("#bkg4") if index == 4
    hide_background("#bkg5") if index == 5
    show_background("#bkg5") if index == 6
    show_background("#bkg4") if index == 7
    show_background("#bkg3") if index == 8
    show_background("#bkg2") if index == 9


adjust_scroll = (e)->
  window_height = $(window).height()
  window_height = 750 if window_height < 750
  size_offset = (window_height - 750) /2
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
    return false
  visible_offset = scroll_top - ((visible_slide_index - 1) * scroll_settings.slide_height)
  if scroll_down && visible_offset > 20
    return if visible_slide_index == slide_count
    animating_scroll = true
    activate_slide(visible_slide_index + 1, visible_slide_index)
  if scroll_up && visible_offset < (scroll_settings.slide_height - 20)
    animating_scroll = true
    activate_slide(visible_slide_index - 1, visible_slide_index)

resize = ->
  gutter = ($(window).width() - 1140)/2
  gutter = 0 if gutter < 0
  window_height = $(window).height()
  window_height = 750 if window_height < 750
  window_width = $(window).width()
  window_width = 940 if window_width < 940
  text_width = 500 +  window_width - 940
  text_width = 700 if text_width > 700
  $(".gradjani").css("width", text_width)
  $("#hana").css("left", gutter)
  $("#hana").css("top", (window_height - 509) /2)
  $("#scroll").css("top", window_height - 100)
  $(".window").css("margin-top", (window_height - 750) /2 + 90)
  $(".gradjani").css("margin-top", (window_height - 750) /2)
  $("ul.language-picker").css("margin-top", (window_height - 750) /2 + 150)
  $(".window .contents, .gradjani, ul.language-picker").css("left", 370 + gutter)

handle_start = ->
  if $(".slide").size() > 0
    $("body").height($(".slide").size() * scroll_settings.slide_height)
  $(window).scroll($.throttle(40, adjust_scroll))
  resize()
  $(window).resize(resize)

page_load = ->
  hide_initial()
  show_loaded()
  handle_start()

ready = ->
  hide_initial()
  $(window).load(->
    show_loaded()
  )
  handle_start()


$(document).ready(ready)
$(document).on('page:load', page_load)
