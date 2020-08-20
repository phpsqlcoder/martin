{{--@php dd(isset($page) && !empty($page->image_url)); @endphp--}}
@if(isset($page) && $page->album && count($page->album->banners) > 0 && $page->album->is_main_banner() && $page->album->banner_type == 'video')
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.home-video')
@elseif(isset($page) && $page->album && count($page->album->banners) > 0 && $page->album->is_main_banner())
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.home-slider')
@elseif(isset($page) && $page->album && count($page->album->banners) > 0 && !$page->album->is_main_banner())
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.page-slider')
@elseif(isset($page) && !empty($page->image_url))
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.page-banner')
@else
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.no-banner')
@endif
