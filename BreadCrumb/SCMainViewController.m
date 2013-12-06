//
//  SCMainViewController.m
//  BreadCrumb
//
//  Created by Serdar coskun on 06/12/13.
//  Copyright (c) 2013 Serdar coskun. All rights reserved.
//

#import "SCMainViewController.h"


@interface SCMainViewController ()

@end

@implementation SCMainViewController
@synthesize breadCrumbView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    breadCrumbView = [[SCBreadCrumbView alloc] initWithFrame:self.view.bounds];
    breadCrumbView.dataSource = self;
    [self.view addSubview:breadCrumbView];
    [breadCrumbView reloadData];
	// Do any additional setup after loading the view.
}

#pragma SCBreadCrumbView Data Source 
-(NSUInteger)numberOfStepsInBreadCrumbView{
    return 13;
}
-(NSAttributedString*)titleForStepAtIndex:(NSUInteger)index{
    return [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Uzun Açıklamalalı ve Fazlasıyla Karmaşık Soru %i",index+1]];
}
-(float)spaceBetweenStepsAtIndex:(NSUInteger)index{
        return 100.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
