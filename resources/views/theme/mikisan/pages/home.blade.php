@extends('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.main')

@section('pagecss')
@endsection

@section('content')

    <div class="main-banner">
        {!! $page->contents !!}
    </div>
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.pages.about-us')
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.pages.products')
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.pages.faq')
    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.pages.footer')
</header>

    
@endsection

@section('pagejs')
@endsection

@section('customjs')
@endsection
