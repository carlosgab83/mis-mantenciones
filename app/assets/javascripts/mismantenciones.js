$(document).ready(function(){
  // Popover Init
  $('[data-toggle="popover"]').popover();
  // Boostrap Select Init
  $('.selectpicker').selectpicker({
    size: 6
  });

  // Sliders
  $('#promo-carousel, #parts-carousel').slick({
    dots: false,
    infinite: true,
    speed: 1000,
    respondTo: 'slider',
    autoplay: true,
    autoplaySpeed: 7000,
    slidesToShow: 3,
    slidesToScroll: 3,
    prevArrow: '<button class="left" type="button" role="button" aria-label="Previous"><span class="fa fa-angle-left"></span></button>',
    nextArrow: '<button class="right" type="button" role="button" aria-label="Next"><span class="fa fa-angle-right"></span></button>',
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

  $('#quote-modal').on('shown.bs.modal', function () {
    var toppadding = $('.quote-selector > ul > li.active > a').height();
    $('.quote-selector > ul').css({'margin-top':toppadding});
  });

  $('.input-capital').on('input', function(evt) {
    $(this).val(function (_, val) {
      return val.toUpperCase();
    });
  });

  confirmBackspaceNavigations();

});

function confirmBackspaceNavigations () {
  // http://stackoverflow.com/a/22949859/2407309
  var backspaceIsPressed = false
  $(document).keydown(function(event){
    if (event.which == 8) {
      backspaceIsPressed = true
    }
  })
  $(document).keyup(function(event){
    if (event.which == 8) {
      backspaceIsPressed = false
    }
  })
  $(window).on('beforeunload', function(){
    if (backspaceIsPressed) {
      backspaceIsPressed = false
      return "Are you sure you want to leave this page?"
    }
  })
}

$( document ).on('turbolinks:load', function() {

})