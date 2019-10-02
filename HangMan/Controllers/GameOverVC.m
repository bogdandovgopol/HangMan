//
//  GameOverVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 8/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "GameOverVC.h"

@implementation GameOverVC
@synthesize gameState, score, totalGuesses, incorrectGuesses, congratulationsTxt, gameStateTxt, gameRecapTxt, answerTxt, answer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    [self updateScore];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //hide navigation bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //show navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)updateUI {
    if([gameState isEqualToString:@"win"]) {
        [congratulationsTxt setText:[NSString stringWithFormat:@"Congratulations!"]];
        [gameStateTxt setText:[NSString stringWithFormat:@"YOU WIN!"]];
    }
    if([gameState isEqualToString:@"lose"]) {
        [congratulationsTxt setText:[NSString stringWithFormat:@"Sorry!"]];
        [gameStateTxt setText:[NSString stringWithFormat:@"YOU LOSE!"]];
    }
    
    [answerTxt setText:[NSString stringWithFormat:@"\"%@\"", answer]];
    [gameRecapTxt setText:[NSString stringWithFormat:@"You made %i total guesses, and %i incorrect guesses.", totalGuesses, incorrectGuesses]];
}


//redirect back to MenuVC
- (IBAction)playAgainClicked:(id)sender {
    //redirect back to MenuVC
    [[self navigationController] popToRootViewControllerAnimated:NO];
}

- (void)updateScore {
    //updating score in firestore db. docs: https://firebase.google.com/docs/firestore/manage-data/add-data#update-data
    [[[[AppHelper db] collectionWithPath:FIRESTORE_USERS] documentWithPath:[[[AppHelper auth] currentUser] uid]] updateData:@{@"score": [NSNumber numberWithInteger:score]} completion:^(NSError * _Nullable error) {
        if(error) {
            [AppHelper presentSimpleAlertWithTitle:@"Error" Message:[error localizedDescription] adnViewController:self];
            return;
        }
    }];
}
@end
