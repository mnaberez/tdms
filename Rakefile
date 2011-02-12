$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'test')

desc "Run tests"
task :test do
  Dir['test/**/*_test.rb'].each { |file| require file }
end

task :default => [:test]
