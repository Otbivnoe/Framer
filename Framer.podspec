Pod::Spec.new do |s|
  s.name             = 'Framer'
  s.version          = '1.1'
  s.summary          = 'Comfortable syntax for working with frames'
  s.description      = <<-DESC
Framer is a good framework which wraps working with frames with a nice chaining syntax.
                       DESC

  s.homepage         = 'https://github.com/Otbivnoe/Framer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nikita Ermolenko' => 'nikita.ermolenko@rosberry.com' }
  s.source           = { :git => 'https://github.com/Otbivnoe/Framer.git', :tag => s.version.to_s }
  s.requires_arc     = true

  s.ios.deployment_target = '8.0'
  s.source_files = 'Framer/Classes/*.{h,m}'
end
