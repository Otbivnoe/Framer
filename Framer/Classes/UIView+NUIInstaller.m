//
//  UIView+NUIInstaller.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "UIView+NUIInstaller.h"

#import <objc/runtime.h>

@implementation UIView (NUIInstaller)

#pragma mark - Framer

- (void)installFrames:(InstallerBlock)installerBlock {

    [self installFrames:installerBlock forState:@0];
}

- (void)installFrames:(InstallerBlock)installerBlock forState:(nonnull NSNumber *)state {

    [NUIFramer configurateView:self forState:state withInstallerBlock:installerBlock];
}

#pragma mark - Runtime

- (void)setNui_state:(NSNumber *)nui_state {
    
    objc_setAssociatedObject(self, @selector(nui_state), nui_state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)nui_state {

    NSNumber *nui_state = objc_getAssociatedObject(self, @selector(nui_state));
    return (nui_state) ?: @0;
}

@end
