//
//  NUIConfigurateProtocol.h
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

@class NUIFramer;
@protocol NUIConfigurateProtocol <NSObject>

@property (nonatomic, nonnull) Class class;

- (void)additionalConfigurateForFramer:(nonnull NUIFramer *)framer;

@end
