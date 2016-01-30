//
//  MAMB09_selNewMembersTableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-01-04.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_selNewMembersTableViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_selNewMembersTableViewController ()

@end

@implementation MAMB09_selNewMembersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
tn();
    NSLog(@"in SELECT New MEMBEFRS   viewDidLoad!");



    [self.tableView setEditing:YES animated:YES];

    self.tableView.allowsMultipleSelectionDuringEditing = YES;

//    [[UITableViewCell appearance] setTintColor:[UIColor greenColor]];  // set color of selected row circle+checkmark background
//    [[UITableViewCell appearance] setTintColor:[UIColor blueColor]];  // set color of selected row circle+checkmark background
//    [[UITableView appearance] setTintColor:[UIColor blackColor]];


//    [self.tableView setBackgroundColor: gbl_colorReportsBG];
//    [self.tableView setBackgroundColor: gbl_colorEditingBG ];
//    [self.tableView setBackgroundColor: gbl_color_cGre ];
    [self.tableView setBackgroundColor: gbl_colorforAddMembers ];


//        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                                         target: self
                                                                                         action: @selector(pressedSaveDone:)];
//        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                                         target: self
                                                                                         action: @selector(pressedCancel:)];
        // put info button on Nav Bar
        UIButton *myInfoButton     =  [UIButton buttonWithType: UIButtonTypeInfoDark] ;
        [myInfoButton addTarget: self action: @selector(pressedInfoButton:) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *navToInfoButton = [[UIBarButtonItem alloc] initWithCustomView: myInfoButton ];


  NSLog(@"navSaveButton=[%@]",navSaveButton);

    // set the Nav Bar Title  according to where we came from
    //
    do {
//        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
//                                                                                         target: self
//                                                                                         action: nil];

        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        myInvisibleButton.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];

        // setup for TWO-LINE NAV BAR TITLE

        //    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];  // 3rd arg is horizontal length
        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

        UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

        NSString *myNavBar2lineTitle;
        
        myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@", @"" ]; // default

        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@",gbl_lastSelectedGroup ];
//myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@", @"Moon Base w2345"];
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@",gbl_lastSelectedGroup ];
//myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@", @"Moon Base w2345"];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\n%@",gbl_lastSelectedGroup ];
//myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\n%@", @"Moon Base w2345"];
        }


        myNavBarLabel.numberOfLines = 2;
    //        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 14.0];
        myNavBarLabel.textColor     = [UIColor blackColor];
        myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
        myNavBarLabel.text          = myNavBar2lineTitle;
        myNavBarLabel.adjustsFontSizeToFitWidth = YES;
        [myNavBarLabel sizeToFit];

//    =  [NSArray arrayWithObjects: 
//                gbl_nameButtonToClearKeyboard, gbl_flexibleSpace,
//                gbl_title_groupName          , gbl_flexibleSpace,
//                gbl_flexibleSpace            , nil ]; 
            //
//        [gbl_ToolbarForGroupName    setItems: gbl_buttonArrayForPersonName  animated: YES];


        // TWO-LINE NAV BAR TITLE
        //
        dispatch_async(dispatch_get_main_queue(), ^{   

            // Disable the swipe to make sure you get your chance to save  
            // self.navigationController?.interactivePopGestureRecognizer.enabled = false
            self.navigationController.interactivePopGestureRecognizer.enabled = false ;

            self.navigationItem.titleView           = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
    //      self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//            self.navigationItem.rightBarButtonItem =  mySpacerForTitle;

            self.navigationItem.leftBarButtonItem   = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item

// self.navigationItem.RightBarButtonItem    = navSaveButton; 
//            self.navigationItem.RightBarButtonItem  = navToInfoButton;
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: navSaveButton ];
//                gbl_flexibleSpace,

            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: 
                navToInfoButton,
                navSaveButton,
                nil
            ]; 


//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myInfoButton  ];
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: navSaveButton ];

//            self.navigationItem.rightBarButtonItems  =
//           [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON

