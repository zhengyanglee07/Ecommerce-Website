var slideNum = 1;
showSlides(slideNum);

function plusSlides(n){
    showSlides(slideNum += n);
}

function currentSlide(n) {
    showSlides(slideNum = n);
}

function showSlides(n) {
    var i; 
    var slide = document.getElementsByClassName("mySlide");
    var dot = document.getElementsByClassName("dot");
    if (n > slide.length) { slideNum = 1 }
    if (n < 1) { slideNum = slide.length }
    for (i = 0; i < slide.length; i++) {
        slide[i].style.display = "none";
    }
    for (i = 0; i < dot.length; i++) {
        dot[i].className = dot[i].className.replace(" active", "");
    }
    slide[slideNum - 1].style.display = "block";
    dot[slideNum - 1].className += " active";
}