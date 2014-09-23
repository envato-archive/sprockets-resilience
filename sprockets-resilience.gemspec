Gem::Specification.new do |s|
  s.name = "sprockets-resilience"
  s.version = "0.0.1"
  s.author = "Charlie Somerville"
  s.email = "charlie@charliesomerville.com"
  s.license = "MIT"
  s.homepage = "https://github.com/envato/sprockets-resilience"

  s.summary = "Stops Rails killing an entire site when an asset is not precompiled"
  s.description = "Ever had your entire Rails app die because one tiny little asset slipped through the cracks and wasn't precompiled? You need this gem!"

  s.add_dependency "rails", ">= 3.0", "< 5"
  s.add_development_dependency "minitest", "~> 4"
end
