//
//  OCGIFView.h
//  OCGIFView
//
//  Created by Oleksii Chopyk on 6/22/15.
//  Copyright (c) 2015 Oleksii Chopyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCGIFView : UIView

@property (nonatomic, retain) NSURL* GIFURL;
@property (nonatomic, readonly) CGSize imageSize;

- (void)play;
- (void)pause;
- (void)stop;

@end
