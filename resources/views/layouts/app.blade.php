<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title>{{ $SiteConfigs->SiteMeta->metaTitle }}</title>
    <meta name="keywords" content="{{ $SiteConfigs->SiteMeta->metaKeys }}">
    <meta name="description" content="{{ $SiteConfigs->SiteMeta->metaDesc }}">
    <meta name="csrf" content="{!! csrf_token() !!}">
    <link rel="stylesheet" href="{{ URL::asset('css/font-awesome.min.css') }}"/>
    <link rel="stylesheet" href="{{ URL::asset('css/bootstrap.css') }}"/>
    <link rel="stylesheet" href="{{ URL::asset('css/jquery-confirm.css') }}"/>
    <link rel="stylesheet" href="{{ URL::asset('css/jquery-ui.css') }}"/>

    <script src="{{ URL::asset('js/jquery.js') }}"></script>
    <script src="{{ URL::asset('js/bootstrap.min.js') }}"></script>
    <script src="{{ URL::asset('js/common.js') }}"></script>
    <script src="{{ URL::asset('js/jquery-ui.js') }}"></script>
    <script src="{{ URL::asset('js/select.js') }}"></script>
    <script src="{{ URL::asset('js/jquery-confirm.js') }}"></script>
    <script src="{{ URL::asset('js/app-labsSelect.js') }}"></script>
    @yield('head_data')
</head>
<body>
@yield('content')

@yield('modals')
</body>
</html>