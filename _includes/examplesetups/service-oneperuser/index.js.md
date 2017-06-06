Survey.defaultBootstrapCss.navigationButton = "btn btn-primary";
Survey.Survey.cssType = "bootstrap";

var clientId;

runSurveyCheck();

function runSurveyCheck() {
    clientId = document.getElementById('clientIdinput').value || 'e2bd506a-a218-4f5c-b8ae-768f203e399b';
    new Survey.dxSurveyService().isCompleted('47e699f7-d523-4476-8fcd-be601c91d119', clientId, onCheckCompleted);
}

function onCheckCompleted(success, result, response) {
    if(!success) return;
    if(result == 'completed') {
        alert('You have already run the survey!');
    } else {
        runSurvey();
    }
}

{% if page.useangular %}
function runSurvey() {
    window.survey = new Survey.Model({
            surveyId: 'e7866476-e901-4ab7-9f38-574416387f73',
            surveyPostId: 'df2a04fb-ce9b-44a6-a6a7-6183ac555a68'
    }, "surveyElement");
    
    survey.onComplete.add(function(result) {
    	document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
    });
    
    survey.onSendResult.add(function (survey) { 
        var text = "clientId:" + survey.clientId + ". The results are:" + JSON.stringify(survey.data)  + String.fromCharCode(13, 10);
        var memo = document.getElementById('serverResultArea');
        memo.value = memo.value + text;
    });
    
    survey.sendResultOnPageNext = true;
    survey.clientId = clientId;
    ng.platformBrowserDynamic.bootstrap(HelloApp);
}

function onAngularComponentInit() {
        Survey.SurveyNG.render("surveyElement", {model:survey});
    }

var HelloApp =
    ng.core
        .Component({
            selector: 'ng-app',
            template: '<div id="surveyContainer" class="survey-container contentcontainer codecontainer">' +
            '<div id="surveyElement"></div></div>'
        })
        .Class({
            constructor: function() {
            },
            ngOnInit: function() {
                onAngularComponentInit();
            }
        });

{% else %}
function runSurvey() {
    window.survey = new Survey.Model({
            surveyId: 'e7866476-e901-4ab7-9f38-574416387f73',
            surveyPostId: 'df2a04fb-ce9b-44a6-a6a7-6183ac555a68'
    }, "surveyElement");
    
    survey.onComplete.add(function(result) {
    	document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
    });
    
    survey.onSendResult.add(function (survey) { 
        var text = "clientId:" + survey.clientId + ". The results are:" + JSON.stringify(survey.data)  + String.fromCharCode(13, 10);
        var memo = document.getElementById('serverResultArea');
        memo.value = memo.value + text;
    });
    
    survey.sendResultOnPageNext = true;
    survey.clientId = clientId;
{% if page.usereact %}
    ReactDOM.render(<Survey.Survey model={survey} />, document.getElementById("surveyElement"));
{% elsif page.useknockout%}
    survey.render("surveyElement");
{% elsif page.usejquery%}
    $("#surveyElement").Survey({model:survey});
{% elsif page.usevue%}
    var app = new Vue({
        el: '#surveyElement',
        data: {
            survey: survey
        }
    });
{% endif %}
}
{% endif %}