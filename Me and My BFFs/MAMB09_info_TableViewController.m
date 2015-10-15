//
//  MAMB09_info_TableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-04-01.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import "MAMB09_info_TableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_info_TableViewController ()

@end


NSString *myMostTitle; // for Most ... reports
NSString *myMostWhat;  // like "Passionate"
NSString *myBestTitle; // for Best ... reports
NSString *myBestWhat;  // like "Day"

NSString *myGoodBadText;  // for trait


@implementation MAMB09_info_TableViewController


- (void)didReceiveMemoryWarning {
    //    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"The App received a Memory Warning"
                                                                   message: @"The system has determined that the \namount of available memory is very low."
                                                            preferredStyle: UIAlertControllerStyleAlert  ];
     
    UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                        style: UIAlertActionStyleDefault
                                                      handler: ^(UIAlertAction * action) {
        NSLog(@"Ok button pressed");
    } ];
    [alert addAction:  okButton];
    [self presentViewController: alert  animated: YES  completion: nil   ];
    [super didReceiveMemoryWarning];
} // didReceiveMemoryWarning 


- (void)viewDidLoad {
    [super viewDidLoad];
    
    fopen_fpdb_for_debug();
    NSLog(@"in INFO   viewDidLoad!");
  NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);

tn(); NSLog(@"in INFO   viewDidLoad!");
  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);      // any of the above 14 RPTs
  NSLog(@"gbl_PSVtappedPersonA_inPair=%@",gbl_PSVtappedPersonA_inPair);      // hompbm,homgbm,pbmco,gbmco
  NSLog(@"gbl_PSVtappedPersonB_inPair=%@",gbl_PSVtappedPersonB_inPair);      // same
  NSLog(@"gbl_TBLRPTS1_PSV_personA=%@",gbl_TBLRPTS1_PSV_personA);            // of pair
  NSLog(@"gbl_TBLRPTS1_PSV_personB=%@",gbl_TBLRPTS1_PSV_personB);            // of pair
  NSLog(@"gbl_TBLRPTS1_PSV_personJust1=%@",gbl_TBLRPTS1_PSV_personJust1);    // for single person reports
  NSLog(@"gbl_TBLRPTS1_NAME_personA=%@",gbl_TBLRPTS1_NAME_personA);          // of pair
  NSLog(@"gbl_TBLRPTS1_NAME_personB=%@",gbl_TBLRPTS1_NAME_personB);          // of pair
  NSLog(@"gbl_TBLRPTS1_NAME_personJust1=%@",gbl_TBLRPTS1_NAME_personJust1);  // for single person reports
tn();

//    trn("in INFO   viewDidLoad!");
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


    //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m


    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; // remove separator lines between cells


    //self.tableView.backgroundColor = gbl_color_cHed;   // WORKS
    self.tableView.backgroundColor = gbl_color_cBgr;   // WORKS


    // When I am navigating back & forth, i see a dark shadow
    // on the right side of navigation bar at top. 
    // It feels rough and distracting. How can I get rid of it?
    //
    self.navigationController.navigationBar.translucent = NO; 
    //
    //http://stackoverflow.com/questions/22413193/dark-shadow-on-navigation-bar-during-segue-transition-after-upgrading-to-xcode-5

    // gbl_currentMenuPlusReportCode decides what info text to put  (set on SELRPT TAP, most/best row TAP, HOME enter)

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"HOME"]    // home screen for app (startup screen)
    ) {
        gbl_helpScreenDescription = @"HOME";
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: @"Me and my BFFS "];
        });
    }

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"]    // calendar year
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbypcy"] 
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]    //  from best year
    ) {
        gbl_helpScreenDescription = @"calendar year";
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: @"Long-term Stress Levels"];
        });
    }

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]    // my best match (grpone)
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]    // my best match (grpone)

      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]    // my best match (grpone)
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]    // my best match (grpone)

      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]    //    best match (grpall)
    ) {
        gbl_helpScreenDescription = @"best match";
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: @"Best Match"];
        });
    }


    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]    // what color is the day?
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]    // what color is the day?
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]    // what color is the day? from best day
    ) {
        gbl_helpScreenDescription = @"what color";
        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: @"Short-term Stress Levels"];
        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]   // Personality

        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]   // Personality

        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]   // Personality

        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmappe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmeppe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmrppe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmpppe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmdppe"]   // Personality
    ) {
        gbl_helpScreenDescription = @"personality";
        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: @"Personality"];
        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]   // compatibility just 2 people
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbmco"]   // compatibility just 2 people
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbmco"]   // compatibility just 2 people
    ) {
        gbl_helpScreenDescription = @"just 2";
        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: @"Compatibility Potential"];
        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
    ) {
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Assertive";
            myMostWhat                = @"Assertive";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Emotional";
            myMostWhat                = @"Emotional";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Restless";
            myMostWhat                = @"Restless";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Passionate";
            myMostWhat                = @"Passionate";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Down-to-earth";
            myMostWhat                = @"Down-to-earth";
        }

        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: myMostTitle];  // like Most Passionate in Swim Team
        });
    } // all Most reports


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]   // Best Year
    ) {
        gbl_helpScreenDescription = @"best year";
        myMostTitle               = @"Best Year in Group";
        myMostWhat                = @"Best Year";

        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: myMostTitle];  // like Most Passionate in Swim Team
        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]   // Best Day
    ) {
        gbl_helpScreenDescription = @"best day";
        myMostTitle               = @"Best Day in Group";
        myMostWhat                = @"Best Day";

        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
            [[self navigationItem] setTitle: myMostTitle];  // like Most Passionate in Swim Team
        });
    }

} // viewDidLoad



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//  NSLog(@"in IINFO   cellForRowAtIndexPath!");
//  NSLog(@"indexPath.row=%ld",indexPath.row);

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"view_info_CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: CellIdentifier];
    }

