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
@property (nonatomic) NSTimeInterval currentTime;

@property (nonatomic) NSInteger currentRepeatCount;

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
    self.currentTime = _currentTime + displayLink.duration;
}

- (void)start
{
    if (_displayLink)
    {
        _displayLink.paused = NO;
    }
    else
    {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkFire:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)pause
{
    _displayLink.paused = YES;
}

- (void)stop
{
    _currentTime = 0;
    [_displayLink invalidate];
}

- (void)seekToTime:(NSTimeInterval)time
{
    self.currentTime = MIN(MAX(0, time), _duration);
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (_currentTime != currentTime)
    {
        if (currentTime >= _duration)
        {
            NSInteger numberOfLoops = floor(currentTime / _duration);
            _currentRepeatCount += numberOfLoops;
            if (_currentRepeatCount >= _repeatCount)
            {
                [self stop];
                if (_didFinishBlock)
                    _didFinishBlock();
            }
            else
            {
                _currentTime = currentTime - _duration * numberOfLoops;
            }
        }
        else
        {
            _currentTime = currentTime;
        }
        
        if (_didChangeTimeBlock)
            _didChangeTimeBlock(_currentTime);
    }
}

- (void)notifyBlockWithCurrentTime:(NSTimeInterval)currentTime
{
    if (_didChangeTimeBlock)
        _didChangeTimeBlock(currentTime);
}


@end
