//
//  OCTimeline.h
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTimeline : NSObject

- (id)initWithTimeIntervals:(NSArray*)timeInterval;
- (id)initWithTimeStamps:(NSArray*)timeStamps;

- (NSInteger)frameIndexAtTimeStamp:(NSTimeInterval)timeStamp;

@end
