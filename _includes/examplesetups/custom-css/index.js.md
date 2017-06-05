Survey.Survey.cssType = "bootstrap";
Survey.defaultBootstrapCss.navigationButton = "btn btn-green";

window.survey = new Survey.Model({% include surveys/questiontype-matrix.json %});
survey.onComplete.add(function(result) {
	document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
});

var myCss = {
    matrix: {root: "table table-striped"},
    navigationButton: "button btn-lg"   
};

{% if page.usereact %}
ReactDOM.render(<Survey.Survey model={survey} css={myCss} />, document.getElementById("surveyElement"));

{% elsif page.useknockout%}
survey.css = myCss;
survey.render("surveyElement");

{% elsif page.useangular%}
function onAngularComponentInit() {
    Survey.SurveyNG.render("surveyElement", {
        model:survey,
        css: myCss
    });
}
{% include examplesetups/angular-example-component.md %}

{% elsif page.usejquery%}
$("#surveyElement").Survey({
    model: survey,
    css: myCss
});

{% elsif page.usevue%}
survey.css = myCss;
var app = new Vue({
    el: '#surveyElement',
    data: {
        survey: survey
    }
});

{% endif %}