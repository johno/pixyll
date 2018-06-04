require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'tests'
  t.pattern = 'tests/test_*.rb'
end

task default: :test
