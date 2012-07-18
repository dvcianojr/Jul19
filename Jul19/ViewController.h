//
//  ViewController.h
//  Jul19
//
//  Created by Dominick Ciano on 7/18/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController: UIViewController {
	NSString *text;
	NSString *viewTitle;
	NSString *symKey;
}

- (id) initWithText: (NSString *) t
			  title: (NSString *) title
			  image: (UIImage *) image
			  badge: (NSString *) badge;

@property (nonatomic, copy) IBOutlet NSString *text;
@property (nonatomic, copy) IBOutlet NSString *viewTitle;
@property (nonatomic, copy) IBOutlet NSString *symKey;

@end
