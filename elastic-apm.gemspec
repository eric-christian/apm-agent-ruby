lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastic_apm/version'

Gem::Specification.new do |spec|
  spec.name          = 'particles-elastic-apm'
  spec.version       = ElasticAPM::VERSION
  spec.authors       = ['Mikkel Malmberg', 'Eric Koch']
  spec.email         = ['mikkel@elastic.co', 'eric.koch@sumcumo.com']

  spec.summary       = 'The official Elastic APM agent for Ruby - Forked for particles (temporarily)'
  spec.homepage      = 'https://github.com/eric-christian/apm-agent-ruby'
  spec.metadata     = { 'source_code_uri' => 'https://github.com/eric-christian/apm-agent-ruby' }
  spec.license       = 'Apache-2.0'
  spec.required_ruby_version = ">= 2.3.0"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://gems.sumcumo.net'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency('concurrent-ruby', '~> 1.0')
  spec.add_dependency('http', '>= 3.0')

  spec.require_paths = ['lib']
end
