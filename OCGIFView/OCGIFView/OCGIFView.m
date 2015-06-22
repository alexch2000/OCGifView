//
//  OCGIFView.m
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import "OCGIFView.h"
#import "OCGIFLayer.h"

@implementation OCGIFView

+ (Class)layerClass
{
    return [OCGIFLayer class];
}

- (void)setGIFURL:(NSURL *)GIFURL
{
    ((OCGIFLayer*)(self.layer)).GIFURL = GIFURL;
}

- (NSURL*)GIFURL
{
    return ((OCGIFLayer*)(self.layer)).GIFURL;
}

- (void)play
{
    [((OCGIFLayer*)(self.layer)) play];
}

- (void)pause
{
    [((OCGIFLayer*)(self.layer)) pause];
}

- (void)stop
{
    [((OCGIFLayer*)(self.layer)) stop];
}

- (CGSize)imageSize
{
    return ((OCGIFLayer*)(self.layer)).gifSize;
}


@end
