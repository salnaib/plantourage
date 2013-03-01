$ ->

  $("#newplan").click ->
    $("#newplan_form").fadeIn(1000);
    positionNewPlanPopup($(this).offset());

  $("#closenewplan").click ->
    $("#newplan_form").fadeOut(500);

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
    (window).location = (window).location;

  $("#plan_date").change ->
    today = new Date();
    newdate = new Date($("#plan_date").attr('value').split("-")[0], $("#plan_date").attr('value').split("-")[1] - 1, $("#plan_date").attr('value').split("-")[2]);
    if (newdate < today)
      errorPopup($(this).offset(), 'Date cannot be earlier than today.');
      $("#plan_date").val("");

  positionNewPlanPopup = (offset) ->
    if (!$("#newplan_form").is(':visible'))
      return;
    $("#newplan_form").css({
    left: offset.left,
    top: offset.top - 225,
    position:'absolute'
    });

  errorPopup = (offset, errorText) ->
    $("#errPopup_form").fadeIn(1000);
    $("#errPopup_form").css({
    left: offset.left,
    top: offset.top - 225,
    position:'absolute'
    });
    $("#error_text").text(errorText);
