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

- (NUIFramer *)and;

/**
 *	Edges relations for superview
 */
- (NUIFramer *(^)(CGFloat))width;
- (NUIFramer *(^)(CGFloat))height;

- (NUIFramer *(^)(CGFloat inset))left;
- (NUIFramer *(^)(CGFloat inset))top;
- (NUIFramer *(^)(CGFloat inset))bottom;
- (NUIFramer *(^)(CGFloat inset))right;

- (NUIFramer *(^)(UIEdgeInsets insets))edges;




- (NUIFramer *(^)(UIView *, CGFloat))left_to;
- (NUIFramer *(^)(UIView *, CGFloat))right_to;
- (NUIFramer *(^)(UIView *, CGFloat))top_to;
- (NUIFramer *(^)(UIView *, CGFloat))bottom_to;

/**
 *	Center relations with other view
 */
- (NUIFramer *(^)(UIView *, CGFloat))centerX_to;
- (NUIFramer *(^)(UIView *, CGFloat))centerY_to;

/**
 *	Center relations with superview
 */
- (NUIFramer *(^)(CGFloat))super_centerX;
- (NUIFramer *(^)(CGFloat))super_centerY;

@end
