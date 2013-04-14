class UIViewController
  class << self
    def pixate_layout(selector='', &block)
      if block_given?
        pixate_layout.selector = MotionPixateLayout::Selector.new(selector)
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
    Hash[
      view.subviews.select(&:styleId).map do |view|
        [view.styleId, view]
      end
    ].freeze
  end
end
