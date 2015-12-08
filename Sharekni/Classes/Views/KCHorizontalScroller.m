//
//  KCHorizontalScroller.m
//  KaizenCare
//
//  Created by Askar on 11/24/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import "KCHorizontalScroller.h"
#import "Constants.h"

// 2
@interface KCHorizontalScroller () <UIScrollViewDelegate>
{
    UIScrollView *scroller;
}
@end

@implementation KCHorizontalScroller


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEWS_OFFSET, VIEW_PADDING_DEFAULT, frame.size.width, frame.size.height)];
        scroller.frame = CGRectMake(0, 0, frame.size.width, frame.size.height) ;
        scroller.showsHorizontalScrollIndicator = NO ;
        scroller.delegate = self;
        [scroller setPagingEnabled:YES];
        [self addSubview:scroller];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [scroller addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)scrollerTapped:(UITapGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    
    // we can't use an enumerator here, because we don't want to enumerate over ALL of the UIScrollView subviews.
    // we want to enumerate only the subviews that we added
    for (int index=0; index<[self.dataSource numberOfViewsForHorizontalScroller:self]; index++)
    {
        UIView *view = scroller.subviews[index];
        
        if (CGRectContainsPoint(view.frame, location))
        {
            [self.delegate horizontalScroller:self clickedViewAtIndex:index];

            break;
        }
    }
}

- (void)reload
{
    // 1 - nothing to load if there's no delegate
    if (self.dataSource == nil) return;

    // 2 - remove all subviews
    [scroller.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];

    // 3 - xValue is the starting point of the views inside the scroller
    CGFloat xValue = VIEWS_OFFSET;
    for (int i=0; i<[self.dataSource numberOfViewsForHorizontalScroller:self]; i++)
    {
        // 4 - add a view at the right position
        xValue += VIEW_PADDING_DEFAULT;
        UIView *view = [self.dataSource horizontalScroller:self viewAtIndex:i];
        view.frame = CGRectMake(xValue,
                                VIEW_PADDING_DEFAULT,
                                self.scrollWidth,
                                self.scrollWidth);
        [scroller addSubview:view];
        xValue += self.scrollWidth + VIEW_PADDING_DEFAULT;
    }

    // 5
    [scroller setContentSize:CGSizeMake(xValue+VIEWS_OFFSET, self.frame.size.height)];

}

- (void)didMoveToSuperview
{
    [self reload];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    CGFloat pageWidth = scroller.bounds.size.width ;
    float fractionalPage = scroller.contentOffset.x / pageWidth ;
    [self.delegate horizontalScrollerDidScrollView:fractionalPage];
}


@end
