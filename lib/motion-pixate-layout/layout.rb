module MotionPixateLayout
  class Layout
    attr_accessor :selector
    attr_reader :after, :before, :blocks

    def initialize
      @before = []
      @after = []
      @blocks = []
    end
  end
end
