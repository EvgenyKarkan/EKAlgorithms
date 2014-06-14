Pod::Spec.new do |s|
  s.name         = "EKAlgorithms"
  s.version      = "0.1"
  s.summary      = "EKAlgorithms contains some well known CS algorithms and other stuff."
  s.homepage     = "https://github.com/EvgenyKarkan/EKAlgorithms"
  s.license      = "MIT"
  s.authors      = { "Evgeny Karkan" => "https://github.com/EvgenyKarkan" }
  s.source       = { :git => "https://github.com/EvgenyKarkan/EKAlgorithms.git", :tag => "v0.1" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '5.0'
  s.source_files = 'EKAlgorithms/**.{h,m}'
  s.requires_arc = true
end
