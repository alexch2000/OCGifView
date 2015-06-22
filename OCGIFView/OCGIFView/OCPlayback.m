//
//  OCPlayback.m
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import "OCPlayback.h"
#import <QuartzCore/QuartzCore.h>

@interface OCPlayback ()

@property (nonatomic, strong) CADisplayLink* displayLink;

@end

@implementation OCPlayback

- (id)initWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount
{
    self = [super init];
    if (self)
    {
        _duration = duration;
        _repeatCount = repeatCount;
    }
    return self;
}

- (void)displayLinkFire:(CADisplayLink*)displayLink
{
    
}

- (void)start
{
    [_displayLink invalidate];
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkFire:)];
}

- (void)pause
{
    [_displayLink invalidate];
}

- (void)stop
{
    _currentTime = 0;
    [_displayLink invalidate];
}

- (void)seekToTime:(NSTimeInterval)time
{
    _currentTime = MAX(MIN(0, time), _duration);
}

@end
