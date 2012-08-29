hideFlashMessages = ->
  $("div#notice, div#warning, div#error, div#alert").hide "slide"
$(document).ready ->
  setTimeout hideFlashMessages, 7000

# allows comment textareas to autogrow
$(document).ready ->
  $(".comment").autogrow()

# show and hide reply comments
$(document).ready ->
  $(".child_reply_container").hide()
  $(".comment_reply_link").click ->
    $(this).next(".child_reply_container").slideToggle 300
