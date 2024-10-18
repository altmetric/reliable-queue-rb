Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.7.0'
  s.name        = 'reliable-queue-rb'
  s.version     = '0.4.0'
  s.authors     = ['Anna Klimas', 'Jonathan Hernandez']
  s.email       = ['support@altmetric.com']

  s.summary     = 'Ruby library for reliable queue processing.'
  s.homepage    = 'https://github.com/altmetric/reliable-queue-rb'
  s.license     = 'MIT'

  s.files = Dir['*.{md,txt}', 'lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_dependency 'redis', '>= 5.0.0'
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('house_style')
end
