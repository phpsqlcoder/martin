$(document).ready(function() {
  var bannerSlick = "#" + bannerID;
  $(bannerSlick)
    .parent("div")
    .prepend('<div id="preloader"><div id="status">&nbsp;</div></div>');

  setInterval(function() {
    $(bannerSlick + " div.banner-wrapper").attr("data-animation-in", bannerFxIn);
    $(bannerSlick + " div.banner-wrapper").attr("data-animation-out", bannerFxOut);
    $(bannerSlick + " div.banner-wrapper").attr("data-delay", "0s");
  }, 3000);

  $(bannerSlick).on("beforeChange", function(
    e,
    slick,
    currentSlide,
    nextSlide
  ) {
    var $animatingElements = $(
      'div.slick-slide[data-slick-index="' + currentSlide + '"]'
    ).find("[data-animation-out]");
    doAnimationOut($animatingElements);
    var $animatingElements = $(
      'div.slick-slide[data-slick-index="' + nextSlide + '"]'
    ).find("[data-animation-in]");
    doAnimationIn($animatingElements);
  });

  $(bannerSlick).slick({
    autoplay: true,
    autoplaySpeed: autoPlayTimeout,
    dots: false,
    fade: true,
    arrows: true,
	prevArrow: '<i class="fa fa-chevron-right" style="position:absolute;z-index:9;right:.5em;"></i>',
    nextArrow: '<i class="fa fa-chevron-left" style="position:absolute;z-index:8;left:.5em;"></i>',
	  responsive: [
		{
		  breakpoint: 480,
		  settings: {
			arrows: false
		  }
		}
	  ]
  });

  function doAnimationIn(elements) {
    var animationEndEvents =
      "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend";
    elements.each(function() {
      var $this = $(this);
      var $animationDelay = $this.data("delay");
      var $animationType = "animated " + $this.data("animation-in");
      $this.addClass(bannerFxIn);
      $this.css({
        "animation-delay": $animationDelay,
        "-webkit-animation-delay": $animationDelay
      });
      $this.addClass($animationType).one(animationEndEvents, function() {
        $this.removeClass($animationType);
      });
    });
  }
  function doAnimationOut(elements) {
    var animationEndEvents =
      "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend";
    elements.each(function() {
      var $this = $(this);
      var $animationDelay = $this.data("delay");
      var $animationType = "animated " + $this.data("animation-out");
      $this.css({
        "animation-delay": $animationDelay,
        "-webkit-animation-delay": $animationDelay
      });
      $this.addClass($animationType).one(animationEndEvents, function() {
        $this.removeClass($animationType);
      });
    });
  }
});
