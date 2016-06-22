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
 *  Example 
            [self.view1 installFrames:^(NUIFramer *framer) {
                framer.width(40).and.height(40);
                framer.centerY_to(self.view2.bottom, 0);
                framer.centerX_to(self.view2.centerX, 0);
            }];
 */
@property (nonatomic, readonly) UIView *left;
@property (nonatomic, readonly) UIView *right;
@property (nonatomic, readonly) UIView *top;
@property (nonatomic, readonly) UIView *bottom;
@property (nonatomic, readonly) UIView *centerX;
@property (nonatomic, readonly) UIView *centerY;

@end

NS_ASSUME_NONNULL_END