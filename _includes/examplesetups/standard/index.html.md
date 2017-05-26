<!DOCTYPE html>
<html>
{% if page.usereact %}
{% elsif page.useknockout%}
<head>
    <title>Welcome to Knockout</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js"></script>

    <script src="https://unpkg.com/survey-knockout"></script>
    <link rel="stylesheet" href="https://getbootstrap.com/dist/css/bootstrap.css">
</head>

<body>
    <div id="surveyElement">
    </div>
    <script src="./index.js"></script>
</body>
{% elsif page.useangular%}
<head>
    <title>Welcome to Angular</title>
    <script src="https://npmcdn.com/zone.js"></script>
    <script src="https://npmcdn.com/core-js/client/shim.min.js"></script>
    <script src="https://npmcdn.com/rxjs@5.0.0-beta.6/bundles/Rx.umd.js"></script>
    <script src="https://npmcdn.com/@angular/core@2.0.0-rc.5/bundles/core.umd.js"></script>
    <script src="https://npmcdn.com/@angular/common@2.0.0-rc.5/bundles/common.umd.js"></script>
    <script src="https://npmcdn.com/@angular/compiler@2.0.0-rc.5/bundles/compiler.umd.js"></script>
    <script src="https://npmcdn.com/@angular/platform-browser@2.0.0-rc.5/bundles/platform-browser.umd.js"></script>
    <script src="https://npmcdn.com/@angular/platform-browser-dynamic@2.0.0-rc.5/bundles/platform-browser-dynamic.umd.js"></script>

    <script src="https://unpkg.com/survey-angular"></script>
    <link rel="stylesheet" href="http://getbootstrap.com/dist/css/bootstrap.css">
</head>

<body>
    <ng-app></ng-app>
    <script src="./index.js"></script>
</body>
{% elsif page.usejquery%}
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to JQuery</title>
    <script src="https://unpkg.com/jquery"></script>

    <script src="https://unpkg.com/survey-jquery"></script>
    <link rel="stylesheet" href="https://getbootstrap.com/dist/css/bootstrap.css">
</head>

<body>
    <div id="surveyElement">
    </div>
    <script src="./index.js"></script>
</body>
</html>
{% elsif page.usevue%}
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Vue</title>
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <link rel="stylesheet" href="http://getbootstrap.com/dist/css/bootstrap.css">

    <script src="./survey.vue.min.js"></script>
</head>

<body>
    <div id="app">
        <survey :survey='survey'/>
    </div>
    <script src="./index.js"></script>
</body>
</html>
{% endif %}
</html>