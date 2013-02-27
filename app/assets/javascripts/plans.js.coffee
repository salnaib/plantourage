$ ->

  $(".addpointto").click ->
    if (parseInt($("#totalpoints").text()) > 0)
      suggestionid = ($(this).attr('id'));
      $.ajax
        url: "/point/addpoint"
        type: "GET"
        async: false
        remote: true
        data: { suggestion_id: suggestionid }
      $("#sugg" + suggestionid + "pointcount").text(" " + (parseInt($("#sugg" + suggestionid + "pointcount").text()) + 1) + " ");
      $("#sugg" + suggestionid + "totpointcount").text(" " + (parseInt($("#sugg" + suggestionid + "totpointcount").text()) + 1) + " ");
      if (parseInt($("#totalpoints").text()) - 1 == 1)
        $("#totalpoints").text(" " + (parseInt($("#totalpoints").text()) - 1) + " Point");
        $("#totalpoints2").text(" " + (parseInt($("#totalpoints2").text()) - 1) + " Point");
      else
        $("#totalpoints").text(" " + (parseInt($("#totalpoints").text()) - 1) + " Points");
        $("#totalpoints2").text(" " + (parseInt($("#totalpoints2").text()) - 1) + " Points");

  $(".removepointfrom").click ->
    suggestionid = ($(this).attr('id'));
    if (parseInt($("#sugg" + suggestionid + "pointcount").text()) > 0)
      $.ajax
        url: "/point/removepoint"
        type: "GET"
        async: false
        remote: true
        data: { suggestion_id: suggestionid }
      $("#sugg" + suggestionid + "pointcount").text(" " + (parseInt($("#sugg" + suggestionid + "pointcount").text()) - 1) + " ");
      $("#sugg" + suggestionid + "totpointcount").text(" " + (parseInt($("#sugg" + suggestionid + "totpointcount").text()) - 1) + " ");
      if (parseInt($("#totalpoints").text()) + 1 == 1)
        $("#totalpoints").text(" " + (parseInt($("#totalpoints").text()) + 1) + " Point");
        $("#totalpoints2").text(" " + (parseInt($("#totalpoints2").text()) + 1) + " Point");
      else
        $("#totalpoints").text(" " + (parseInt($("#totalpoints").text()) + 1) + " Points");
        $("#totalpoints2").text(" " + (parseInt($("#totalpoints2").text()) + 1) + " Points");

  $("#updateplan").click ->
    planid = $("#planid").attr('value');
    plandate = $("#plan_date").attr('value');
    planname = $("#plan_name").attr('value');
    $.ajax
      url: "/plans/change"
      type: "GET"
      async: false
      remote: true
      data: { id: planid, plan_name: planname, plan_date: plandate }
    (window).location = (window).location;

  $("#addvenue").click ->
    $("#addvenue_form").fadeIn(1000);
    positionVenuePopup();

  $("#showcomments").click ->
    $("#show_comments_form").fadeIn(1000);
    positionCommentsPopup();

  $("#closevenue").click ->
    $("#addvenue_form").fadeOut(500);

  $("#closecomments").click ->
    $("#show_comments_form").fadeOut(500);

  $("#submitvenue").click ->
    planid = $("#planid").attr('value');
    for element in $(".venue_check")
      if ($(element).attr('checked') == "checked")
        venueid = ($(element).attr('id'));
        $.ajax
          url: "/suggestions"
          type: "POST"
          async: false
          remote: true
          data: { venue_id: venueid, plan_id: planid }
    $("#addvenue_form").fadeOut(500);
    (window).location = (window).location;

  $("#invited_user_id").click ->
    planid = $("#planid").attr('value');
    userfbid = $(this).attr('value');
    username = $("#invited_user_name").attr('value');
    $.ajax
      url: "/invites"
      type: "POST"
      async: false
      remote: true
      data: { uid: userfbid, plan_id: planid, name: username }

  $("#add_comment").click ->
    planid = $("#planid").attr('value');
    content = $("#new_comment").attr('value');
    inviteid = $("#invite_id").attr('value');
    $.ajax
      url: "/micropost/addcomment"
      type: "GET"
      async: false
      remote: true
      data: { plan_id: planid, content: content, invite_id: inviteid }
    (window).location = (window).location;

  $("#delete_comment").click ->
    commentid = $(this).attr('alt');
    $.ajax
      url: "/micropost/deletecomment"
      type: "GET"
      async: false
      remote: true
      data: { comment_id: commentid }
    (window).location = (window).location;

  positionVenuePopup = () ->
    if (!$("#addvenue_form").is(':visible'))
      return;
    $("#addvenue_form").css({
      left: ($(window).width() - $('#addvenue_form').width()) / 2,
      top: ($(window).width() - $('#addvenue_form').width()) / 7,
      position:'absolute'
    });

  positionCommentsPopup = () ->
    if (!$("#show_comments_form").is(':visible'))
      return;
    $("#show_comments_form").css({
    left: ($(window).width() - $('#show_comments_form').width()) / 2,
    top: ($(window).width() - $('#show_comments_form').width()) / 7,
    position:'absolute'
    });
