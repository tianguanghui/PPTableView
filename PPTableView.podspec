Pod::Spec.new do |s|
  s.name         = "PPTableView"
  s.version      = "1.0.0"
  s.summary      = ""
  s.description  = ""

  s.homepage     = "https://github.com/DSKcpp/PPTableView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "DSKcpp" => "dskcpp@gmail.com" }

  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/DSKcpp/PPTableView.git", :tag => s.version }

  s.frameworks   = "Foundation", "UIKit"

  s.source_files = "Classes/*.{h,m}"
end