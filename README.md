# Framer

[![CI Status](http://img.shields.io/travis/Nikita Ermolenko/Framer.svg?style=flat)](https://travis-ci.org/Nikita Ermolenko/Framer)
[![Version](https://img.shields.io/cocoapods/v/Framer.svg?style=flat)](http://cocoapods.org/pods/Framer)
[![License](https://img.shields.io/cocoapods/l/Framer.svg?style=flat)](http://cocoapods.org/pods/Framer)
[![Platform](https://img.shields.io/cocoapods/p/Framer.svg?style=flat)](http://cocoapods.org/pods/Framer)

Framer is a great layout framework which wraps manually calculation frames with a nice-chaining syntax.

It's also available for *Swift* but with another name -  [Framezilla](https://github.com/Otbivnoe/Framezilla)

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
        framer.bottom_to(self.view1.nui_top, 0);
        framer.left_to(self.view1.nui_right, 0);
    }];
```

... or maybe so? 

![alt Framer](http://i.imgur.com/gGRCOBU.png)

```obj-c
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(100);
        framer.height(100);
        framer.super_centerX(0).and.super_centerY(0);
    }];
    
    [self.view2 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.top(10);
        framer.bottom(10);
        framer.left(10);
        framer.width_to(self.view2.nui_height, 0.5); // height*0.5
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
        framer.bottom_to(self.view1.nui_top, 0);
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
        framer.top_to(self.label1.nui_bottom, 0).and.left(0);
        framer.sizeToFit();
    }];
    
    [self.container installFrames:^(NUIFramer * _Nonnull framer) {
        framer.container();
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
```

##States:

It's very convenient use many states for animations, because you can just configure all states in one place and when needed change frame for view - just apply needed state! Awesome, is'n it?
```obj-c

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    /* Configure frame for '0' state */
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(10);
        framer.height(10);
        framer.super_centerX(0).and.super_centerY(0);
    }];
    
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(40);
        framer.height(40);
        framer.super_centerX(0).and.super_centerY(0);
    } forState:@1];
    
    [self.view1 installFrames:^(NUIFramer * _Nonnull framer) {
        framer.width(100);
        framer.height(100);
        framer.super_centerX(0).and.super_centerY(0);
    } forState:@2];
}
```

set new state and animate it:
```obj-c
/* Next time when viewDidLayoutSubviews will be called, self.view1 configure frame for state 2. */
    self.view1.nui_state = @2;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
```
##Macroses:

```obj-c
    CGFloat width = NUI_WIDTH(view);
    CGFloat midX = NUI_MID_X(view);
```

## Updates:
**v1.4**
* Added macroses for getting width, height etc.

**v1.3**
* Added *centerX* and *centerY* methods for just setting center point. 
* Added *width_to* and *height_to* for configure height/width relatively specific view.

**v1.1**
* Added 'nui' prefix to relations(left, right etc). 
* Added possibility to configure frame for special state.

**v1.0**
* First release version. Configure frame blocks.

## TODO
* Other platforms support
* Swift support
* More tests

## Author

Nikita Ermolenko, nikita.ermolenko@rosberry.com

## License

Framer is available under the MIT license. See the LICENSE file for more info.
