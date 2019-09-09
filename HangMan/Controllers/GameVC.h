//
//  GameVC.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 4/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppHelper.h"
#import "Constants.h"
#import "GameOverVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameVC : UIViewController <UITextFieldDelegate>
//properties
@property NSString *mode; //modes of the game, currently only 2 => hard/easy
@property NSString *gameState; //win or lose
@property int lives;
@property int score;
@property int modeBonus;
@property NSString *word; //word to guess ex. airplane
@property NSMutableString *mysteryWord; //word replaced with dashes ex. -------- => airplane
@property NSMutableString *guessedLetters;
@property int guessCounter;
@property int incorrectGuesses;

//outlets
@property (weak, nonatomic) IBOutlet UILabel *livesTxt;
@property (weak, nonatomic) IBOutlet UILabel *wrongGuessesTxt;
@property (weak, nonatomic) IBOutlet UILabel *wordToGuessTxt;
@property (weak, nonatomic) IBOutlet UITextField *guessedLetterTxt;

//support methods
- (void)setupGame;
- (void)guess;
- (void)generateWord;
@end

NS_ASSUME_NONNULL_END
