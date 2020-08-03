<div class="menu">
    <nav class="navik-menu menu-caret submenu-scale">
        <ul>
            @php
                $menu = \App\Menu::where('is_active', 1)->first();
            @endphp
            @foreach ($menu->parent_navigation() as $item)
                @include('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.layout.menu-item', ['item' => $item])
            @endforeach
        </ul>
    </nav>
</div>
