@extends('layouts.admin')

@section('page')
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Добавление пользователя</h3>
                </div>
                <div class="panel-body">
                {!! Form::open(['class' => 'form-horizontal', 'method' => 'post', 'id' => 'userAddForm', 'action' => 'MainController@submitAddUser']) !!}
                <div class="col-xs-12 col-sm-12 col-md-9">
                    <div class="form-group">
                        <label class="col-md-3 col-lg-2 middle">Логин</label>
                        <input class="form-control2 col-md-9 col-lg-10" type="text" name="username" class="form-control" placeholder="Введите login...">
                    </div>
                    <div class="form-group">
                        <label class="col-md-3  col-lg-2 middle">Пароль</label>
                        <input class="form-control2 col-md-9 col-lg-10" type="password" name="password" placeholder="Введите пароль...">
                    </div>
                    <div class="form-group">
                        <label class="col-md-3  col-lg-2 middle ">Е-майл</label>
                        <input class="form-control2 col-md-9 col-lg-10" type="email" name="email" class="form-control" placeholder="Введите email...">
                    </div>
                    <div class="form-group">
                        <label class="col-md-3  col-lg-2 middle">Имя</label>
                        <input class="form-control2 col-md-9  col-lg-10" type="text" name="name" class="form-control" placeholder="Введите имя...">
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-3">
                <div id="addUserSubmitWrapper">
                    <button type="submit" id="addUserButton" class="btn btn-success">Создать</button>
                </div>
                </div>
                {!! Form::close() !!}

            </div>
        </div>
    </div>
@endSection
