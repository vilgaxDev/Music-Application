@extends('vendor.installer.layouts.master')

@section('template_title')
      Muzzie Installer
@endsection

@section('title')
      Muzzie Installer
@endsection

@section('container')
    <p class="text-center">
    This installation will initial your app, when it is done make sure to log into your admin account to check the settings and customize the app the way you like.
    </p>
    <p class="text-center">
      <a href="{{ route('LaravelInstaller::requirements') }}" class="button">
        Start
        <i class="fa fa-angle-right fa-fw" aria-hidden="true"></i>
      </a>
    </p>
@endsection
