// const qOne = document.getElementById('question-one');
// const qTwo = document.getElementById('question-two');
// const qThree = document.getElementById('question-three');

// const
// button.addEventListener('click', (event) => {
//   // do something on click of an element
//   qOne.style.display = "none";
//   qTwo.style.display = "content";
// });

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

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();

        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

const boxChecked =
console.log(document.querySelectorAll('active').length);

document.querySelectorAll("label").forEach((label) => {
  label.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("img-circle");
  });
});
