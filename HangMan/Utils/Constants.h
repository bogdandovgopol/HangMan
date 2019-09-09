//
//  Constants.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Constants : NSObject
//STORYBOARDS
extern NSString * const AUTH_STORYBOARD;
extern NSString * const MAIN_STORYBOARD;

//IDENTIFICATORS
extern NSString * const SIGNINVC_ID;
extern NSString * const MENUVC_ID;
extern NSString * const LEADERBOARD_CELL_ID;

//SEGUES
extern NSString * const TO_GAME_SEGUE;
extern NSString * const TO_GAME_OVER_VC_SEGUE;

//FIRESTORE
extern NSString * const FIRESTORE_USERS;

@end

NS_ASSUME_NONNULL_END
