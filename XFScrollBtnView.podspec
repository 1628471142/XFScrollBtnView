
Pod::Spec.new do |s|

  s.name         = "XFScrollBtnView"
  s.version      = "1.0.0"
  s.summary      = "Quickly create Jingdong category selection button style"
  s.description  = "It helps you quickly create a Jingdong category selection style and is highly customizable."
  s.homepage     = "https://github.com/1628471142/XFScrollBtnView"
  s.license      = "MIT"
  s.author       = { "Mnid" => "953894805@qq.com" }
  s.source       = { :git => "https://github.com/1628471142/XFScrollBtnView.git", :tag => "s.version" }
  s.source_files  = "XFScrollBtnViewDemo/XFScrollBtnView/**/*.{h,m}"
  s.platform      = :ios
  s.framework  = "UIKit"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'


end
