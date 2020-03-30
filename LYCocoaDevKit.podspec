Pod::Spec.new do |s|
s.name         = 'LYCocoaDevKit'
s.version      = '1.0.3'
s.summary      = 'awesome develop kit for cocoa coding !'
s.homepage     = 'https://github.com/zhangliyong1024/LYCocoaDevKit'
s.license      = 'MIT'
s.authors      = { "zhangliyong" => "zhangliyong1997@gmail.com" }
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/zhangliyong1024/LYCocoaDevKit.git', :tag => s.version}
s.source_files = 'LYCocoaDevKit/LYCocoaDevKit/**/*.{h,m}'
s.requires_arc = true

s.dependency 'SDWebImage'
s.dependency 'NYXImagesKit'

end

