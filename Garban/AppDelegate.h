//
//  AppDelegate.h
//  Garban
//
//  Created by Pablo Formoso Estrada on 07/12/11.
//  Copyright Pablo Formoso 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
