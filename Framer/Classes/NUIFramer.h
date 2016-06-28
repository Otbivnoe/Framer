//
//  NUIFramer.h
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NUIFramer : NSObject

NS_ASSUME_NONNULL_BEGIN

/**
 *	Optional semantic property for improvements readability.
 */
- (NUIFramer *)and;

/**
 *  Relations for settings custom width and height.
 */
- (NUIFramer *(^)(CGFloat width))width;
- (NUIFramer *(^)(CGFloat height))height;

/**
 *  Edges relations relatively superview.
 *  @param inset Additional inset between self.view and superview.
 */
- (NUIFramer *(^)(CGFloat inset))left;
- (NUIFramer *(^)(CGFloat inset))top;
- (NUIFramer *(^)(CGFloat inset))bottom;
- (NUIFramer *(^)(CGFloat inset))right;

/**
 *  Conveniently edges relations for setting left / right/ top / bottom in one method.
 *  @params edges Edges between view and superview.
 */
- (NUIFramer *(^)(UIEdgeInsets insets))edges;

/**
 *  Configure wrapped frame by all subviews.
 *  @warning You should not use 'bottom' and 'right' (relatively superview) configurations by subviews.
 */
- (NUIFramer *(^)())container;

/**
    Resizes and moves the receiver view so it just encloses its subviews.
    @see -sizeToFit method (UIKit)
 */
- (NUIFramer *(^)())sizeToFit;

/**
    Calculate the size that best fits the specified size.
    @param size The size for best-fitting
 */
- (NUIFramer *(^)(CGSize size))sizeThatFits;

/**
 *	Edges relations relatively other view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relations.
 *  @param inset Additional inset between self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))left_to;
- (NUIFramer *(^)(UIView *view, CGFloat inset))right_to;
- (NUIFramer *(^)(UIView *view, CGFloat inset))top_to;
- (NUIFramer *(^)(UIView *view, CGFloat inset))bottom_to;

/**
 *	Center relations with relatively view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relations.
 *  @param inset Additional inset between center of self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))centerX_to;
- (NUIFramer *(^)(UIView *view, CGFloat inset))centerY_to;

/**
 *	Center relations relatively superview.
 *  @param inset Additional inset between center of self.view and center of superview.
 */
- (NUIFramer *(^)(CGFloat inset))super_centerX;
- (NUIFramer *(^)(CGFloat inset))super_centerY;

/**
 *	Configuration method.
 *  @param view The view for which installs relations.
 *  @param installerBlock An installer block within which you can configurate frame relations.
 *  @see -installFrames: (UIView+NUIInstaller.h)
 */
+ (void)configurateView:(UIView *)view withInstallerBlock:(void(^)(NUIFramer *framer))installerBlock;

NS_ASSUME_NONNULL_END

@end
