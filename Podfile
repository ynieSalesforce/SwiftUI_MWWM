# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def sharedPods
  pod 'Alamofire'
  pod 'Overture'
  pod 'ReactiveSwift'
  pod 'ReactiveCocoa'
end

def testingPods
  pod 'Quick'
  pod 'Nimble'
end

target 'SwiftUIDemo' do
  sharedPods
end

target 'SwiftUIDemoTests' do
  testingPods
  sharedPods
end
