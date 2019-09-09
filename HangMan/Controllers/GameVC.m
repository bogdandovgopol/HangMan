//
//  GameVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 4/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "GameVC.h"

@implementation GameVC
@synthesize mode, gameState, lives, score, modeBonus, word, mysteryWord, guessedLetters, livesTxt, wrongGuessesTxt, wordToGuessTxt, guessedLetterTxt, guessCounter, incorrectGuesses;

- (void)viewDidLoad {
    [super viewDidLoad];
    //set navigation bar title
    [[self navigationItem] setTitle:[mode uppercaseString]];
    //access textfield specific functions
    guessedLetterTxt.delegate = self;
    //show keyboard
    [guessedLetterTxt becomeFirstResponder];

    //setup a game
    [self setupGame];
}

//listen to keyboard return button click
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //make sure guessedLetterTxt is not empty
    if(![guessedLetterTxt hasText] || [[guessedLetterTxt text] length] == 0) {
        [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"You have to guess a letter" adnViewController:self];
        return NO;
    }
    
    [self guess];
    return YES;
}

//limit textfield input to only 1 character
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 1);
    
}

- (void)setupGame {
    if([mode  isEqual: @"easy"]) {
        lives = 5;
        modeBonus = 10;
    }
    if([mode isEqual: @"hard"]) {
        lives = 3;
        modeBonus = 20;
    }
    guessedLetters = [NSMutableString stringWithString:@""];
    [livesTxt setText:[NSString stringWithFormat:@"%i", lives]];
    [self generateWord];
}

- (void)generateWord {
    NSArray *words = [NSArray arrayWithObjects:@"dance", @"shark", @"chair", @"smile", @"robot", @"happy", @"back", @"clap", @"circle", @"jump", @"sleep", @"car", @"elephant", @"alligator", @"head", @"bird", @"cheek", @"drink", @"airplane", @"camera", @"telephone", @"toothbrush", @"mosquito", @"football", @"kangaroo", @"australia", nil];
    //get a random word from array of words
    word = words[arc4random_uniform((int)[words count])];
    NSLog(@"WORD: %@", word);
    //replace characters with dashes
    self.mysteryWord = [NSMutableString stringWithString:@""];
    for (int i = 0; i < [word length]; i++) {
        [mysteryWord insertString:@"-" atIndex:i];
    }
    //show hidden word to user to guess
    [wordToGuessTxt setText:mysteryWord];
}

- (void)guess {
    NSString *guessedLetter = [guessedLetterTxt text];
    int appearences = 0;
    guessCounter++;
    
    
    //check if letter has been already guessed
    if([guessedLetters containsString:guessedLetter]) {
        //clear guessedLetterTxt
        [guessedLetterTxt setText:nil];
        //notify user
        [AppHelper presentSimpleAlertWithTitle:@"" Message:@"This letter has been already guessed" adnViewController:self];
        return;
    }
    
    //save guessed letter
    guessedLetters = [[guessedLetters stringByAppendingString:guessedLetter] mutableCopy];
    
    //find all character appearences and reveal them.
    for(int i = 0; i < [word length]; i++) {
        if([word characterAtIndex:i] == [guessedLetter characterAtIndex:0]) {
            appearences++;
            //reveal correctly guessed letters
            mysteryWord = [[mysteryWord stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:guessedLetter] mutableCopy];
        }
    }
    
    //if there was no character appearences found, deduct 1 life and add 1 incorrect guess
    if(appearences == 0) {
        lives--;
        incorrectGuesses++;
        [livesTxt setText:[NSString stringWithFormat:@"%i", lives]];
    }
    
    //if there was appearences found, check if word is guessed
    if(appearences > 0) {
        //if word is guessed set gameState to win, estimate a score value and redirect to GameOverVC
        if([mysteryWord isEqualToString:word]) {
            gameState = @"win";
            score += (int)[guessedLetters length] + guessCounter * 10 + modeBonus;
            [self performSegueWithIdentifier:TO_GAME_OVER_VC_SEGUE sender:nil];
        }
    }
    
    //check if player is out of lives, if yes update gameState to lose, add 1 to score and redirect to GameOverVC
    if(lives <= 0) {
        gameState = @"lose";
        score += 1;
        [self performSegueWithIdentifier:TO_GAME_OVER_VC_SEGUE sender:nil];
    }
    
    //update wordToGuess
    [wordToGuessTxt setText:mysteryWord];
    //update wrongGuessesTxt
    [wrongGuessesTxt setText:guessedLetters];
    //clear guessedLetterTxt
    [guessedLetterTxt setText:nil];
    
}

//preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //find segue
    if ([[segue identifier] isEqualToString:TO_GAME_OVER_VC_SEGUE])
    {
        //get reference to the destination view controller
        GameOverVC *vc = [segue destinationViewController];
        
        //pass data to GameVC
        vc.gameState = gameState;
        vc.score = score;
        vc.totalGuesses = guessCounter;
        vc.incorrectGuesses = incorrectGuesses;
        vc.answer = word;
    }
}

@end
