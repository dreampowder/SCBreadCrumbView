//
//  SCMainViewController.h
//  BreadCrumb
//
//  Created by Serdar coskun on 06/12/13.
//  Copyright (c) 2013 Serdar coskun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBreadCrumbView.h"

@interface SCMainViewController : UIViewController<SCBreadCrumbViewDataSource,SCBreadCrumbViewDelegate>

@property (nonatomic, strong)SCBreadCrumbView* breadCrumbView;

@end
