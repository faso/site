Survey.Survey.cssType = "bootstrap";
Survey.defaultBootstrapCss.navigationButton = "btn btn-green";

Survey.JsonObject.metaData.addProperty("dropdown", {name: "dateFormat", default: "mm/dd/yy", choices: ["mm/dd/yy", "yy-mm-dd", "d M, y", "d MM, y", "DD, d MM, yy", "'day' d 'of' MM 'in the year' yy"]});

window.survey = new Survey.Model({
    pages: [
        { name:"page1", questions: [
            {name:"date", type:"text", inputType:"date", title: "Your favorite date:", dateFormat: "mm/dd/yy"}
        ]}
    ]
});
survey.onComplete.add(function(result) {
	document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
});

{% if page.usevue != true %}
var widget = {
    name: "datepicker",
    htmlTemplate: "<input class='widget-datepicker' type='text' style='width: 100%;'>",
    isFit: function(question) {
        return question.getType() === 'text' && question.inputType === 'date';
    },
    afterRender: function(question, el) {
        var $el;
{% if page.useknockout %}
        $el = $(el);
{% else %}
        $el = $(el).find('.widget-datepicker');
{% endif %}
        var widget = $el.datepicker({
            dateFormat: question.dateFormat,
            onSelect: function(dateText) {
                question.value = dateText;
            }
        });
        question.valueChangedCallback = function() {
            widget.datepicker('setDate', new Date(question.value));
        }
        question.valueChangedCallback();
    },
    willUnmount: function(question, el) {
{% if page.useknockout %}
        $(el).datepicker("destroy");
{% else %}
        $(el).find('.widget-datepicker').datepicker("destroy");
{% endif %}
    }
}

Survey.CustomWidgetCollection.Instance.addCustomWidget(widget);
{% endif %}

{% if page.usereact %}
ReactDOM.render(<Survey.Survey model={survey}/>, document.getElementById("surveyElement"));

{% elsif page.useknockout %}
survey.render("surveyElement");
{% elsif page.useangular %}
function onAngularComponentInit() {
    Survey.SurveyNG.render("surveyElement", {
        model:survey
    });
}
{% include examplesetups/angular-example-component.md %}

{% elsif page.usejquery %}
$("#surveyElement").Survey({
    model: survey
});

{% elsif page.usevue %}
var widget = {
    name: "datepicker",
    isFit : function(question) { return question.name == 'date'; }
}

Vue.component(widget.name, {
    props: ['question', 'css', 'isEditMode'],
    template: "<input class='widget-datepicker' type='text' style='width: 100%;'>",
    mounted: function () {
        var vm = this
        var widget = $(vm.$el).datepicker({
            dateFormat: vm.question.dateFormat,
            onSelect: function(dateText) {
                vm.question.value = dateText;
            }
        });
        vm.question.valueChangedCallback = function() {
            widget.datepicker('setDate', new Date(vm.question.value));
        }
        widget.datepicker('setDate', new Date(vm.question.value || Date.now));
    },
    destroyed: function () {
        $(this.$el).datepicker("destroy");
    }
})
Survey.CustomWidgetCollection.Instance.addCustomWidget(widget);
new Vue({ el: '#surveyElement', data: { survey: survey } });
{% endif %}

window.surveyForceUpdate = function() {
    document.getElementById("surveyElement").innerHTML = "";
{% if page.useknockout %}
    survey.render();
{% elsif page.usereact %}
    ReactDOM.render(<Survey.Survey model={survey}/>, document.getElementById("surveyElement"));
{% elsif page.usejquery %}
    $("#surveyElement").Survey({ model: survey });
{% elsif page.useangular %}
    document.querySelector("ng-app").innerHTML = "";
    ng.platformBrowserDynamic.bootstrap(HelloApp);
{% elsif page.usevue %}
    document.getElementById("surveyElement").innerHTML = "<survey :survey='survey'/>";
    vueApp.$destroy();
    vueApp = new Vue({ el: '#surveyElement', data: { survey: survey } });
{% endif %}
}