<div class="banner-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 p-0">
                <div id="banner" class="article-banner">
                    <div>
                        <img src="{{ asset('theme/'.env('FRONTEND_TEMPLATE').'/images/news/news1.jpg') }}" />
                        <div class="sub-banner-caption">
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h2>
                                            {{ $page->name }}
                                        </h2>
                                        @if(isset($breadcrumb))
                                            <ul class="crumbs">
                                                @foreach($breadcrumb as $link => $url)
                                                    <li class="breadcrumb-item @if($loop->last) active @endif" aria-current="page">
                                                        @if($loop->last)
                                                            {{ $link }}
                                                        @else
                                                            <a href="{{$url}}">{{$link}}</a>
                                                        @endif
                                                    </li>
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
