# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def sharedPods
  pod 'Alamofire', '~> 4.9.1'
  pod 'Overture', '~> 0.5.0'
  pod 'ReactiveSwift', '~> 6.2.0'
  pod 'ReactiveCocoa', '~> 10.2.0'
end

def testingPods
  pod 'Quick', '~> 2.2.0'
  pod 'Nimble', '~> 8.0.5'
end

target 'SwiftUIDemo' do
  sharedPods
end

target 'SwiftUIDemoTests' do
  testingPods
  sharedPods
end
