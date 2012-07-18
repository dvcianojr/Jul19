//
//  ViewController.m
//  Jul19
//
//  Created by Dominick Ciano on 7/18/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@implementation ViewController;
@synthesize text;
@synthesize viewTitle;
@synthesize symKey;

- (id) initWithText: (NSString *) t
			  title: (NSString *) title
			  image: (UIImage *) image
			  badge: (NSString *) badge {
	
	self = [super initWithNibName: nil bundle: nil];
	if (self != nil) {
		self.title = title;
		self.tabBarItem.image = image;
		self.tabBarItem.badgeValue = badge;
		self.text = t;		//text = [t copy];
		self.viewTitle = title;
		self.symKey = @"";
	}
	
	return self;
}


- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void) loadView
{
	//CGRect frame = [UIScreen mainScreen].applicationFrame;
	UIScreen *screen = [UIScreen mainScreen];
    CGRect bounds = screen.bounds;
	const CGRect rect1 = CGRectMake(
									0,    //x
									40,   //y
									bounds.size.width,  //width
									bounds.size.height - 40    //height
									);	

	CGRect frame = rect1;
	self.view = [[View alloc] initWithFrame: frame controller: self];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
	[super viewDidLoad];
}


- (void) viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

@end
