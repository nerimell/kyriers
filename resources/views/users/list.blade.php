@extends('layouts.admin')

@section('page')
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Список пользователей</h3>
                    <a href="/users/addUser" class="topRightHeadingButton btn btn-success" id="addUser" type="button"><i class="fa fa-plus"></i>Добавить</a>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            @if($users->count())
                            <div class="table-responsive">
                                <table class="table editable">
                                    <thead>
                                    <tr>
                                        <th>Логин</th>
                                        <th>Почта</th>
                                        <th>Имя</th>
                                        <th class="t-a-r">Действия</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    @foreach($users as $user)
                                    <tr>
                                    <input type="hidden" class="userId" value="{{ $user->id }}" />
                                    <td class="userLogin">{{ $user->username }}</td>
                                    <td class="userMail">{{ $user->email }}</td>
                                    <td>{{ $user->name }}</td>
                                    <td class="t-a-r">
                                    @if($user->id != 1 && $authId != $user->id)
                                    <button type="button" class="deleteUser transpBtn">
                                        <i class="fa fa-close"></i>
                                    </button>
                                    @endif
                                    </td>
                                    </tr>
                                    @endforeach

                                    </tbody>
                                </table>
                            </div>
                            @else
                            <span class="noUsers">Пользователи не найдены, вы можете вернуться на <a href="{{ URL::asset('/users/userList') }}">первую страницу</a></span>
                            @endif
                        </div>
                    </div>
                </div>
                <div id="pagination">
                {{ $users->links() }}
                </div>
            </div>
        </div>
    </div>
@endSection

@section('head_data')
    @parent
    <script src="{{ URL::asset('/js/userActions.js') }}"></script>
@endSection