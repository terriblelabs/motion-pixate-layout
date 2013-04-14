# MotionPixateLayout

![Build Status of master branch](https://travis-ci.org/terriblelabs/motion-pixate-layout.png?branch=master)

This project adds a simple DSL to your Rubymotion UIViewControllers to create subviews to be styled with [Pixate](http://www.pixate.com/).

The idea is inspired by [Teacup](https://github.com/rubymotion/teacup), which has an awesome layout/subview DSL for laying out your controllers.  While this DSL is great, Teacup brings in a lot of style/stylesheet features that are not useful to Pixate users.  MotionPixateLayout also adds a convenient shorthand selector to quickly set the styleId and styleClass of subviews.

## A quick example

````ruby
class MyViewController < UIViewController
  pixate_layout '#my-view.fancy' do
    UILabel '#title-label.small.green', text: 'My Title'
    UIButton '#ok-button.call-to-action'
  end
end
````

This code hooks into UIViewController's `viewDidLoad` mode and:

1. Sets `view.styleId` to 'my-view'
1. Sets `view.styleClass` to 'fancy'
1. Adds a UILabel with these attributes as a subview of the controller's view:
    * styleId: 'title-label'
    * styleClass: 'small green'
    * text: 'My Title'
1. Adds a UIButton with these attributes as a subview of the controller's view:
    * styleId: 'ok-button'
    * styleClass: 'call-to-action'

## Accessing subviews

MotionPixateLayout adds a `subviews` accessor to UIViewController that returns a hash of the controller's main view's subviews, where the keys are the styleId of the subview. To set the text of the title-label in the above example, we can access the subview by its id:

````ruby
class MyViewController < UIViewController
  # pixate_layout { ... }

  def update_label_text
    subviews['title-label'].text = 'An updated title'
  end
end
````

## Context and lifecycle

Be aware that inside the pixate_layout block is instance_eval'ed in the context of a proxy object, so you can't call methods on or add instance variables to your controller there.  MotionPixateLayout adds 2 lifecycle hooks, `before_pixate_layout` and `after_pixate_layout` that execute in the context of your controller instance before and after the layout block, respectively.


````ruby
class MyViewController < UIViewController
  pixate_layout do
    @layout = true # Does not set an instance variable in controller
  end

  before_pixate_layout do
    @layout = true # sets @layout instance variable in controller
  end

  after_pixate_layout do
    @layout = true # sets @layout instance variable in controller
  end
end
````

## Installation

If you're using Bundler, just add `gem 'motion-pixate-layout'` to your Gemfile, and `bundle install`.

Make sure you've vendored the Pixate framework and [set up motion-pixate](https://github.com/Pixate/RubyMotion-Pixate#setup).

## To-do

* Generalize to work with NUI in addition to Pixate (rename?)
* More examples

## Suggestions? Comments?

I'd love some.

## Contributions

Are welcome. Please fork and submit a pull request with some specs.
