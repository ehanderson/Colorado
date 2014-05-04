jQuery ->
  $("a[href*='pdf']").each ->
    $(this).addClass('pdf')
    $(this).parent().addClass('text-center')

jQuery ->
  $transition_time = 1000
  $time_between_slides = 4000
  
  $interval = setInterval ( ->
    $('.social-media-cycler').fadeOut(500)
    console.log($('.social-media-cycler'))
    
    $clone = $('.social-media-cycler li:first').clone(true)
    
    setTimeout (->
      $('.social-media-cycler li:first').remove()
    ), 500
    
    console.log("SOMETHING IS SUPPOSED TO HAPPEN")
    console.log($clone)

    $clone.appendTo($('.social-media-cycler')).removeClass().addClass('inactive')
    
    $('.social-media-cycler li:first').addClass('active')

    $('.social-media-cycler').fadeIn(500)

  ), $transition_time + $time_between_slides

cycleThrough = ->
  