//
//  LeaderBoardCell.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 8/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeaderBoardCell : UITableViewCell
//outlets
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;

@end

NS_ASSUME_NONNULL_END
