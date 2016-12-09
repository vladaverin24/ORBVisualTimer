//
//  ViewController.m
//  ORBVisualTimerDemo
//
//  Created by Vladislav Averin on 29/11/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import "ViewController.h"
#import "ORBVisualTimer.h"

@interface ViewController () <ORBVisualTimerDelegate>

@end

@implementation ViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self minimalDemo];
    [self comprehensiveDemo];
}

#pragma mark - Demo cases

- (void)minimalDemo {
    /* Required minimum */
    ORBVisualTimerBar *barTimer = (ORBVisualTimerBar *)[ORBVisualTimer timerWithStyle:ORBVisualTimerStyleBar frame:CGRectMake(0, 0, self.view.bounds.size.width * 0.8, 200) timeRemaining:8.0f];
    barTimer.center = self.view.center;
    barTimer.delegate = self;
    
    /* Further customizations */
    
    barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleReflection;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[barTimer stopAndHide];
        
        barTimer.backgroundViewColor = [UIColor darkGrayColor];
        barTimer.backgroundViewCornerRadius = 20.0f;
        barTimer.timerShapeInactiveColor = [UIColor lightGrayColor];
        barTimer.timerShapeActiveColor = [UIColor orangeColor];
        barTimer.timerLabelColor = [UIColor orangeColor];
        barTimer.showTimerLabel = YES;
        barTimer.autohideWhenFired = NO;
        barTimer.barCapStyle = kCALineCapSquare;
        barTimer.barThickness = 100.0f;
        barTimer.barPadding = 60.0f;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(111.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            barTimer.showTimerLabel = YES;
            [barTimer stopTimerView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(111.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                barTimer.showTimerLabel = NO;
            });
        });
    });
    
    /* Optionally we can add observer to track exact time remaining */
    [barTimer addObserver:self forKeyPath:@"timeRemaining"
                  options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    /* Kickstarting timer */
    
    [self.view addSubview:barTimer];
    [barTimer start];
}

