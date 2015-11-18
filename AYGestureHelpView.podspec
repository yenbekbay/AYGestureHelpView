Pod::Spec.new do |s|
  s.name             = "AYGestureHelpView"
  s.version          = "0.2.0"
  s.summary          = "A view that can show a tutorial for gestures"
  s.homepage         = "https://github.com/yenbekbay/AYGestureHelpView"
  s.license          = 'MIT'
  s.author           = { "Ayan Yenbekbay" => "ayan.yenb@gmail.com" }
  s.source           = { :git => "https://github.com/yenbekbay/AYGestureHelpView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'pop', '~> 1.0'
end
