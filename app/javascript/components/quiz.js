

// const qOne = document.getElementById('question-one');
// const qTwo = document.getElementById('question-two');
// const qThree = document.getElementById('question-three');

// cont
// button.addEventListener('click', (event) => {
//   // do something on click of an element
//   qOne.style.display = "none";
//   qTwo.style.display = "content";
// });


$(document).ready(function(){
  $("#suivant-one").click(function(){
    $(".question_quiz").addClass("hidden");
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
