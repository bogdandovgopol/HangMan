//
//  Constants.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "Constants.h"

@implementation Constants
//STORYBOARDS
NSString * const AUTH_STORYBOARD = @"Authentication";
NSString * const MAIN_STORYBOARD = @"Main";

//IDENTIFICATORS
NSString * const SIGNINVC_ID = @"SignInVC";
NSString * const MENUVC_ID = @"MenuVC";
NSString * const LEADERBOARD_CELL_ID = @"LeaderBoardCell";

//SEGUES
NSString * const TO_GAME_SEGUE = @"toGame";
NSString * const TO_GAME_OVER_VC_SEGUE = @"toGameOverVC";

//FIRESTORE
NSString * const FIRESTORE_USERS = @"users";

@end
