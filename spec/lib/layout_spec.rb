describe "MotionPixateLayout::Layout" do
  describe "UIViewController Extensions" do
    describe "pixate_layout" do
      class TestViewController < UIViewController
        attr_reader :before_called

        before_pixate_layout do
          @before_called = true
        end

        pixate_layout '#view-id.view-class.view-class-2', accessibilityLabel: 'main view' do
          UILabel '#style-id.class1.class2', text: 'Test Label'
          UIView '#subview' do
            UILabel '#grandchild' do
              UIButton '#great_grandchild'
            end
          end
        end

        after_pixate_layout do
          subviews['style-id'].accessibilityLabel = 'Set after pixate layout'
        end
      end

      tests TestViewController

      it 'recursively adds subviews supplied in blocks' do

        controller.subviews['subview'].subviews.size.should == 1
        controller.subviews['subview'].subviews.first.tap do |grandchild|
          grandchild.styleId.should == 'grandchild'
          grandchild.should.be.kind_of UILabel
          grandchild.subviews.size.should == 1
          grandchild.subviews.first.styleId.should == 'great_grandchild'
        end
      end

      it "is added to UIViewController" do
        UIViewController.should.respond_to :pixate_layout
      end

      it 'calls mutators for hash parameters' do
        controller.view.accessibilityLabel.should == 'main view'
      end

      it 'sets the style id of its view from the selector' do
        controller.view.styleId.should == 'view-id'
      end

      it 'sets the style class of its view from the selector' do
        controller.view.styleClass.should == 'view-class view-class-2'
      end

      it "adds subviews that are specified in its block" do
        controller.view.subviews.size.should == 2
      end

      it "assigns the styleID from subview selectors" do
        controller.view.subviews.first.styleId.should == 'style-id'
      end

      it 'assigns the styleClass from subview selectors' do
        controller.view.subviews.first.styleClass.should == 'class1 class2'
      end

      it 'exposes subviews via their styldId' do
        controller.subviews['style-id'].should.be.kind_of UILabel
      end

      it 'calls the before_pixate_layout blocks' do
        controller.before_called.should.be.true
      end

      it 'calls the after_pixate_layout blocks' do
        controller.subviews['style-id'].accessibilityLabel.should == 'Set after pixate layout'
      end
    end
  end
end
