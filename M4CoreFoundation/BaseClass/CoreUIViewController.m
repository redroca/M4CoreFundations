//
//  CoreUIViewController.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreUIViewController.h"

@interface CoreUIViewController ()

@property (nonatomic, assign) BOOL initialized;

@end

@implementation CoreUIViewController

- (void)setup {
    
}

- (void)initialize {
    if( !self.initialized ){
        self.initialized = YES;
        [self setup];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
