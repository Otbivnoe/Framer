//
//  UIView+Installer.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "UIView+Installer.h"
#import "NUIFramer.h"

#import <objc/runtime.h>

@implementation UIView (Installer)

#pragma mark - Framer

- (void)installFrames:(void(^)(NUIFramer *framer))installerBlock {
    
    [NUIFramer configurateView:self withInstallerBlock:installerBlock];
}

@end
