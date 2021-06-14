#
# Be sure to run `pod lib lint SortSnapshot.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SortSnapshot'
  s.version          = '1.7'
  s.summary          = 'Sorting methods for NSDiffableDataSourceSnapshot.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/pookjw/SortSnapshot'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jinwoo Kim' => 'kidjinwoo@me.com' }
  s.source           = { :git => 'https://github.com/pookjw/SortSnapshot.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15.1'
  s.tvos.deployment_target = '13.0'

  s.source_files = 'SortSnapshot/Classes/**/*'
  s.requires_arc = true
  s.swift_version = '4.2'
end
