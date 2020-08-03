@extends('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.main')

@section('pagecss')
@endsection

@section('content')
    <main>
        <section>
            <div class="main-wrapper">
                <div class="container">
                    <div class="row">
                        @if($parentPage)
                            <div class="col-md-3">
                                <a href="{{ $parentPage->get_url() }}" style="text-decoration: none;">
                                    <h3>
                                        {{ $parentPage->name }}
                                    </h3>
                                </a>
                                <div class="side-menu">
                                    <ul>
                                        @foreach ($parentPage->sub_pages as $subPage)
                                            <li @if ($subPage->id == $page->id) class="active" @endif>
                                                <a href="{{ $subPage->get_url() }}">{{ $subPage->name }}</a>
                                                @if ($subPage->has_sub_pages())
                                                    <ul>
                                                        @foreach ($subPage->sub_pages as $subSubPage)
                                                            <li @if ($subSubPage->id == $page->id) class="active" @endif>
                                                                <a href="{{ $subSubPage->get_url() }}">{{ $subSubPage->name }}</a>
                                                                @if ($subSubPage->has_sub_pages())
                                                                    <ul>
                                                                        @foreach ($subSubPage->sub_pages as $subSubSubPage)
                                                                            <li @if ($subSubSubPage->id == $page->id) class="active" @endif>
                                                                                <a href="{{ $subSubSubPage->get_url() }}">{{ $subSubSubPage->name }}</a>
                                                                            </li>
                                                                        @endforeach
                                                                    </ul>
                                                                @endif
                                                            </li>
                                                        @endforeach
                                                    </ul>
                                                @endif
                                            </li>
                                        @endforeach
                                    </ul>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                {!! $page->contents !!}
                            </div>
                        @else
                            <div class="col-lg-12">
                                {!! $page->contents !!}
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </section>
    </main>
@endsection

@section('pagejs')
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
    </script>
@endsection


