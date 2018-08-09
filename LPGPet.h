//
//  LPGPet.h
//  Phonagotchi
//
//  Created by Sam Meech-Ward on 2018-08-09.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPGPet : NSObject

@property (nonatomic, readonly) BOOL grumpy;

- (void)petWithVelocityX:(double)velocityX velocityY:(double)velocityY;

@end
