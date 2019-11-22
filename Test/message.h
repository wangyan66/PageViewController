//
//  message.h
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface message : NSObject
@property (nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *time;
@end

NS_ASSUME_NONNULL_END