//    UIImage *myImageWhatColor        = [UIImage  imageNamed: @"whatColor_info2.png" inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageWhatColor        = [UIImage  imageNamed: @"whatColor_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageScore            = [UIImage  imageNamed: @"score_info2.png"       inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings2       = [UIImage  imageNamed: @"twoThings_info.png"  inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info3.png"      inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info2.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageWillpower        = [UIImage  imageNamed: @"willpower_info2.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info6.png"      inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info8.png"      inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info3.png" inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info9.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info5.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info8.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageWillpower        = [UIImage  imageNamed: @"willpower_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageDestiny          = [UIImage  imageNamed: @"overcomDestiny_info2.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageTraits           = [UIImage  imageNamed: @"overcomTraits_info2.png"    inBundle: nil compatibleWithTraitCollection: nil ];


//    UIFont *myFont       = [UIFont fontWithName: @"Menlo-bold" size: 12.0];
    UIFont *myFont       = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
//    UIFont *myFont       = [UIFont fontWithName: @"Menlo"      size: 12.0];

    UIFont *myFontOnSide = [UIFont fontWithName: @"Menlo-bold" size: 10.0];
//    UIFont *myFontOnSide = [UIFont fontWithName: @"Menlo"      size: 10.0];

//    UIFont *myTitleFont  = [UIFont fontWithName: @"Menlo-bold" size: 13.1];
    UIFont *myTitleFont  = [UIFont fontWithName: @"Menlo-bold" size: 14.5];

//    UIFont *myDisclaimerFont= [UIFont fontWithName: @"Menlo-bold" size:  8.0];
    UIFont *myDisclaimerFont= [UIFont fontWithName: @"Menlo-bold" size:  9.0];

    NSString *myTextLabelTextAddOn;  // depends on report

    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"calendar year"] )
    {
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 1) {
            NSString *myIntroString;
            myIntroString = [NSString stringWithFormat: 
                @"The two 6-month Graphs show the overall stress level for %@ on every second day in %ld.", 
//                gbl_lastSelectedPerson, (long)gbl_currentYearInt];
                gbl_viewHTML_NAME_personJust1, (long)gbl_currentYearInt];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== intro text for FUT
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = myIntroString;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for score info 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Labels inside the Graph";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {
            NSString *text_cGr2 = @" GREAT  ";
            NSString *text_cGre = @" GOOD   ";
            NSString *text_cNeu = @" neutral  grey area (no label) ";
            NSString *text_cRed = @" STRESS ";
            NSString *text_cRe2 = @" OMG    ";

            NSString *allLabelExplaintext = [NSString stringWithFormat:
//              @" %@  very peaceful\n %@  peaceful\n %@\n %@  stressful\n %@  very stressful\n\n  Stressful and very stressful zones are colored red because stress is generally considered challenging.\n\n  The green zones are the opposite of stress.  Notice that the opposite of stressful is peaceful.\n\nIf your graph goes way up into the green zones, it generally does not mean fantastic excitement with kaleidiscopic fireworks.  Green means serene, calm, restful, tranquil.",
              @" %@  very peaceful\n %@  peaceful\n %@\n %@  stressful\n %@  very stressful\n\nThe stressful and very stressful zones are colored red.\n\nThe green zones are the opposite of stressful.  Notice that the opposite of stressful is peaceful.\n\nIf your graph goes way up into the green zones, it generally does not mean fantastic excitement with fireworks.  Green is serene, calm, restful, tranquil.",
                text_cGr2,
                text_cGre,
                text_cNeu,
                text_cRed,
                text_cRe2 
            ];

//  NSLog(@"allLabelExplaintext =%@",allLabelExplaintext );
//  NSLog(@"text_cGr2=%@",text_cGr2);

            // Define needed attributes for the entire allLabelExplaintext 
            NSDictionary *myNeededAttribs = @{
//                                      NSForegroundColorAttributeName: self.label.textColor,
//                                      NSBackgroundColorAttributeName: cell.textLabel.attributedText
//                                      NSBackgroundColorAttributeName: cell.textLabel.textColor
                                      NSFontAttributeName: cell.textLabel.font,
                                      NSBackgroundColorAttributeName: cell.textLabel.backgroundColor
                                      };

            NSMutableAttributedString *myAttributedTextLabelExplain = 
                [[NSMutableAttributedString alloc] initWithString: allLabelExplaintext
                                                       attributes: myNeededAttribs     ];

//  NSLog(@"myAttributedTextLabelExplain #1 =%@",myAttributedTextLabelExplain );

            // set text attributes on appropriate substring text inside myAttributedTextLabelExplain 
            // * Notice that usage of rangeOfString here may cause some bugs - I use it here only for demonstration
            //
            //       e.g.   range: NSMakeRange(0,9)  ];          // offset, length
            // 
            NSRange range_cGr2 = [allLabelExplaintext rangeOfString: text_cGr2];
            NSRange range_cGre = [allLabelExplaintext rangeOfString: text_cGre];
            NSRange range_cNeu = [allLabelExplaintext rangeOfString: text_cNeu];
            NSRange range_cRed = [allLabelExplaintext rangeOfString: text_cRed];
            NSRange range_cRe2 = [allLabelExplaintext rangeOfString: text_cRe2];

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cGr2 
                                                 range: range_cGr2        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFont 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cGre 
                                                 range: range_cGre        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFont 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cNeu 
                                                 range: range_cNeu        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFont 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cRed 
                                                 range: range_cRed        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFont 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cRe2 
                                                 range: range_cRe2        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFont 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length


//  NSLog(@"myAttributedTextLabelExplain #2 =%@",myAttributedTextLabelExplain );


//  NSLog(@"myAttributedTextLabelExplain #7 =%@",myAttributedTextLabelExplain );

            // BEWARE: the order and what is here is a fragile house of cards    DO NOT CHANGE ANYTHING
            //
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for label explain
                cell.textLabel.textColor      = [UIColor blackColor];
                cell.userInteractionEnabled   = NO;
                cell.textLabel.font           = myFont;
                cell.backgroundColor          = gbl_color_cBgr;
                cell.textLabel.numberOfLines  = 0;
//                cell.textLabel.numberOfLines  = 25;
                cell.textLabel.text           = allLabelExplaintext; // for test
                cell.textLabel.attributedText = myAttributedTextLabelExplain;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

                cell.imageView.image          = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView           = nil ;
            });
            return cell;
        }
        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
            });
            return cell;
        }
        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for time frame influences
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Time Frame Influences";
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
            });
            return cell;
        }
        if (indexPath.row == 7) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for time frame influences
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"A starting date and ending date tell when the inluence for that time frame is working.  The influence will be favorable or challenging.\n\nChallenging influences look like a valley or letter \"u\" on the graph.\nFrom the start of the time frame the influence gradually falls down to it's lowest point at the middle of the time frame.  From there, it gradually rises up until it reaches the end of the time frame.\n\nFavorable influences look like a hill or letter \"n\" on the graph.\nFrom the beginning of the time frame the influence gradually rises up to it's highest point at the middle of the time frame.  From there, it gradually falls down until it reaches the end of the time frame.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 8) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"The 1 to 99 Score for the Whole Year";
                cell.textLabel.text          = @"Year Summary Score";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"A score from 1 to 99 is calculated from the amount of time spent in the green zones and red zones over the whole year.\n\nThe score tells how favorable or challenging the year overall is.\n\nChallenging times can be tough. However, because we have free will, even challenging times can be bettered by will power.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 11) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 12) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
            });
            return cell;
        }
        if (indexPath.row == 13) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 14) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }



