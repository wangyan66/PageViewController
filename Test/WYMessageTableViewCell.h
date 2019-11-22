//
//  WYMessageTableViewCell.h
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "message.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYMessageTableViewCell : UITableViewCell
@property(nonatomic,strong) message* message;
+(instancetype)loadCell;
@end

NS_ASSUME_NONNULL_END
