here = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift File.join(here, 'lib')
$LOAD_PATH.unshift File.join(here, 'test')

desc "Run tests"
task :test do
  require 'tdms'
  require 'test_helper'

  Dir.chdir(File.join(here, 'test')) do
    Dir['**/*_test.rb'].each { |file| require file }
  end
end

task :default => [:test]
