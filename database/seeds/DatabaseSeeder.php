<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            MenuSeeder::class,
            OptionSeeder::class,
            AlbumSeeder::class,
            BannerSeeder::class,
            SettingSeeder::class,
            PageSeeder::class,
            MenusHasPagesSeeder::class,
            ArticleSeeder::class,
            RoleSeeder::class,
            PermissionSeeder::class,
            RolepermissionSeeder::class,
            // ProductCategorySeeder::class,
            // ProductSeeder::class,
            // ProductPhotoSeeder::class
        ]);

        $this->user();
    }

    private function user()
    {
        $users = [
            [
                'name' => 'Admin',
                'firstname' => 'admin',
                'lastname' => 'istrator',
                'email' => 'wsiprod.demo@gmail.com',
                'email_verified_at' => now(),
                'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
                'remember_token' => Str::random(10),
                'role_id' => 1,
                'is_active' => 1,
                'user_id' => 1,
                'created_at' => date("Y-m-d H:i:s"),
                'updated_at' => date("Y-m-d H:i:s"),
            ]
        ];

        DB::table('users')->insert($users);
    }
}
