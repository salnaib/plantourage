$ ->

  currentScroll=0;

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
    else
      errorPopup($(this).offset(), 'You have no more points to vote with. Remove points from another venue to be able to add to this venue');

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
    else
      errorPopup($(this).offset(), 'You have no points to remove from this venue.');

  $("#changeplan").click ->
    popupFunction("#updateplan_form");
    $("#plan_name").focus();

  $("#closeupdateplan").click ->
    popupCloseFunction("#updateplan_form");

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

  $("#createfbevent").click ->
    planid = $("#planid").attr('value');
    $.ajax
      url: "/plans/createfbevent"
      type: "GET"
      async: false
      remote: true
      data: { id: planid }
    (window).location = (window).location;

  $("#plan_date").change ->
    today = new Date();
    newdate = new Date($("#plan_date").attr('value').split("-")[0], $("#plan_date").attr('value').split("-")[1] - 1, $("#plan_date").attr('value').split("-")[2]);
    if (newdate < today)
      errorPopup($(this).offset(), 'Date cannot be earlier than today.');
      $("#plan_date").val("");

  $("#addvenue").click ->
    popupFunction("#mapCanvas_form");

  $("#closemapcanvas").click ->
    popupCloseFunction("#mapCanvas_form");

  $("#closevenue").click ->
    popupCloseFunction("#addvenue_form");

  $("#closeError").click ->
    popupCloseFunction("#errPopup_form");

  $("#showcomments").click ->
    popupFunction("#show_comments_form");

  $("#closecomments").click ->
    popupCloseFunction("#show_comments_form");

  $("#selectvenue").live( "click", ->
    planid = $("#planid").attr('value');
    venuegoogleid = $("#venuegoogleid").attr('value');
    venuename = $("#venuename").attr('value');
    venueaddress = $("#venueaddress").attr('value');
    venuecity = $("#venuecity").attr('value');
    venuestate = $("#venuestate").attr('value');
    venuecountry = $("#venuecountry").attr('value');
    venuepostal = $("#venuepostal").attr('value');
    venuephone = $("#venuephone").attr('value');
    venuegoogleurl = $("#venuegoogleurl").attr('value');
    venuewebsite = $("#venuewebsite").attr('value');
    venuegeolocation = $("#venuegeolocation").attr('value');
    venuetypes = $("#venuetypes").attr('value');
    $.ajax
      url: "/suggestions"
      type: "POST"
      async: false
      remote: true
      data: { plan_id: planid, venuegoogleid: venuegoogleid, venuename: venuename, venueaddress: venueaddress, venuecity: venuecity, venuestate: venuestate, venuecountry: venuecountry, venuepostal: venuepostal, venuephone: venuephone, venuegoogleurl: venuegoogleurl, venuewebsite: venuewebsite, venuegeolocation: venuegeolocation, venuetypes: venuetypes }
    (window).location = (window).location;
    )

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

  popupFunction = (form) ->
    $(form).fadeIn(1000);
    $(".shell").css({
    opacity: 0.5,
    });
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
