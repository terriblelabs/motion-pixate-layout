module MotionPixateLayout
  class Proxy
    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end

    def view
      controller.view
    end

    def layout
      controller.pixate_layout
    end

    def run
      apply_selector
      apply_attributes
      run_blocks controller, layout.before
      view_proxy.run_blocks
      run_blocks controller, layout.after
      controller.view.updateStyles
    end

    def view_proxy
      @view_proxy ||= ViewProxy.new(self.view).tap do |proxy|
        proxy.blocks = layout.blocks
      end
    end

    def apply_selector
      if layout.selector
        view.styleId = layout.selector.style_id
        view.styleClass = layout.selector.style_classes.join(' ')
      end
    end

    def run_blocks(context, blocks)
      blocks.each { |block| context.instance_eval &block }
    end

    def apply_attributes
      layout.view_attributes ||= []
      layout.view_attributes.each do |key, value|
        view.public_send "#{key}=", value
      end
    end
  end

  class ViewProxy
    attr_accessor :blocks
    attr_reader :view

    def initialize(view)
      @view = view
      self.blocks = []
    end

    def subview(subview_class, selector, attributes = {}, &block)
      selector = MotionPixateLayout::Selector.new(selector)

      subview_class.new.tap do |subview|
        subview.styleId = selector.style_id
        subview.styleClass = selector.style_classes.join(" ")

        attributes.each do |key, value|
          subview.send "#{key}=", value
        end

        view.addSubview subview
        if block_given?
          ViewProxy.new(subview).tap do |proxy|
            proxy.blocks << block
            proxy.run_blocks
          end
        end
      end
    end

    def method_missing(method_name, *args, &block)
      if Kernel.constants.include?(method_name.to_sym)
        view_class = Kernel.const_get(method_name.to_s)
        raise "#{view_class.name} is not a known UIView subclass" unless view_class <= UIView
        return subview(view_class, *args, &block)
      else
        raise "#{method_name} is not defined. Should be a subclass of UIView."
      end
    end

    def run_blocks
      blocks.each { |block| self.instance_eval &block }
    end

  end
end