//"
//
//The Labels on the Graph
//
//
//GREAT   very peaceful
//GOOD    peaceful
//neutral grey area (no label)
//STRESS  stressful
//OMG     very stressful
//
//Stressful and very stressful zones are colored red because stress is generally considered negative.
//The green zones are the opposite of Stress.
//Notice that the opposite of stressful is peaceful.
//If your graph goes way up into the green zones, it generally does not mean
//fantastic excitement with kaleidiscopic fireworks. 
//Green means serene, calm, restful, tranquil.  Think yoga meditation.
//
//
//The Important Periods
//
//Each period has a date range when the inluence for the period is in effect.
//The influence will be favorable or challenging.  
//
//On the graph, favorable influences look like a hill or letter "n".  
//From the beginning of the date range
//the influence gradually rises up
//to the highest point at the middle of the date range.
//From there, the influence gradually falls down
//until it reaches the end of the date range.
//
//On the graph, challenging influences look like a valley or letter "u".  
//From the start of the date range
//the influence gradually falls down
//to the lowest point at the middle of the date range.
//From there, the influence gradually rises up
//until it reaches the end of the date range.
//
//the 1 to 99 "score" for the year
//
//";
//
//
//        UIFont *currentFont       = cell.textLabel.font;
//        UIFont *currentFontBolded = [myappDelegate boldFontWithFont: (UIFont *) currentFont];
////  NSLog(@"currentFontBolded =%@",currentFontBolded );
//
//        //myNewCellText                = @"    This report is for entertainment purposes only.  ";
//        NSAttributedString *myNewCellAttributedText2 = [
//            [NSAttributedString alloc] initWithString:  @"       This report is for entertainment purposes only.  "
//                                           attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
//                                                           NSForegroundColorAttributeName: [UIColor redColor]               }
//        ];
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            cell.textLabel.font           = currentFontBolded;
//            cell.textLabel.numberOfLines  = 1; 
//            cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
//            cell.userInteractionEnabled   = NO;
//            cell.textLabel.attributedText = myNewCellAttributedText2;
//        });
//
//        return cell;
//
//    }  // end of 3 of 3 FOOTER CELLS
//
//
    } // end of "calendar year"


    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"best match"] )   // my best match (grpone)  plus best match (grpall)
    {
nbn(100);
        if (indexPath.row == 0) {                              // <===  preamble
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"The scores in this report measure Compatibility Potential: how likely two people can form a good relationship, assuming both people also show mostly positive personality traits.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for score info 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Scores in Group Reports";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 4) {                          // score image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"All group Reports are ranked by Score\n\nScores go from 1 to 99\n\nA score of 88 is higher than 88% of all scores in the world\n\nA score of 11 is higher than 11% of all scores in the world \n\nEach score is called a Percentile Rank\n\nHighest 25% are green\nLowest  25% are red";

                cell.imageView.image         = myImageScore;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 5) {

nbn(100);
//            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]
//            ){   // my best match (grpone)
//
//                myTextLabelTextAddOn = [NSString stringWithFormat: 
//                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
////                    gbl_lastSelectedPerson, gbl_lastSelectedGroup, gbl_lastSelectedPerson];
//                    gbl_TBLRPTS1_NAME_personJust1, gbl_lastSelectedGroup, gbl_TBLRPTS1_NAME_personJust1];
////  NSLog(@"gbl_TBLRPTS1_PSV_personJust1=%@",gbl_TBLRPTS1_PSV_personJust1);
//
//


//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]    // my best match (grpone)
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]    // my best match (grpone)
//
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]    // my best match (grpone)
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]    // my best match (grpone)
//
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]    //    best match (grpall)
//    ) 
//


