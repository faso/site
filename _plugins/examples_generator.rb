module Jekyll

  class ExamplePage < Page
    def initialize(site, base, dir, platform, example)
      @site = site
      @base = base
      @dir = File.join(dir, example['name'])
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'example_template.md')

      use_platform_key = "use#{platform}"
      self.data[use_platform_key] = true

      self.data['contentHTML'] = example['contentHTML'] || 'examplesetups/standard/index.html.md'
      self.data['contentJS'] = example['contentJS'] || 'examplesetups/standard/index.js.md'
      self.data['contentCSS'] = example['contentCSS'] || 'examplesetups/standard/index.css.md'
      self.data['includes'] = example['includes'] || [
        "live-example-code.html"
      ]

      self.data['hasColumnCount'] = example['hasColumnCount']
      self.data['propertiesFile'] = example['propertiesFile']
      self.data['canonicalUrl'] = example['canonicalUrl']

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

      @includePath = example['contentHTML'] || 'examplesetups/standard/index.html.md'
      self.content = File.read(base + '/_includes/' + @includePath)
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

      self.data['dataFile'] = example['dataFile'] || "surveys/#{example['name']}.json"

      @includePath = example['contentJS'] || 'examplesetups/standard/index.js.md'
      self.content = File.read(base + '/_includes/' + @includePath)
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

      @includePath = example['contentCSS'] || 'examplesetups/standard/index.css.md'
      self.content = File.read(base + '/_includes/' + @includePath)
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