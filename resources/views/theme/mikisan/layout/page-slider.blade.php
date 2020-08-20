<div class="banner-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12" style="padding:0;">
                <div id="banner" class="carousel-banner owl-carousel owl-theme banner-content">
                    @foreach ($page->album->banners as $banner)
                        <div>
                            <img src="{{ $banner->image_path }}" />
                            <div class="sub-banner-caption">
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</div>
