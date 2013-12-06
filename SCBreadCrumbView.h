//
//  SCBreadCrumbView.h
//  BreadCrumb
//
//  Created by Serdar coskun on 06/12/13.
//  Copyright (c) 2013 Serdar coskun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCBreadCrumbViewDataSource <NSObject>

@optional
-(NSUInteger)numberOfStepsInBreadCrumbView;
-(NSAttributedString*)titleForStepAtIndex:(NSUInteger)index;
-(float)spaceBetweenStepsAtIndex:(NSUInteger)index;
-(UIView*)viewForIndex:(NSUInteger)index;

@end

@protocol SCBreadCrumbViewDelegate <NSObject>

@optional
-(void)moveToNextStep;
-(void)moveToLastStep;
-(void)jumpToStepNumber:(NSUInteger)stopNumber;
@end

@interface SCBreadCrumbView : UIView

@property id<SCBreadCrumbViewDataSource> dataSource;
@property id<SCBreadCrumbViewDelegate> delegate;

//initial line position to start with.
@property CGPoint linePosition;

//Breadcrumb line width
@property float lineWeight;

//Breadcrumb color
@property UIColor* lineColor;

//Scrollview Container
@property (nonatomic, strong) UIScrollView* containerView;

-(void)reloadData;

@end
