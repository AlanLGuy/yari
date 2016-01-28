require 'yari'
require 'rspec'

module Yari
  module RSpec
    module Loader
      def load(*paths, &block)

        # Override feature exclusion filter if running features
        if paths.any? { |path| Yari.feature?(path) }
          ::RSpec.configuration.filter_manager.exclusions.rules.reject! do |key, value|
            key == :feature || (key == :type && value == 'feature')
          end
        end

        paths = paths.map do |path|
          if Yari.feature?(path)
            spec_path = Yari.feature_to_spec(path)
            if File.exist?(spec_path)
              spec_path
            else
              Yari::Builder.build(path).features.each do |feature|
                ::RSpec.describe("Feature: #{feature.name}", :type => :feature, :feature => true) do
                  it do |example|
                    example.metadata[:location] = path << ':1'
                    skip('No spec implemented for feature')
                  end
                end
              end
              nil
            end
          else
            path
          end
        end.compact

        # Load needed features to Yari.features array
        paths.each do |path|
          if Yari.feature_spec?(path)
            feature_path = Yari.spec_to_feature(path)

            if File.exists?(feature_path)
              Yari.features += Yari::Builder.build(feature_path).features
            end
          end
        end

        super(*paths, &block) if paths.size > 0
      end
    end
  end
end
