<div class="main-banner">
    <div class="slick-slider" id="banner">
        @foreach ($page->album->banners as $banner)
          <div class="banner-wrapper">
            <div class="banner-image"><img src={{ $banner->image_path }} />
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
          </div>
        @endforeach
    </div>
</div>