$(document).ready(function(){
  // Popover Init
  $('[data-toggle="popover"]').popover(); 
  // Sliders
  $('#promo-carousel, #parts-carousel').slick({
    dots: false,
    infinite: true,
    speed: 1000,
    respondTo: 'slider',
    autoplay: false,
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

  $('.quote-selector > ul > li > a').click(function(event) {
    $('.quote-selector > ul > li').removeClass('active');
    $(this).parent('li').addClass('active');
    var toppadding = $(this).height();
    $('.quote-selector > ul').css({'margin-top':toppadding});
  });
  $('#quote-modal').on('shown.bs.modal', function () {
    var toppadding = $('.quote-selector > ul > li.active > a').height();
    $('.quote-selector > ul').css({'margin-top':toppadding});
  });
});
$( window ).resize(function() {
  var toppadding = $('.quote-selector > ul > li.active > a').height();
  $('.quote-selector > ul').css({'margin-top':toppadding});
});