// @function      Include
// @description   Includes an external scripts to the page
// @param         {string} scriptUrl

function include(scriptUrl) {
  document.write('<script src="' + scriptUrl + '"><\/script>');
}

// @module RD Navbar
// @description Enables RD Navbar Plugin

(function ($) {
  var o = $('.rd-navbar');
  if (o.length > 0) {
    include('plugins/rd-navbar/dist/js/jquery.rd-navbar.min.js');

    $(document).ready(function () {
      o.RDNavbar({
        stickUpClone: false,
        stickUpOffset: 170
      });
    });
  }
})(jQuery);

// @module Slick
// @description Enables Slick Plugin

(function ($) {
  var o = $('link');
  if (o.length > 0) {
    for (let i = 0; i < o.length; i++) {
      var attr = o[i].getAttribute('href');
      var patt = /slick/i;
      var result = attr.match(patt);
      if (result) {
        include('plugins/slick/slick.js');
      }
    }
  }
})(jQuery);

// @module Bootstrap
// @description Enables Bootstrap Plugin

(function ($) {
  var o = $('link');
  if (o.length > 0) {
    for (let i = 0; i < o.length; i++) {
      var attr = o[i].getAttribute('href');
      var patt = /bootstrap/i;
      var result = attr.match(patt);
      if (result) {
        include('plugins/bootstrap/js/bootstrap.min.js');
      }
    }
  }
})(jQuery);

// @module AOS
// @description Enables AOS Plugin

(function ($) {
  var o = $('link');
  if (o.length > 0) {
    for (let i = 0; i < o.length; i++) {
      var attr = o[i].getAttribute('href');
      var patt = /aos/i;
      var result = attr.match(patt);
      if (result) {
        include('plugins/aos/dist/aos.js');

        $(document).ready(function () {
          $("script[src*='aos']").after("<script>AOS.init();</script>");
        });
      }
    }
  }
})(jQuery);

// @module WOW
// @description Enables WOW Plugin

(function ($) {
  var o = $('.wow');
  if (o.length > 0) {
    include('plugins/wow/dist/wow.min.js');

    $(document).ready(function () {
      $("script[src*='wow']").after("<script>new WOW().init();</script>");
    });
  }
})(jQuery);

// @module Preloader
// @description Set timer for preloader

var timerStart = Date.now();

$(window).on('load', function () {
  var preloader = $(".preloader");
  var timerSet = Date.now() - timerStart + 1000;

  if (preloader.length) {
    setTimeout(function () {
      preloader.addClass('loaded');
    }, timerSet);
  }
});

// @description FadeOut to Next Page

$(document).ready(function () {
  $(document).on("click", "a", function (e) {
    e.preventDefault();

    var link = $(this);
    var href = link.attr("href");
    var target = link.attr("target");
    if (target && target.indexOf("_blank") >= 0) return;
    if (href.indexOf("mailto:") == 0) return;
    if (href.indexOf("tel:") == 0) return;
    if (!href || href[0] === "#") {
      return;
    }

    setTimeout(function () {
      $("html").fadeOut(function () {
        window.location = href;
      })
    });
  });
});

// jQuery for page scrolling feature - requires jQuery Easing plugin

$(function () {
  $('.navbar-nav li a').bind('click', function (event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: $($anchor.attr('href')).offset().top
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
  });
  $('.page-scroll a').bind('click', function (event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: $($anchor.attr('href')).offset().top
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
  });
});

// Resize window for RD Navbar Top Panel

$(document).ready(function () {
  var w = window.innerWidth;

  if (w > 991) {
    $(".rd-navbar-top-panel__left").addClass("bg-secondary-1");
    $(".rd-navbar-top-panel__right").addClass("bg-secondary-1");
    $(".rd-navbar .unit__body a").addClass("alt");
  } else {
    $(".rd-navbar-top-panel__left").removeClass("bg-secondary-1");
    $(".rd-navbar-top-panel__right").removeClass("bg-secondary-1");
    $(".rd-navbar .unit__body a").removeClass("alt");
  }
});

$(window).resize(function () {
  var w = window.innerWidth;

  if (w > 991) {
    $(".rd-navbar-top-panel__left").addClass("bg-secondary-1");
    $(".rd-navbar-top-panel__right").addClass("bg-secondary-1");
    $(".rd-navbar .unit__body a").addClass("alt");
  } else {
    $(".rd-navbar-top-panel__left").removeClass("bg-secondary-1");
    $(".rd-navbar-top-panel__right").removeClass("bg-secondary-1");
    $(".rd-navbar .unit__body a").removeClass("alt");
  }
});

// Set z-index RD Navbar Dropdown

$(document).ready(function () {
  var w = window.innerWidth;
  var RDdropdown = ".rd-navbar-nav > li > .rd-navbar-dropdown";
  console.log($(RDdropdown).length);
  if ($(RDdropdown).length != 0) {
    for (let i = 0; i < $(RDdropdown).length; i++) {
      var lft = Math.round($(RDdropdown + ":eq(" + i + ")").offset().left);
      // console.log(lft);
      console.log($(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").length);

      if (lft > w * .8) {
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").removeClass("rd-navbar-open-right");
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").addClass("rd-navbar-open-left");
      } else {
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").removeClass("rd-navbar-open-left");
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").addClass("rd-navbar-open-right");
      }
    }
  }
});

$(window).resize(function () {
  var w = window.innerWidth;
  var RDdropdown = ".rd-navbar-nav > li > .rd-navbar-dropdown";
  console.log($(RDdropdown).length);
  if ($(RDdropdown).length != 0) {
    for (let i = 0; i < $(RDdropdown).length; i++) {
      var lft = Math.round($(RDdropdown + ":eq(" + i + ")").offset().left);
      console.log(lft);
      if (lft > w * .8) {
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").removeClass("rd-navbar-open-right");
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").addClass("rd-navbar-open-left");
      } else {
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").removeClass("rd-navbar-open-left");
        $(RDdropdown + ":eq(" + i + ") .rd-navbar-dropdown").addClass("rd-navbar-open-right");
      }
    }
  }
});