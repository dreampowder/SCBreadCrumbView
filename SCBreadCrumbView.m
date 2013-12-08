//
//  SCBreadCrumbView.m
//  BreadCrumb
//
//  Created by Serdar coskun on 06/12/13.
//  Copyright (c) 2013 Serdar coskun. All rights reserved.
//

#import "SCBreadCrumbView.h"
#define TAG_BREADCRUMB_QUESTION_LABEL 1000
#define TAG_BREADCRUMB_QUESTION_ANSWER 2000
#define TAG_BREADCRUMB_QUESTION_NUMBER 3000
#define TAG_BREADCRUMB_LINE 4000

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
    
    UIView* breadCrumbLine = nil;
    if(![self.containerView viewWithTag:TAG_BREADCRUMB_LINE]){
        CGRect breadCrumbFrame;
        breadCrumbFrame.origin = self.linePosition;
        breadCrumbFrame.size = CGSizeMake(self.lineWeight, [self getTotalHeight]);
        breadCrumbLine = [[UIView alloc] initWithFrame:breadCrumbFrame];
        breadCrumbLine.backgroundColor = self.lineColor;
        breadCrumbLine.layer.cornerRadius = self.lineWeight/2.0f;
        breadCrumbLine.tag = TAG_BREADCRUMB_LINE;
        [self.containerView addSubview:breadCrumbLine];
        [self updateLines];
    }
    else{
        breadCrumbLine = [self.containerView viewWithTag:TAG_BREADCRUMB_LINE];
        [UIView animateWithDuration:0.3f animations:^{
            CGRect breadCrumbFrame;
            breadCrumbFrame.origin = self.linePosition;
            breadCrumbFrame.size = CGSizeMake(self.lineWeight, [self getTotalHeight]);
            [breadCrumbLine setFrame:breadCrumbFrame];
            [self updateLines];
        }];
    }
}

-(void)updateLines{
    UIView* breadCrumbLine = [self.containerView viewWithTag:TAG_BREADCRUMB_LINE];
    int steps = [self numberOfStepsInBreadCrumbView];
    for(int i =0;i<steps;i++){
        float pointSize = 20.0f;
        int pointViewTag =TAG_BREADCRUMB_QUESTION_NUMBER+i;
        //Yuvarlak elemanlar ve içlerindeki rakamlar ekleniyor
        if(![self.containerView viewWithTag:pointViewTag]){ //Eklenmişse birdaha ekleme!
            CGRect pointFrame = CGRectZero;
            pointFrame.origin.x = self.linePosition.x-(pointSize/2.0f)+(self.lineWeight/2.0f);
            pointFrame.origin.y = self.linePosition.y+(i*[self spaceBetweenStepsAtIndex:i]);
            pointFrame.size = CGSizeZero;
            UIView* pointView = [[UIView alloc] initWithFrame:pointFrame];
            
            pointView.layer.cornerRadius = pointSize/2.0f;
            pointView.layer.borderColor = [UIColor orangeColor].CGColor;
            pointView.layer.borderWidth = 3.0f;
            pointView.backgroundColor = [UIColor whiteColor];
            
            UILabel* indicator = [[UILabel alloc] initWithFrame:[pointView bounds]];
            indicator.text = [NSString stringWithFormat:@"%i",i];
            indicator.textAlignment = NSTextAlignmentCenter;
            indicator.font = [UIFont systemFontOfSize:12.0f];
            indicator.alpha = 0.0f;
            pointView.tag = pointViewTag;
            [self.containerView insertSubview:pointView aboveSubview:breadCrumbLine];
            [pointView addSubview:indicator];
            
            
            [UIView animateWithDuration:0.05f animations:^{
                CGRect newFrame = CGRectZero;
                newFrame.origin.x = self.linePosition.x-(pointSize/2.0f)+(self.lineWeight/2.0f);
                newFrame.origin.y = self.linePosition.y+(i*[self spaceBetweenStepsAtIndex:i]);
                newFrame.size = CGSizeMake(pointSize, pointSize);
                pointView.center = newFrame.origin;
                [pointView setFrame:newFrame];
                [indicator setFrame:[pointView bounds]];
                indicator.alpha = 1.0f;
                
                int labelTag =TAG_BREADCRUMB_QUESTION_LABEL+i;
                if(![containerView viewWithTag:labelTag]){
                    CGRect labelFrame= CGRectZero;
                    labelFrame.origin = CGPointMake(0, self.linePosition.y+(i*[self spaceBetweenStepsAtIndex:i])-(pointSize/2.0f));
                    labelFrame.size = CGSizeMake(self.linePosition.x-10+(self.lineWeight/2.0f), [self spaceBetweenStepsAtIndex:i]);
                    UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
                    label.textAlignment = NSTextAlignmentRight;
                    [label setAttributedText:[self titleForStepAtIndex:i]];
                    label.font = [UIFont systemFontOfSize:14.0f];
                    label.numberOfLines = 0;
                    [label setMinimumScaleFactor:0.1f];
                    label.tag = labelTag;
                    label.alpha = 0.0f;
                    [containerView addSubview:label];
                    
                    int lastLabel = TAG_BREADCRUMB_QUESTION_LABEL+[self numberOfStepsInBreadCrumbView]-1;
                    UIView* labelView = [self.containerView viewWithTag:lastLabel];
                    [self.containerView scrollRectToVisible:labelView.frame animated:YES];
                    [UIView animateWithDuration:0.2f animations:^{
                        label.alpha = 1.0f;
                    }];
                }
            } completion:^(BOOL finished){
                int answerTag = TAG_BREADCRUMB_QUESTION_ANSWER+i;
                if(![self.containerView viewWithTag:answerTag]){
                    CGRect answerRect = CGRectZero;
                    answerRect.origin = CGPointMake(self.containerView.bounds.size.width + self.linePosition.x+15+(self.lineWeight/2.0f), self.linePosition.y+((i)*[self spaceBetweenStepsAtIndex:i]));
                    
                    answerRect.size = CGSizeMake(self.containerView.bounds.size.width-(self.linePosition.x-10+(self.lineWeight/2.0f))-30.0f,[self spaceBetweenStepsAtIndex:i]-10.0f);
                    UIView* answerView = [self viewForIndex:i];
                    answerView.tag = answerTag;
                    [answerView setFrame:answerRect];
                    answerView.backgroundColor = [UIColor redColor];
                    answerView.layer.cornerRadius = 5.0f;
                    answerView.alpha = 0.0f;
                    [self.containerView addSubview:answerView];
                    [UIView animateWithDuration:0.1f animations:^{
                        CGRect answerRect = CGRectZero;
                        answerRect.origin = CGPointMake(self.linePosition.x+15+(self.lineWeight/2.0f), self.linePosition.y+((i)*[self spaceBetweenStepsAtIndex:i]));
                        answerRect.size = CGSizeMake(self.containerView.bounds.size.width-(self.linePosition.x-10+(self.lineWeight/2.0f))-30.0f,[self spaceBetweenStepsAtIndex:i]-10.0f);
                        answerView.alpha = 1.0f;
                        [answerView setFrame:answerRect];
                    }];
                }
            }];
        }
        //Yuvarlak elemanlar ve içlerindeki rakamlar ekleniyor - Bitti
        
        //Yan başlıklar ekleniyor

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

-(UIView*)viewForIndex:(NSUInteger)index{
    if([self.dataSource respondsToSelector:@selector(viewForIndex:)]){
        return [self.dataSource viewForIndex:index];
    }else
        return [[UIView alloc] init];
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
