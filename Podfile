# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

# 忽略引入库的所有警告
inhibit_all_warnings!

target 'typecho' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for typecho
  pod 'wpxmlrpc'
  pod 'CYLTabBarController'
  pod 'AFNetworking'
  pod 'R.objc'
  pod 'MJExtension'
  
  # 加入WoodPecker工具框架 (查看沙盒,网络请求等. 只在Debug模式生效)
  pod 'WoodPeckeriOS', :configurations => ['Debug']
end
