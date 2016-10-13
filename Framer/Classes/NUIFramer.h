//
//  NUIFramer.h
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIFramer;

typedef void (^InstallerBlock)(NUIFramer *_Nonnull framer);

@interface NUIFramer : NSObject

NS_ASSUME_NONNULL_BEGIN

/**
 *	Optional semantic property for improvements readability.
 */
- (NUIFramer *)and;

/**
 *  Relation for settings custom width.
 */
- (NUIFramer *(^)(CGFloat width))width;

/**
 *  Relation for settings custom height.
 */
- (NUIFramer *(^)(CGFloat height))height;

/**
 *  Relation for settings custom width with some multiplier.
 *  @param multiplier Additional multiplier configuration.
 */
- (NUIFramer *(^)(UIView *view, CGFloat multiplier))width_to;

/**
 *  Relation for settings custom height with some multiplier.
 *  @param multiplier Additional multiplier configuration.
 */
- (NUIFramer *(^)(UIView *view, CGFloat multiplier))height_to;

/**
 *  Left relation relatively superview.
 *  @param inset Additional inset between self.view and superview.
 */
- (NUIFramer *(^)(CGFloat inset))left;

/**
 *  Top relation relatively superview.
 *  @param inset Additional inset between self.view and superview.
 */
- (NUIFramer *(^)(CGFloat inset))top;

/**
 *  Bottom relation relatively superview.
 *  @param inset Additional inset between self.view and superview.
 */
- (NUIFramer *(^)(CGFloat inset))bottom;

/**
 *  Right relation relatively superview.
 *  @param inset Additional inset between self.view and superview.
 */
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
    Resizes and moves the receiver view so it just encloses its subviews only for width.
 */
- (NUIFramer *(^)())widthToFit;

/**
    Resizes and moves the receiver view so it just encloses its subviews only for height.
 */
- (NUIFramer *(^)())heightToFit;

/**
    Calculate the size that best fits the specified size.
    @param size The size for best-fitting.
 */
- (NUIFramer *(^)(CGSize size))sizeThatFits;

/**
 *	Left relation relatively other view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relation.
 *  @param inset Additional inset between self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))left_to;

/**
 *	Right relation relatively other view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relation.
 *  @param inset Additional inset between self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))right_to;

/**
 *	Top relation relatively other view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relation.
 *  @param inset Additional inset between self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))top_to;

/**
 *	Bottom relation relatively other view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relation.
 *  @param inset Additional inset between self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))bottom_to;

/**
 *	CenterX relation with relatively view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relation.
 *  @param inset Additional inset between center of self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))centerX_to;

/**
 *	CenterY relation with relatively view. Possible to use these methods for superview.
 *  @param view  The view with which you want to add relation.
 *  @param inset Additional inset between center of self.view and other view.
 */
- (NUIFramer *(^)(UIView *view, CGFloat inset))centerY_to;

/**
 *	Just set needed X for center point.
 */
- (NUIFramer *(^)(CGFloat x))centerX;

/**
 *	Just set needed Y for center point.
 */
- (NUIFramer *(^)(CGFloat y))centerY;

/**
 *	CenterX relation relatively superview.
 *  @param inset Additional inset between centerX of self.view and centerX of superview.
 */
- (NUIFramer *(^)(CGFloat inset))super_centerX;

/**
 *	CenterY relation relatively superview.
 *  @param inset Additional inset between centerY of self.view and centerY of superview.
 */
- (NUIFramer *(^)(CGFloat inset))super_centerY;

/**
 *	Configuration method.
 *  @param view The view for which installs relations.
 *  @param installerBlock An installer block within which you can configurate frame relations.
 *  @see -installFrames: (UIView+NUIInstaller.h)
 */
+ (void)configurateView:(UIView *)view withInstallerBlock:(InstallerBlock)installerBlock;
+ (void)configurateView:(UIView *)view forState:(NSNumber *)state withInstallerBlock:(InstallerBlock)installerBlock;

NS_ASSUME_NONNULL_END

@end
