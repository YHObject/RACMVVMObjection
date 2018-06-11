//
//  YHWeatherTableViewCell.m
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHWeatherTableViewCell.h"
#import "YHWeatherModel.h"

@interface YHWeatherTableViewCell()
@property (nonatomic , strong) UILabel *titleLabel;
@end

@implementation YHWeatherTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (nil != self) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 10, 15));
        }];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindViewModel:(YHWeatherDetailModel *)viewModel
{
    self.titleLabel.text = viewModel.title;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
