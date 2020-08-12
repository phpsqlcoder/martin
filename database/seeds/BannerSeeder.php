<?php

use Illuminate\Database\Seeder;

class BannerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        \App\Banner::insert([
            [
                'album_id' => 1,
                'image_path' => \URL::to('/') . '/theme/mikisan/images/banners/image1.jpg',
                'title' => '',
                'description' => '',
                'alt' => 'Banner 1',
                'url' => '',
                'order' => 1,
                'user_id' => 1,
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
            [
                'album_id' => 1,
                'image_path' => \URL::to('/') . '/theme/mikisan/images/banners/image2.jpg',
                'title' => '',
                'description' => '',
                'alt' => '',
                'url' => '',
                'order' => 2,
                'user_id' => 1,
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
            [
                'album_id' => 1,
                'image_path' => \URL::to('/') . '/theme/mikisan/images/banners/image3.jpg',
                'title' => '',
                'description' => '',
                'alt' => '',
                'url' => '',
                'order' => 3,
                'user_id' => 1,
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s")
            ],
        ]);
    }
}
