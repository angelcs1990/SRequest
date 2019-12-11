Pod::Spec.new do |s|
  s.name = "SRequest"
  s.version = "0.1.1"
  s.summary = "\u7F51\u7EDC\u8BF7\u6C42\u7C7B."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"cs"=>"cs"}
  s.homepage = "https://github.com/angelcs1990/SRequest"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/SRequest.framework'
end
