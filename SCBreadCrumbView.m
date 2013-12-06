//
//  SCBreadCrumbView.m
//  BreadCrumb
//
//  Created by Serdar coskun on 06/12/13.
//  Copyright (c) 2013 Serdar coskun. All rights reserved.
//

#import "SCBreadCrumbView.h"

@implementation SCBreadCrumbView
@synthesize containerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)reloadData{
    NSLog(@"reloading data");
    int steps = [self numberOfStepsInBreadCrumbView];
    
    NSLog(@"numofsteps = %i",steps);
    
    if (CGPointEqualToPoint(self.linePosition, CGPointZero)) {
        self.linePosition = CGPointMake(100, 40);
    }
    if(self.lineWeight==0.0f){
        self.lineWeight = 5.0f;
    }
    if(!self.lineColor){
        self.lineColor = [UIColor orangeColor];
    }
    

    
    if(!self.containerView){
        containerView = [[UIScrollView alloc] initWithFrame:[self bounds]];
        [containerView setContentInset:UIEdgeInsetsMake(0, 0, self.linePosition.y, 0)];
        [self addSubview:containerView];
    }
    containerView.contentSize = CGSizeMake(self.bounds.size.width, [self getTotalHeight]);
    
    CGRect breadCrumbFrame;
    breadCrumbFrame.origin = self.linePosition;
    breadCrumbFrame.size = CGSizeMake(self.lineWeight, [self getTotalHeight]);
    UIView* breadCrumbLine = [[UIView alloc] initWithFrame:breadCrumbFrame];
    breadCrumbLine.backgroundColor = self.lineColor;
    breadCrumbLine.layer.cornerRadius = self.lineWeight/2.0f;;
    [self.containerView addSubview:breadCrumbLine];
    
    
    
    for(int i =0;i<steps;i++){
        
        //Yuvarlak elemanlar ve içlerindeki rakamlar ekleniyor
        float pointSize = 20.0f;
        CGRect pointFrame = CGRectZero;
        pointFrame.origin.x = self.linePosition.x-(pointSize/2.0f)+(self.lineWeight/2.0f);
        pointFrame.origin.y = self.linePosition.y+(i*[self spaceBetweenStepsAtIndex:i]);
        pointFrame.size = CGSizeMake(pointSize, pointSize);
        UIView* pointView = [[UIView alloc] initWithFrame:pointFrame];
        
        pointView.layer.cornerRadius = pointView.frame.size.height/2.0f;
        pointView.layer.borderColor = [UIColor orangeColor].CGColor;
        pointView.layer.borderWidth = 3.0f;
        pointView.backgroundColor = [UIColor whiteColor];
        
        UILabel* indicator = [[UILabel alloc] initWithFrame:[pointView bounds]];
        indicator.text = [NSString stringWithFormat:@"%i",i];
        indicator.textAlignment = NSTextAlignmentCenter;
        indicator.font = [UIFont systemFontOfSize:12.0f];
        [self.containerView insertSubview:pointView aboveSubview:breadCrumbLine];
        [pointView addSubview:indicator];
        //Yuvarlak elemanlar ve içlerindeki rakamlar ekleniyor - Bitti
        
        //Yan başlıklar ekleniyor
        CGRect labelFrame= CGRectZero;
        labelFrame.origin = CGPointMake(0, self.linePosition.y+(i*[self spaceBetweenStepsAtIndex:i])-(pointSize/2.0f));
        labelFrame.size = CGSizeMake(self.linePosition.x-10+(self.lineWeight/2.0f), [self spaceBetweenStepsAtIndex:i]);
        UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
        label.textAlignment = NSTextAlignmentRight;
        [label setAttributedText:[self titleForStepAtIndex:i]];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.numberOfLines = 0;
        [label setMinimumScaleFactor:0.1f];
        [containerView addSubview:label];
    }
}

-(float)getTotalHeight{
    float totalHeight = 0.0f;
    for(int i = 0;i<[self numberOfStepsInBreadCrumbView];i++){
        totalHeight+= [self spaceBetweenStepsAtIndex:i];
    }
    return totalHeight;
}

#pragma SCBreadCrumb Datasource

-(NSUInteger)numberOfStepsInBreadCrumbView{
    if([self.dataSource respondsToSelector:@selector(numberOfStepsInBreadCrumbView)])
        return [self.dataSource numberOfStepsInBreadCrumbView];
    else
        return 0;
}

-(NSAttributedString*)titleForStepAtIndex:(NSUInteger)index{
    if([self.dataSource respondsToSelector:@selector(titleForStepAtIndex:)]){
        return [self.dataSource titleForStepAtIndex:index];
    }
    else
        return [[NSMutableAttributedString alloc] initWithString:@""];
}

-(float)spaceBetweenStepsAtIndex:(NSUInteger)index{
    if([self.dataSource respondsToSelector:@selector(spaceBetweenStepsAtIndex:)]){
        return [self.dataSource spaceBetweenStepsAtIndex:index];
    }
    else
        return 44.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
