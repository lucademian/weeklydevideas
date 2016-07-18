var userId = localStorage.getItem("userId");
var passKey = localStorage.getItem("passKey");

var items = [];

if(userId == null || passKey == null)
{
  $.ajax({
    type: "POST",
    url: "/api/user/",
    data: {},
    success: function(response){
      if(response.success)
      {
        userId = response.payload.userId;
        passKey = response.payload.passKey;
        localStorage.setItem("userId", userId);
        localStorage.setItem("passKey", passKey);
      }
      else {
        $("body").html("Unable to connect to server. Reloading...");
        setTimeout(function(){
          window.location.reload();
        },2000);
      }
    }
  });
}

function listItems(items){
  $("#list ul").empty();
  $.each(items, function(key, value){
    $("#list ul").append('<li class="vote-item '+value.vote+'" data-id="'+value.id+'">\
      <div class="vote-title">'+value.title+'</div>\
      <div class="vote-text">'+value.text+'</div>\
      <div class="vote-actions">\
        <div class="vote-action upvote"></div>\
        <div class="vote-count">'+value.karma+'</div>\
        <div class="vote-action downvote"></div>\
      </div>\
    </li>');
  });
}

$.ajax({
  type: "GET",
  url: "/api/ideas/week/"+weekNum,
  data: {
    userId:userId,
    passKey:passKey
  },
  success: function(response){
    console.log(response);
    if(response.success)
    {
      items = response.payload.items;

      listItems(items);
    }
  }
});




$("body").on("click", ".upvote", function(){
  element = $(this).parents(".vote-item");
  voteCount = parseInt(element.find(".vote-count").text());

  if(element.hasClass("upvoted"))
  {
    element.find(".vote-count").text(voteCount - 1);
    element.addClass("neutral").removeClass("upvoted").removeClass("downvoted");

    $.ajax({
      type: "POST",
      url: "/api/"+element.data("id")+"/unvote/",
      data: {
        userId:userId,
        passKey:passKey
      },
      success: function(response){
        console.log(response);
      }
    });
  }
  else if(element.hasClass("downvoted"))
  {
    $.ajax({
      type: "POST",
      url: "/api/"+element.data("id")+"/upvote/",
      data: {
        userId:userId,
        passKey:passKey
      },
      success: function(response){
        console.log(response);
      }
    });
    element.find(".vote-count").text(voteCount + 2);
    element.addClass("upvoted").removeClass("downvoted").removeClass("neutral");
  }
  else
  {
    $.ajax({
      type: "POST",
      url: "/api/"+element.data("id")+"/upvote/",
      data: {
        userId:userId,
        passKey:passKey
      },
      success: function(response){
        console.log(response);
      }
    });
    element.find(".vote-count").text(voteCount + 1);
    element.addClass("upvoted").removeClass("downvoted").removeClass("neutral");
  }

});

$("body").on("click", ".downvote", function(){
  element = $(this).parents(".vote-item");
  voteCount = parseInt(element.find(".vote-count").text());

  if(element.hasClass("downvoted"))
  {
    element.find(".vote-count").text(voteCount + 1);
    element.addClass("neutral").removeClass("upvoted").removeClass("downvoted");

    $.ajax({
      type: "POST",
      url: "/api/"+element.data("id")+"/unvote/",
      data: {
        userId:userId,
        passKey:passKey
      },
      success: function(response){
        console.log(response);
      }
    });
  }
  else if(element.hasClass("upvoted"))
  {
    $.ajax({
      type: "POST",
      url: "/api/"+element.data("id")+"/downvote/",
      data: {
        userId:userId,
        passKey:passKey
      },
      success: function(response){
        console.log(response);
      }
    });
    element.find(".vote-count").text(voteCount - 2);
    element.addClass("downvoted").removeClass("upvoted").removeClass("neutral");
  }
  else
  {
    $.ajax({
      type: "POST",
      url: "/api/"+element.data("id")+"/downvote/",
      data: {
        userId:userId,
        passKey:passKey
      },
      success: function(response){
        console.log(response);
      }
    });
    element.find(".vote-count").text(voteCount - 1);
    element.addClass("downvoted").removeClass("upvoted").removeClass("neutral");
  }

	$(this).toggleClass("active");
	$(".upvote").removeClass("active");
});



$("#sortby").change(function(){
  if($(this).val() == "newest")
  {
    items.sort(function(a, b){
      return b.date - a.date;
    });
    listItems(items);
  }
  else if($(this).val() == "oldest")
  {
    items.sort(function(a, b){
      return a.date - b.date;
    });
    listItems(items);
  }
  else if($(this).val() == "top")
  {
    items.sort(function(a, b){
      return b.karma - a.karma;
    });
    listItems(items);
  }
});


$("#newidea").submit(function(e){
  e.preventDefault();

  element = $(this);
  $.ajax({
    type: "POST",
    url: "/api/idea/",
    data: {
      userId:userId,
      passKey:passKey,
      title:element.find("input").val(),
      text:element.find("textarea").val()
    },
    success: function(response){
      if(response.success)
      {
        $("#newidea button").after("<div class='error'>Saved Idea</div>");
        $("#newidea .error").delay(1500).fadeOut(500, function(){
          $(this).remove();
        });

        element.find("input").val("");
        element.find("textarea").val("");
      }
      else
      {
        $("#newidea .error").remove();
        $("#newidea button").after("<div class='error'>Error Saving</div>");
        $("#newidea .error").delay(1500).fadeOut(500, function(){
          $(this).remove();
        });
      }
    }
  });
});


$(document).scroll(function(){
  if($(document).scrollTop() > 800)
    $("#scrollup").addClass("active");
  else {
    $("#scrollup").removeClass("active");
  }
});
$("#scrollup").click(function(e){
  e.preventDefault();
  $("body").animate({scrollTop:0});
});
