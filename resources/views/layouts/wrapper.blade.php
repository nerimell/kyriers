@extends('layouts.app')

@section('content')
@include('elements.navbar')
<div class="container">
@yield('page')
</div>
@include('elements.footer')
@endSection
@section('head_data')
<link rel="stylesheet" href="{{ URL::asset('css/overrides.css') }}"/>
<link rel="stylesheet" href="{{ URL::asset('css/template.css') }}"/>
<script src="{{ URL::asset('/js/frontActions.js') }}"></script>
@endSection

@section('modals')
<div class="modal fade" id="loginForm" tabindex="-1" role="dialog">
   <div class="modal-dialog" role="document">
   <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"></i></button>
    <h4 class="modal-title authActionsTogglers loginAction" action-type="authorization">Авторизация</h4>
    <h4 class="modal-title authActionsTogglers registerAction" action-type="registration">Регистрация</h4>
   </div>
   <div class="modal-body">
    {{ Form::open(['class' => 'form-horizontal authActionsTogglers registerAction', 'action-type' => 'registration', 'method' => 'POST', 'url' => 'auth/sendRegistration']) }}
    <div class="form-group">
        <input type="text" class="form-control" name="phone" placeholder="Введите номер телефона" />
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="name" placeholder="Ваше имя" />
    </div>
    <div class="form-group">
        <input type="email" class="form-control" name="email" placeholder="Введите Email" />
    </div>
    <div class="form-group">
        <input type="password" class="form-control" name="password_one" placeholder="Введите пароль" />
    </div>
    <div class="form-group">
        <input type="password" class="form-control" name="password_two" placeholder="Подтвердите пароль"/>
    </div>
    <div class="form-group">
        <select class="combobox" name="city" id="registrationCity">
        <?php
            foreach($cities as $city) {
                echo '<option value="'.$city->name.'">'.$city->name.'</option>';
            }
        ?>
        </select>
     </div>
    <div class="form-group">
        <button type="submit" class="btn btn-blue">Зарегистрироваться</button>
    </div>
    {{ Form::close() }}

       {{ Form::open(['class' => 'form-horizontal authActionsTogglers loginAction', 'action-type' => 'authorization', 'method' => 'POST', 'url' => 'auth/sendAuthorization']) }}
       <div class="form-group">
           <input type="text" class="form-control" name="phone" placeholder="Введите логин" />
       </div>
       <div class="form-group">
           <input type="password" class="form-control" name="password" placeholder="Введите пароль" />
       </div>
       <div class="form-group">
           <button type="submit" class="btn btn-blue centered-btn">Войти</button>
       </div>
       {{ Form::close() }}

   </div>
  </div>
 </div>
</div>
@endSection