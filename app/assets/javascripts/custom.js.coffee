$(document).ready ->
  $("a[href*='pdf']").each ->
    $(this).addClass('pdf');
    $(this).parent().addClass('text-center');
