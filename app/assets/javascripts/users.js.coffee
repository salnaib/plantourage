$ ->

  currentScroll=0;

  $("#newplan").click ->
    popupFunction("#newplan_form");
    $("#plan_name").focus();

  $("#closenewplan").click ->
    popupCloseFunction("#newplan_form");

  $("#submitnewplan").click ->
    planname = $("#plan_name").attr('value')
    plandate = $("#plan_date").attr('value')
    userid = $("#userid").attr('value');
    $.ajax
      url: "/plans"
      type: "POST"
      async: false
      remote: true
      data: { name: planname, plandate: plandate, userid: userid }
    $("#newplan_form").fadeOut(500);
    (window).location.reload(true);

  $("#plan_date").change ->
    today = new Date();
    newdate = new Date($("#plan_date").attr('value').split("-")[0], $("#plan_date").attr('value').split("-")[1] - 1, $("#plan_date").attr('value').split("-")[2]);
    if (newdate < today)
      errorPopup($(this).offset(), 'Date cannot be earlier than today.');
      $("#plan_date").val("");

  popupFunction = (form) ->
    $(".shell").css({
      opacity: 0.5,
    });
    $(form).fadeIn(1000);
    currentScroll=$(window).scrollTop();
    $(window).bind('scroll',lockscroll);

  lockscroll = () ->
    $(window).scrollTop(currentScroll);

  popupCloseFunction = (form) ->
    $(form).fadeOut(500);
    $(".shell").css({
      opacity: 1,
    });
    $(window).unbind();

  errorPopup = (offset, errorText) ->
    #$("#errPopup_form").fadeIn(1000);
    #$("#errPopup_form").css({
    #left: offset.left,
    #top: offset.top - 225,
    #position:'absolute'
    #});
    #$("#error_text").text(errorText);
