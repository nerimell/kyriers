@extends('admin.admin')

@section('page')
    <div class="col-md-12">
        <div class="panel panel-default mh900">
            <div class="panel-body">
            {{ Form::open(['class' => 'form-horizontal', 'method' => 'POST']) }}
                <div class="form-title">
                    Конфигурация сервиса
                </div>
                <div class="form-group">
                <label class="col-xs-12 col-sm-5 col-md-4 col-lg-3">Название сайта</label>
                <div class="col-xs-12 col-sm-7 col-md-4 col-lg-4">
                    <input type="text" class="form-control" name="metaTitle" value="{{ $SiteConfigs->SiteMeta->metaTitle }}" />
                </div>
                <div class="hidden-xs hidden-sm col-sm-4 col-lg-5 field_desc">выберите как будет называться ваш сайт</div>
                </div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-5 col-md-4 col-lg-3">Ключевые слова</label>
                    <div class="col-xs-12 col-sm-7 col-md-4 col-lg-4">
                        <input type="text" class="form-control" name="metaKeys" value="{{ $SiteConfigs->SiteMeta->metaKeys }}" />
                    </div>
                    <div class="hidden-xs hidden-sm col-sm-4 col-lg-5 field_desc">(Мета ключи) помогают пользователям найти ваш сайт</div>
                </div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-5 col-md-4 col-lg-3">Описание сайта</label>
                    <div class="col-xs-12 col-sm-7 col-md-4 col-lg-4">
                        <textarea class="form-control" name="metaDesc">{{ $SiteConfigs->SiteMeta->metaDesc }}</textarea>
                    </div>
                    <div class="hidden-xs hidden-sm col-sm-4 col-lg-5 field_desc">(Мета описание) может заставить пользователя принять решение перейти именно на ваш сайт</div>
                </div>

                <div class="form-title">
                    Настройки Sms.ru
                </div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-5 col-md-4 col-lg-3">Api идентификатор</label>
                    <div class="col-xs-12 col-sm-7 col-md-4 col-lg-4">
                        <input type="text" class="form-control" name="smsRuId" value="{{ $SiteConfigs->SmsConfigs->smsRuId }}" />
                    </div>
                    <div class="hidden-xs hidden-sm col-sm-4 col-lg-5 field_desc">
                        API идентификатор SMS.RU может быть найден в <a href="https://sms.ru/?panel=api">панели управления sms.ru</a>
                    </div>
                </div>



                <div class="form-group">
                    <button type="submit" class="btn btn-purple centered-btn">Сохранить изменения</button>
                </div>
            {{ Form::close() }}
            </div> <!-- Panel-body -->
        </div> <!-- Panel -->
    </div>
@endSection