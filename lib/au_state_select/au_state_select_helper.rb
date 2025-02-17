module ActionView
  module Helpers
    class FormBuilder
      def state_select(method, priority_or_options = {}, options = {}, html_options = {})
        if Hash === priority_or_options
          html_options = options
          options = priority_or_options
        else
          options[:priority_state] = priority_or_options
        end

        @template.state_select(@object_name, method, objectify_options(options), @default_options.merge(html_options))
      end
    end

    module FormOptionsHelper
      def state_select(object, method, options = {}, html_options = {})
        Tags::AUStateSelect.new(object, method, self, options, html_options).render
      end
    end
    
    module Tags
      class AUStateSelect < Base
        include ::AUStateSelect::TagHelper

        def initialize(object_name, method_name, template_object, options, html_options)
          @html_options = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          select_content_tag(state_option_tags, @options, @html_options)
        end
      end
    end
  end
end