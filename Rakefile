begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--format documentation"
  end
  task :default => :spec
rescue LoadError
# ignored
end

task :run do
  ruby "bin/order_my_lunch_runner.rb"
end