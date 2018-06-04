# # #
# Get gemspec info

gemspec_file = Dir['*.gemspec'].first
gemspec = eval File.read(gemspec_file), binding, gemspec_file
info = "#{gemspec.name} | #{gemspec.version} | " \
       "#{gemspec.runtime_dependencies.size} dependencies | " \
       "#{gemspec.files.size} files"


# # #
# Gem build and install task

desc info
task :gem do
  puts info + "\n\n"
  print "  "; sh "gem build #{gemspec_file}"
  FileUtils.mkdir_p 'pkg'
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", 'pkg'
  puts; sh %{gem install --no-document pkg/#{gemspec.name}-#{gemspec.version}.gem}
end


# # #
# Start an IRB session with the gem loaded

desc "#{gemspec.name} | IRB"
task :irb do
  sh "irb -I ./lib -r #{gemspec.name.gsub '-','/'}"
end

# # #
# Run all specs


desc "#{gemspec.name} | Test"
task :test do
  sh "rspec spec"
end
task :spec => :test
task :default => :test

# # #
# Update index table

namespace :update do
  desc "#{gemspec.name} | Update index"
  task :index do
    require File.dirname(__FILE__) + '/lib/unicode/display_width/index_builder'
    Unicode::DisplayWidth::IndexBuilder.build!
  end
end

# # #
# Update data file

namespace :update do
  desc "#{gemspec.name} | Update unicode data"
  task :data do
    require File.dirname(__FILE__) + '/lib/unicode/display_width/index_builder'
    Unicode::DisplayWidth::IndexBuilder.fetch!
  end
end

