//
//  LPGPet.m
//  Phonagotchi
//
//  Created by Sam Meech-Ward on 2018-08-09.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import "LPGPet.h"

@interface LPGPet()

@property (nonatomic) BOOL grumpy;
@property (nonatomic) NSDate *grumpyUntil;

@end

@implementation LPGPet

- (instancetype)init
{
  self = [super init];
  if (self) {
    _grumpy = NO;
    _grumpyUntil = [NSDate date];
  }
  return self;
}

- (void)petWithVelocityX:(double)velocityX velocityY:(double)velocityY {
  if ([self.grumpyUntil timeIntervalSinceNow] > 1) {
    return;
  }
  if (MAX(fabs(velocityX), fabs(velocityY)) > 1000) {
    self.grumpy = YES;
    self.grumpyUntil = [NSDate dateWithTimeIntervalSinceNow:2];
  } else {
    self.grumpy = NO;
  }
}

@end
