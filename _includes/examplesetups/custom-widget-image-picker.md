<script src="https://cdnjs.cloudflare.com/ajax/libs/image-picker/0.3.0/image-picker.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/image-picker/0.3.0/image-picker.css" />


{% capture survey_setup %}
Survey.JsonObject.metaData.addProperty("dropdown", {name: "renderAs", default: "standard", choices: ["standard", "imagepicker"]});
var survey = new Survey.Model({ questions: [
 { type: "dropdown", name: "choosepicture", renderAs: "imagepicker", title: "What animal would you like to see first ?", 
     choices: [
        {value: "lion", text: "../../images/image-picker/lion.jpg"},
        {value: "giraffe", text: "../../images/image-picker/giraffe.jpg"},
        {value: "panda", text: "../../images/image-picker/panda.jpg"},
        {value: "camel", text: "../../images/image-picker/camel.jpg"}
     ]
  }
]});

{% if page.usevue != true %}
var widget = {
    name: "imagepicker",
    isFit : function(question) { return question["renderAs"] === 'imagepicker'; },
    isDefaultRender: true,
    afterRender: function(question, el) {
{% if page.useknockout %}
        var $el = $(el);
{% else %}
        var $el = $(el).find("select");
{% endif %}
        var options = $el.find('option');
        for (var i=1; i<options.length; i++) {
            options[i].dataset["imgSrc"] = options[i].text;
        }
        $el.imagepicker({
            hide_select : true,
            show_label  : false,
            selected: function(opts) {
                question.value = opts.picker.select[0].value;
            }
        })
    }
    {% if page.useknockout %}

    {% else %}
        ,
        willUnmount: function(question, el) {
            var $el = $(el).find("select");
            $el.data('picker').destroy();
        } 
    {% endif %}
}

Survey.CustomWidgetCollection.Instance.addCustomWidget(widget);

{% if page.usereact %}
ReactDOM.render(<Survey.Survey model={survey}/>, document.getElementById("surveyElement"));

{% elsif page.useknockout %}

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
{% endif %}

{% elsif page.usevue %}
var widget = {
    name: "imagepicker",
    isFit : function(question) { return question["renderAs"] === 'imagepicker'; },
}

Vue.component(widget.name, {
    props: ['question', 'css', 'isEditMode'],
    template: `
      <select :id="question.inputId" v-model="question.value">
          <option v-for="(item, index) in question.visibleChoices" :value="item.value">{{ "{{ item.text" }}}}</option>
      </select>
    `,
    mounted: function () {
        var vm = this;
        var $el = $(vm.$el);
        var options = $el.find('option');
        for (var i=0; i<options.length; i++) {
            options[i].dataset["imgSrc"] = options[i].text;
        }
        $el.imagepicker({
            hide_select : true,
            show_label  : false,
            selected: function(opts) {
                vm.question.value = opts.picker.select[0].value;
            }
        })
    }
})
Survey.CustomWidgetCollection.Instance.addCustomWidget(widget);

var vueApp = new Vue({ el: '#surveyElement', data: { survey: survey } });
{% endif %}

{% endcapture %}

{% if page.usereact %}
<script type="text/babel">
{% else %}
<script>
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
</script>

{% include live-example-code.html %}