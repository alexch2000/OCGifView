//
//  OCGIFLayer.h
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

@interface OCGIFLayer : CALayer
{
@private
    NSURL* _GIFURL;

}

@property (nonatomic, retain) NSURL* GIFURL;
@property (nonatomic, readonly) CGSize gifSize;

- (void)play;
- (void)pause;
- (void)stop;

@end
