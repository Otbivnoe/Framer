//
//  UIView+NUIAdditions.h
//  Pods
//
//  Created by Nikita on 19/06/16.
//
//

#import <UIKit/UIKit.h>

/*!
 * @typedef NUIRelationType
 * @brief A list of relations.
 */
typedef NS_ENUM(NSInteger, NUIRelationType) {
    NUIRelationTypeWidth,
    NUIRelationTypeWidthTo,
    NUIRelationTypeHeight,
    NUIRelationTypeHeightTo,
    NUIRelationTypeLeft,
    NUIRelationTypeRight,
    NUIRelationTypeTop,
    NUIRelationTypeBottom,
    NUIRelationTypeCenterX,
    NUIRelationTypeCenterY
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NUIAdditions)

/**
 *  Current relation type for configuration.
 */
@property (nonatomic, readonly) NUIRelationType relationType;

/**
 *	Conveniently properties for setting flexible relations.
 *  @code
            [self.view1 installFrames:^(NUIFramer *framer) {
                framer.width(40).and.height(40);
                framer.centerY_to(self.view2.nui_bottom, 0);
                framer.centerX_to(self.view2.nui_centerX, 0);
            }];
 */
@property (nonatomic, readonly) UIView *nui_width;
@property (nonatomic, readonly) UIView *nui_height;
@property (nonatomic, readonly) UIView *nui_left;
@property (nonatomic, readonly) UIView *nui_right;
@property (nonatomic, readonly) UIView *nui_top;
@property (nonatomic, readonly) UIView *nui_bottom;
@property (nonatomic, readonly) UIView *nui_centerX;
@property (nonatomic, readonly) UIView *nui_centerY;

@end

NS_ASSUME_NONNULL_END
