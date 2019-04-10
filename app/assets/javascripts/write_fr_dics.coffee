# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Javascript for delay paly audio in skill Write from dictionary
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
        $secondsEl.text '00'
        callback()
      return
    ), interval)
    return

# ------------------------------------------------------------------------------
$(document).on 'turbolinks:load', ->

  $('.next-button').click ->
    prev = $(this).parent().prev()
    current = $(this).parent()
    next = $(this).parent().next()
    $('.progress li').eq($('fieldset').index(next)).addClass 'active'
    alert($('fieldset').index(current)).find('textarea')
    current.hide()
    next.show()
    $('.timer-beep').get($('fieldset').index(current)).pause()
    $('.timer-beep').get($('fieldset').index(current)).currentTime = 0
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
      document.getElementById('timer-beep').play()
      return
    return
  return
