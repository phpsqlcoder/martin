<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Setting extends Model
{
    use SoftDeletes;

    protected $table = 'settings';
    protected $fillable = ['api_key', 'website_name', 'website_favicon', 'company_logo', 'company_favicon', 'company_name',
        'google_analytics', 'google_recaptcha_sitekey', 'google_recaptcha_secret', 'data_privacy_title',
        'data_privacy_popup_content', 'data_privacy_content', 'mobile_no', 'fax_no', 'tel_no', 'email', 'company_about',
        'company_address', 'google_map', 'social_media_accounts', 'copyright', 'user_id', 'contact_us_email_layout'];

    public static function getWebsiteName()
    {
        $data = Setting::where('id',1)->first();

        return $data->website_name;
    }

    public static function getCopyright()
    {
        $data = Setting::where('id',1)->first();

        return $data->copyright;
    }
}
