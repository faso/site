module Jekyll

  class ExamplePage < Page
    def initialize(site, base, dir, platform, example)
      @site = site
      @base = base
      @dir = File.join(dir, example['name'])
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'example_template.html')

      use_platform_key = "use#{platform}"
      self.data[use_platform_key] = true

      self.data['contentHTML'] = example['contentHTML']
      self.data['contentJS'] = example['contentJS']
      self.data['contentCSS'] = example['contentCSS']
      self.data['includes'] = example['includes'] || [
        "live-example-code.html"
      ]

      self.data['hasColumnCount'] = example['hasColumnCount']
      self.data['propertiesFile'] = example['propertiesFile']
      self.data['disablereRun'] = example['disablereRun']
      self.data['canonicalUrl'] = example['canonicalUrl']
      self.data['usedxchart'] = example['usedxchart']
      self.data['usedevextreme'] = example['usedevextreme']
      self.data['jquery'] = example['jquery']
      self.data['preSurvey'] = example['preSurvey']
      self.data['fiddle'] = example['fiddle']

      self.data['dataFile'] = example['dataFile'] || "surveys/#{example['name']}.json"
      self.data['title'] = example['title']

      if 'jquery'.eql? platform #TODO: avoid this somehow...
        self.data['redirect_from'] = "/examples/#{example['name']}.html"
      end
    end
  end

  class ExampleHTML < Page
    def initialize(site, base, dir, platform, example)
      @site = site
      @base = base
      @dir = File.join(dir, example['name'] + '/content')
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'example_content_html.md')

      use_platform_key = "use#{platform}"
      self.data[use_platform_key] = true

      self.content = File.read(base + '/_includes/' + example['contentHTML'])
    end
  end

  class ExampleJS < Page
    def initialize(site, base, dir, platform, example)
      @site = site
      @base = base
      @dir = File.join(dir, example['name'] + '/content')
      @name = 'index.js'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'example_content_js.md')

      use_platform_key = "use#{platform}"
      self.data[use_platform_key] = true

      self.content = File.read(base + '/_includes/' + example['contentJS'])
    end
  end

  class ExampleCSS < Page
    def initialize(site, base, dir, platform, example)
      @site = site
      @base = base
      @dir = File.join(dir, example['name'] + '/content')
      @name = 'index.css'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'example_content_css.md')

      use_platform_key = "use#{platform}"
      self.data[use_platform_key] = true

      self.content = File.read(base + '/_includes/' + example['contentCSS'])
    end
  end

  class ExamplePagesGenerator < Generator
    safe true

    def generate(site)
      # if site.layouts.key? 'category_index'
        dir = site.config['examples_dir'] || 'examples'
        site.data['platforms'].each do |platform|
          name = platform['name']
          site.data['examples_'].each do |exampleDescription|
            site.pages << ExamplePage.new(site, site.source, File.join(dir, name), name, exampleDescription)
            site.pages << ExampleHTML.new(site, site.source, File.join(dir, name), name, exampleDescription)
            site.pages << ExampleJS.new(site, site.source, File.join(dir, name), name, exampleDescription)
            site.pages << ExampleCSS.new(site, site.source, File.join(dir, name), name, exampleDescription)
          end
        end
      # end
    end
  end

end