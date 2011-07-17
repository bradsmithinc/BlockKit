//
//  BlockPlaygroundViewController.m
//  BlockPlayground
//
//  Created by Nick Paulson on 7/16/11.
//  Copyright 2011 Linebreak. All rights reserved.
//

#import "BlockPlaygroundViewController.h"
#import "UIView-BKAdditions.h"
#import "UIControl-BKAdditions.h"
#import "NSURLConnection-BKAdditions.h"
#import "NSString-BKAdditions.h"

@implementation BlockPlaygroundViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __block BlockPlaygroundViewController *safeself = self;
    
    UIView *blockView = [[UIView alloc] initWithDrawRectBlock:^(CGRect dirtyRect) {
        [[UIColor redColor] set];
        [[UIBezierPath bezierPathWithRect:safeself.view.bounds] fill];
    }];
    
    blockView.frame = self.view.frame;
    self.view = blockView;
    
    [blockView release];
    
    __block BOOL isRed = NO; // Must be NO because __block causes it to stick around, and -drawRect gets called on the next run loop pass
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tempButton setTitle:@"Change Color" forState:UIControlStateNormal];
    
    [tempButton addActionForControlEvents:UIControlEventTouchUpInside usingBlock:^{
        safeself.view.drawRectBlock = ^(CGRect dirtyRect) {
            [isRed ? [UIColor greenColor] : [UIColor redColor] set];
            [[UIBezierPath bezierPathWithRect:safeself.view.bounds] fill];
        };
        isRed = !isRed;
    }];
    
    CGFloat buttonWidth = 200.0f;
    tempButton.frame = CGRectMake(floorf((CGRectGetWidth(self.view.frame) - buttonWidth) / 2), 50, buttonWidth, 44);
    
    [self.view addSubview:tempButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
