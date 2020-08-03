<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    @if ($page->name == 'Home')
        <title>{{ Setting::info()->company_name }}</title>
    @else
        <title>{{ (empty($page->meta_title) ? $page->name:$page->meta_title) }} | {{ Setting::info()->company_name }}</title>
    @endif
    <link rel="shortcut icon" href="{{ Setting::get_company_favicon_storage_path() }}" type="image/x-icon" />
    <meta name="description" content="{{ $page->meta_description }}">
    <meta name="keywords" content="{{ $page->meta_keyword }}">

    {{-- Custom CSS Scripts--}}
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/font-awesome/css/font-awesome.min.css') }}"/>
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/owl.carousel/assets/owl.carousel.css') }}" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/owl.carousel/assets/owl.theme.default.min.css') }}"  />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/bootstrap/css/bootstrap.min.css') }}" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/aos/dist/aos.css') }}" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/css/animate.css') }}" media="screen" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/navik/navik.menu.css') }}" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/linearicon/linearicon.css') }}" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/jssocials/jssocials.css') }}" />
    <link rel="stylesheet" href="{{ asset('theme/cerebro/plugins/jssocials/jssocials-theme-plain.css') }}" />
    {{-- End Custom CSS Scripts--}}

    @yield('pagecss')

    {!! \Setting::info()->google_analytics !!}
</head>
<body>
    <div id="top">
        <img src="{{ asset('theme/cerebro/images/misc/top.png') }}" />
    </div>

    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.header')

    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.banner')

    @yield('content')

    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.footer')

    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.privacy-policy')

    @if(!empty($page->album) && $page->album->id != 0)
        <script type="text/javascript">
            let bannerFxIn = "{{ $page->album->animationIn->value }}";
            let bannerFxOut = "{{ $page->album->animationOut->value }}";
            let bannerCaptionFxIn = "fadeInUp";
            let autoPlayTimeout = "{{ $page->album->transition }}000";
            let bannerID = "banner";
        </script>
    @endif

    {{-- Custom JS Scripts--}}
    <script src="{{ asset('lib/jquery/jquery2-2-4.min.js') }}"></script>
    <script src="{{ asset('lib/jquery/jquery-cookies.min.js') }}"></script>
    <script src="{{ asset('theme/cerebro/plugins/navik/navik.menu.js') }}"></script>
    <script src="{{ asset('theme/cerebro/js/jquery.nicescroll.js') }}"></script>
    <script type="text/javascript" src="{{ asset('theme/cerebro/plugins/owl.carousel/owl.carousel.js') }}"></script>
    <script type="text/javascript" src="{{ asset('theme/cerebro/plugins/owl.carousel/owl.carousel.extension.js') }}"></script>
{{--    <script src="{{ asset('theme/cerebro/js/wow.min.js') }}"></script>--}}
    {{-- End Customer JS Scripts--}}

    <script src="{{ asset('js/jquery.cookie.js') }}"></script>
    <script src="{{ asset('js/privacy_policy.js') }}"></script>
    @yield('customjs')

    @yield('pagejs')
</body>
</html>
