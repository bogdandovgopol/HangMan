//
//  GameOverVC.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 8/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "AppHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameOverVC : UIViewController
//properties
@property NSString *gameState; //win or lose
@property NSString *answer; //win or lose
@property int score;
@property int totalGuesses;
@property int incorrectGuesses;

//outlets
@property (weak, nonatomic) IBOutlet UILabel *congratulationsTxt;
@property (weak, nonatomic) IBOutlet UILabel *gameStateTxt;
@property (weak, nonatomic) IBOutlet UILabel *answerTxt;
@property (weak, nonatomic) IBOutlet UILabel *gameRecapTxt;

//actions
- (IBAction)playAgainClicked:(id)sender;

//support methods
- (void)updateUI;
- (void)updateScore;
@end

NS_ASSUME_NONNULL_END
