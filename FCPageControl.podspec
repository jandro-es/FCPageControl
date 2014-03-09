Pod::Spec.new do |s|
  s.name = "FCPageControl"
  s.version = "0.0.3"
  s.license = { :type => 'Apache', :file => 'LICENCE.md' }
  s.summary = "Lightweight, customisable replacement for UIPageControl"
  s.homepage = "https://github.com/nicklockwood/iCarousel"
  s.authors = { "Alejandro Barros Cuetos" => "jandrob1978@gmail.com" }
  s.social_media_url = 'https://twitter.com/jandro_es'
  s.source = { :git => "https://github.com/jandro-es/FCPageControl.git", :tag => "0.0.3" }
  s.source_files = 'FCPageControl'
  s.requires_arc = true
  s.ios.deployment_target = '6.0'
end