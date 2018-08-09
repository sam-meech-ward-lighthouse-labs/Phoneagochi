//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "LPGPet.h"

@interface LPGViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) LPGPet *cat;
@property (weak, nonatomic) IBOutlet UIImageView *apple;
@property (nonatomic) UIImageView *currentApple;
@property (nonatomic) UIImageView *petImageView;

@end

@implementation LPGViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupView];
  [self setupGestures];
  [self setupData];
}

# pragma mark - Setup

- (void)setupData {
  self.cat = [[LPGPet alloc] init];
}

- (void)setupGestures {
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(petCat:)];
  [self.petImageView addGestureRecognizer:panGesture];
  
  UIPanGestureRecognizer *applePanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panApple:)];
  [self.apple addGestureRecognizer:applePanGesture];
  applePanGesture.delegate = self;
}

- (void)setupView {
  self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
  
  self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
  self.petImageView.userInteractionEnabled = YES;
  
  [self.view addSubview:self.petImageView];
  [self updateCat];
  
  [NSLayoutConstraint constraintWithItem:self.petImageView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                                constant:0.0].active = YES;
  
  [NSLayoutConstraint constraintWithItem:self.petImageView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                                constant:0.0].active = YES;
}

# pragma mark - Gestures

- (void)petCat:(UIPanGestureRecognizer *)gesture {
  CGPoint velocity = [gesture velocityInView:self.petImageView];
  
  [self.cat petWithVelocityX:velocity.x velocityY:velocity.y];
  [self updateCat];
}

- (IBAction)pinchApple:(UIPinchGestureRecognizer *)sender {
  
  if (self.currentApple) {
    return;
  }
  self.currentApple = [self createNewApple];
  
}

- (void)panApple:(UIPanGestureRecognizer *)gesture {
  CGPoint translation = [gesture translationInView:self.currentApple];
  
  self.currentApple.center = CGPointMake(self.currentApple.center.x + translation.x, self.currentApple.center.y + translation.y);
  
  [gesture setTranslation:CGPointZero inView:self.petImageView];
  
  if (gesture.state == UIGestureRecognizerStateEnded) {
    [UIView animateWithDuration:1.0 animations:^{
      self.currentApple.center = CGPointMake(self.currentApple.center.x, 1000);
    }];
    self.currentApple = nil;
  }
}

# pragma mark - View

- (UIImageView *)createNewApple {
  UIImageView *apple = [[UIImageView alloc] init];
  apple.image = [UIImage imageNamed:@"apple.png"];
  apple.frame = CGRectOffset(self.apple.frame, -10, -20);
//  apple.userInteractionEnabled = YES;
  
  [self.view addSubview:apple];
  
  return apple;
}

- (void)updateCat {
  if (self.cat.grumpy == YES) {
    self.petImageView.image = [UIImage imageNamed:@"grumpy.png"];
  } else {
    self.petImageView.image = [UIImage imageNamed:@"default.png"];
  }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
  return YES;
}

@end
