
Pod::Spec.new do |s|

  s.name         = "TwitterLikeButton"
  s.version      = "1.0.3"
  s.summary      = "Twitter's like button animation in Swift"
  s.description  = <<-DESC
                  Twitter's like button animation in Swift - Demo
                   DESC
  s.homepage     = "https://github.com/kevinil/TwitterLikeButton"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "KeviNil" => "liulangsf@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/kevinil/TwitterLikeButton.git", :tag => s.version }
  s.source_files  = "TwitterLikeButton/KevinButton/LikeButton.swift"
  s.resources = "TwitterLikeButton/KevinButton/*.png"
  s.requires_arc = true

end
