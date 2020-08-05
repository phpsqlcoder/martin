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

        $homeHTML = '&nbsp;';

        $aboutHTML = '<section class="wrapper" id="about">
        <div class="container text-center">
        <div class="row">
        <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 my-5">
        <h2>ABOUT</h2>
        
        <p>Mikisan is specially formulated with kojic acid dipalmitate, a more effective form of kojic acid that penetrates the deep layers of the skin and procedures excellent effects in skin whitening. Keeping the balance of your skin&rsquo;s natural moisture.</p>
        </div>
        
        <div class="col-lg-10 offset-lg-1">
        <div class="carousel-standard">
        <div class="px-3"><img src="theme/mikisan/images/misc/beauty1.jpg" /></div>
        
        <div class="px-3"><img src="theme/mikisan/images/misc/beauty2.jpg" /></div>
        
        <div class="px-3"><img src="theme/mikisan/images/misc/beauty3.jpg" /></div>
        </div>
        </div>
        
        <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 my-5">
        <h2>BEAUTY</h2>
        
        <p>A visibly whiter and flawless look is what we always wanted. Enjoy a burst of refreshness and experience radiant skin with Miki San, the perfect choice for a smooth, lighter, and healthier skin.</p>
        </div>
        </div>
        </div>
        </section>
        ';


        $footerHTML = '<footer class="wrapper bg-footer pb-1" id="connect">
        <div class="container">
        <div class="row">
        <div class="col-lg-4 col-md-6 mb-4"><img src="theme/mikisan/images/misc/nikisan-logo-black.jpg" />
        <hr class="space m" />
        <ul class="share-this footer">
            <li><a class="facebook" href="https://www.facebook.com/mikisanofficial/" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
            <li><a class="pinterest" href="https://www.instagram.com/mikisanofficial/" target="_blank"><i class="fab fa-instagram"></i></a></li>
            <li><a class="twitter" href="https://twitter.com/mikisan2018" target="_blank"><i class="fab fa-twitter"></i></a></li>
        </ul>
        </div>
        
        <div class="col-lg-5 col-md-6 mb-4">
        <h5>Contact Info</h5>
        <small>Office address</small>
        
        <ul class="ul-none no-padding">
            <li>' . Setting::info()->company_address . '</li>
        </ul>
        <small>Email address</small>
        
        <ul class="ul-none no-padding">
            <li>' . Setting::info()->email . '</li>
        </ul>
        </div>
        
        <div class="col-lg-3 col-md-12">
        <h5>Contact Numbers</h5>
        <small>Mobile</small>
        
        <ul class="ul-none no-padding">
            <li>(+63999) 888 7588</li>
            <li>(+63917) 839 7373</li>
        </ul>
        <small>Phone</small>
        
        <ul class="ul-none no-padding">
            <li>(+632) 8998 2357</li>
            <li>(+632) 8475 3723</li>
        </ul>
        </div>
        
        <div class="col-12">
        <div class="copyright">
        <p class="text-center">&copy; 2020 - <span><a href="/">Mikisan</a></span></p>
        </div>
        </div>
        </div>
        </div>
        </footer>
        ';

        $productsHTML = '<section class="wrapper bg-main text-white" id="products">
        <div class="container">
        <div class="row">
        <div class="col-md-5 offset-md-1">
        <h2>PRODUCT PRICE LIST</h2>
        
        <table class="table border-bottom my-4 text-white">
            <tbody>
                <tr>
                    <td>Miki San 45g packs by 3 (soon)</td>
                    <td class="text-right">₱48.00</td>
                </tr>
                <tr>
                    <td>Miki San 90g packs by 3</td>
                    <td class="text-right">₱99.00</td>
                </tr>
                <tr>
                    <td>Miki San 125g packs by 3</td>
                    <td class="text-right">₱139.00</td>
                </tr>
            </tbody>
        </table>
        </div>
        
        <div class="col-md-5">
        <p><img src="theme/mikisan/images/misc/mikisan-soap.jpg" /></p>
        </div>
        </div>
        </div>
        </section>
        ';

        $faqHTML = '<section class="wrapper" id="faq">
        <div class="container">
        <div class="row">
        <div class="col-md-10 offset-md-1">
        <h2 class="text-center">FAQs</h2>
        
        <table class="table table-borderless table-sm my-4 tbl-faq">
            <tbody>
                <tr>
                    <td>
                    <p class="m-0"><span class="h2">Q.</span> What are the benefits I can get from using Mikisan everyday?</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    <p class="m-0"><span class="h2">A.</span> It keeps the balance of your skin&rsquo;s natural moisture. Also it aids to achieve lighter and younger looking skin.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    <p class="m-0"><span class="h2">Q.</span> Where can we buy Mikisan?</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    <p class="m-0"><span class="h2">A.</span> We are exclusively available at all Watsons Stores Nationwide.</p>
                    </td>
                </tr>
            </tbody>
        </table>
        </div>
        </div>
        </div>
        </section>
        
        ';

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
                'slug' => 'about',
                'name' => 'About',
                'label' => 'About',
                'contents' => $aboutHTML,
                'status' => 'PUBLISHED',
                'page_type' => 'standard',
                'image_url' => '',
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
                'album_id' => 0,
                'slug' => 'faq',
                'name' => 'faq',
                'label' => 'faq',
                'contents' => $faqHTML,
                'status' => 'PUBLISHED',
                'page_type' => 'standard',
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
                'contents' => $productsHTML,
                'status' => 'PUBLISHED',
                'page_type' => 'standard',
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
