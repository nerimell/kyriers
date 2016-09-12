@extends('layouts.app')

@section('content')
<div class="verticalWrapper">
<div class="verticalAligner">
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-body">
                <div class="loginFirst">
                    <i class="fa fa-bolt" aria-hidden="true"></i>
                    <h5 class="content-group">Вход в систему
                        <span class="display-block">введите ваши данные</span>
                    </h5>
                </div>
                    <form class="form-horizontal" id="loginForm" role="form" method="POST" action="{{ url('/login') }}">
                        {{ csrf_field() }}

                        <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                            <div class="col-md-12">
                                <input id="username" type="text" placeholder="Логин..." class="form-control" name="username" value="">
                                <i class="fa fa-user absLogin" aria-hidden="true"></i>

                                @if ($errors->has('username'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('username') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>

                        <div class="form-group{{ $errors->has('password') ? ' has-error' : '' }}">

                            <div class="col-md-12">
                                <input id="password" type="password" class="form-control" name="password" placeholder="Пароль..."><i  class="fa fa-lock absLogin" aria-hidden="true"></i>

                                @if ($errors->has('password'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('password') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="col-xs-12">
                                <button type="submit" class="btn btn-primary">
                                    Войти <i class="fa fa-chevron-circle-right" aria-hidden="true"></i>
                                </button>


                            </div>
                            <div class="col-xs-12">
                                <a class="btn btn-link" href="{{ url('/password/reset') }}">Забыли пароль?</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
@endsection
