//
//  MAMB09_viewHTMLViewController.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-11-19.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAMB09_viewHTMLViewController : UIViewController

@property (strong, nonatomic) NSString *fromHomeCurrentSelection;     // CSV  for per or grp or pair of people
@property (strong, nonatomic) NSString *fromHomeCurrentSelectionType; // like "group" or "person" or "pair"
@property (strong, nonatomic) NSString *fromHomeCurrentEntity;        // like "group" or "person"

@property (nonatomic)         NSInteger fromSelRptRowNumber;  // row in tableView
@property (strong, nonatomic) NSString *fromSelRptRowString;  // like "Personality"

@end
