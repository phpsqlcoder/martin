<?php

use Illuminate\Database\Seeder;

class PageSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = \Faker\Factory::create();

        $homeHTML = '<section class="product-promo-wrapper wrapper">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product-promo-items">
                            <div class="product-promo-item">
                                <div class="product-promo-image"><a href="'.url('/').'/products"><img src="'.\URL::to('/').'/theme/richams/images/misc/promo1.jpg" /></a></div>
                            </div>
                            <div class="product-promo-item">
                                <div class="product-promo-image"><a href="'.url('/').'/products"><img src="'.\URL::to('/').'/theme/richams/images/misc/promo2.jpg" /></a></div>
                            </div>
                            <div class="product-promo-item">
                                <div class="product-promo-image"><a href="'.url('/').'/products"><img src="'.\URL::to('/').'/theme/richams/images/misc/promo3.jpg" /></a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        {Featured Products}
        {Best Seller Products}
        {Featured Articles}';

        $aboutHTML = "<p>Sed quis iaculis risus, in dapibus nisi. Etiam dictum, ligula eget vehicula facilisis, turpis ipsum euismod tortor, at tristique lectus turpis vel lorem. Praesent in libero commodo dolor mollis consequat. Quisque in metus fringilla, aliquam sem eu, ornare ipsum. Donec commodo sagittis lacinia. Aenean elementum porttitor metus, ac rutrum ex condimentum eget. Ut est purus, interdum id sem nec, vehicula scelerisque purus. Quisque nec neque risus. Aliquam rhoncus lectus vitae massa imperdiet ullamcorper. Nunc sodales vehicula iaculis. </p>
					<p>Sed vel placerat metus. Etiam consequat, nisi semper lobortis posuere, ex sem pretium lectus, ac pulvinar diam nibh tincidunt felis. Duis eget facilisis quam, in accumsan erat. Duis ornare ut augue nec efficitur. Donec in sem accumsan, dapibus magna vel, iaculis nisi. Duis sed ante vulputate, fermentum ligula eget, luctus nulla. Nunc sodales congue quam, non cursus elit pellentesque sed. Integer a congue sapien, vel pulvinar erat. Vestibulum eu ullamcorper nibh. Nullam euismod ex quis arcu fermentum molestie. Vivamus volutpat ut urna eget cursus. </p>";

        $contact_us = '<div class="col-md-4">
                <div class="contact-details">
                    <h4 class="secondary-title">Office Address</h4>
                    <i class="fa fa-map-marker-alt fa-3x"></i>
                    <p>Aliquam iaculis metus eget magna feugiat hendrerit</p>
                    <div class="gap-50"></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="contact-details">
                    <h4 class="secondary-title">Contact Number</h4>
                    <i class="fa fa-phone fa-3x"></i>
                    <p>+63 919 172 3412
                        <br>+63 2 283 9047</p>
                    <div class="gap-50"></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="contact-details">
                    <h4 class="secondary-title">Email Address</h4>
                    <i class="fa fa-envelope-open fa-3x"></i>
                    <p><a href="#">name@website.com.ph</a></p>
                    <p><a href="#">othename@webstie.com.ph</a></p>
                    <div class="gap-50"></div>
                </div>
            </div>';

        $footerHTML = '<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h3 class="footer-title">About us</h3>
					<p>Zenshop is a premium Templates theme with advanced admin module. It’s extremely customizable, easy to use and fully responsive and retina ready.</p>
					<img src="'.\URL::to('/').'/theme/richams/images/rich-ams-logo-small.png" />
				</div>
				<div class="col-md-2">
					<h3 class="footer-title">Information</h3>
					<ul>
						<li><a href="'.url('/').'">home</a></li>
						<li><a href="'.url('/').'/about-us">about us</a></li>
						<li><a href="'.url('/').'/products">our products</a></li>
						<li><a href="'.url('/').'/contact-us">contact us</a></li>
					</ul>
				</div>
				<div class="col-md-4">
					<h3 class="footer-title">Contact us</h3>
					<ul>
						<li>+84 3333 6789</li>
						<li>262 Milacina Mrest Street Behansed, United State.</li>
						<li class="social-media"><a href="#"><i class="fab fa-facebook-f"></i></a><a href="#"><i class="fab fa-twitter"></i></a><a href="#"><i class="fab fa-instagram"></i></a></li>
					</ul>
				</div>
				<div class="col-md-12">
					<div class="footer-copyright">
						Created by WebFocus Solutions, Inc. © 2019 - <span>Rich Ams Global</span>
					</div>
				</div>
			</div>
		</div>';

        $newsListingContent = '';
        $pages = [
            [
                'parent_page_id' => 0,
                'album_id' => 1,
                'slug' => 'home',
                'name' => 'Home',
                'label' => 'Home',
                'contents' => $homeHTML,
                'status' => 'PUBLISHED',
                'page_type' => 'default',
                'image_url' => '',
                'meta_title' => 'Home',
                'meta_keyword' => 'home',
                'meta_description' => 'Home page',
                'user_id' => 1,
                'template' => 'home',
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
            [
                'parent_page_id' => 0,
                'album_id' => 0,
                'slug' => 'about-us',
                'name' => 'About Us',
                'label' => 'About Us',
                'contents' => $aboutHTML,
                'status' => 'PUBLISHED',
                'page_type' => 'standard',
                'image_url' => \URL::to('/').'/theme/'.env('FRONTEND_TEMPLATE').'/images/banners/sub-banner-bg.jpg',
                'meta_title' => 'About Us',
                'meta_keyword' => 'About Us',
                'meta_description' => 'About Us page',
                'user_id' => 1,
                'template' => '',
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],

            [
                'parent_page_id' => 0,
                'album_id' => 2,
                'slug' => 'contact-us',
                'name' => 'Contact Us',
                'label' => 'Contact Us',
                'contents' => $contact_us,
                'status' => 'PUBLISHED',
                'page_type' => 'customize',
                'image_url' => '',
                'meta_title' => 'Contact Us',
                'meta_keyword' => 'Contact Us',
                'meta_description' => 'Contact Us page',
                'user_id' => 1,
                'template' => 'contact-us',
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
            [
                'parent_page_id' => 0,
                'album_id' => 0,
                'slug' => 'news',
                'name' => 'News',
                'label' => 'News',
                'contents' => '',
                'status' => 'PUBLISHED',
                'page_type' => 'customize',
                'image_url' => '',
                'meta_title' => 'News',
                'meta_keyword' => 'news',
                'meta_description' => 'News page',
                'user_id' => 1,
                'template' => 'news',
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
            [
                'parent_page_id' => 0,
                'album_id' => 0,
                'slug' => 'footer',
                'name' => 'Footer',
                'label' => 'footer',
                'contents' => $footerHTML,
                'status' => 'PUBLISHED',
                'page_type' => 'default',
                'image_url' => '',
                'meta_title' => '',
                'meta_keyword' => '',
                'meta_description' => '',
                'user_id' => 1,
                'template' => '',
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
            [
                'parent_page_id' => 0,
                'album_id' => 0,
                'slug' => 'products',
                'name' => 'Products',
                'label' => 'Products',
                'contents' => '',
                'status' => 'PUBLISHED',
                'page_type' => 'customize',
                'image_url' => '',
                'meta_title' => '',
                'meta_keyword' => '',
                'meta_description' => '',
                'user_id' => 1,
                'template' => '',
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ]
        ];

        DB::table('pages')->insert($pages);
    }
}
