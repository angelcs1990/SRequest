Pod::Spec.new do |s|
  s.name = "SRequest"
  s.version = "0.1.0"
  s.summary = "\u{7f51}\u{7edc}\u{8bf7}\u{6c42}\u{7c7b}."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"cs"=>"cs"}
  s.homepage = "https://github.com/angelcs1990/SRequest"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/SRequest.framework'
end