//            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
                   if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
            ) {   // my best match (grpone)  FROM home > choose person > choose RPT best match in grp > choose group
                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
                    gbl_TBLRPTS1_NAME_personJust1, gbl_lastSelectedGroup, gbl_TBLRPTS1_NAME_personJust1];

            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]
            ) {   //    best match (grpall)  FROM home > choose group > choose RPT best match
                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match in Group %@\", each score measures the compatibility potential for two people who are members of the group.",
                     gbl_lastSelectedGroup];

            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]
            ) {   // my best match (grpone) FROM home > choose grp > choose RPT best match > TAP pair > choose RPT best match for A in same group

                NSString *myPersonA_name;
                myPersonA_name = [gbl_PSVtappedPersonA_inPair componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
                    myPersonA_name , gbl_lastSelectedGroup, myPersonA_name ];

            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]
                       || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]
            ) {   // my best match (grpone) FROM home > TAP grp > SELRPT best match >                  TAP pair > SELRPT best match for B in same grp
                  // my best match (grpone) FROM home > TAP per > SELRPT best match in grp > TAP grp > TAP pair > SELRPT best match for B in same grp
                NSString *myPersonB_name;
                myPersonB_name = [gbl_PSVtappedPersonB_inPair componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
                    myPersonB_name , gbl_lastSelectedGroup, myPersonB_name ];


            } else {
                myTextLabelTextAddOn = @" ";
            }

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          =  myTextLabelTextAddOn;
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 7) {                                // <=== title for Complexity info 
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Relationships are Complex";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 8) {                              // <===  complexity #1
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility score if one of the two people (or both) have bad personality traits.";
                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility score if one of the two people (or both) have challenging personality traits.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 9) {                            // <=== two things image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;
                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageTwoThings] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 11) {                         // <===  complexity #2
            dispatch_async(dispatch_get_main_queue(), ^{        
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  Habits are extremely difficult to overcome, but it can be done.";
                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  Overcoming habits is very hard, but possible.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 12) {                            // <=== two things image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageWillpower] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 13) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 14) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }


    } // end of "best match"


    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"just 2"] )   // "Compatibility Paired with ..." or "Compatibility Potential"
    {
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 1) {                          // preamble
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Compatiblity Potential is how likely two people can form a good relationship-  assuming both people also show mostly positive personality traits.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for score info 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Compatibility Potential Score";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 4) {                          // score image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"\nScores go from 1 to 99\n\nA score of 88 is higher than 88% of all scores in the world\n\nA score of 11 is higher than 11% of all scores in the world \n\nEach score is called a Percentile Rank\n\nHighest 25% are green\nLowest  25% are red";

                cell.imageView.image         = myImageScore;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {                              // <===  complexity #1
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility score if one of the two people (or both) have bad personality traits.";

                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility score if one of the two people (or both) have challenging personality traits.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 7) {                            // <=== two things image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageTwoThings] ;
            });
            return cell;
        }
        if (indexPath.row == 8) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 9) {                         // <===  complexity #2
            dispatch_async(dispatch_get_main_queue(), ^{        
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"HOWEVER, because we have free will, even bad personality traits can be overcome by intense will power.  It is extremely difficult to overcome bad habits, but it can be done.";
//                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  It is extremely difficult to overcome habits, but it can be done.";
                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  Overcoming habits is very hard, but possible.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {                            // <=== willpower image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageWillpower] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 11) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 12) {                                // <=== title for 3 categories  3 fun categories
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"The 3 Fun Categories";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 13) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 14) {                              // <===  text #1 for 3 categories
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Out of the many factors making up the Compatibility Potential Score, these 3 categories are fun to look at separately.";

                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 15) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 16) {                            // <=== 3 categories image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageCategories3] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 17) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 18) {                              // <===  text #2 for 3 categories
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

                cell.textLabel.text          = @"The \"Closeness\" category is useful because it shows the natural ease of liking the other person in a comfortable way.\n\nThe 2 \"Point of view\" categories occasionally show that one of the two people sees the relationship as being very favorable but the other person sees it as very challenging.";

                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 19) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 20) {                                // <=== title for Complexity info 
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Relationships are Complex";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 21) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"The compatibility details on the bottom give a LOT of detail.  It's hard work to combine the differing influences into an overall picture.\n\nIn doing his integration you have\n  - the 3 fun categories\n  - details at the bottom\n  - a personality report for each\n    of the 2 people\n\nA lot of the integration is done for you in the compatibility Potential score from 1 to 99.";
//This is why consulting astrologers can make a living meeting with people for an hour to sort everything out

                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 22) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }

    } // end of "just 2"



 

    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"what color"]  )
    {

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"What Color is the Day?\n\nUse this report to check out today and yesterday and the next few days.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;


            });
            return cell;
        }
        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"The score measures stress levels on this day for this person.\n\nA day with a lower score, say below 10, is likely to be more stressful, whereas a day with a high score, like above 90, is likely to be more peaceful.";
