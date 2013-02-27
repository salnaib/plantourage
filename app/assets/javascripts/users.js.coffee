$ ->

  $("#newplan").click ->
    $("#newplan_form").fadeIn(1000);
    positionNewPlanPopup();

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
      alert("Date cannot be earlier than today");
      $("#plan_date").val("");

  positionNewPlanPopup = () ->
    if (!$("#newplan_form").is(':visible'))
      return;
    $("#newplan_form").css({
    left: ($(window).width() - $('#newplan_form').width()) / 2,
    top: ($(window).width() - $('#newplan_form').width()) / 7,
    position:'absolute'
    });
