$ ->

  $("#newplan").click ->
    $("#newplan_form").fadeIn(1000);
    $("#plan_name").focus();
    $(".shell").css({
      opacity: 0.5,
      });

  $("#closenewplan").click ->
    $("#newplan_form").fadeOut(500);
    $(".shell").css({
    opacity: 1,
    });


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

  errorPopup = (offset, errorText) ->
    #$("#errPopup_form").fadeIn(1000);
    #$("#errPopup_form").css({
    #left: offset.left,
    #top: offset.top - 225,
    #position:'absolute'
    #});
    #$("#error_text").text(errorText);