//                cell.textLabel.text          = @"The score measures stress levels on this day for this person.\n\nFor example, a day with a lower score in the red zones is likely to be more stressful, whereas a day with a higher score in the green zones is likely to be more peaceful.";
                cell.textLabel.text          = @"The score measures stress levels on this day for this person.\n\nA day with a lower score in the red zones is more likely to have stressful times, whereas a day with a higher score in the green zones is more likely to have peaceful times.";

                cell.imageView.image = myImageWhatColor;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"The stress level score in this report is calculated from very short-term influences whose effects last just a few hours or a day or two.\n\nFar more important is the \"Calendar Year\" report where the influences are much stronger and they can last for many weeks or even months.";
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  6) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }

    } // end of "what color"


    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"personality"] )
    {

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {                                // <=== size of traits
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Size of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 2) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          =  @"Each TRAIT is a general catgegory of interest in a person.\n\nEach SCORE for a trait measures \"how much\" of that trait the person has.\n\nA really low score or really high score is neither good nor bad.  The score just measures how much of that trait the person has.";
                cell.textLabel.text          =  @"Each TRAIT is a general catgegory of interest in a person.\n\nEach SCORE for a trait measures \"how much\" of that trait the person has.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world\n\nA really low score or really high score is neither favorable nor challenging. That's why the scores are not shown with the colors green/red because those colors mean favorable/challenging.";
//
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"example";

                cell.imageView.image = myImagePersonality;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {
//            UIFont *myFontSpecial1 = [UIFont fontWithName: @"Menlo-bold" size: 10.0];
//            UIFont *myFontSpecial1 = [UIFont fontWithName: @"Menlo" size: 10.0];
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide ;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

                cell.textLabel.text          = @"Down-to-earth\n     stable, practical, ambitious\nPassionate\n     intense, enthusiastic, relentless\nEmotional\n     protective, sensitive, possessive\nRestless\n     versatile, independent, changeable\nAssertive\n     competitive, authoritative, outspoken";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
//        if (indexPath.row == 5) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.textLabel.font          = myFont;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//
//                cell.textLabel.text          = [NSString stringWithFormat: 
//                    @"To compare %@'s highest score of %@ in \"%@\" against all people in a group, go to a group %@ is in and look at the report \"Most %@\".",
//                    gbl_viewHTML_NAME_personJust1,
//                    gbl_highestTraitScore,             // this goes in INFO for personality
//                    gbl_highestTraitScoreDescription,  // this goes in INFO for personality
//                    gbl_viewHTML_NAME_personJust1,
//                    gbl_highestTraitScoreDescription   // this goes in INFO for personality
//                ];
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//
//        if (indexPath.row == 6) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.textLabel.font          = myFont;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
////                cell.textLabel.text          = @"Scores go from 1 to 99\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world\nEach score is called a Percentile Rank";
//                cell.textLabel.text          = @"Scores go from 1 to 99\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world";
//                cell.imageView.image         = nil;
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {                                // <=== title for quality of traits
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Quality of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 7) {                                // text for quality
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide ;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"The text below the table of traits gives favorable and challenging influences.\n\nBUT, a person can use FREE WILL to act on traits and change them.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

//        if (indexPath.row == 8) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
//                cell.textLabel.font          = myFontOnSide;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = nil;
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//
//
        if (indexPath.row == 8) {                            // <=== overcome traits image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageTraits] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }

    } // end of "personality"


    if (  [gbl_helpScreenDescription isEqualToString: @"most reports"] )
    {   // all Most ... in Group ... reports

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 1) {                                // <=== title for how much
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Size of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 2) {


            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = [NSString stringWithFormat: @"This %@ report measures the \"size\" of the trait %@ within each person.\n\nEach SCORE measures \"how much\" of the trait %@ the person has.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88%% of all scores in the world\nA score of 11 is higher than 11%% of all scores in the world\n\nA really low score or really high score is neither favorable nor challenging. That's why the scores are not shown with the colors green/red because those colors mean favorable/challenging.",
                    myMostTitle, myMostWhat, myMostWhat
                ];
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {                                // <=== title for quality of traits
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Quality of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 4) {                                // <=== reference to Personality report
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"The Personality report for each person gives you the \"quality\" of the personality traits of that person.\n\nIn the Personality report look at the text below the table.  This is where favorable and challenging influences are.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 5) {

            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of %@ might be a domineering approach or hot-tempered behavior.\n\nA favorable expression of %@ might be acting as a good leader and speaking up against injustices. ", myMostWhat , myMostWhat ];
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of %@ might be extreme sensitivity or being too impressionable.\n\nA favorable expression of %@ might be alertness to other's feelings and protecting those less fortunate. ", myMostWhat , myMostWhat ];

            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of %@ might be a scattered approach and changeableness.\n\nA favorable expression of %@ might be independence and versatility.", myMostWhat , myMostWhat ];
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of %@ might be overpowering intensity or holding grudges.\n\nA favorable expression of %@ might be enthusiasm or doing a job with intensity.", myMostWhat , myMostWhat ];
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of %@ might be rigidity and an uncompromising approach.\n\nA favorable expression of %@ might be stability and a practical approach. ", myMostWhat , myMostWhat ];
            }

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFont;
                ;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = myGoodBadText;
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {                            // <=== overcome traits image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageTraits] ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 7) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  8) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }
    }   // all Most ... in Group ... reports


    if (  [gbl_helpScreenDescription isEqualToString: @"best year"] )
    {   // all Most ... in Group ... reports

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Year Summary Score";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

                cell.textLabel.text          = @"The score tells how favorable or challenging the year overall is.\n\nA score is given for each person for the year.  The Calendar Year graph for the person is looked at. The amount of time that person spent in the green favorable zones and red challenging zones of the graph over the whole year determines the score.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world.\n\nChallenging times can be tough. However, because we have free will, even challenging times can be bettered by will power.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  6) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }

    } // end of gbl_helpScreenDescription   "best year"


    if (  [gbl_helpScreenDescription isEqualToString: @"best day"] )
    { 

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Score for the Day";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

                cell.textLabel.text          = [NSString stringWithFormat: @"The score measures stress levels on this day for each person person in group %@.\n\nA day with a lower score in the red zones is more likely to have stressful times, whereas a day with a higher score in the green zones is more likely to have peaceful times.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88%% of all scores in the world\nA score of 11 is higher than 11%% of all scores in the world.\n\nThe stress level score in this report is calculated from very short-term influences whose effects last just a few hours or a day or two.\n\nFar more important is the \"Calendar Year\" report where the influences are much stronger and they can last for many weeks or even months.", gbl_lastSelectedGroup];

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;

                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  6) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }

    } // end of gbl_helpScreenDescription   "best year"

    if (  [gbl_helpScreenDescription isEqualToString: @"HOME"] )
    { 

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

//        if (indexPath.row == 1) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== home preamble
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
//                cell.textLabel.font          = myFont;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
//
////                cell.textLabel.text          = @" Gather \"Me and my BFFs\" together and have fun using this app.";
////                cell.textLabel.text          = @" \"Me and my BFFs\" get together and have fun using this app.";
//                cell.textLabel.text          = @" To have fun, get \"Me and my BFFs\" together and use this app.";
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//
        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for do stuff
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"How to Do Stuff";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }


        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== do stuff text
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"To send ANY REPORT as an email attachment, tap \"Share\"\n\nTo email a Group to a BFF who has this app, go to the Group, then tap \"Share\"\n\nTo import a Group someone has emailed you, open the email on the device where you have this app, and tap and hold on the email attachment";
                cell.textLabel.text          = @"To send ANY REPORT as an email attachment, tap \"Share\"\n\nTo email a Group to a BFF who has this app, go to the Group, then tap \"Share\"\n\nTo import a Group someone has emailed you, open the email on the device where you have this app, and tap and hold on the email attachment\n\nTo have fun, get \"Me and my BFFs\" together and use this app.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for report list
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Reports";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }



        if (indexPath.row == 4) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== report list 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @" - Calendar Year stress levels\n - Personality\n - Compatibility Potential of two people\n - What Color is Today for Me?\n - Best Match for a Person in a Group\n\n - in a Group, Best Matched Pair\n - in a Group, Most Emotional Person\n - in a Group, Most Down-to-earth Person\n - in a Group, Most Passionate Person\n - in a Group, Most Assertive Person\n - in a Group, Most Restless Person";
                cell.textLabel.text          = @" - Calendar Year stress levels\n - What Color is Today for Me?\n - Personality\n - Compatibility Potential of two people\n - Best Match for a Person in a Group\n\n - in a Group, Best Matched Pair\n - in a Group, Most Emotional Person\n - in a Group, Most Down-to-earth Person\n - in a Group, Most Passionate Person\n - in a Group, Most Assertive Person\n - in a Group, Most Restless Person";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Why Not ?
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Why Not ?";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for why not
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Study human factors on sports teams\n\nBe a matchmaker by using the reports \"Best Match\" and \"Personality\"\n\nSend questions and comments to QQQQQ@QQQQQ.com";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row ==  7) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"All reports are for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }
    } // end of gbl_helpScreenDescription   "HOME"
