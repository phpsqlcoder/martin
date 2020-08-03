<div class="banner-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12" style="padding:0;">
                <div id="banner" class="carousel-banner owl-carousel owl-theme banner-content">
                    @foreach ($page->album->banners as $banner)
                        <div>
                            <img src="{{ $banner->image_path }}">
                            <div class="banner-caption">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-sm-10 col-lg-8">
                                            <h2>{{ $banner->title }}</h2>
                                            <p>
                                                {{ $banner->description }}
                                            </p>
                                            @if (!empty($banner->url) && !empty($banner->button_text))
                                                <a class="primary-btn" href="{{ $banner->url }}">{{ $banner->button_text }}</a>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</div>
