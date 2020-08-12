<?php

use Illuminate\Database\Seeder;

class
SettingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $contactUsEmailContent = '<style>
                    body {
                        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                        background: #f0f0f0;
                    }
                
                    h1,
                    h2,
                    h3,
                    h4,
                    h5,
                    h6,
                    p {
                        margin: 10px 0;
                        padding: 0;
                        font-weight: normal;
                    }
                
                    p {
                        font-size: 13px;
                    }
                </style>
                
                <!-- BODY-->
                <div style="max-width: 700px; width: 100%; background: #fff;margin: 30px auto;">
                
                    <div style="padding:30px 60px;">
                        <div style="text-align: center;padding: 20px 0;">
                            {company_logo}
                        </div>
                
                        <p style="margin-top: 30px;"><strong>Dear {name},</strong></p>
                
                        <p>
                            This is to inform you that your inquiry has been sent to our Admin for action.
                        </p>
                
                        <p>
                            For your reference, please see details of your inquiry below.
                        </p>
                
                        <br />
                
                        <table style="width:100%; padding: 20px;background: #f0f0f0;font-size: 14px;">
                            <tbody>
                            <tr>
                                <td width="30%"><strong>Name</strong></td>
                                <td>{name}</td>
                            </tr>
                            <tr>
                                <td><strong>Email</strong></td>
                                <td>{email}</td>
                            </tr>
                            <tr>
                                <td><strong>Contact Number</strong></td>
                                <td>{contact}</td>
                            </tr>
                            <tr>
                                <td><strong>Message</strong></td>
                                <td>{message}</td>
                            </tr>
                            </tbody>
                        </table>
                
                        <br />
                
                        <br />
                
                        <p>
                            <strong>
                                Regards, 
                                <br />
                                {company_name}
                            </strong>
                        </p>
                    </div>
                
                    <div style="padding: 30px;background: #fff;margin-top: 20px;border-top: solid 1px #eee;text-align: center;color: #aaa;">
                        <p style="font-size: 12px;">
                            <strong>{company_name}</strong> 
                            <br /> 
                            {company_address}
                            <br /> 
                            {company_telephone_no} | {company_mobile_no}
                            <br />
                            <br /> 
                            {website_url}
                        </p>
                    </div>
                </div>';

        $setting = [
            'id' => 1,
            'api_key' => '',
            'website_name' => 'Mikisan Soap',
            'website_favicon' => '',
            'company_logo' => 'logo.jpg',
            'company_favicon' => '',
            'company_name' => 'Mikisan Soap',
            'company_about' => '',
            'company_address' => '#196 NORTHWEST IPIL ST. MARIKINA HEIGTS, MARIKINA CITY',
            'google_map' => '',
            'google_recaptcha_sitekey' => '',
            'google_recaptcha_secret' => '',
            'data_privacy_title' => 'Privacy-Policy',
            'data_privacy_popup_content' => 'This website uses cookies to ensure you get the best experience.',
            'data_privacy_content' => "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            'mobile_no' => '',
            'fax_no' => '',
            'tel_no' => '',
            'email' => 'mikisansoap@gmail.com',
            'social_media_accounts' => '',
            'copyright' => '2019-2020',
            'user_id' => '1',
            'contact_us_email_layout' => $contactUsEmailContent
        ];

        DB::table('settings')->insert($setting);
    }
}
