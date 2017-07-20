Pod::Spec.new do |s|

# pod trunk push AXKit.podspec

  s.name         = "AXKit"
  s.version      = "0.0.12"
  s.summary      = "系统类的功能扩展和一些常用的控件封装，综合型开发工具包。"
  s.description  = <<-DESC
                   系统类的功能扩展和一些常用的控件封装，综合型开发工具包。详情请访问官方主页：https://axkit.xaoxuu.com。
                   DESC
  s.homepage     = "http://xaoxuu.com/axkit"
  s.license      = "MIT"
  s.author       = { "xaoxuu" => "xaoxuu@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'
  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/xaoxuu/AXKit.git", :tag => "#{s.version}", :submodules => true}

  # s.source_files  = "AXKit/**/*.{h,m}"
  s.public_header_files = 'AXKit/**/*.{h}'
  s.source_files = 'AXKit/**/*.{h,m}'

  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = 'AXKit/**/*.{h}'

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  s.resources = "AXKit/*.{bundle}"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.frameworks = "Foundation", "UIKit", 'QuartzCore', 'CoreGraphics'
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
