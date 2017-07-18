//
//  CoreCollectionViewCell.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreCollectionViewCell.h"

#import "CoreNibFileCache.h"

@interface CoreCollectionViewCell()

@property (nonatomic, assign) BOOL initialized;

@end


@implementation CoreCollectionViewCell

- (NSString *)stringWithKey:(NSString *)key
{
    return NSLocalizedStringFromTable(key, self.localizationItemName, nil);
}

- (void)setup
{}

- (void)initialize {
    if( !self.initialized ){
        self.initialized = YES;
        [self setup];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

+ (__kindof UICollectionViewCell *)reusableCellDequeueCollectionView:(UICollectionView *) collectionView forIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellReuseIdentifier = NSStringFromClass([self class]);
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:cellReuseIdentifier];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (CGSize) sizeOfCollectionViewCell
{
    return CGSizeMake(0.0f, 0.0f);
}

- (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

@end


@implementation CoreXibCollectionViewCell

- (void) setup
{
    [super setup];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (__kindof UICollectionViewCell *)reusableCellDequeueCollectionView:(UICollectionView *) collectionView forIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellReuseIdentifier = NSStringFromClass([self class]);
    UINib *nib = [[CoreNibFileCache sharedInstance] nibWithNameKey:cellReuseIdentifier];
    if (!nib)
    {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException
                                                         reason:[NSString stringWithFormat:@"CoreNibFileCache could not find nib file %@", cellReuseIdentifier]
                                                       userInfo:nil];
        [exception raise];
    }
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellReuseIdentifier];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
