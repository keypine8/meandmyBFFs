//
//  MAMB09viewTBLRPTs_1_TableViewController.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-02-26.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MAMB09viewTBLRPTs_1_TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *outletForViewTBLRPT1TableViewController;

@end
