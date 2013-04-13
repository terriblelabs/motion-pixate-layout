require "bundler/gem_tasks"
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
Bundler.setup
Bundler.require

require 'motion-pixate'

Motion::Project::App.setup do |app|
  app.name = 'testSuite'
  app.identifier = 'com.terriblelabs.motionPixateLayout.testSuite'

  app.pixate.framework = 'vendor/PXEngine.framework'
end
