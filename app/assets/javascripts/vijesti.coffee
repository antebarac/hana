window.show_news = (id) ->
  $.get('/news/' + id, (data) ->
    $(data).modal({
      opacity: 90,
      onShow: ->
        $("#simplemodal-container").css({
          top: 0,
          height: 'auto',
          position: 'absolute'
        })
    })
  )
