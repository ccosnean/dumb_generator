Gem::Specification.new do |s|
    s.name        = "dumb_generator"
    s.version     = "0.0.1"
    s.summary     = "A simple scaffolding generator"
    s.description = "A simple hello world gem"
    s.authors     = ["Cristian Cosneanu"]
    s.email       = "cosneanuc@gmail.com"
    s.files       = Dir["{bin,lib}/**/*", "LICENSE", "README.md"]
    s.homepage    = "https://rubygems.org/gems/dgen"
    s.license     = "MIT"

    s.executables << 'dgen'
end