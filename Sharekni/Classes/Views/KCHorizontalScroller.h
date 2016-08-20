//
//  KCHorizontalScroller.h
//  KaizenCare
//
//  Created by Askar on 11/24/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KCHorizontalScroller ;
@protocol KCHorizontalScrollerDataSource <NSObject>

@required
// ask the delegate how many views he wants to present inside the horizontal scroller
- (NSInteger)numberOfViewsForHorizontalScroller:(KCHorizontalScroller*)scroller;

// ask the delegate to return the view that should appear at <index>
- (UIView*)horizontalScroller:(KCHorizontalScroller*)scroller viewAtIndex:(int)index;

@end

@protocol KCHorizontalScrollerDelegate <NSObject>

@required
// inform the delegate what the view at <index> has been clicked
- (void)horizontalScroller:(KCHorizontalScroller*)scroller clickedViewAtIndex:(int)index;

@optional
// ask the delegate for the index of the initial view to display. this method is optional
// and defaults to 0 if it's not implemented by the delegate
- (NSInteger)initialViewIndexForHorizontalScroller:(KCHorizontalScroller*)scroller;

- (void)horizontalScrollerDidScrollView:(float)fractional ;

@end

@interface KCHorizontalScroller : UIView

@property (nonatomic) int scrollWidth;
@property (weak) id <KCHorizontalScrollerDataSource> dataSource ;
@property (weak) id <KCHorizontalScrollerDelegate> delegate;

- (void)reload;

@end
