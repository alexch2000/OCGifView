//
//  OCTimeline.m
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import "OCTimeline.h"

@interface OCTimeline ()

@property (nonatomic, strong) NSArray* timeStampsArray;

@end

@implementation OCTimeline

+ (NSArray*)arrayByMappingObjectFromArray:(NSArray*)array usingBlock:(id(^)(id object))mappingBlock
{
    NSMutableArray* resultArray = [NSMutableArray new];
    for (id object in array)
    {
        [resultArray addObject:mappingBlock(object)];
    }
    
    return [resultArray copy];
}

- (id)initWithTimeIntervals:(NSArray*)timeInterval
{
    __block NSTimeInterval previousTime = 0;
    return [self initWithTimeStamps:[OCTimeline arrayByMappingObjectFromArray:timeInterval usingBlock:^id(id object) {
        NSTimeInterval timeInterval = [object doubleValue];
        id returnValue = @(timeInterval + previousTime);
        previousTime += timeInterval;
        return returnValue;
    }]];
}

- (id)initWithTimeStamps:(NSArray*)timeStamps
{
    self = [super init];
    if (self)
    {
        _timeStampsArray = [timeStamps copy];
    }
    
    return self;
}


- (NSInteger)frameIndexAtTimeStamp:(NSTimeInterval)timeStamp
{
    return [_timeStampsArray indexOfObject:@(timeStamp) inSortedRange:NSMakeRange(0, _timeStampsArray.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
}


@end
