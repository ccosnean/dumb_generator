Gem::Specification.new do |s|
    s.name        = "dumb_generator"
    s.version     = "0.0.6"
    s.summary     = "A simple scaffolding generator"
    s.description = "This is a simple scaffolding generator. A Copy-Paste tool with some extra features like variable injection, and it intends on remaining like this."
    s.authors     = ["Cristian Cosneanu"]
    s.email       = "cosneanuc@gmail.com"
    s.files       = Dir["{bin,lib}/**/*", "LICENSE", "README.md"]
    s.homepage    = "https://rubygems.org/gems/dumb_generator"
    s.license     = "MIT"

    s.executables << 'dgen'
end