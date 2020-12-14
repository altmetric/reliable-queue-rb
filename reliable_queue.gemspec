Gem::Specification.new do |s|
  s.name        = 'reliable-queue-rb'
  s.version     = '0.1.0'
  s.authors     = ['Anna Klimas','Jonathan Hernandez']
  s.email       = ['support@altmetric.com']

  s.summary     = "Ruby library for reliable queue processing."
  s.homepage      = 'https://github.com/altmetric/reliable-queue-rb'
  s.license     = "MIT"

  s.files = Dir['*.{md,txt}', 'lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_dependency 'redis', '~> 3.3'
  s.add_development_dependency('rake', '~> 10.0')
  s.add_development_dependency('rspec', '~> 3.10')
end
