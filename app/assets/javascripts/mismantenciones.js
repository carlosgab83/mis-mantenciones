$(document).ready(function(){
  // World Slider
  $('#promo-carousel, #parts-carousel').slick({
    dots: false,
    infinite: true,
    speed: 600,
    respondTo: 'slider',
    autoplay: false,
    slidesToShow: 3,
    slidesToScroll: 3,
    prevArrow: '<button class="left" type="button" role="button" aria-label="Previous"><span class="pe-7s-angle-left"></span></button>',
    nextArrow: '<button class="right" type="button" role="button" aria-label="Next"><span class="pe-7s-angle-right"></span></button>',
    responsive: [
      {
        breakpoint: 780,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2,
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      }
    ]
  });
});