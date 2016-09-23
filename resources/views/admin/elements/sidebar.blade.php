<?php
if(!isset($CurMenu)) {
    $CurMenu = '';
}
$navigation = array();
$navigation[] = ['component' => 'configs', 'title' => 'Настройки', 'url' => URL::asset('/'), 'icon' => 'fa-wrench', 'childs' => [
        1 => ['menu' => 'global', 'icon' => 'fa-sliders', 'title' => 'глобальные', 'url' => URL::asset('/control-panel/globalConfigs')],
        2 => ['menu' => 'slider', 'icon' => 'fa-search', 'title' => 'слайдера', 'url' => URL::asset('/control-panel/sliderConfigs')],
]
];
$navigation[] = ['component' => 'analytics', 'title' => 'Аналитика', 'url' => URL::asset('/control-panel/analytics'), 'icon' => 'fa-bar-chart',];
$navigation[] = ['component' => 'payments', 'title' => 'Биллинг', 'url' => URL::asset('/'), 'icon' => 'fa-dollar',
        'childs' => [
                0 => ['menu' => 'paymentsByReports', 'icon' => 'fa-paste', 'title' => 'по ведомостям', 'url' => URL::asset('/paymentsByReports')],
                1 => ['menu' => 'paymentsByDates', 'icon' => 'fa-calendar', 'title' => 'по датам', 'url' => URL::asset('/paymentsByDates')]
        ]
];
$navigation[] = ['component' => 'rates', 'title' => 'Тарифы', 'url' => URL::asset('/rates'), 'icon' => 'fa-tasks',];
$navigation[] = ['component' => 'users', 'title' => 'Пользователи', 'url' => '#', 'icon' => 'fa-user',
        'childs' => [
                0 => ['menu' => 'addUser', 'icon' => 'fa-user-plus', 'title' => 'Добавить пользователя', 'url' => URL::asset('/users/addUser')],
                1 => ['menu' => 'userList', 'icon' => 'fa-users', 'title' => 'Список', 'url' => URL::asset('/users/userList')]
        ]
];
$navigation[] = ['component' => 'logout', 'title' => 'Выход', 'url' => URL::asset('/logout'), 'icon' => 'fa-sign-in'];
?>

<aside class="sidebar">
    <div class="sidebar-container">
        <div class="sidebar-header">
            <div class="brand">
                <div class="logo">
                    <span class="l l1"></span>
                    <span class="l l2"></span>
                    <span class="l l3"></span>
                    <span class="l l4"></span>
                    <span class="l l5"></span>
                </div>
                <span class="h_title">Управление</span>
            </div>
        </div>
        <nav class="menu">
            <ul class="nav metismenu" id="sidebar-menu">
                <?php
                foreach($navigation as $nav) {
                    $clsParent = '';
                    $collapseStatus = '';
                    if($nav['component'] == $component) {
                        if(isset($nav['childs']) && count($nav['childs'])) {
                            $clsParent = ' open';
                            $collapseStatus = ' style="display: block;"';
                        }
                        $cls = ' class="active'.$clsParent.'"';
                    } else {
                        $cls = '';
                    }
                    if(isset($nav['childs']) && $nav['childs'] > 0) {
                        $arrow = '<i class="fa arrow"></i>';
                    } else {
                        $arrow = '';
                    }
                    echo '<li '.$cls.'>';
                    echo '<a href="'.$nav['url'].'"><i class="fa '.$nav["icon"].'"></i><span>'.$nav["title"].'</span>'.$arrow.'</a>';
                    if(!empty($arrow)) {
                        echo '<ul class="collapse"'.$collapseStatus.'>';
                        foreach($nav['childs'] as $nchild) {
                            if($CurMenu == $nchild['menu']) {
                                $ccls = ' class="active"';
                            } else {
                                $ccls = '';
                            }
                            echo '<li ' . $ccls . '>';
                            echo '<a href="' . $nchild['url'] . '"><i class="fa '.$nchild['icon'].' iconSpan"></i></span><span class="textSpan">'.$nchild["title"] .'</span></a>';
                            echo '</li>';
                        }
                        echo '</ul>';
                    }
                    echo '</li>';

                } ?>

            </ul>
        </nav>
    </div>

</aside><div class="sidebar-overlay" id="sidebar-overlay"></div>