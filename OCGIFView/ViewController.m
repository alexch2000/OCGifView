//
//  ViewController.m
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import "ViewController.h"
#import "OCGIFView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet OCGIFView *gifView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gifView.GIFURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loader2" ofType:@"gif"]];
    [self.gifView play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
