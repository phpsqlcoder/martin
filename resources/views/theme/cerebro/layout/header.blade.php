<header>
    <div class="head-wrapper navik-header">
        <div class="container">
            <div class="navik-header-container">
                <!--Logo-->
                <div class="logo" data-mobile-logo="{{ asset('storage').'/logos/'.Setting::getFaviconLogo()->company_logo }}" data-sticky-logo="{{ asset('storage').'/logos/'.Setting::getFaviconLogo()->company_logo }}">
                    <a href="{{ url('/') }}"><img src="{{ asset('storage').'/logos/'.Setting::getFaviconLogo()->company_logo }}" alt="logo"/></a>
                </div>

                <div class="burger-menu">
                    <div class="line-menu line-half first-line"></div>
                    <div class="line-menu"></div>
                    <div class="line-menu line-half last-line"></div>
                </div>

                @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.menu')

            </div>
        </div>
    </div>
</header>
