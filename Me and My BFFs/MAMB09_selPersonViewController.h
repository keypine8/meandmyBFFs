//
//  MAMB09_selPersonViewController.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-12-01.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>

hey a change 222  is here !!


@interface MAMB09_selPersonViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *outletForSelPersonTableViewController;

@property (strong, nonatomic) NSMutableArray *PSVs_for_person_picklist;  // now used for both person and group selection from hompco or hompbm
@property (strong, nonatomic) NSMutableArray *PSVs_for_group_picklist;

@end
