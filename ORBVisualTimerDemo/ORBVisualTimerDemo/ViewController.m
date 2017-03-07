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

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *sampleViews;

@end

@implementation ViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self prepareUI];
    
    //[self minimalDemo];
    [self comprehensiveDemo];
}

#pragma mark - UI

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)prepareUI {
    for (UIView *container in self.sampleViews) {
        if (container == self.sampleViews.lastObject) { return; }
        
        UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, container.bounds.size.height - 1, container.bounds.size.width, 1)];
        sep.backgroundColor = [UIColor whiteColor];
        [container addSubview:sep];
    }
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
    
    for (NSUInteger i = 0; i < numOfBars; i++) {
        CGRect containerBounds = [self.sampleViews[i] bounds];
        
        ORBVisualTimerBar *barTimer;
        
        switch (i) {
            case 0: {
                CGRect barFrame = CGRectMake(0, 0,
                                             containerBounds.size.width,
                                             containerBounds.size.height * 0.24);
                
                barTimer = (ORBVisualTimerBar *)[ORBVisualTimer timerWithStyle:ORBVisualTimerStyleBar frame:barFrame timeRemaining:(5)];
                
                barTimer.center = CGPointMake(containerBounds.size.width / 2,
                                              containerBounds.size.height * 0.88);
                
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleStraight;
                
                barTimer.backgroundViewColor = [UIColor colorWithWhite:0.0f alpha:0.40f];
                barTimer.backgroundViewCornerRadius = 0.0f;
                barTimer.timerShapeInactiveColor = [UIColor darkGrayColor];
                barTimer.timerShapeActiveColor = [UIColor orangeColor];
                barTimer.timerLabelColor = [UIColor whiteColor];
                //barTimer.showTimerLabel = NO;
                //barTimer.autohideWhenFired = YES;
                barTimer.barCapStyle = kCALineCapSquare;
                barTimer.barThickness = 10.0f;
                barTimer.barPadding = 20.0f;
                
                break;
            }
                
            case 1: {
                CGRect barFrame = CGRectMake(0, 0,
                                             containerBounds.size.width * 0.80,
                                             containerBounds.size.height * 0.4);
                
                barTimer = (ORBVisualTimerBar *)[ORBVisualTimer timerWithStyle:ORBVisualTimerStyleBar frame:barFrame timeRemaining:(7)];
                
                barTimer.center = CGPointMake(containerBounds.size.width / 2,
                                              containerBounds.size.height * 0.5);
                
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleReflection;
                
                barTimer.backgroundViewColor = [UIColor clearColor];
                //barTimer.backgroundViewCornerRadius = 20.0f;
                barTimer.timerShapeInactiveColor = [UIColor colorWithWhite:1.0f alpha:0.4f];
                barTimer.timerShapeActiveColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.9f alpha:0.2f];
                //barTimer.timerLabelColor = [UIColor whiteColor];
                barTimer.showTimerLabel = NO;
                //barTimer.autohideWhenFired = YES;
                barTimer.barCapStyle = kCALineCapRound;
                barTimer.barThickness = 30.0f;
                barTimer.barPadding = 10.0f;
                
                break;
            }
                
            case 2: {
                CGRect barFrame = CGRectMake(0, 0,
                                             containerBounds.size.width * 0.50,
                                             containerBounds.size.height * 0.3);
                
                barTimer = (ORBVisualTimerBar *)[ORBVisualTimer timerWithStyle:ORBVisualTimerStyleBar frame:barFrame timeRemaining:(9)];
                
                barTimer.center = CGPointMake(containerBounds.size.width * 0.3,
                                              containerBounds.size.height * 0.25);
                
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleBackwards;
                
                int random = ((int)(5.0f * (i+1)) % 2) + 1;
                NSString *pattern = [NSString stringWithFormat:@"pattern_%i", random];
                
                barTimer.timerShapeInactiveColor = [UIColor colorWithPatternImage:
                                               [UIImage imageNamed:pattern]];
                barTimer.timerShapeActiveColor = [UIColor colorWithPatternImage:
                                                    [UIImage imageNamed:@"pattern_3"]];
                
                barTimer.backgroundViewColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1.0f];
                barTimer.backgroundViewCornerRadius = 15.0f;
                //barTimer.timerLabelColor = [UIColor whiteColor];
                barTimer.showTimerLabel = NO;
                //barTimer.autohideWhenFired = YES;
                barTimer.barCapStyle = kCALineCapSquare;
                barTimer.barThickness = containerBounds.size.height * 0.25 * 0.9;
                barTimer.barPadding = 40.0f;
                
                break;
            }
                
            default:
                break;
        }
        
        barTimer.delegate = self;
        barTimer.tag = i;
        
        [barTimer addObserver:self forKeyPath:@"timeRemaining"
                      options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [self.sampleViews[i] addSubview:barTimer];
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
                    bar.barThickness += 2.0f;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        bar.timerLabelColor = barLabelColor;
                        bar.timerShapeActiveColor = barColor;
                        bar.barThickness = barThickness;
                        
                        if (timeRemaining <= 0) {
                            bar.timerShapeInactiveColor = [UIColor redColor];
                            bar.barThickness += 10.0f;
                            //bar.barPadding += 10.0f;
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
                    //bar.backgroundViewColor = color;
                    bar.barThickness -= bar.barThickness;
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
                    
                    bar.barThickness += 10.0f;
                    bar.barCapStyle = kCALineCapRound;
                    bar.backgroundViewColor = [UIColor clearColor];
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
