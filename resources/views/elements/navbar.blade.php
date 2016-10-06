<div id="headerRow">
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">
              <img src="/images/logo.png" id="logoImage" />
              <span id="brandTitle">Delivery</span>
              <span id="brandDesc">services</span>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="navRight">
                <?php if($userData) { ?>
                <li><a href="/my/settings">Мой аккаунт</a></li>
                <li><a href="/logout">Выход</a></li>
                <?php } else { ?>
                <li><a href="#" id="loginIntoSystem">Войти</a></li>
                <li><a href="#" id="registerIntoSystem">Зарегистрироваться</a></li>
                <li><a href="/aboutService" id="registerIntoSystem">О сервисе</a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
</nav>
</div>