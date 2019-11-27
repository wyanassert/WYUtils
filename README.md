# WYUtils

[![Version](https://img.shields.io/cocoapods/v/WYUtils.svg?style=flat)](https://cocoapods.org/pods/WYUtils)
[![License](https://img.shields.io/cocoapods/l/WYUtils.svg?style=flat)](https://cocoapods.org/pods/WYUtils)
[![Platform](https://img.shields.io/cocoapods/p/WYUtils.svg?style=flat)](https://cocoapods.org/pods/WYUtils)

### Run Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
git clone https://github.com/wyanassert/WYUtils
cd Example/
pod install
open WYUtils.xcworkspace
```

### Installation

WYUtils is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'WYUtils'
```

### Overview
```
── WYUtils
── Macro
   ── WYMacroHeader
   ── WYSerializeKit
── NSData
   ── NSData+WYBase64
   ── NSData+WYEncrypt
   ── NSData+WYHexString
   ── NSData+WYUtils
── NSDate
   ── NSDate+WYExtension
   ── NSDate+WYUtils
── NSObject
   ── NSObject+WYUtils
   ── WYNumberConvert
── NSOperation
   ── WYSyncOperation
   ── WYSyncTaskManager
   ── WYSyncToken
── NSString
   ── NSString+WYBase64
   ── NSString+WYDecimal
   ── NSString+WYEncrypt
   ── NSString+WYHighLightColor
   ── NSString+WYMd5
   ── NSString+WYSuffix
   ── NSString+WYURLEncode
   ── NSString+WYUtils
── UIColor
   ── UIColor+WYHexString
   ── UIColor+WYUtils
── UIDevice
   ── UIDevice+WYUtils
── UIFont
   ── UIFont+WYAllFonts
   ── UIFont+WYUtils
── UIImage
   ── UIImage+WYBlur
   ── UIImage+WYCache
   ── UIImage+WYColor
   ── UIImage+WYMask
   ── UIImage+WYOrientation
   ── UIImage+WYShrink
   ── UIImage+WYSpilteNine
   ── UIImage+WYUtils
── UILabel
   ── UILabel+WYUtils
   ── WYBorderLabel
── UINavigationBar
   ── UINavigationBar+WYBottomBorderColor
   ── UINavigationBar+WYUtils
── UIView
   ── UIView+WYCorner
   ── UIView+WYGestureRecognizer
   ── UIView+WYRenderImage
   ── UIView+WYSubView
   ── UIView+WYUtils
   ── WYDisplayImageView
   ── WYExchangeWidgetView
   ── WYMaskView
   ── WYNotHintView
   ── WYPageControl
   ── WYStickerView
```

### Extra 
Because some code may require for System permissions such as Camera roll, so I place these code in Gist.

* [Share & Save ](https://gist.github.com/wyanassert/a01f693a49efaf15020d940803528c71)
* [UIImagePicker](https://gist.github.com/wyanassert/b098c5c2849492c6b1dab9d391598952)

### Author

wyanassert, wyanassert@gmail.com

### License

WYUtils is available under the MIT license. See the LICENSE file for more info.
