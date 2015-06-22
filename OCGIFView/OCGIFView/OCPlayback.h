//
//  OCPlayback.h
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCPlayback : NSObject

- (id)initWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount;

@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) NSUInteger repeatCount;

@property (nonatomic, readonly) NSTimeInterval currentTime;

- (void)start;
- (void)pause;
- (void)stop; // Set current time to 0

- (void)seekToTime:(NSTimeInterval)time;

@end
