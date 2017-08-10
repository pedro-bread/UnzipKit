Pod::Spec.new do |s|
  s.name             = "UnzipKit"
  s.version          = ENV["TRAVIS_TAG"]
  s.summary          = "An Objective-C zlib wrapper for compressing and decompressing Zip files"
  s.license          = "BSD"
  s.homepage         = "https://github.com/abbeycode/UnzipKit"
  s.author           = { "Dov Frankel" => "dov@abbey-code.com" }
  s.social_media_url = "https://twitter.com/dovfrankel"
  s.source           = { :git => "https://github.com/abbeycode/UnzipKit.git", :tag => "#{s.version}" }
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.requires_arc = 'Source/**/*'
  s.public_header_files  = "Source/UnzipKit.h",
                           "Source/UZKArchive.h",
                           "Source/UZKFileInfo.h"
  s.private_header_files = "Source/UZKFileInfo_Private.h",
                           "Lib/**/*.h"
  s.source_files         = "Source/**/*.{m,h}",
                           "Lib/**/*.{c,h}"
  s.exclude_files        = 'Resources/**/Info.plist'
  s.resource_bundles = {
      'UnzipKitResources' => ['Resources/**/*']
  }
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/*.{h,m}'
    test_spec.exclude_files = 'Tests/ExtractFilesTests.m'
    test_spec.resources = ['Tests/Test Data']
  end
  s.library = "z"
end
