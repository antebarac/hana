second = ->
  $("#blood").fadeIn()
  $("#bkg2").fadeIn()

third = ->
  $("#bruises").fadeIn()
  $("#bkg3").fadeIn()

fourth = ->
  $("#morebruises").fadeIn()
  $("#bkg4").slideDown()

$ ->
  $("#bkg2, #bkg3, #bkg4, #blood, #bruises, #morebruises").hide()
  $(window).load(->
    $("#everything").show()
    setTimeout(second, 2000)
    setTimeout(third, 4000)
    setTimeout(fourth, 6000)
  )
