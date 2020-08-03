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
    <link rel="shortcut icon" href="{{ asset('theme/mikisan/images/favicon.ico') }}" type="image/x-icon">
	<link rel="icon" href="{{ asset('theme/mikisan/images/favicon.ico') }}" type="image/x-icon">
	<link href="{{ asset('theme/mikisan/plugins/font-awesome/css/fontawesome-all.min.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/plugins/bootstrap/css/bootstrap.min.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/plugins/slick/slick.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/plugins/slick/slick-theme.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/plugins/navik/navik.menu.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/plugins/cookie-alert/cookiealert.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/css/animate.min.css') }}" type="text/css" rel="stylesheet" />
	<link href="{{ asset('theme/mikisan/css/style.css') }}" type="text/css" rel="stylesheet" />
    {{-- End Custom CSS Scripts--}}

    @yield('pagecss')

    {!! \Setting::info()->google_analytics !!}
</head>
<body>
    

    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.header')

    @yield('content')




    

    {{-- @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.footer')

    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.privacy-policy') --}}

    @if(!empty($page->album) && $page->album->id != 0)
        <script type="text/javascript">
            let bannerFxIn = "{{ $page->album->animationIn->value }}";
            let bannerFxOut = "{{ $page->album->animationOut->value }}";
            let bannerCaptionFxIn = "fadeInUp";
            let autoPlayTimeout = "{{ $page->album->transition }}000";
            let bannerID = "banner";
        </script>
    @endif

    <script type="text/javascript">
        var bannerFxIn = "bounceInDown";
        var bannerFxOut = "zoomOutDown";
        var bannerCaptionFxIn = "fadeInUp";
        var autoPlayTimeout = "4000";
        var bannerID = "banner";
    </script>
	{{-- Custom JS Scripts--}}
	<script src="{{ asset('theme/mikisan/js/jquery-2.2.0.min.js') }}" type="text/javascript"></script>
	<script src="{{ asset('theme/mikisan/js/script.js') }}" type="text/javascript"></script>
	<script src="{{ asset('theme/mikisan/js/popper.min.js') }}" type="text/javascript"></script>
	<script src="{{ asset('theme/mikisan/plugins/bootstrap/js/bootstrap.js') }}" type="text/javascript"></script>
	<script src="{{ asset('theme/mikisan/plugins/cookie-alert/cookiealert.js') }}" type="text/javascript"></script>
	<script src="{{ asset('theme/mikisan/plugins/slick/slick.js') }}" type="text/javascript"></script>
	<script src="{{ asset('theme/mikisan/plugins/slick/slick.extension.js') }}" type="text/javascript"></script>
    <script src="{{ asset('theme/mikisan/plugins/navik/navik.menu.js') }}" type="text/javascript"></script>
    {{-- End Customer JS Scripts--}}


    <script src="{{ asset('js/jquery.cookie.js') }}"></script>
    <script src="{{ asset('js/privacy_policy.js') }}"></script>
    @yield('customjs')

    @yield('pagejs')
</body>
</html>
