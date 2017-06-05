Survey.Survey.cssType = "bootstrap";
Survey.defaultBootstrapCss.navigationButton = "btn btn-green";

window.survey = new Survey.Model({% include surveys/survey-severalpages.json %});
survey.showTitle = false;
survey.onComplete.add(function(result) {
	document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
});

function doOnCurrentPageChanged(survey) {
    document.getElementById('surveyPrev').style.display = !survey.isFirstPage ? "inline" : "none";
    document.getElementById('surveyNext').style.display = !survey.isLastPage ? "inline" : "none";
    document.getElementById('surveyComplete').style.display = survey.isLastPage ? "inline" : "none";
    document.getElementById('surveyProgress').innerText = "Page " + (survey.currentPage.visibleIndex + 1) + " of " + survey.visiblePageCount + ".";
    if(document.getElementById('surveyPageNo')) document.getElementById('surveyPageNo').value = survey.currentPageNo;
}

{% if page.usereact %}
ReactDOM.render(<Survey.Survey model={survey} onCurrentPageChanged={doOnCurrentPageChanged} />, document.getElementById("surveyElement"));
doOnCurrentPageChanged(survey);

{% elsif page.useknockout %}
survey.onRendered.add(doOnCurrentPageChanged);
survey.onCurrentPageChanged.add(doOnCurrentPageChanged);
survey.render("surveyElement");

{% elsif page.useangular %}
function onAngularComponentInit() {
    Survey.SurveyNG.render("surveyElement", {
        model:survey,
        onCurrentPageChanged: doOnCurrentPageChanged
    });
}
{% include examplesetups/angular-example-component.md %}
doOnCurrentPageChanged(survey);

{% elsif page.usejquery %}
$("#surveyElement").Survey({
    model: survey,
    onCurrentPageChanged: doOnCurrentPageChanged
});
doOnCurrentPageChanged(survey);

{% elsif page.usevue %}
survey.onCurrentPageChanged.add(doOnCurrentPageChanged);
new Vue({ el: '#surveyElement', data: { survey: survey } });
doOnCurrentPageChanged(survey);

{% endif %}