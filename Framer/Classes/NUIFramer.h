//
//  NUIFramer.h
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NUIFramer : NSObject

@property (nonatomic, weak) UIView *view;

+ (void)configurateView:(UIView *)view withInstallerBlock:(void(^)(NUIFramer *framer))installerBlock;

- (NUIFramer *(^)(CGFloat))width;
- (NUIFramer *(^)(CGFloat))height;

- (NUIFramer *(^)(CGFloat))left;
- (NUIFramer *(^)(CGFloat))top;
- (NUIFramer *(^)(CGFloat))bottom;
- (NUIFramer *(^)(CGFloat))right;

- (NUIFramer *(^)(UIEdgeInsets))insets;

- (NUIFramer *(^)(UIView *, CGFloat))left_to;
- (NUIFramer *(^)(UIView *, CGFloat))right_to;
- (NUIFramer *(^)(UIView *, CGFloat))top_to;
- (NUIFramer *(^)(UIView *, CGFloat))bottom_to;

- (NUIFramer *(^)(UIView *, CGFloat))centerX_to;
- (NUIFramer *(^)(UIView *, CGFloat))centerY_to;

- (NUIFramer *(^)(CGFloat))super_centerX;
- (NUIFramer *(^)(CGFloat))super_centerY;

- (NUIFramer *)and;

@end
