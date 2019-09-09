//
//  LeaderBoardCell.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 8/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "LeaderBoardCell.h"

@implementation LeaderBoardCell
@synthesize playerName, playerScore;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
