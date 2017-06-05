Survey.Survey.cssType = "bootstrap";
Survey.defaultBootstrapCss.navigationButton = "btn btn-green";
Survey.defaultBootstrapCss.progressBar = "bar-green";

window.survey = new Survey.Model({% include surveys/survey-severalpages.json %});
survey.onComplete.add(function(result) {
	document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
});
survey.showProgressBar = "bottom";

{% if page.usereact %}
ReactDOM.render(<Survey.Survey model={survey} />, document.getElementById("surveyElement"));
{% elsif page.useknockout%}
survey.render("surveyElement");
{% elsif page.useangular%}
function onAngularComponentInit() {
    Survey.SurveyNG.render("surveyElement", {model:survey});
}
{% include examplesetups/angular-example-component.md %}
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