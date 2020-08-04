<header id="home">
    <div class="main-navigation">
        <div class="navik-header header-shadow">
            <div class="container">

                <!-- Navik header -->
                <div class="navik-header-container">

                    <!--Logo-->
                    <div class="logo"  data-mobile-logo="{{ asset('storage').'/logos/'.Setting::getFaviconLogo()->company_logo }}" data-sticky-logo="{{ asset('storage').'/logos/'.Setting::getFaviconLogo()->company_logo }}">
                        <a href="{{ url('/') }}"><img src="{{ asset('storage').'/logos/'.Setting::getFaviconLogo()->company_logo }}" alt="logo"/></a>
                    </div>

                    <!-- Burger menu -->
                    <div class="burger-menu">
                        <div class="line-menu line-half first-line"></div>
                        <div class="line-menu"></div>
                        <div class="line-menu line-half last-line"></div>
                    </div>

                    <!--Navigation menu-->
                    @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.menu')


                </div>

            </div>
        </div>
    </div>
    <!-- InstanceBeginEditable name="content area" -->