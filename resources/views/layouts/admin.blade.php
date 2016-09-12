@extends('layouts.app')

@section('content')
<div class="main-wrapper">
    <div class="app" id="app">
        @include('layouts.headerSection')
        @include('layouts.sidebar')
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
    </div>
</div>

@yield('modal')

@endSection

@section('head_data')
<script src="{{ URL::asset('js/timer.js') }}"></script>
@endSection



