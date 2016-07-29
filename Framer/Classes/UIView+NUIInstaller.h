//
//  UIView+NUIInstaller.h
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUIFramer.h"

@interface UIView (NUIInstaller)

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, readonly) NSMutableDictionary <NSNumber *, InstallerBlock> *stateConfigurator;

/*
    Apply new configuration state without frame updating.
 */
@property (nonatomic) NSNumber *state;

/**
 *  Creates and configurates NUIFramer object for each view.
 *  @param installerBlock An installer block within which you can configurate frame relations.
 */
- (void)installFrames:(InstallerBlock)installerBlock;
- (void)installFrames:(InstallerBlock)installerBlock forState:(NSNumber *)state;

/*
 * Configure frame for current state immediately.
 * @param state A state for which applies 'installer block'.
 */
- (void)applyFrameForState:(NSNumber *)state;

NS_ASSUME_NONNULL_END

@end
