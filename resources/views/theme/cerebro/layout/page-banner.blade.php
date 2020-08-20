@php
    $photoUrl = (isset($page->album->banners) && count($page->album->banners) == 1) ? $page->album->banners[0]->image_path : $page->image_url;
@endphp

<div class="banner-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 p-0">
                <div id="banner">
                    <div>
                        <img src="{{ $photoUrl }}" />
                        <div class="sub-banner-caption">
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h2>{{ $page->name }}</h2>
                                        @if(isset($breadcrumb))
                                            <ul class="crumbs">
                                                @foreach($breadcrumb as $link => $url)
                                                    <li><a href="{{$url}}">{{$link}}</a></li>
                                                @endforeach
                                            </ul>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>