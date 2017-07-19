//
//  CoreUIView.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreUIView.h"

#import "UIView+Extension.h"
#import "CoreNibFileCache.h"


@interface CoreUIView()

@property (nonatomic, assign) BOOL initialized;

@end


@implementation CoreUIView

- (NSString *)stringWithKey:(NSString *)key {
    return NSLocalizedStringFromTable(key, self.localizationItemName, nil);
}

- (void)setup {}

- (void)initialize {
    if( !self.initialized ){
        self.initialized = YES;
        [self setup];
    }
}

- (id)init {
    if ( (self = [super init]) ) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame] ) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super initWithCoder:aDecoder] ) {
        [self initialize];
    }
    return self;
}

@end




@implementation CoreDesignableXibUIView

- (id)initWithXib {
    if ( (self = [super init]) ) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super initWithCoder:aDecoder] ) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame] ) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [super initialize];
}

- (void)setup {
    [super setup];
    
    NSString *nibClassName = NSStringFromClass([self class]);
    UINib *nib = [[CoreNibFileCache sharedInstance] nibWithNameKey:nibClassName];
//    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (!nib)
    {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException
                                                         reason:[NSString stringWithFormat:@"CoreNibFileCache could not find nib file %@", nibClassName]
                                                       userInfo:nil];
        [exception raise];
    }
    
    NSArray *arrayViews = [nib instantiateWithOwner:self options:nil];
    if (arrayViews.count != 1)
    {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException
                                                         reason:[NSString stringWithFormat:@"CoreNibFileCache found more than one view in nib file %@", nibClassName]
                                                       userInfo:nil];
        [exception raise];
    }
    
    UIView *view = arrayViews.firstObject;
    [self addSubview:view];
    [self sendSubviewToBack:view];
    self.backgroundColor = [UIColor clearColor];
    
    //Constraints
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(@"view", view);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:bindings]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:bindings]];
    self.sizeH = ((UIView *)view).sizeH;
    self.sizeW = ((UIView *)view).sizeW;
    [self setNeedsLayout];
}

@end
