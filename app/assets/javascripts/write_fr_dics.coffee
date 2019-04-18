# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Javascript for delay paly audio in skill Write from dictionary


# ------------------------------------------------------------------------------
$(document).on 'turbolinks:load', ->

  $.fn.timer = (callback) ->
  callback = callback or ->
  @each ->
    `var timer`
    $timer = $(this)
    $secondsEl = $timer.find('.seconds')
    interval = 1000
    timer = null
    start = 3
    timer = setInterval((->
      start--
      $secondsEl.text start.toString()
      if start == 0
        clearInterval timer
        $secondsEl.text '0'
        callback()
      return
    ), interval)
    return
  
  Pause = ->
    $('.timer-beep').each (i) ->
      $(this).get($('fieldset').index(i)).pause()
      $(this).get($('fieldset').index(i)).currentTime = 0
      return
    return
  
  $('.next-button').click ->
    current = $(this).parent()
    next = $(this).parent().next()
    $('.progress li').eq($('fieldset').index(next)).addClass 'active'
    Pause()
    current.hide()
    next.show()
    $('.timer').timer ->
      $('.timer-beep').get($('fieldset').index(next)).play()
      return
    return
    
  $('.prev-button').click ->
    current = $(this).parent()
    prev = $(this).parent().prev()
    $('.progress li').eq($('fieldset').index(current)).removeClass 'active'
    $('.timer-beep').get($('fieldset').index(current)).pause()
    $('.timer-beep').get($('fieldset').index(current)).currentTime = 0
    current.hide()
    prev.show()
    $('.timer').timer ->
      $('.timer-beep').get($('fieldset').index(prev)).play()
      return
    return
  $ ->
    $('.timer').timer ->
      Pause()
      document.getElementById('timer-beep').play()
      return
    return
  return