//<.>



    return cell;

} // end of  cellForRowAtIndexPath:(NSIndexPath *)indexPath


// ---------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  // Return the number of rows in the section.
    //    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) {   return 3; } // my best match (grpone)

    if ([gbl_helpScreenDescription isEqualToString: @"most reports" ] ) { return  9; } 
    if ([gbl_helpScreenDescription isEqualToString: @"personality"  ] ) { return 11; } 
    if ([gbl_helpScreenDescription isEqualToString: @"best match"   ] ) { return 15; }  
    if ([gbl_helpScreenDescription isEqualToString: @"what color"   ] ) { return  7; }
    if ([gbl_helpScreenDescription isEqualToString: @"just 2"       ] ) { return 23; }  // compatibility just 2 people
    if ([gbl_helpScreenDescription isEqualToString: @"calendar year"] ) { return 15; } 
    if ([gbl_helpScreenDescription isEqualToString: @"best year"    ] ) { return  7; } 
    if ([gbl_helpScreenDescription isEqualToString: @"best day"     ] ) { return  7; } 
    if ([gbl_helpScreenDescription isEqualToString: @"HOME"         ] ) { return  8; } 
    return 1;
}

// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
//  NSLog(@"in heightForRowAtIndexPath  INFO ");

    if (   [gbl_helpScreenDescription isEqualToString: @"HOME"] ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
//        if (indexPath.row ==   1) return    50.0;  // home preamble
        if (indexPath.row ==   1) return    30.0;  // title for do stuff
//        if (indexPath.row ==   2) return   150.0;  // text  for do stuff
//        if (indexPath.row ==   2) return   170.0;  // text  for do stuff
        if (indexPath.row ==   2) return   160.0;  // text  for do stuff
        if (indexPath.row ==   3) return    30.0;  // title for report list
//        if (indexPath.row ==   4) return   170.0;  // report  list
        if (indexPath.row ==   4) return   160.0;  // report  list

        if (indexPath.row ==   5) return    30.0;  // title for why not ?
//        if (indexPath.row ==   6) return    90.0;  // text  for why not ?
        if (indexPath.row ==   6) return    84.0;  // text  for why not ?

        if (indexPath.row ==   7) return    20.0;  // text for disclaimer
//<.>
    }
    if (   [gbl_helpScreenDescription isEqualToString: @"best day"] ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for Score for the Year
        if (indexPath.row ==   2) return   325.0;  // text  for Score for the Year
        if (indexPath.row ==   3) return     8.0;  // spacer
        if (indexPath.row ==   4) return    55.0;  // image for overcome destiny
        if (indexPath.row ==   5) return     8.0;  // spacer
        if (indexPath.row ==   6) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"best year"] ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for Score for the Year
        if (indexPath.row ==   2) return   270.0;  // text  for Score for the Year
        if (indexPath.row ==   3) return     8.0;  // spacer
        if (indexPath.row ==   4) return    55.0;  // image for overcome destiny
        if (indexPath.row ==   5) return     8.0;  // spacer
        if (indexPath.row ==   6) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"personality"] ) {

        if (indexPath.row ==  0) return     8.0;  // spacer
        if (indexPath.row ==  1) return    30.0;  // title for size of personality traits
//        if (indexPath.row ==  2) return   140.0;  // table preamble
        if (indexPath.row ==  2) return   250.0;  // table preamble
//        if (indexPath.row ==  3) return   175.0;  // table
        if (indexPath.row ==  3) return   210.0;  // table
        if (indexPath.row ==  4) return   135.0;  // 5 trait rundown
//        if (indexPath.row ==  5) return    75.0;  // check out Most ...  report
//        if (indexPath.row ==  6) return    80.0;  // 1 to 99 explain
        if (indexPath.row ==  5) return     8.0;  // spacer
        if (indexPath.row ==  6) return    30.0;  // title for quality of personality traits
        if (indexPath.row ==  7) return    82.0;  // text for quality
//        if (indexPath.row ==  8) return     8.0;  // spacer
        if (indexPath.row ==  8) return    55.0;  // image for overcome traits
        if (indexPath.row ==  9) return     8.0;  // spacer
        if (indexPath.row == 10) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"most reports"] ) {

        if (indexPath.row == 0) return     8.0;  // spacer
        if (indexPath.row == 1) return    30.0;  // title for size of traits
        if (indexPath.row == 2) return   265.0;  // score how much not good/bad
        if (indexPath.row == 3) return    30.0;  // title for quality of traits
        if (indexPath.row == 4) return   105.0;  // reference to Personality report
        if (indexPath.row == 5) return   115.0;  // specific trait reference
        if (indexPath.row == 6) return    55.0;  // image for overcome traits
        if (indexPath.row == 7) return     8.0;  // spacer
        if (indexPath.row == 8) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"calendar year"]  ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
        if (indexPath.row ==   1) return    60.0;  // intro string
        if (indexPath.row ==   2) return     8.0;  // spacer
        if (indexPath.row ==   3) return    30.0;  // title for Labels inside the Graph
        if (indexPath.row ==   4) return   250.0;  // text  for Labels inside the Graph
        if (indexPath.row ==   5) return     8.0;  // spacer
        if (indexPath.row ==   6) return    30.0;  // title for Time Frame Influences
        if (indexPath.row ==   7) return   300.0;  // text  for Time Frame Influences
        if (indexPath.row ==   8) return     8.0;  // spacer
        if (indexPath.row ==   9) return    30.0;  // title for Score for the Year
        if (indexPath.row ==  10) return   150.0;  // text  for Score for the Year
        if (indexPath.row ==  11) return     8.0;  // spacer
        if (indexPath.row ==  12) return    55.0;  // image for overcome destiny
        if (indexPath.row ==  13) return     8.0;  // spacer
        if (indexPath.row ==  14) return    20.0;  // text for disclaimer
        return 40;
    }
    if (   [gbl_helpScreenDescription isEqualToString: @"just 2"]  ) {

        if (indexPath.row ==  0) return     8.0;  // spacer
        if (indexPath.row ==  1) return    80.0;  // preamble
        if (indexPath.row ==  2) return    30.0;  // title for scores
        if (indexPath.row ==  3) return    16.0;  // spacer
        if (indexPath.row ==  4) return   225.0;  // image
        if (indexPath.row ==  5) return    16.0;  // spacer
        if (indexPath.row ==  6) return   140.0;  // text for complexity #1
        if (indexPath.row ==  7) return    60.0;  // image two things
        if (indexPath.row ==  8) return     8.0;  // spacer
        if (indexPath.row ==  9) return    70.0;  // text for complexity #2
        if (indexPath.row == 10) return    55.0;  // image overcome trait
        if (indexPath.row == 11) return    24.0;  // spacer

        if (indexPath.row == 12) return    30.0;  // title for 3 categories    3 fun categories
        if (indexPath.row == 13) return    16.0;  // spacer
        if (indexPath.row == 14) return    45.0;  // text #1 for 3 categories
        if (indexPath.row == 15) return     8.0;  // spacer
        if (indexPath.row == 16) return   320.0;  // image 3 categories
        if (indexPath.row == 17) return     1.0;  // spacer
        if (indexPath.row == 18) return   130.0;  // text #2 for 3 categories

        if (indexPath.row == 19) return     16.0;  // spacer
        if (indexPath.row == 20) return    30.0;  // title for relationships are really complex
        if (indexPath.row == 21) return   210.0;  // text for complexity part 2
        if (indexPath.row == 22) return    20.0;  // text for disclaimer
    }
    // if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"])     // what color is the day?
    if (   [gbl_helpScreenDescription isEqualToString: @"what color"]  ) {

        if (indexPath.row == 0) return    90.0;  
        if (indexPath.row == 1) return   210.0;  
        if (indexPath.row == 2) return   120.0;  
        if (indexPath.row == 3) return     8.0;  // spacer
        if (indexPath.row == 4) return    55.0;  // image for overcome destiny
        if (indexPath.row == 5) return     8.0;  // spacer
        if (indexPath.row == 6) return    20.0;  // text for disclaimer
    }
    // if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] )    // my best match (grpone)
    if (   [gbl_helpScreenDescription isEqualToString: @"best match"]  ) {

        if (indexPath.row ==  0) return   100.0;  // text for preamble
        if (indexPath.row ==  1) return     8.0;  // spacer
        if (indexPath.row ==  2) return    30.0;  // title for scores
        if (indexPath.row ==  3) return    16.0;  // spacer
        if (indexPath.row ==  4) return   225.0;  // image
        if (indexPath.row ==  5) return   100.0;  // this report details
        if (indexPath.row ==  6) return     8.0;  // spacer
        if (indexPath.row ==  7) return    30.0;  // title for complexity
        if (indexPath.row ==  8) return   140.0;  // text for complexity #1
        if (indexPath.row ==  9) return    55.0;  // image two things
        if (indexPath.row == 10) return     8.0;  // spacer
        if (indexPath.row == 11) return    70.0;  // text for complexity #2
        if (indexPath.row == 12) return    55.0;  // image overcome trait
        if (indexPath.row == 13) return    16.0;  // spacer
        if (indexPath.row == 14) return    20.0;  // text for disclaimer
    }
    return 200.0;  // default  (should neve happen)

}  // end of heightForRowAtIndexPath
// ---------------------------------------------------------------------------------------------------------------------


