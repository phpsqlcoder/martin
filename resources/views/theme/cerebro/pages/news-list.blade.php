@extends('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.main')
@section('pagecss')

@endsection
@section('content')
    <main>
        <section>
            <div class="main-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <h3>News</h3>
                            <div class="side-menu">
                                <ul>
                                    @foreach ($articleYears as $year)
                                        <li @if ($search == $year->year) class="active" @endif>
                                            <a href="{{ route('news.front.index') }}?type=year&criteria={{ $year->year }}">{{ $year->year }}</a>
                                            @if (isset($articleMonthsByYear[$year->year]))
                                                <ul>
                                                    @foreach ($articleMonthsByYear[$year->year] as $month)
                                                        <li @if ($search == $month->year.'-'.$month->month) class="active" @endif>
                                                            <a href="{{ route('news.front.index') }}?type=month&criteria={{ $month->year.'-'.$month->month }}">{{ $month->month_name }}</a>
                                                        </li>
                                                    @endforeach
                                                </ul>
                                            @endif
                                        </li>
                                    @endforeach
                                </ul>
                            </div>

                            <h3>Categories</h3>
                            <div class="side-menu">
                                <ul>
                                    @foreach ($articleCategories as $category)
                                        <li @if ($type == "category" && $search == $category->id) class="active" @endif>
                                            <a href="{{route('news.front.index')}}?type=category&criteria={{ $category->id }}">{{ $category->name }}</a>
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <form id="frm_search" class="search">
                                <div class="input-group">
                                    <input type="text" name="searchtxt" id="searchtxt" class="form-control" value="{{ $search }}" placeholder="Search news" aria-label="Search news" aria-describedby="button-addon2"/>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" id="button-addon2">
                                            <span class="lnr lnr-magnifier"></span>
                                        </button>
                                    </div>
                                </div>
                            </form>

                            @foreach($articles as $article)
                                <div class="news-post">
                                    @if (empty($article->thumbnail_url))
                                        <div class="news-post-img" style="background-image:url({{ asset('theme/'.env('FRONTEND_TEMPLATE', 'cerebro').'/images/news/news2.jpg') }})">
                                            <img src="" />
                                        </div>
                                    @else
                                        <div class="news-post-img" style="background-image:url({{ $article->thumbnail_url }})">
                                            <img src="{{ $article->thumbnail_url }}" />
                                        </div>
                                    @endif

                                    <div class="news-post-info">
                                        <h4>
                                            {{ $article->name }}
                                        </h4>
                                        <p class="news-post-info-excerpt">
                                            {{ $article->teaser }}
                                        </p>
                                        <p class="news-post-info-meta">
                                            Posted on {{ $article->date_posted() }} • <a href="{{ $article->get_url() }}">Read more</a>
                                        </p>
                                    </div>
                                </div>
                            @endforeach

                            {{ $articles->links('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.pagination') }}
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
@endsection

@section('pagejs')

@endsection

@section('customjs')
    <script>
        var navikMenuListDropdown = $(".side-menu ul li:has(ul)");

        navikMenuListDropdown.each(function() {
            $(this).append('<span class="dropdown-append"></span>');
        });

        $(".side-menu .active").each(function() {
            $(this)
                .parents("ul")
                .css("display", "block");
            $(this)
                .parents("ul")
                .prev("a")
                .css("color", "#00bfca");
            $(this)
                .parents("ul")
                .next(".dropdown-append")
                .addClass("dropdown-open");
        });

        $(".dropdown-append").on("click", function() {
            $(this)
                .prev("ul")
                .slideToggle(300);
            $(this).toggleClass("dropdown-open");
        });

        $(function() {
            $('#frm_search').on('submit', function(e) {
                e.preventDefault();
                window.location.href = "/news?type=searchbox&criteria="+$('#searchtxt').val();
            });
        });
    </script>
@endsection
