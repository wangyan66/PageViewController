//
//  WYMessageTableViewCell.m
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import "WYMessageTableViewCell.h"
@interface WYMessageTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *MessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;


@end
@implementation WYMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMessage:(message *)message{
    self.NameLabel.text = message.name;
    self.MessageLabel.text = message.message;
    self.timeLabel.text = message.time;
    self.Avatar.image = message.image;
}
+ (instancetype)loadCell{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WYMessageTableViewCell" owner:self options:nil];
    return [nib objectAtIndex:0];
}
@end
