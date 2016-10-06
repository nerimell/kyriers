@extends('layouts.app')


@section('content')
    <div class="main-wrapper">
        <div class="app" id="app">
            @include('admin.elements.headerSection')
            @include('admin.elements.sidebar')
            <div class="content forms-page">
                <div class="title-block">
                    <h3 class="title">{{ $componentTitle }}</h3>
                    <p class="title-description">{{ $componentDesc }}</p>
                </div>
                <div class="row">
                    @yield('page')
                </div>
            </div>

            <div id="testDiv">

            </div>
            <div id="lastResponse">

            </div>
            <div id="testJson">

            </div>
        </div>
    </div>

@endSection

@section('head_data')
    <link rel="stylesheet" href="{{ URL::asset('css/admin/app.css') }}"/>
    <link rel="stylesheet" href="{{ URL::asset('css/admin/vendor.css') }}"/>
    <link rel="stylesheet" href="{{ URL::asset('css/admin/template.css') }}"/>
    <link rel="stylesheet" href="{{ URL::asset('css/admin/overrides.css') }}"/>
    <script src="{{ URL::asset('/js/sidebar.js') }}"></script>
@endSection