    <nav class="navik-menu menu-caret menu-hover-3 submenu-top-border submenu-scale">
        <ul id='navmenu-items'>
            @php
                $menu = \App\Menu::where('is_active', 1)->first();
            @endphp
            @foreach ($menu->parent_navigation() as $item)
                @include('theme.'.env('FRONTEND_TEMPLATE', 'mikisan').'.layout.menu-item', ['item' => $item])
            @endforeach
            <li>
                <a href="#connect">Connect</a>
            </li>
            
        </ul>
    </nav>