//  full example NSMutableAttributedString:  http://stackoverflow.com/questions/11031623/how-can-i-use-attributedtext-in-uilabel
//  (could not get this version to work)
//
//NSString *redText  = @"red text";
//NSString *greenText = @"green text";
//NSString *purpleBoldText = @"purple bold text";
//
//NSString *text = [NSString stringWithFormat:@"Here are %@, %@ and %@", 
//                  redText,  
//                  greenText,  
//                  purpleBoldText];
//
//// If attributed text is supported (iOS6+)
//if ([self.label respondsToSelector:@selector(setAttributedText:)]) {
//
//    // Define general attributes for the entire text
//    NSDictionary *attribs = @{
//                              NSForegroundColorAttributeName: self.label.textColor,
//                              NSFontAttributeName: self.label.font
//                              };
//    NSMutableAttributedString *attributedText = 
//        [[NSMutableAttributedString alloc] initWithString:text
//                                               attributes:attribs];
//
//    // Red text attributes
//    UIColor *redColor = [UIColor redColor];
//    NSRange redTextRange = [text rangeOfString:redText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:redColor}
//                            range:redTextRange];
//
//    // Green text attributes
//    UIColor *greenColor = [UIColor greenColor];
//    NSRange greenTextRange = [text rangeOfString:greenText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor}
//                            range:greenTextRange];
//
//    // Purple and bold text attributes
//    UIColor *purpleColor = [UIColor purpleColor];
//    UIFont *boldFont = [UIFont boldSystemFontOfSize:self.label.font.pointSize];
//    NSRange purpleBoldTextRange = [text rangeOfString:purpleBoldText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:purpleColor,
//                                    NSFontAttributeName:boldFont}
//                            range:purpleBoldTextRange];
//
//    self.label.attributedText = attributedText;
//




