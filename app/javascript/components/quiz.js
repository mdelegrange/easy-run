

// const qOne = document.getElementById('question-one');
// const qTwo = document.getElementById('question-two');
// const qThree = document.getElementById('question-three');

// cont
// button.addEventListener('click', (event) => {
//   // do something on click of an element
//   qOne.style.display = "none";
//   qTwo.style.display = "content";
// });


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
