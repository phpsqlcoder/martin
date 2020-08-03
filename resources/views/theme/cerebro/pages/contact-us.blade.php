@extends('theme.'.env('FRONTEND_TEMPLATE', 'cerebro').'.main')

@section('pagecss')
@endsection

@section('content')
    <section class="bg-main wrapper">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                    <h4 class="title-secondary">get in touch with us</h4>
                    <div class="gap-10"></div>
                    <form id="contactUsForm" method="POST" action="{{ route('contact-us') }}">
                        @csrf
                        @if(session()->has('success') && session())
                            <div class="alert alert-success">
                                {{ session()->get('success') }}
                            </div>
                        @endif
                        @if(session()->has('error'))
                            <div class="alert alert-danger">
                                {{ session()->get('error') }}
                            </div>
                        @endif
                        <div class="form-group">
                            <label for="form_name">Name *</label>
                            <input id="form_name" type="text" name="name" class="form-control" placeholder="Your name" required="required">
                        </div>
                        <div class="form-group">
                            <label for="form_email">Email *</label>
                            <input id="form_email" type="email" name="email" class="form-control" placeholder="name@website.com" required="required">
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <label for="form_number">Contact Number *</label>
                            <input id="form_number" type="text" name="contact" class="form-control" placeholder="Your contact number *" required="required">
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <label for="form_message">Message *</label>
                            <textarea id="form_message" name="message" class="form-control" placeholder="Message" rows="4" required="required"></textarea>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <script src="https://www.google.com/recaptcha/api.js?hl=en" async="" defer="" ></script>
                            <div class="g-recaptcha" data-sitekey="{{ \Setting::info()->google_recaptcha_sitekey }}"></div>
                            <label class="control-label text-danger" for="g-recaptcha-response" id="catpchaError" style="display:none;"><i class="fa fa-times-circle-o"></i>The Captcha field is required.</label></br>
                            @if($errors->has('g-recaptcha-response'))
                                @foreach($errors->get('g-recaptcha-response') as $message)
                                    <label class="control-label text-danger" for="g-recaptcha-response"><i class="fa fa-times-circle-o"></i>{{ $message }}</label></br>
                                @endforeach
                            @endif
                        </div>
                        <button type="submit" class="btn btn-primary btn-third">Submit</button>
                    </form>
                    <div class="gap-50"></div>
                </div>
                <div class="col-lg-7">
                    <h4 class="title-secondary">find us on the map</h4>
                    <div class="gap-10"></div>
                    <iframe class="mt-2 mb-4" src="{{ \Setting::info()->google_map }}" width="100%" height="500" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
                </div>
            </div>
        </div>
    </section>

    {!! $page->contents !!}
@endsection

@section('pagejs')
    <script>
        $('#contactUsForm').submit(function (evt) {
            let recaptcha = $("#g-recaptcha-response").val();
            if (recaptcha === "") {
                evt.preventDefault();
                $('#catpchaError').show();
                return false;
            }
        });
    </script>
@endsection
