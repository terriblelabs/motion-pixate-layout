module MotionPixateLayout
  class Layout
    attr_accessor :selector

    def <<(block)
      blocks << block
    end

    def each
      blocks.each do |block|
        yield block
      end
    end

    def after
      @_after ||= []
    end

    def before
      @_before ||= []
    end

    def blocks
      @_blocks ||= []
    end
  end

  class Proxy
    attr_reader :view

    def initialize(view)
      @view = view
    end

    def method_missing(method_name, *args)
      if Kernel.constants.include?(method_name.to_sym)
        view_class = Kernel.const_get(method_name.to_s)
        raise "#{view_class.name} is not a known UIView subclass" unless view_class < UIView
        return subview(view_class, *args)
      else
        raise "#{method_name} is not defined. Should be a subclass of UIView."
      end
    end

    def subview(subview_class, selector, attributes = {})
      selector = MotionPixateLayout::Selector.new(selector)

      subview_class.new.tap do |subview|
        subview.styleId = selector.style_id
        subview.styleClass = selector.style_classes.join(" ")

        attributes.each do |key, value|
          subview.send "#{key}=", value
        end

        view.addSubview subview
      end
    end
  end
end
