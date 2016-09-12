@extends('layouts.admin')

@section('page')
    <div class="col-xs-12 col-lg-8">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Список тарифов</h3>
        </div>
        <div class="panel-body ratesPanel">
            <div class="table-responsive">

                    <table class="table editable">
                        <thead>
                        <tr>
                            <th>Наименование</th>
                            <th class="ratePercent">% cтавка</th>
                            <th class="t-a-r">Действия</th>
                        </tr>
                        </thead>
                        <tbody id="ratesListTable">
                        @if(count($rates))
                        @foreach($rates as $rate)
                            <tr>
                                <td class="rateName"><span class="toggledHide">{{ $rate->name }}</span><input type="text" class="toggleableInput" value="{{ $rate->name }}" /></td>
                                <td class="ratePercent"><span class="toggledHide">{{ $rate->rate }}</span><input  class="toggleableInput" type="text" maxlength="2" value="{{ $rate->rate }}"/></td>
                                <td class="t-a-r">
                                    <button type="button" class="editRateSubmit toggleableBtn btn">
                                        <i class="fa fa-save"></i>
                                    </button><button type="button" class="editRate transpBtn">
                                        <i class="fa fa-pencil"></i>
                                    </button><button type="button" class="deleteRate transpBtn">
                                        <i class="fa fa-close"></i>
                                    </button>
                                </td>
                            </tr>
                        @endforeach
                        @endif
                        </tbody>
                    </table>


            </div>
        </div>
    </div>
    </div>
    <div class="col-xs-12 col-lg-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Создать новый тариф</h3>
            </div>
            <div class="panel-body ratesPanel">
                <div class="table-responsive">
                    <form class="form-horizontal col-md-12">
                        <div class="form-group">
                            <input type="text" class="form-control" name="rateName" placeholder="Введите наименование тарифа..." />
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="ratePercent" placeholder="Укажите процентную ставку..." max-length="2"/>
                        </div>
                        <div class="tarBtnWrapper">
                     <button type="button" class="btn btn-success" id="submitNewRate"><i class="fa fa-chevron-left"></i>Создать</button>
                     </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection

@section('head_data')
    @parent
    <script src="{{ URL::asset('/js/rateActions.js') }}"></script>
    @endSection