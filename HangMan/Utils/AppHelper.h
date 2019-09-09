//
//  AppHelper.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface AppHelper : NSObject

+ (FIRFirestore *)db;
+ (FIRAuth *)auth;
+ (void)presentSimpleAlertWithTitle: (NSString*) title Message: (NSString*) message adnViewController: (UIViewController*) vc;
+ (BOOL)isValidEmail: (NSString *)email;

@end

NS_ASSUME_NONNULL_END
