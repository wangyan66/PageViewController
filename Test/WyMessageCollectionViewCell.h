//
//  WyMessageCollectionViewCell.h
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WyMessageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *indicator;
+(instancetype)loadCell;
@end

NS_ASSUME_NONNULL_END
