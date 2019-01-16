Pod::Spec.new do |s|

# pod lib lint
# pod trunk push AXKit.podspec

  s.name = "AXKit"
  s.version = "0.3.7"
  s.summary = "这是一个综合型开发工具包，包含对系统类的功能扩展和一些常用控件的封装。"
  s.homepage = "http://xaoxuu.com"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { "xaoxuu" => "xaoxuu@gmail.com" }
  s.platform = :ios, "8.0"
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
