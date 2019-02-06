drafts_dir = '_drafts'
posts_dir  = '_posts'

# rake post['my new post']
desc 'create a new post with "rake post[\'post title\']"'
task :post, :title do |t, args|
  if args.title
    title = args.title
  else
    puts "Please try again. Remember to include the filename."
  end
  mkdir_p "#{posts_dir}"
  filename = "#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.downcase.gsub(/[^\w]+/, '-')}.md"
  puts "Creating new post: #{filename}"
  File.open(filename, "w") do |f|
    f << <<-EOS.gsub(/^    /, '')
    ---
    layout: post
    title: #{title}
    date: #{Time.new.strftime('%Y-%m-%d %H:%M')}
    categories:
    ---

    EOS
  end

# Uncomment the line below if you want the post to automatically open in your default text editor
#  system ("#{ENV['EDITOR']} #{filename}")
end

# usage: rake draft['my new draft']
desc 'create a new draft post with "rake draft[\'draft title\']"'
task :draft, :title do |t, args|
  if args.title
    title = args.title
  else
    puts "Please try again. Remember to include the filename."
  end
  mkdir_p "#{drafts_dir}"
  filename = "#{drafts_dir}/#{title.downcase.gsub(/[^\w]+/, '-')}.md"
  puts "Creating new draft: #{filename}"
  File.open(filename, "w") do |f|
    f << <<-EOS.gsub(/^    /, '')
    ---
    layout: post
    title: #{title}
    date: #{Time.new.strftime('%Y-%m-%d %H:%M')}
    categories:
    ---

    EOS
  end

# Uncomment the line below if you want the draft to automatically open in your default text editor
# system ("#{ENV['EDITOR']} #{filename}")
end

desc 'preview the site with drafts'
task :preview do
  puts "## Generating site"
  puts "## Stop with ^C ( <CTRL>+C )"
  system "jekyll serve --watch --drafts"
end

# usage: rake undraft['my-file.md']
desc 'publish a draft post with "rake undraft[\'draft-file.md\']"'
task :undraft, :file do |t, args|
  if args.file
    file = args.file
  else
    abort "Please try again. Remember to include the file name."
  end

  draft = "#{drafts_dir}/#{file}"
  unless File.exists?(draft)
    abort "Draft does not exist: #{draft}"
  end

  today = Time.now
  post = "#{posts_dir}/#{today.strftime('%Y-%m-%d')}-#{file}"

  # Slurp file in to memory
  lines = IO.readlines(draft).map do |line|
    dateline = /\s*^date:\s*(.*)\s*$/.match(line)
    if dateline
      puts "Original date of draft: #{dateline[1]}"
      "date: #{today.strftime('%Y-%m-%d %H:%M')}"
    else
      line
    end
  end

  print "Moving #{draft} to #{post}..."
  FileUtils.mv(draft, post)
  puts "done."

  print "Modifying date for post to '#{today.strftime('%Y-%m-%d %H:%M')}'..."
  File.open(post, 'w') do |file|
    file.puts lines
  end
  puts "done."

# Uncomment the line below if you want the post to automatically open in your default text editor
# system ("#{ENV['EDITOR']} #{post}")
end

desc 'list tasks'
task :list do
  puts "Tasks: #{(Rake::Task.tasks - [Rake::Task[:list]]).join(', ')}"
  puts "(type rake -T for more detail)\n\n"
end
