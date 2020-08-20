@extends('admin.layouts.app')

@section('pagetitle')
    User Management
@endsection

@section('pagecss')
    <link href="{{ asset('lib/bselect/dist/css/bootstrap-select.css') }}" rel="stylesheet">
@endsection

@section('content')
<div class="container pd-x-0">
    <div class="d-sm-flex align-items-center justify-content-between mg-b-20 mg-lg-b-25 mg-xl-b-30">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-style1 mg-b-10">
                    <li class="breadcrumb-item" aria-current="page"><a href="{{route('dashboard')}}">CMS</a></li>
                    <li class="breadcrumb-item" aria-current="page"><a href="{{route('users.index')}}">Users</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Create a User</li>
                </ol>
            </nav>
            <h4 class="mg-b-0 tx-spacing--1">Create a User</h4>
        </div>
    </div>

{{--    @if($message = Session::get('duplicate'))--}}
{{--        <div class="alert alert-warning d-flex align-items-center mg-t-15" role="alert">--}}
{{--            <p class="mg-b-0"><i data-feather="alert-circle" class="mg-r-10"></i>{{ $message }}--}}
{{--        </div>--}}
{{--    @endif--}}

    <div class="row">
        <div class="col-md-6">
            <form action="{{ route('users.store') }}" method="post">
                    @csrf
                    @method('POST')
                    <div class="form-group">
                        <label class="d-block">First Name *</label>
                        <input type="text" name="fname" id="fname" maxlength="90" value="{{ old('fname')}}" class="form-control @error('fname') is-invalid @enderror" required>
                        @hasError(['inputName' => 'fname'])
                        @endhasError
                    </div>
                    <div class="form-group">
                        <label class="d-block">Last Name *</label>
                        <input type="text" name="lname" id="lname" maxlength="90" value="{{ old('lname')}}" class="form-control @error('lname') is-invalid @enderror" required>
                        @hasError(['inputName' => 'lname'])
                        @endhasError
                    </div>
                    <div class="form-group">
                        <label class="d-block">Email *</label>
                        <input type="email" name="email" id="email" maxlength="150" value="{{ old('email')}}" class="form-control @error('email') is-invalid @enderror" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                        @hasError(['inputName' => 'email'])
                        @endhasError
                    </div>
                    <div class="form-group">
                        <label class="d-block">Role *</label>
                        <select name="role" class="selectpicker mg-b-5 @error('role') is-invalid @enderror" data-style="btn btn-outline-light btn-md btn-block tx-left" title="Select role" data-width="100%" required>
                            @foreach($roles as $role)
                                <option value="{{ $role->id }}" {{ (old("role") == $role->id ? "selected":"") }}>{{ $role->name }}</option>
                            @endforeach
                        </select>
                        @hasError(['inputName' => 'role'])
                        @endhasError
                    </div>
                    <button class="btn btn-primary btn-sm btn-uppercase" type="submit">Create User</button>
                    <a class="btn btn-outline-secondary btn-sm btn-uppercase" href="{{ route('users.index') }}">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection

@section('pagejs')
    <script src="{{ asset('lib/bselect/dist/js/bootstrap-select.js') }}"></script>
@endsection

@section('customjs')
    <script>
        $(function() {
            $('.selectpicker').selectpicker();
        });
    </script>
@endsection
