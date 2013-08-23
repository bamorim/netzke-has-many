require 'active_support/concern'

module Netzke
  module HasMany
    module Base
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many many, options = {}
          grid_klass = options[:grid_klass].to_s if options[:grid_klass]
          endpoint_path = options[:endpoint] || :select_one
          endpoint_fun = endpoint_path.to_s.camelize
          endpoint_fun = endpoint_fun[0].downcase + endpoint_fun[1..-1]
          class_eval do
            action "edit_#{many}".to_sym

            endpoint endpoint_path do | params, this |
              component_session["selected_#{config["model"].underscore}_id"] = params["one_id"]
            end

            component "#{many}_window" do |c|
              c.klass = ManyWindow
              c.one_id = component_session["selected_#{config["model"].underscore}_id"]
              c.one_name = "#{config["model"].underscore}_id".to_sym
              c.grid_klass = grid_klass
              c.grid_model = many.to_s.singularize.camelize
            end

            js_configure do |c|
              c.send "on_edit_#{many}=", <<-JS
                function(){
                  this.netzkeLoadComponent("#{many}_window", {callback: function(w){
                    w.show();
                  }});
                }
              JS

              c.init_component = <<-JS
                function(){
                  Netzke.classes.#{self.to_s.gsub("::",".")}.superclass.initComponent.call(this);

                  this.getSelectionModel().on('selectionchange', function(selModel){
                    this.actions.edit#{many.to_s.camelize}.setDisabled(selModel.getCount() != 1);
                    if(selModel.getCount() == 1) {
                      one_id = selModel.store.getAt(selModel.getSelection()[0].index).get('id');
                      this.#{endpoint_fun}({one_id: one_id})
                    }
                  }, this);
                }
              JS
            end

            define_method :default_bbar do |*params|
              ["edit_#{many}".to_sym, "-", *super(*params)]
            end

            define_method :default_context_menu do |*params|
              ["edit_#{many}".to_sym, "-", *super(*params)]
            end
          end
        end
      end
    end
  end
end