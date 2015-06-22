//
//  OCGIFLayer.m
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import "OCGIFLayer.h"
#import "OCPlayback.h"

static CGFloat sDefaultFPS = 10.0f;

@interface OCGIFLayer ()

@property (nonatomic) CGImageSourceRef GIFImageSource;
@property (nonatomic) NSUInteger currentImageIndex;

@end

@implementation OCGIFLayer

- (void)setGIFURL:(NSURL *)GIFURL
{
    if (_GIFURL != GIFURL)
    {
        _GIFURL = [GIFURL copy];
        [self invalidateProperties];
    }
}

- (void)play
{
    [self updateContents];
}

- (void)pause
{
    
}

- (void)stop
{
    
}

- (void)invalidateProperties
{
    if (_GIFImageSource)
        CFRelease(_GIFImageSource);
}

- (CGImageSourceRef)imageSource
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
    CGImageSourceRef imageSource = [self imageSource];
    CGImageRef image = nil;
    if (imageSource && CGImageSourceGetCount(imageSource) > _currentImageIndex)
        image = CGImageSourceCreateImageAtIndex(imageSource, _currentImageIndex, NULL);
    self.contents = (__bridge id)image;
    if (image)
        CGImageRelease(image);
}

- (void)updateTimeline
{
    NSUInteger framesCount = CGImageSourceGetCount(_GIFImageSource);
    for (NSInteger index = 0; index < framesCount; index++)
    {
        NSDictionary* dictionary = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(_GIFImageSource, index, NULL));
        NSDictionary* gifOptionsDictionary = [dictionary objectForKey:(id)kCGImagePropertyGIFDictionary];
        CGFloat timeDelay = [[gifOptionsDictionary objectForKey:(id)kCGImagePropertyGIFDelayTime] floatValue];
        if (timeDelay == 0)
        {
            timeDelay = 1.0f / sDefaultFPS;
        }
    }

}

@end
