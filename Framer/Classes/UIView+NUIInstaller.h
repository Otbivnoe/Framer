//
//  UIView+NUIInstaller.h
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIFramer;
@interface UIView (NUIInstaller)

/**
 *  Creates and configurates NUIFramer object for each view.
 *  @param installerBlock An installer block within which you can configurate frame relations.
 */
- (void)installFrames:(void(^)(NUIFramer *framer))installerBlock;

@end
