{{--<div class="video-banner">--}}
{{--    @foreach ($page->album->banners as $banner)--}}
{{--        <video autoplay muted loop id="myVideo">--}}
{{--            <source src="{{ $banner->image_path }}" type="video/mp4">--}}
{{--        </video>--}}
{{--        <div class="container">--}}
{{--            <div class="video-caption">--}}
{{--                <h2>{{ $banner->title }}</h2>--}}
{{--                <p>{{ $banner->description }}</p>--}}
{{--                @if($banner->url && $banner->button_text)--}}
{{--                    <a href="{{ $banner->url }}" class="link-primary hvr-shrink">{{ $banner->button_text }}</a>--}}
{{--                @endif--}}
{{--            </div>--}}
{{--        </div>--}}
{{--        @break--}}
{{--    @endforeach--}}
{{--</div>--}}
<section class="main-slider">
    <div class="item youtube">
        @foreach ($page->album->banners as $banner)
            <video autoplay muted loop id="myVideo">
                <source src="{{ $banner->image_path }}" type="video/mp4">
            </video>
            <div class="caption d-flex align-items-center">
                <div class="banner-text p-5">
                    <div class="jumbotron banner-welcome p-0 pl-lg-5 bg-transparent">
                        <h2 class="slide-content-title h1">{{ $banner->title }}</h2>
                        <p class="lead slide-content-info">{!! $banner->description !!}</p>
                        @if($banner->url && $banner->button_text)
                            <div class="slide-content-btn">
                                <a class="btn btn-primary btn-lg btn-main" href="{{ $banner->url }}" role="button">{{ $banner->button_text }}</a>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
            @break
        @endforeach
    </div>
</section>
