Pod::Spec.new do |s|
  s.name             = "SSToastView"
  s.version          = "1.0"
  s.summary          = "Toast for iOS."
  s.homepage         = "https://github.com/shingwasix/SSToastView"
  s.license          = 'MIT'
  s.author           = { "Shingwa Six" => "https://github.com/shingwasix" }
  s.source           = { :git => "https://github.com/shingwasix/SSToastView.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