-(void) viewWillAppear:(BOOL)animated 
{
    NSLog(@"in INFO  viewWillAppear!");
    [super viewWillAppear: animated];

//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//    self.navigationItem.rightBarButtonItem = mySpacerForTitle;
//


    // set up navigation bar  right button  with mamb icon
    //
        UIImage *myImage = [[UIImage imageNamed: @"rounded_MAMB09_029.png"]
                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

        UIBarButtonItem *myMAMBicon = [[UIBarButtonItem alloc]initWithImage: myImage
                                                                      style: UIBarButtonItemStylePlain 
                                                                     target: self 
                                                                     action: nil];
        [myMAMBicon setEnabled:NO];
//        myMAMBicon.userInteractionEnabled = NO;

        self.navigationItem.rightBarButtonItem = myMAMBicon;


//    NSLog(@"END OF  in INFO  viewWillAppear!");


} // end of   viewWillAppear


- (void)viewDidAppear:(BOOL)animated

{
    //     [super viewDidAppear];
    NSLog(@"in INFO   viewDidAppear!");
}

@end


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//  p_fn_prtlin("    *trait");
//  p_fn_prtlin("");
//  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken");
//
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//
//
//  p_fn_prtlin("     Ups and Downs - having very high ups ");
//  p_fn_prtlin("                     and very low downs in life ");
//  p_fn_prtlin("");
//  p_fn_prtlin("");
//  p_fn_prtlin("  Check out reports \"Most Assertive\", \"Most Emotional\" ...  ");
//  p_fn_prtlin("  which use trait scores to compare with other group members  ");
//  p_fn_prtlin("");

//

