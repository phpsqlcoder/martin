 @extends('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.main')
@section('pagecss')

@endsection
 @section('content')
{{--    <section class="bg-main wrapper">--}}
{{--        <div class="container">--}}
{{--            <div class="row">--}}
{{--                <div class="col-lg-9 col-md-8 order-md-12">--}}
{{--                    <div class="article-details">--}}
{{--                        <div class="article-details-title"><h2 class="ttle-secondary">{{ $news->name }}</h2></div>--}}
{{--                        <div class="article-details-posted">Posted on <span>{{ date('M d, Y h:i A', strtotime($news->created_at)) }}</span></div>--}}
{{--                        <div class="article-details-infos">--}}
{{--                            {!! $news->contents !!}--}}
{{--                        </div>--}}
{{--                    </div>--}}

{{--                    <h6 class="ttle-third pt-5">Share this</h6>--}}
{{--                    <ul class="share-this">--}}
{{--                        <li><a href="https://twitter.com/share?url={{ urlencode($news->get_url()) }}&text={{ $news->name }}" class="twitter"><i class="fab fa-twitter"></i></a></li>--}}
{{--                        <li><a href="https://facebook.com/sharer/sharer.php?u={{ urlencode($news->get_url()) }}" class="facebook"><i class="fab fa-facebook-f"></i></a></li>--}}
{{--                        <li><a href="https://www.linkedin.com/shareArticle?mini=true&url={{ urlencode($news->get_url()) }}" class="linkedin"><i class="fab fa-linkedin-in"></i></a></li>--}}
{{--                        <li><a href="https://pinterest.com/pin/create/bookmarklet/?&url={{ urlencode($news->get_url()) }}&description={{ $news->name }}" class="pinterest"><i class="fab fa-pinterest-p"></i></a></li>--}}
{{--                    </ul>--}}
{{--                    <div class="gap-30"></div>--}}
{{--                </div>--}}

{{--                <div class="col-lg-3 col-md-4">--}}
{{--                    <h6 class="ttle-third">Recently Post</h6>--}}
{{--                    <ul class="side-navigation mb-5">--}}
{{--                        @foreach ($latestArticles as $article)--}}
{{--                            <li>--}}
{{--                                <a href="{{ $article->get_url() }}">{{ $article->name }}</a>--}}
{{--                            </li>--}}
{{--                        @endforeach--}}
{{--                    </ul>--}}
{{--                    <h6 class="ttle-third">Category</h6>--}}
{{--                    <ul class="side-navigation cat-nav mb-5">--}}
{{--                        @foreach ($articleCategories as $category)--}}
{{--                            <li>--}}
{{--                                <a href="{{route('news.front.index')}}?type=category&criteria={{ $category->id }}">{{ $category->name }}</a>--}}
{{--                            </li>--}}
{{--                        @endforeach--}}
{{--                    </ul>--}}
{{--                </div>--}}
{{--            </div>--}}
{{--        </div>--}}
{{--    </section>--}}

    <main>
        <section>
            <div class="main-wrapper">
                <div class="container">
                    <div class="row main-article">
                        <div class="col-lg-3">
                            <div class="article-opt">
                                <p>
                                    <a href="{{ route('news.front.index') }}"><span><i class="fa fa-long-arrow-left"></i></span>Back to news listing</a>
                                </p>
                                <p>
                                    <a data-toggle="modal" data-target="#email-article"><span><i class="fa fa-mail-forward"></i></span>E-mail this article</a>
                                </p>
                                <p>
                                    <a href="{{ route('news.front.print', $news->slug) }}" target="_blank"><span><i class="fa fa-print"></i></span>Print this article</a>
                                </p>
                            </div>
                            <div class="article-widget">
                                <div class="article-widget-title">Search</div>
                                <div class="article-widget-search">
                                    <form id="frm_search" class="search">
                                        <div class="input-group">
                                            <input type="text" name="searchtxt" id="searchtxt" class="form-control" placeholder="Search news" aria-label="Search news" aria-describedby="button-addon2" />
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button" id="button-addon2">
                                                    <span class="lnr lnr-magnifier"></span>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="article-widget">
                                <div class="article-widget-title">
                                    Latest News
                                </div>
                                @foreach ($latestArticles as $article)
                                    <div class="article-widget-news">
                                        <p class="news-date">{{ $article->date_posted() }}</p>
                                        <p class="news-title">
                                            <a href="{{ $article->get_url() }}">
                                                {{ $article->name }}
                                            </a>
                                        </p>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <div class="article-meta-share">
                                <div class="article-meta">
                                    <p>
                                        Posted on {{ $article->date_posted() }}
                                    </p>
                                </div>
                                <div class="article-share">
                                    <div class="article-share-text">Share:</div>
                                    <div id="article-social"></div>
                                </div>
                            </div>
                            <div class="article-content">
                                {!! $news->contents !!}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>


    <div class="modal fade" id="email-article" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">E-mail this article</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label>E-mail to *</label>
                            <input type="text" class="form-control" placeholder="Input receipient's e-mail address">
                        </div>
                        <div class="form-group">
                            <label>Your Name *</label>
                            <input type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Your E-mail Address *</label>
                            <input type="text" class="form-control">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button data-toggle="modal" data-target="#email-success" class="btn btn-primary">Send Article</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="email-success" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">E-mail this article</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Article successfully sent!
                </div>
            </div>
        </div>
    </div>

