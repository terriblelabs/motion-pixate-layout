module MotionPixateLayout
  class Selector
    attr_reader :string
    CLASS_PATTERN = (/\.([^#\.\s]+)/)
    ID_PATTERN = (/#([^#\.\s]+)/)

    def initialize(string)
      @string = string
    end

    def style_classes
      @_classes ||= string.scan(CLASS_PATTERN).flatten
    end

    def style_id
      @_style_id ||= string.scan(ID_PATTERN).flatten.first
    end
  end
end