- (void)comprehensiveDemo {
    NSUInteger numOfBars = 3;
    CGFloat availableHeight = self.view.bounds.size.height / 3 + 20 * (numOfBars - 1);
    CGFloat maxBarHeight = availableHeight / numOfBars;
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                 self.view.bounds.size.width, availableHeight)];
    container.center = self.view.center;
    [self.view addSubview:container];
    
    for (NSUInteger i = 0; i < numOfBars; i++) {
        CGRect barFrame = CGRectMake(10,
                                     0 + (maxBarHeight + 20) * i,
                                     container.bounds.size.width - 20,
                                     maxBarHeight);
        
        ORBVisualTimerBar *barTimer = (ORBVisualTimerBar *)[ORBVisualTimer timerWithStyle:ORBVisualTimerStyleBar frame:barFrame timeRemaining:(5.0f * (i+1))];
        
        barTimer.delegate = self;
        
        barTimer.tag = i;
        
        switch (i) {
            case 0: {
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleStraight;
                
                barTimer.backgroundViewColor = [UIColor darkGrayColor];
                barTimer.backgroundViewCornerRadius = 20.0f;
                barTimer.timerShapeInactiveColor = [UIColor lightGrayColor];
                barTimer.timerShapeActiveColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.3f alpha:0.8f];
                barTimer.timerLabelColor = [UIColor whiteColor];
                //barTimer.showTimerLabel = NO;
                //barTimer.autohideWhenFired = YES;
                //barTimer.barCapStyle = kCALineCapSquare;
                barTimer.barThickness = 20.0f;
                barTimer.barPadding = 20.0f;
                
                break;
            }
                
            case 1: {
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleReflection;
                
                barTimer.backgroundViewColor = [UIColor colorWithWhite:0.9 alpha:0.9f];
                //barTimer.backgroundViewCornerRadius = 20.0f;
                barTimer.timerShapeInactiveColor = [UIColor whiteColor];
                barTimer.timerShapeActiveColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.9f alpha:0.2f];
                //barTimer.timerLabelColor = [UIColor whiteColor];
                barTimer.showTimerLabel = NO;
                //barTimer.autohideWhenFired = YES;
                barTimer.barCapStyle = kCALineCapSquare;
                barTimer.barThickness = 60.0f;
                barTimer.barPadding = 50.0f;
                
                break;
            }
                
            case 2: {
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleBackwards;
                
                int random = ((int)(5.0f * (i+1)) % 2) + 1;
                NSString *pattern = [NSString stringWithFormat:@"pattern_%i", random];
                
                barTimer.timerShapeInactiveColor = [UIColor colorWithPatternImage:
                                               [UIImage imageNamed:pattern]];
                barTimer.timerShapeActiveColor = [UIColor colorWithPatternImage:
                                                    [UIImage imageNamed:@"pattern_3"]];
                
                barTimer.backgroundViewColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1.0f];
                barTimer.backgroundViewCornerRadius = 50.0f;
                //barTimer.timerLabelColor = [UIColor whiteColor];
                barTimer.showTimerLabel = NO;
                //barTimer.autohideWhenFired = YES;
                //barTimer.barCapStyle = kCALineCapSquare;
                barTimer.barThickness = 60.0f;
                barTimer.barPadding = 50.0f;
                
                break;
            }
                
            default:
                break;
        }
        
        [barTimer addObserver:self forKeyPath:@"timeRemaining"
                      options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [container addSubview:barTimer];
        [barTimer start];
    }
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    ORBVisualTimerBar *bar = (ORBVisualTimerBar *)object;
    
    if ([keyPath isEqualToString:@"timeRemaining"] && [bar timerIsActive]) {
        CGFloat timeRemaining = [[change valueForKey:NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"Time remaining: %.1f", timeRemaining);
        
        switch (bar.tag) {
            case 0: {
                if (timeRemaining <= 3) {
                    UIColor *barLabelColor = bar.timerLabelColor;
                    bar.timerLabelColor = [UIColor redColor];
                    
                    UIColor *barColor = bar.timerShapeActiveColor;
                    bar.timerShapeActiveColor = [UIColor redColor];
                    
                    CGFloat barThickness = bar.barThickness;
                    bar.barThickness += 4.0f;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        bar.timerLabelColor = barLabelColor;
                        bar.timerShapeActiveColor = barColor;
                        bar.barThickness = barThickness;
                        
                        if (timeRemaining <= 0) {
                            bar.timerShapeInactiveColor = [UIColor redColor];
                            bar.barThickness += 10.0f;
                            bar.barPadding += 20.0f;
                        }
                    });
                }
                
                break;
            }
                
            case 1: {
                CGFloat hue = ( arc4random() % 256 / 256.0 );
                CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
                CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
                UIColor *color = [UIColor colorWithHue:hue
                                            saturation:saturation
                                            brightness:brightness alpha:1];
                
                bar.timerShapeActiveColor = color;
                
                if (timeRemaining <= 0) {
                    bar.backgroundViewColor = color;
                    bar.barThickness -= 30.0f;
                    bar.barPadding += 60.0f;
                    bar.showTimerLabel = YES;
                }
                
                break;
            }
            
            case 2: {
                if (timeRemaining <= 0) {
                    int random = ((int)timeRemaining % 2) + 1;
                    NSString *pattern = [NSString stringWithFormat:@"pattern_%i", random];
                    
                    bar.timerShapeInactiveColor = [UIColor colorWithPatternImage:
                                                   [UIImage imageNamed:pattern]];
                    
                    bar.barThickness += 30.0f;
                    bar.barPadding -= 1.0f;
                }
                
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - ORBVisualTimerDelegate

- (void)visualTimerFired:(ORBVisualTimer *)timerView {
    NSLog(@"FIRED!");
}

@end