{{--    <div class="article-share">--}}
{{--        <div class="article-share-text">Share:</div>--}}
{{--        <div id="article-social" class="jssocials">--}}
{{--            <div class="jssocials-shares">--}}
{{--                <div class="jssocials-share jssocials-share-facebook jssocials-flat-facebook">--}}
{{--                    <a target="_blank" href="" class="jssocials-share-link">--}}
{{--                        <i class="fa fa-facebook-f jssocials-share-logo"></i>--}}
{{--                    </a>--}}
{{--                </div>--}}
{{--                <div class="jssocials-share jssocials-share-twitter jssocials-flat-twitter">--}}
{{--                    <a target="_blank" href="" class="jssocials-share-link">--}}
{{--                        <i class="fa fa-twitter jssocials-share-logo"></i>--}}
{{--                    </a>--}}
{{--                </div>--}}
{{--                <div class="jssocials-share jssocials-share-instagram jssocials-flat-instagram">--}}
{{--                    <a target="_blank" href="https://www.instagram.com/" class="jssocials-share-link">--}}
{{--                        <i class="fa fa-instagram jssocials-share-logo"></i>--}}
{{--                    </a>--}}
{{--                </div>--}}
{{--                <div class="jssocials-share jssocials-share-googleplus jssocials-flat-googleplus">--}}
{{--                    <a target="_blank" href="" class="jssocials-share-link">--}}
{{--                        <i class="fa fa-google jssocials-share-logo"></i>--}}
{{--                    </a>--}}
{{--                </div>--}}
{{--                <div class="jssocials-share jssocials-share-linkedin jssocials-flat-linkedin">--}}
{{--                    <a target="_blank" href="" class="jssocials-share-link">--}}
{{--                        <i class="fa fa-linkedin jssocials-share-logo"></i>--}}
{{--                    </a>--}}
{{--                </div>--}}
{{--            </div>--}}
{{--        </div>--}}
{{--    </div>--}}
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
            $(this).parents("ul").css("display", "block");
            $(this).parents("ul").prev("a").css("color", "#00bfca");
            $(this).parents("ul").next(".dropdown-append").addClass("dropdown-open");
        });

        $(".dropdown-append").on("click", function() {
            $(this).prev("ul").slideToggle(300);
            $(this).toggleClass("dropdown-open");
        });
    </script>
    <script>
        $(function() {
            $('#frm_search').on('submit', function(e) {
                e.preventDefault();
                window.location.href = "/news?type=searchbox&criteria="+$('#searchtxt').val();
            });

            $('#shareEmailForm').submit(function(evt) {
                let data = $('#shareEmailForm').serialize();
                // console.log(data);

                $.ajax({
                    data: data,
                    type: "POST",
                    url: "{{ route('news.front.share', $news->slug) }}",
                    success: function(returnData) {
                        $('#email-success').modal('show');
                        $('#email-article').modal('hide');
                        $('#email-article input').val('');
                    },
                    error: function(){
                        $('#email-failed').modal('show');
                        $('#email-article').modal('hide');
                        $('#email-article input').val('');
                    }
                });

                evt.preventDefault();
                return false;
            });
        });
    </script>
    <script src="{{ asset('theme/cerebro/plugins/jssocials/jssocials.min.js') }}"></script>
    <script>
        jsSocials.shares.facebook = {
            logo: "fa fa-facebook-f",
            css: "jssocials-flat-facebook",
            shareUrl:
                "https://facebook.com/sharer/sharer.php?u={url}",
            getCount: function(data) {
                return data.count;
            }
        };
        jsSocials.shares.twitter = {
            logo: "fa fa-twitter",
            css: "jssocials-flat-twitter",
            shareUrl:
                "https://twitter.com/share?url={url}&text={text}",
            getCount: function(data) {
                return data.count;
            }
        };
        jsSocials.shares.instagram = {
            logo: "fa fa-instagram",
            css: "jssocials-flat-instagram",
            shareUrl: "https://www.instagram.com/",
            countUrl: "",
            getCount: function(data) {
                return data.count;
            }
        };
        jsSocials.shares.googleplus = {
            logo: "fa fa-google",
            css: "jssocials-flat-googleplus",
            shareUrl: "https://plus.google.com/share?url={url}",
            getCount: function(data) {
                return data.count;
            }
        };
        jsSocials.shares.linkedin = {
            logo: "fa fa-linkedin",
            css: "jssocials-flat-linkedin",
            shareUrl:
                "https://www.linkedin.com/shareArticle?mini=true&url={url}",
            getCount: function(data) {
                return data.count;
            }
        };

        $("#article-social").jsSocials({
            showLabel: false,
            showCount: false,
            shares: [
                "facebook",
                "twitter",
                "instagram",
                "googleplus",
                "linkedin"
            ]
        });
    </script>
@endsection
