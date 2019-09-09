//
//  LeaderBoardVC.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 8/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "LeaderBoardCell.h"
#import "AppHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeaderBoardVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
//properties
@property NSMutableArray *players;
//outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//support methods
- (void)prepareData;
@end

NS_ASSUME_NONNULL_END
