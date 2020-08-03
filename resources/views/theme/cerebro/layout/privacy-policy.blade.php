<div id="privacy-policy" class="privacy-policy" style="display:none;z-index: 1;">
    <div class="privacy-policy-desc">
        <p class="title">{{ Setting::info()->data_privacy_title }}</p>
        <p>
            {{ Setting::info()->data_privacy_popup_content }}
        </p>
    </div>
    <div class="privacy-policy-btn">
        <a class="primary-btn" href="javascript:void(0)" id="cookieAcceptBarConfirm">Accept</a>
        <a class="secondary-btn" href="{{ route('privacy-policy') }}">Learn More</a>
    </div>
</div>
