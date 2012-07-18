hideFlashMessages = ->
  $("div#notice, div#warning, div#error, div#alert").fadeOut 1500
$(document).ready ->
  setTimeout hideFlashMessages, 7000