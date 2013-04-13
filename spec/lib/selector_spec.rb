describe 'Selector' do
  before do
    @selector = MotionPixateLayout::Selector.new('#some-id.class1.class2')
  end

  describe '.style_classes' do
    it 'returns an array of the parsed classes from the selector' do
      @selector.style_classes.should == %w[class1 class2]
    end
  end

  describe '.style_id' do
    it "returns the id parsed from the selector" do
      @selector.style_id.should == 'some-id'
    end
  end
end
