# TwitterLikeButton
Twitter like button animation in swift

## Usage

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!
pod 'TwitterLikeButton', '~> 1.0.2'
```
## PictureResource

- Pods/TwitterLikeButton/TwitterLikeButton/*.png    (unlike.png & like.png)

```ruby
let iv = KevinButton(frame: CGRectMake(100, 100, 100, 100))
iv.initialImage = UIImage(named: "unlike")
iv.selectedImage = UIImage(named: "like")
view.addSubview(iv)
```
