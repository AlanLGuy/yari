require 'gherkin/parser'
module Yari
  class Builder
    attr_reader :features

    def self.build(file)
      parser = Gherkin::Parser.new
      token = Gherkin::TokenScanner.new(File.read(file))
      Yari::Builder.new(parser.parse(token))
    end

    def initialize(feature_hash)
      @features ||= []
      @features << Feature.new(feature_hash)
    end
  end

  class Feature
    attr_reader :raw, :scenarios, :tags

    def initialize(raw)
      @raw = raw
      @scenarios = []
      @raw[:scenarioDefinitions].each do |raw_scenario|
        @scenarios << Scenario.new(raw_scenario)
      end
    end

    def tags
      @raw[:tags].map { |tag| tag[:name] }
    end

    def name
      @raw[:name]
    end

    def location
      @raw[:location]
    end

    def comments
      @raw[:comments]
    end
  end

  class Scenario
    attr_reader :raw, :steps, :tags, :examples

    def initialize(raw_scenario)
      @raw = raw_scenario
    end

    def name
      @raw[:name]
    end

    def tags
      @raw[:tags].map { |tag| tag[:name] }
    end

    def type
      @raw[:type]
    end

    def location
      @raw[:location]
    end

    def steps
      @raw[:steps]
    end

    def examples
      if type == :ScenarioOutline
        @raw[:examples].each { |raw_example| Yari::Example.new(raw_example) }
      end
    end
  end

  class Example
    def initialize(raw_example)
      @raw = raw_example
    end

  end

end

