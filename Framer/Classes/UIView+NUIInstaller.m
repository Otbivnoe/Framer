//
//  UIView+NUIInstaller.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "UIView+NUIInstaller.h"

#import <objc/runtime.h>

@interface UIView (NUIInstaller)

@property (nonatomic, nonnull) NSMutableDictionary <NSNumber *, InstallerBlock> *stateConfigurator;

@end

@implementation UIView (NUIInstaller)

#pragma mark - Framer

- (void)installFrames:(InstallerBlock)installerBlock {

    [self installFrames:installerBlock forState:@0];
}

- (void)installFrames:(InstallerBlock)installerBlock forState:(nonnull NSNumber *)state {
    
    if (!self.stateConfigurator) {
        self.stateConfigurator = [[NSMutableDictionary alloc] init];
    }
    
    [NUIFramer configurateView:self forState:state withInstallerBlock:installerBlock];
}

- (void)applyFrameForState:(nonnull NSNumber *)state {
    
    NSAssert(self.stateConfigurator[state] != nil, @"Configuration block for this state doesn't exist.");
    self.nui_state = state;
    [NUIFramer configurateView:self forState:state withInstallerBlock:self.stateConfigurator[state]];
}

#pragma mark - Runtime

- (void)setStateConfigurator:(NSMutableDictionary<NSNumber *, InstallerBlock> *)stateConfigurator {
    
    objc_setAssociatedObject(self, @selector(stateConfigurator), stateConfigurator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,InstallerBlock> *)stateConfigurator {
    
    return objc_getAssociatedObject(self, @selector(stateConfigurator));
}

- (void)setNui_state:(NSNumber *)nui_state {
    
    objc_setAssociatedObject(self, @selector(nui_state), nui_state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)nui_state {

    NSNumber *nui_state = objc_getAssociatedObject(self, @selector(nui_state));
    return (nui_state) ?: @0;
}

@end
