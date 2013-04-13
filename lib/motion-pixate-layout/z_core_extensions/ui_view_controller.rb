class UIViewController
  class << self
    def pixate_layout(selector='', &block)
      if block_given?
        pixate_layout.selector = MotionPixateLayout::Selector.new(selector)
        pixate_layout << block
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
    if pixate_layout.selector
      view.styleId = pixate_layout.selector.style_id
      view.styleClass = pixate_layout.selector.style_classes.join(' ')
    end

    proxy = MotionPixateLayout::Proxy.new(view)

    pixate_layout.before.each do |block|
      instance_eval &block
    end

    pixate_layout.each do |block|
      proxy.instance_eval &block
    end

    view.updateStyles

    pixate_layout.after.each do |block|
      instance_eval &block
    end
  end

  def subviews
    Hash[
      view.subviews.select(&:styleId).map do |view|
        [view.styleId, view]
      end
    ].freeze
  end
end