//            // below works for when there is an info button  (from storyboard)
//            self.navigationItem.rightBarButtonItems  =
//                [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON

//            // below works for no info button
// self.navigationItem.RightBarButtonItem    = navSaveButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item


        });

    } while (FALSE);


//    do {  // set up NAV BAR   BUTTONS
//
//
//        // When someone is creating a new entries, you need a way for them to abandon those entries and not create anything.
//        // In iOS apps, there are two ways of doing this:
//        // Use the 'back' button position for the 'cancel' button, and have a single 'done' button.
//        // This is functionally how many iOS apps handle things, and the method that I would recommend.
//        // Here you don't have to decide how your back button will behave, and the options are clear to your users.
//        //
//        //  navbar=   Cancel   New Contact   Done
//        //
//        // http://ux.stackexchange.com/questions/38157/is-there-a-need-for-save-cancel-buttons-in-ios-app
//
////        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
//        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
//                                                                                         target: self
//                                                                                         action: @selector(pressedSaveDone:)];
////        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
//        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
//                                                                                         target: self
//                                                                                         action: @selector(pressedCancel:)];
//
//
//        dispatch_async(dispatch_get_main_queue(), ^{  
//
////            self.navigationItem.leftBarButtonItems   =
////                [self.navigationItem.leftBarButtonItems   arrayByAddingObject: navCancelButton]; // add CANCEL BUTTON
//            self.navigationItem.leftBarButtonItem    = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item
//            // gold
//
//            // below works for when there is an info button
//            self.navigationItem.rightBarButtonItems  =
//                [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON
//
//            // below works for no info button
//            // self.navigationItem.RightBarButtonItem    = navSaveButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item
//
////            self.navigationItem.rightBarButtonItems =
////                [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//
//        });
//
//    } while (false);   // set up NAV BAR   BUTTONS
//




    // get array to populate tableview with

    [gbl_arrayNewMembersToPickFrom removeAllObjects];
    gbl_arrayNewMembersToPickFrom = [[NSMutableArray alloc] init];

    // make array of group member names to check against
    //
    NSMutableArray *grpmemNameArray;
    grpmemNameArray = [[NSMutableArray alloc]init];

  NSLog(@"gbl_lastSelectedGroup =[%@]",gbl_lastSelectedGroup );
    for (id myMemberRec in gbl_arrayMem) {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//
        NSArray *psvArray;
        NSString *currGroup;
        NSString *currMember;
        
        psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currGroup  = psvArray[0];
        currMember = psvArray[1];
//  NSLog(@"currGroup  =[%@]",currGroup  );
//  NSLog(@"currMember =[%@]",currMember );

        if ([currGroup isEqualToString: gbl_lastSelectedGroup ] )
        {
            [grpmemNameArray addObject: currMember ];                        //  Person name for pick
//  NSLog(@"grpmemNameArray =[%@]",grpmemNameArray );
        }
    } // for each groupmember
//  NSLog(@"grpmemNameArray =[%@]",grpmemNameArray );


    // INCLUDE ONLY  non members of gbl_lastSelectedGroup
    //
    for (id myNewMemberRec in gbl_arrayPer) {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//

        NSArray *psvArray;
        NSString *currMember;
        
        psvArray = [myNewMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currMember = psvArray[0];


        if ( [grpmemNameArray containsObject: currMember] ) continue;
       
        [gbl_arrayNewMembersToPickFrom addObject: currMember ];                        //  Person name for pick
    } // for each groupmember

 NSLog(@"gbl_arrayNewMembersToPickFrom=%@",gbl_arrayNewMembersToPickFrom);
 NSLog(@"gbl_arrayNewMembersToPickFrom.count=%lu",(unsigned long)gbl_arrayNewMembersToPickFrom.count);


//    [self updateButtonsToMatchTableState]; // make our view consistent - Update the delete button's title based on how many items are selected.
    //    [self updateButtonsToMatchTableState]; // Update the delete button's title based on how many items are selected.

} //   viewDidLoad 




- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
NSLog(@"in viewDidAppear()");
} // end of viewDidAppear




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



- (IBAction)pressedSaveDone:(id)sender
{
  NSLog(@"in pressedSAVEDONE!!");

    [gbl_selectedMembers_toAdd  removeAllObjects];
     gbl_selectedMembers_toAdd  = [[NSMutableArray alloc] init];
        
    for (id idxpath in [self.tableView indexPathsForSelectedRows] )
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: idxpath];
        [gbl_selectedMembers_toAdd  addObject: cell.textLabel.text ];
    }

    // sort array  gbl_selectedMembers_toAdd 
    if (gbl_selectedMembers_toAdd)  { [gbl_selectedMembers_toAdd  sortUsingSelector: @selector(caseInsensitiveCompare:)]; }

  NSLog(@"[self.tableView indexPathsForSelectedRows] =[%@]",[self.tableView indexPathsForSelectedRows] );
  NSLog(@"gbl_selectedMembers_toAdd  =[%@]",gbl_selectedMembers_toAdd);

    // add the members here
    //
    if (gbl_selectedMembers_toAdd.count == 0) return;



    // before write of array data to file, disallow/ignore user interaction events
    //
//    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] ==  NO) {  // suspend handling of touch-related events
//        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];     // typically call this before an animation or transitiion.
//NSLog(@"ARE  IGnoring events");
//    }
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

    [myappDelegate mamb_beginIgnoringInteractionEvents ];
   


    NSString *member_record;
    for (id add_me in gbl_selectedMembers_toAdd)   // add each new member
    {
        member_record = [NSString stringWithFormat:  @"%@|%@||", gbl_lastSelectedGroup, add_me ];

        [gbl_arrayMem addObject: member_record ];                        //  Person name for pick

    }

    [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; // sort array by name
    [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"member"]; // write new array data to file
//  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"member"]; // read new data from file to array


//    // after write of array data to file, allow user interaction events again
//    //
//    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) {  // re-enable handling of touch-related events
//        [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
//NSLog(@"STOP IGnoring events");
//    }


    gbl_justWroteMemberFile = 1;

    dispatch_async(dispatch_get_main_queue(), ^{  
        [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
    });

} // pressedSaveDone  for Add selected members


- (IBAction)pressedCancel:(id)sender     // this is the Cancel on left of Nav Bar
{
  NSLog(@"pressedCancel");
  NSLog(@" // actually do the BACK action ");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

    dispatch_async(dispatch_get_main_queue(), ^{  
        [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
    });
} // pressedCancel

- (IBAction)pressedInfoButton:(id)sender     // this is the Cancel on left of Nav Bar
{
  NSLog(@"pressedInfoButton");
  NSLog(@" // go to info screen ");

} // pressedInfoButton




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return gbl_arrayNewMembersToPickFrom.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelNewPersonCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    

    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];

    dispatch_async(dispatch_get_main_queue(), ^(void){

//        cell.tintColor = [UIColor blackColor] ;
//        cell.accessory.tintColor = [UIColor blackColor] ;

        cell.textLabel.text = [gbl_arrayNewMembersToPickFrom   objectAtIndex:indexPath.row];
        //        cell.textLabel.font = [UIFont systemFontOfSize: 16.0];
        cell.textLabel.font = myNewFont;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
        // PROBLEM  name slides left off screen when you hit red round delete "-" button
        //          and delete button slides from right into screen
        //
        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
    });

    return cell;
}



// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];

    // UIColor *gbl_colorEditingBG_current;  // is now yellow or blue for add a record screen  (addChange view)
    cell.backgroundColor = [UIColor clearColor];
}

// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
//  NSLog(@"in heightForRowAtIndexPath 1");

  return 44.0; // matches report height
}


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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

  NSLog(@"in prepareForSegue  in SEL  NEW  MEMbers");

}

@end
