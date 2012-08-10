$LOAD_PATH.unshift File.expand_path("lib", __FILE__)
Gem::Specification.new do |s|
  s.name = "with_gc_stats"
  s.summary = "Super simple method for running a block of code with GC stats"
  s.description = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.version = "0.0.1"
  s.author = "Carlo Scarioni"
  s.email = "carlo.scarioni@gmail.com"
  s.homepage = "http://cscarioni.blogspot.com"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.8'
  s.files = Dir['**/**']
  s.test_files = Dir["spec/*_spec.rb"]
  s.has_rdoc = false
  s.require_path     = "lib"
end