@extends('layouts.wrapper')
@section('page')
<div id="content">
<div id="errorDiv">
<?php echo session()->getId(); ?>
 <?php
    if(session('regMessage')) {
        echo session('regMessage');
    }
 ?>
</div>
</div>
@endSection