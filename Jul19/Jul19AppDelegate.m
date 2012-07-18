//
//  Jul19AppDelegate.m
//  Jul19
//
//  Created by Dominick Ciano on 7/18/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import "Jul19AppDelegate.h"
#include "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation Jul19AppDelegate

@synthesize window = _window;

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
	
	// Override point for customization after application launch.
	UITabBarController *tabBarController = [[UITabBarController alloc] init];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:
										
										[[ViewController alloc]
										 initWithText: @"       Stock Book - Prices"	
										 title: @"Prices"
										 image: [UIImage imageNamed: @"172-pricetag.png"]
										 badge: nil
										 ],
										
										[[ViewController alloc]
										 initWithText: @"      Stock Book - Earnings"
										 title: @"Earnings"
										 image: [UIImage imageNamed: @"119-piggy-bank"]
										 badge: nil
										 ],
										
										[[ViewController alloc]
										 initWithText: @"     Stock Book - Dividends"
										 title: @"Dividends"
										 image: [UIImage imageNamed: @"Dollar Sign.png"]
										 badge: nil
										 ],
										
										[[ViewController alloc]
										 initWithText: @"    Stock Book - Fundamentals"
										 title: @"Fundamentals"
										 image: [UIImage imageNamed: @"161-calculator.png"]
										 badge:nil
										 ],			
										nil
										];
	
	tabBarController.selectedIndex = 0;	//0 (the leftmost one) is the default
	self.window.rootViewController = tabBarController;
	[self.window makeKeyAndVisible];
	for (int i=0; i<4; ++i)
	{
		ViewController *v = [tabBarController.viewControllers objectAtIndex:i];
		v.symKey = @"IBM";
	}
	
// take screenshot - currently remmed out since it was only needed for building app's icon 
//		UIGraphicsBeginImageContext(self.window.bounds.size);
//		[self.window.layer renderInContext: UIGraphicsGetCurrentContext()];
//		UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//		UIGraphicsEndImageContext();
//		
//		if (image == nil) {
//			NSLog(@"UIGraphicsGetImageFromCurrentImageContext failed");
//			return YES;
//		}
//		
//		NSData *d = UIImagePNGRepresentation(image);
//		if (d == nil) {
//			NSLog(@"UIImagePNGRepresentation failed");
//			return YES;
//		}
//		
//		NSString *fileName = [NSString stringWithFormat:
//							  @"%@/jul19snapshot.png", NSHomeDirectory()];
//		
//		if (![d writeToFile: fileName atomically: NO]) {
//			NSLog(@"writeToFile:atomically: failed");
//			return YES;
//		}	
//	
	
	
	
	
	return YES;
}

- (void) applicationWillResignActive: (UIApplication *) application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void) applicationDidEnterBackground: (UIApplication *) application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void) applicationWillEnterForeground: (UIApplication *) application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void) applicationDidBecomeActive: (UIApplication *) application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void) applicationWillTerminate: (UIApplication *) application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

@end
