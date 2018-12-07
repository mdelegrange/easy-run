import "bootstrap";
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

