{{--@php dd(isset($page) && !empty($page->image_url)); @endphp--}}
@if(isset($page) && $page->album && count($page->album->banners) > 0 && $page->album->is_main_banner() && $page->album->banner_type == 'video')
    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.home-video')
@elseif(isset($page) && $page->album && count($page->album->banners) > 0 && $page->album->is_main_banner())
    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.home-slider')
@elseif(isset($page) && $page->album && count($page->album->banners) > 1 && !$page->album->is_main_banner())
    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.page-slider')
@elseif(isset($page) && !empty($page->image_url))
    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.page-banner')
@else
    @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.no-banner')
@endif
