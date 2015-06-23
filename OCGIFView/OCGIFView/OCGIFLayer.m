//
//  OCGIFLayer.m
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import "OCGIFLayer.h"
#import "OCPlayback.h"
#import "OCTimeline.h"

static CGFloat sDefaultFPS = 10.0f;

@interface OCGIFLayer ()

@property (nonatomic) CGImageSourceRef GIFImageSource;
@property (nonatomic) NSUInteger currentImageIndex;
@property (nonatomic, strong) OCPlayback* playback;

@property (nonatomic, strong) OCTimeline* timeLine;

@end

@implementation OCGIFLayer

- (OCPlayback*)playback
{
    if (!_playback)
    {
        __weak typeof (self) weakSelf = self;
        _playback = [[OCPlayback alloc] initWithDuration:self.timeLine.duration repeatCount:NSUIntegerMax];
        [_playback setDidChangeTimeBlock:^(NSTimeInterval timeInterval)
        {
            weakSelf.currentImageIndex = [weakSelf.timeLine frameIndexAtTimeStamp:timeInterval];
            if (weakSelf.currentImageIndex == 40)
                NSLog(@"Error");
            [weakSelf updateContents];
        }];
    }
    
    return _playback;
}

- (void)setGIFURL:(NSURL *)GIFURL
{
    if (_GIFURL != GIFURL)
    {
        _GIFURL = [GIFURL copy];
        [self invalidateProperties];
        [self updateTimeline];
    }
}

- (void)play
{
    [self.playback start];
    [self updateContents];
}

- (void)pause
{
    [self.playback pause];
}

- (void)stop
{
    [self.playback stop];
}

- (void)invalidateProperties
{
    _playback = nil;
    if (_GIFImageSource)
        CFRelease(_GIFImageSource);
}

- (CGImageSourceRef)GIFImageSource
{
    if (!_GIFImageSource && _GIFURL)
    {
        _GIFImageSource = CGImageSourceCreateWithURL((CFURLRef) _GIFURL, NULL);
        if (_GIFImageSource)
        {
            NSDictionary* dictionary = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(_GIFImageSource, 0, NULL));

            _gifSize.width = [[dictionary objectForKey:(id)kCGImagePropertyPixelWidth] floatValue];
            _gifSize.height = [[dictionary objectForKey:(id)kCGImagePropertyPixelHeight] floatValue];
            [self updateTimeline];
        }
        [self updateContents];
    }
    return _GIFImageSource;
}

- (void)updateContents
{
    NSLog(@"%lu", (unsigned long)_currentImageIndex);
    CGImageSourceRef imageSource = self.GIFImageSource;
    CGImageRef image = nil;
    if (imageSource && CGImageSourceGetCount(imageSource) > _currentImageIndex)
        image = CGImageSourceCreateImageAtIndex(imageSource, _currentImageIndex, NULL);
    self.contents = (__bridge id)image;
    if (image)
        CGImageRelease(image);
}

- (void)updateTimeline
{
    NSUInteger framesCount = CGImageSourceGetCount(self.GIFImageSource);
    NSMutableArray* timeLineTimeStamps = [NSMutableArray new];
    for (NSInteger index = 0; index < framesCount; index++)
    {
        NSDictionary* dictionary = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(_GIFImageSource, index, NULL));
        NSDictionary* gifOptionsDictionary = [dictionary objectForKey:(id)kCGImagePropertyGIFDictionary];
        CGFloat timeDelay = [[gifOptionsDictionary objectForKey:(id)kCGImagePropertyGIFUnclampedDelayTime] floatValue];

        if (timeDelay == 0)
            timeDelay = [[gifOptionsDictionary objectForKey:(id)kCGImagePropertyGIFDelayTime] floatValue];
        
        if (timeDelay == 0)
            timeDelay = 1.0f / sDefaultFPS;
        
        [timeLineTimeStamps addObject:@(timeDelay)];
    }
    
    self.timeLine = [[OCTimeline alloc] initWithTimeIntervals:timeLineTimeStamps];

}

@end
