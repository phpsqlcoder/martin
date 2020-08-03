<?php

Route::get('/', 'FrontController@home')->name('home');
Route::get('/privacy-policy/', 'FrontController@privacy_policy')->name('privacy-policy');
Route::post('/contact-us', 'FrontController@contact_us')->name('contact-us');

// Custom routes
Route::post('/contact-us-ajax', 'FrontController@contact_us_ajax')->name('contact-us-ajax');
Route::get('/search', 'FrontController@search')->name('search');
// End Custom Routes

//News Frontend
Route::get('/news/', 'News\ArticleFrontController@news_list')->name('news.front.index');
Route::get('/news/{slug}', 'News\ArticleFrontController@news_view')->name('news.front.show');
Route::get('/news/{slug}/print', 'News\ArticleFrontController@news_print')->name('news.front.print');
Route::post('/news/{slug}/share', 'News\ArticleFrontController@news_share')->name('news.front.share');

Route::get('/albums/preview', 'FrontController@test')->name('albums.preview');

##############################################################
Route::group(['prefix' => env('APP_PANEL', 'mikisan')], function () {

    Route::get('/', 'Auth\LoginController@showLoginForm')->name('panel.login');

    Auth::routes(['verify' => true]);

    Route::group(['middleware' => 'authenticated'], function () {

        Route::get('/dashboard', 'DashboardController@index')->name('dashboard');


        //Pages
        Route::resource('/pages', 'PageController');
        Route::get('/pages-advance-search', 'PageController@advance_index')->name('pages.index.advance-search');
        Route::post('/pages/get-slug', 'PageController@get_slug')->name('pages.get_slug');
        Route::put('/pages/{page}/default', 'PageController@update_default')->name('pages.update-default');
        Route::put('/pages/{page}/customize', 'PageController@update_customize')->name('pages.update-customize');
        Route::put('/pages/{page}/contact-us', 'PageController@update_contact_us')->name('pages.update-contact-us');
        Route::post('/pages-change-status', 'PageController@change_status')->name('pages.change.status');
        Route::post('/pages-delete', 'PageController@delete')->name('pages.delete');
        Route::get('/page-restore/{page}', 'PageController@restore')->name('pages.restore');


        // Albums
        Route::resource('/albums', 'Banner\AlbumController');
        Route::post('/albums/upload', 'Banner\AlbumController@upload')->name('albums.upload');
        Route::delete('/many/album', 'Banner\AlbumController@destroy_many')->name('albums.destroy_many');
        Route::put('/albums/quick/{album}', 'Banner\AlbumController@quick_update')->name('albums.quick_update');
        Route::post('/albums/{album}/restore', 'Banner\AlbumController@restore')->name('albums.restore');
        Route::post('/albums/banners/{album}', 'Banner\AlbumController@get_album_details')->name('albums.banners');



        // Files
        Route::get('/laravel-filemanager', '\UniSharp\LaravelFilemanager\Controllers\LfmController@show')->name('file-manager.show');
        Route::post('/laravel-filemanager/upload', '\UniSharp\LaravelFilemanager\Controllers\UploadController@upload')->name('file-manager.upload');
        Route::get('/file-manager', 'FileManagerController@index')->name('file-manager.index');


        // Menu
        Route::resource('/menus', 'Menu\MenuController');
        Route::delete('/many/menu', 'Menu\MenuController@destroy_many')->name('menus.destroy_many');
        Route::put('/menus/quick1/{menu}', 'Menu\MenuController@quick_update')->name('menus.quick_update');
        Route::get('/menu-restore/{menu}', 'Menu\MenuController@restore')->name('menus.restore');


        // News
        Route::resource('/news', 'News\ArticleController');
        Route::get('/news-advance-search', 'News\ArticleController@advance_index')->name('news.index.advance-search');
        Route::post('/news-get-slug', 'News\ArticleController@get_slug')->name('news.get-slug');
        Route::post('/news-change-status', 'News\ArticleController@change_status')->name('news.change.status');
        Route::post('/news-delete', 'News\ArticleController@delete')->name('news.delete');
        Route::get('/news-restore/{news}', 'News\ArticleController@restore')->name('news.restore');
        // News Category
        Route::resource('/news-categories', 'News\ArticleCategoryController');
        Route::post('/news-categories/get-slug', 'News\ArticleCategoryController@get_slug')->name('news-categories.get-slug');
        Route::post('/news-categories/delete', 'News\ArticleCategoryController@delete')->name('news-categories.delete');
        Route::get('/news-categories/restore/{id}', 'News\ArticleCategoryController@restore')->name('news-categories.restore');


        // Account
        Route::get('/account/edit', 'Settings\AccountController@edit')->name('account.edit');
        Route::put('/account/update', 'Settings\AccountController@update')->name('account.update');
        Route::put('/account/update_email', 'Settings\AccountController@update_email')->name('account.update-email');
        Route::put('/account/update_password', 'Settings\AccountController@update_password')->name('account.update-password');
        // Website
        Route::get('/website-settings/edit', 'Settings\WebController@edit')->name('website-settings.edit');
        Route::put('/website-settings/update', 'Settings\WebController@update')->name('website-settings.update');
        Route::post('/website-settings/update_contacts', 'Settings\WebController@update_contacts')->name('website-settings.update-contacts');
        Route::post('/website-settings/update_media_accounts', 'Settings\WebController@update_media_accounts')->name('website-settings.update-media-accounts');
        Route::post('/website-settings/update_data_privacy', 'Settings\WebController@update_data_privacy')->name('website-settings.update-data-privacy');
        Route::post('/website-settings/remove_logo', 'Settings\WebController@remove_logo')->name('website-settings.remove-logo');
        Route::post('/website-settings/remove_icon', 'Settings\WebController@remove_icon')->name('website-settings.remove-icon');
        Route::post('/website-settings/remove_media', 'Settings\WebController@remove_media')->name('website-settings.remove-media');
        // Audit
        Route::get('/audit-logs', 'Settings\LogsController@index')->name('audit-logs.index');
        // CMS
        //Route::view('/settings/cms/index', 'admin.settings.cms.index')->name('settings.cms')->middleware('checkPermission:admin/settings');


        // Users
        Route::resource('/users', 'Settings\UserController');
        Route::post('/users/deactivate', 'Settings\UserController@deactivate')->name('users.deactivate');
        Route::post('/users/activate', 'Settings\UserController@activate')->name('users.activate');
        Route::get('/user-search/', 'Settings\UserController@search')->name('user.search');
        Route::get('/profile-log-search/', 'Settings\UserController@filter')->name('user.activity.search');

        // Roles
        Route::resource('/role', 'Settings\RoleController');
        Route::post('/role/delete', 'Settings\RoleController@destroy')->name('role.delete');
        Route::get('/role/restore/{id}', 'Settings\RoleController@restore')->name('role.restore');
        // Access
        Route::resource('/access', 'Settings\AccessController');
        Route::post('/roles_and_permissions/update', 'Settings\AccessController@update_roles_and_permissions')->name('role-permission.update');
        if (env('APP_DEBUG') == "true") {
            // Permission Routes
            Route::resource('/permission', 'Settings\PermissionController');
            Route::get('/permission-search/', 'Settings\PermissionController@search')->name('permission.search');
            Route::post('/permission/destroy', 'Settings\PermissionController@destroy')->name('permission.destroy');
            Route::get('/permission/restore/{id}', 'Settings\PermissionController@restore')->name('permission.restore');
        }
    });
});

// Pages Frontend
Route::get('/{any}', 'FrontController@page')->where('any', '.*');
