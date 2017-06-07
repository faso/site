<!DOCTYPE html>
<html>
{% if page.useknockout%}
<head>
    <title>Welcome to Knockout</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js"></script>
    <script src="https://unpkg.com/survey-knockout"></script>
    <script src="https://unpkg.com/jquery"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/themes/smoothness/jquery-ui.css" type="text/css" rel="stylesheet" /> 
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./index.css">
</head>

<body>
    <div id="surveyElement"></div>
    <div id="surveyResult"></div>
    <script src="./index.js"></script>
</body>
{% elsif page.usereact%}
<head>
    <title>Welcome to React</title>
    <script src="https://unpkg.com/react@15/dist/react.js"></script>
    <script src="https://unpkg.com/react-dom@15/dist/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js"></script>
    <script src="https://unpkg.com/survey-react"></script>
    <script src="https://unpkg.com/jquery"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/themes/smoothness/jquery-ui.css" type="text/css" rel="stylesheet" /> 
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./index.css">
</head>

<body>
    <div id="surveyElement"></div>
    <div id="surveyResult"></div>
    <script type="text/babel" src="./index.js"></script>
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
    <script src="https://unpkg.com/jquery"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/themes/smoothness/jquery-ui.css" type="text/css" rel="stylesheet" /> 
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./index.css">
</head>

<body>
    <ng-app></ng-app>
    <div id="surveyResult"></div>
    <script src="./index.js"></script>
</body>
{% elsif page.usejquery%}
<head>
    <title>Welcome to JQuery</title>
    <script src="https://unpkg.com/jquery"></script>
    <script src="https://unpkg.com/survey-jquery"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/themes/smoothness/jquery-ui.css" type="text/css" rel="stylesheet" /> 
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./index.css">
</head>

<body>
    <div id="surveyElement"></div>
    <div id="surveyResult"></div>
    <script src="./index.js"></script>
</body>
{% elsif page.usevue%}
<head>
    <title>Welcome to Vue</title>
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://unpkg.com/survey-vue"></script>
    <script src="https://unpkg.com/jquery"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/themes/smoothness/jquery-ui.css" type="text/css" rel="stylesheet" /> 
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./index.css">
</head>

<body>
    <div id="surveyElement">
        <survey :survey='survey'/>
    </div>
    <div id="surveyResult"></div>
    <script src="./index.js"></script>
</body>
{% endif %}
</html>