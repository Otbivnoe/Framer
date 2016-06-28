# Framer

[![CI Status](http://img.shields.io/travis/Nikita Ermolenko/Framer.svg?style=flat)](https://travis-ci.org/Nikita Ermolenko/Framer)
[![Version](https://img.shields.io/cocoapods/v/Framer.svg?style=flat)](http://cocoapods.org/pods/Framer)
[![License](https://img.shields.io/cocoapods/l/Framer.svg?style=flat)](http://cocoapods.org/pods/Framer)
[![Platform](https://img.shields.io/cocoapods/p/Framer.svg?style=flat)](http://cocoapods.org/pods/Framer)

Framer is a great layout framework which wraps manually calculation frames with a nice-chaining syntax.

**Framer is actively maintained.**

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. It has over eighteen thousand libraries and can help you scale your projects elegantly. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

To install Framer, simply add the following line to your Podfile:

```ruby
pod "Framer"
```

then add 
```obj-c
    #import <Framer/Framer.h>
```
# USAGE

##You can configure relations with superview very fast and convenient:

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.top(10).and.bottom(10);
        framer.right(10).and.left(10);
    }];
```

... or just  

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.edges(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
```

For example, you just want to centered subview relative superview with constant width and height. 

So easy to do it with Framer :

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(100).and.height(100);
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
```




##Relation between two views:

![alt Framer](http://i.imgur.com/RoQdI3L.png)

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(100).and.height(100);
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
    
    [self.view2 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(50).and.height(50);
        framer.bottom_to(self.view1.top, 0);
        framer.left_to(self.view1.right, 0);
    }];
```
#NOTE
**That's important to point out relations for two views.**

####Incorrect:

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.bottom_to(self.view1, 0);
    }];
```
####Correct:

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.bottom_to(self.view1.top, 0);
    }];
```




##Container relation:

![alt Framer](http://i.imgur.com/18vDfn1.png)

#NOTE
**At first you should configurate all subviews and then configure container.**

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(200).and.height(200);
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
    
    [self.label1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.top(0).and.left(0);
        framer.sizeToFit();
    }];
    
    [self.label2 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.top_to(self.label1.bottom, 0).and.left(0);
        framer.sizeToFit();
    }];
    
    [self.container installFrames:^(NUIFramer * _Nonnull framer) {
        framer.container();
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
```

## TODO
* Other platforms support
* Swift support
* More tests

## Author

Nikita Ermolenko, nikita.ermolenko@rosberry.com

## License

Framer is available under the MIT license. See the LICENSE file for more info.
