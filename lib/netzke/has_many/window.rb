require 'netzke-basepack'

module Netzke
  module HasMany
    class Window < Netzke::Basepack::Window
      def configure(c)
        super
        c.width = 400
        c.items = [:many_grid]
      end

      component :many_grid do |c|
        if config[:grid_klass]
          c.klass = config[:grid_klass].constantize
        else
          c.klass = Netzke::Basepack::Grid
          c.model = config[:grid_model]
          c.force_fit = true
        end
        attrs = {config[:one_name] => config[:one_id]}
        c.scope = attrs
        c.strong_default_attrs = attrs
      end
    end
  end
end