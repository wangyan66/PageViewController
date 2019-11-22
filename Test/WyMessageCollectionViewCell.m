//
//  WyMessageCollectionViewCell.m
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import "WyMessageCollectionViewCell.h"

@implementation WyMessageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)loadCell{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WyMessageCollectionViewCell" owner:self options:nil];
    return [nib objectAtIndex:0];
}
@end
