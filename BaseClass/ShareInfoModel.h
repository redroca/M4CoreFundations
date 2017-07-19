//
//  ShareInfoModel.h
//  
//
//  Created by Benjamin on 1/7/2016.
//

#import "ModelBaseClass.h"

@interface ShareInfoModel : ModelBaseClass

@property  (nonatomic, copy)         NSString *ShareTitle;
@property  (nonatomic, copy)         NSString *ShareContent;
@property  (nonatomic, strong)       NSURL    *ShareURL;
@property  (nonatomic, strong)       NSURL    *ShareIconURL;

@end
