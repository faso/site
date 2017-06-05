{% capture survey_setup %}
var survey = new Survey.Model({% include surveys/survey-multilanguages.json %});

{% if page.usereact %}
ReactDOM.render(<Survey.Survey model={survey} />, document.getElementById("surveyElement"));

{% elsif page.usevue%}
var app = new Vue({
    el: '#surveyElement',
    data: {
        survey: survey
    }
});

{% elsif page.useangular%}
function onAngularComponentInit() {
    Survey.SurveyNG.render("surveyElement", {model:survey});
}
{% include examplesetups/angular-example-component.md %}

{% elsif page.usejquery%}
$("#surveyElement").Survey({model:survey});

{% endif %}
{% endcapture %}

{% include live-example-code.html %}

