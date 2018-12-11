import "bootstrap";
import "../components/quiz";
$(document).ready(function(){
  $(".category-choice_1").click(function(){
    $(".category-choice_1").siblings().removeClass('active');
    $(this).toggleClass("active");
  });
});

$(document).ready(function(){
  $(".category-choice_2").click(function(){
    $(".category-choice_2").siblings().removeClass('active');
    $(this).toggleClass("active");
  });
});

$(document).ready(function(){
  $(".category-choice_3").click(function(){
    $(".category-choice_3").siblings().removeClass('active');
    $(this).toggleClass("active");
  });
});

$(document).ready(function(){
  $(".card-race-results-1").click(function(){
    $(".race-selector-1").addClass("hidden");
  });
});

$(document).ready(function(){
  $(".card-race-results-2").click(function(){
    $(".race-selector-2").addClass("hidden");
  });
});

$(document).ready(function(){
  $(".card-race-results-3").click(function(){
    $(".race-selector-3").addClass("hidden");
    $(".race-selector-4").toggleClass("hidden");
  });
});


