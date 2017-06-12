require 'opal'

Dir['src/*.rb'].each { |rb_file|
  desc "Build and run #{rb_file}"
  basename = File.basename(rb_file, '.rb')
  task basename do
    puts "Building #{basename}"
    system "opal -rconsole -Ec #{rb_file} > #{basename}.js"
    puts "\trunning"
    system 'say running'
    system "node #{basename}.js"
  end
}
