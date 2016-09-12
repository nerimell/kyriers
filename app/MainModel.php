<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;
use Auth;

class MainModel extends Model
{

    public static function getCities() {
        $cities = DB::table('cities')
        ->select('name')->get();
        return $cities;
    }

    public static function getDrivers() {
        $userData = Auth::user();
        $params = array('ordering' => 'id', 'userId' => $userData->id);
        $accounts = UberModel::getAccounts($params);
        $accountIds = [];
        if(!$accounts) {
            return false;
        }
        foreach($accounts['accounts'] as $acc) {
            $accountIds[] = $acc->id;
        }

        $accountsToReturn = [];
        foreach($accounts['accounts'] as $acc) {
            $accountsToReturn[$acc->id] = $acc;
        }
        $drivers = DB::table('uberdrivers')
            ->whereIn('uberaccount', $accountIds)
            ->paginate(35);
        $driversCount = DB::table('uberdrivers')
            ->whereIn('uberaccount', $accountIds)
            ->count();
        $result['drivers'] = $drivers;
        $result['driversCount'] = $driversCount;
        $result['uberAccounts'] = $accountsToReturn;
        return $result;
    }

    public static function countDrivers() {

    }

    public static function getRates($userId) {
        $rates = DB::table('rates')
            ->where('user_id', $userId)
            ->orderBy('rate', 'asc')
            ->get();
        return $rates;
    }

    public static function getMostRecentDate($dates) {
        if(!is_array($dates)) {
            return $dates;
        }
        $mostRecent = 0;
        foreach ($dates as $date) {
            $curDate = strtotime($date);
            if ($curDate > $mostRecent) {
                $mostRecent = $curDate;
            }
        }

        return $mostRecent;
    }



}
