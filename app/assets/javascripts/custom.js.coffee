jQuery ->
  $("a[href*='pdf']").each ->
    $(this).addClass('pdf')
    $(this).parent().addClass('text-center')

jQuery ->
  cycleThrough('facebook-cycler')
  cycleThrough('twitter-cycler')

cycleThrough = (klass) ->
  transitionTime = 1000
  timeBetweenSlides = 4000
  $interval = setInterval ( ->
    $clone = $('.' + klass + ' li:first').clone(true)
    $('.' + klass + ' li:first').remove()
    $clone.removeClass().addClass('inactive')
    $('.' + klass + ' ul').append($clone)
    $('.' + klass + ' li:first').removeClass().addClass('active')
  ), transitionTime + timeBetweenSlides