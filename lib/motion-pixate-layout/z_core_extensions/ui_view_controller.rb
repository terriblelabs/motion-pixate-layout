class UIViewController
  class << self
    def pixate_layout(selector='', attributes={}, &block)
      if block_given?
        pixate_layout.selector = MotionPixateLayout::Selector.new(selector)
        pixate_layout.view_attributes = attributes
        pixate_layout.blocks << block
      else
        @_pixate_layout ||= MotionPixateLayout::Layout.new
      end
    end

    def after_pixate_layout(&block)
      pixate_layout.after << block
    end

    def before_pixate_layout(&block)
      pixate_layout.before << block
    end
  end

  def pixate_layout
    self.class.pixate_layout
  end

  def viewDidLoad
    MotionPixateLayout::Proxy.new(self).run
  end

  def subviews
    @subviews_hash ||= SubviewHash.new(view)
  end

  class SubviewHash
    attr_reader :view

    def initialize(view)
      @view = view
    end

    def [](key)
      hash[key] ||= current_hash[key]
    end

    private

    def hash
      @hash ||= current_hash
    end

    def current_hash
      Hash[
        view.subviews.select(&:styleId).map { |view| [view.styleId, view] }
      ]
    end
  end
end
