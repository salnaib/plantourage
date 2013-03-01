$ ->

  $("#how_we_work_image").click ->
    $("#howwework_form").fadeIn(1000);
    positionhowweworkPopup();

  $("#about_us_image").click ->
    $("#aboutus_form").fadeIn(1000);
    positionaboutusPopup();

  $("#closehowwework").click ->
    $("#howwework_form").fadeOut(500);

  $("#closeaboutus").click ->
    $("#aboutus_form").fadeOut(500);

  positionhowweworkPopup = () ->
    if (!$("#howwework_form").is(':visible'))
      return;
    $("#howwework_form").css({
    left: 30,
    top: ($(window).width() - $('#howwework_form').width()) / 15,
    position:'absolute'
    });

  positionaboutusPopup = () ->
    if (!$("#aboutus_form").is(':visible'))
      return;
    $("#aboutus_form").css({
    left: 30,
    top: ($(window).width() - $('#aboutus_form').width()) / 15,
    position:'absolute'
    });
