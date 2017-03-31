//
//  MAMB09_selNewMembersTableViewController.m
//  Me&myBFFs
//
// MIT License
//
// Copyright (c) 2017 softwaredev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
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

//  NSLog(@"gbl_arrayMem in viewdidload TOP =[%@]",gbl_arrayMem );

    [gbl_selectedMembers_toAdd  removeAllObjects];
     gbl_selectedMembers_toAdd  = [[NSMutableArray alloc] init];


    [self.tableView setEditing:YES animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
//    self.tableView.allowsMultipleSelection = YES;

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
//        // put info button on Nav Bar
//        UIButton *myInfoButton     =  [UIButton buttonWithType: UIButtonTypeInfoDark] ;
//        [myInfoButton addTarget: self action: @selector(pressedInfoButton:) forControlEvents:UIControlEventTouchUpInside];
//
//        UIBarButtonItem *navToInfoButton = [[UIBarButtonItem alloc] initWithCustomView: myInfoButton ];
//


  NSLog(@"navSaveButton=[%@]",navSaveButton);

    // set the Nav Bar Title
    //
    do {
//        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
//                                                                                         target: self
//                                                                                         action: nil];

        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        myInvisibleButton.backgroundColor = [UIColor clearColor];
//        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];

        // setup for TWO-LINE NAV BAR TITLE

        //    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

        UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

        NSString *myNavBar2lineTitle;
        
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@", @"" ]; // default
        myNavBar2lineTitle = [NSString stringWithFormat:  @"Pick New People for\nGroup %@", @"" ]; // default

        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
//            myNavBar2lineTitle = [NSString stringWithFormat:  @"Add New People to\nGroup %@",gbl_lastSelectedGroup ];
            myNavBar2lineTitle = [NSString stringWithFormat:  @"Pick New People for\nGroup %@",gbl_lastSelectedGroup ];
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            myNavBar2lineTitle = [NSString stringWithFormat:  @"Pick New People for\nGroup %@",gbl_lastSelectedGroup ];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            myNavBar2lineTitle = [NSString stringWithFormat:  @"Pick New People for\n%@",gbl_lastSelectedGroup ];
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
//                navToInfoButton,
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

        NSArray *psvArray;
        NSString *candidateMember;
        
        psvArray = [myNewMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        candidateMember = psvArray[0];

        if ( [grpmemNameArray containsObject: candidateMember] ) continue;   // in the group already

        //   // EXCLUDE       people who are example data ("~")
        if ([candidateMember hasPrefix: @"~" ])                  continue;   // no example people to be member
       
        [gbl_arrayNewMembersToPickFrom addObject: candidateMember ];         //  Person name for pick
    } // for each groupmember

 NSLog(@"gbl_arrayNewMembersToPickFrom=%@",gbl_arrayNewMembersToPickFrom);
 NSLog(@"gbl_arrayNewMembersToPickFrom.count=%lu",(unsigned long)gbl_arrayNewMembersToPickFrom.count);


//    [self updateButtonsToMatchTableState]; // make our view consistent - Update the delete button's title based on how many items are selected.
    //    [self updateButtonsToMatchTableState]; // Update the delete button's title based on how many items are selected.



  NSLog(@" // set up sectionindex  or not");
    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex  or not

//  NSLog(@"gbl_arrayMem in viewdidload BOTTOM =[%@]",gbl_arrayMem );

} //   viewDidLoad 




- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
//  NSLog(@"gbl_arrayMem in viewdidappear =[%@]",gbl_arrayMem );
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in didSelectRowAtIndexPath! in sel new mbr");
    UITableViewCell* cell   = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType      = UITableViewCellAccessoryCheckmark;
    NSString *tmpMemberName = cell.textLabel.text;
    [gbl_selectedMembers_toAdd  addObject: tmpMemberName ];          //  Person name for pick

//  NSLog(@"gbl_arrayMem didselectrow     =[%@]",gbl_arrayMem );
//  NSLog(@"gbl_selectedMembers_toAdd  =[%@]",gbl_selectedMembers_toAdd  );
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in didDeselectRowAtIndexPath! in sel new mbr");
    UITableViewCell* cell   = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType      = UITableViewCellAccessoryNone;
    NSString *tmpMemberName = cell.textLabel.text;
    [gbl_selectedMembers_toAdd  removeObject: tmpMemberName ];          //  Person name for pick
}


- (IBAction)pressedSaveDone:(id)sender
{
  NSLog(@"in pressedSAVEDONE!!");


    if ([gbl_lastSelectedGroup hasPrefix: @"~" ]) 
    {
        UIAlertController* myAlert = [
            UIAlertController alertControllerWithTitle: @"An Example Group Cannot be Changed"
                                               message: @"You cannot add new members to an example group."
                                        preferredStyle: UIAlertControllerStyleAlert 
        ];
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
        [myAlert addAction:  okButton];

        [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

        return;
    }


    // PROBLEM:  CANNOT TRUST  [self.tableView indexPathsForSelectedRows] when scrolling off screen
    // therefore,  use gbl_selectedMembers_toAdd  
    //
    //nbn(1);        
    //  NSLog(@"[self.tableView indexPathsForSelectedRows] =[%@]",[self.tableView indexPathsForSelectedRows] );
    //  NSArray *selectedArr = [self.tableView indexPathsForSelectedRows];
    //  NSLog(@"selectedArr =[%@]",selectedArr );
    //    for (id idxpath in [self.tableView indexPathsForSelectedRows] )
    //    {
    //        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: idxpath];
    //  NSLog(@"a selected member = cell.textLabel.text =[%@]",cell.textLabel.text );
    ////        if (cell.textLabel.text != nil)
    //        [gbl_selectedMembers_toAdd  addObject: cell.textLabel.text ];
    //  NSLog(@"gbl_selectedMembers_toAdd=[%@]",gbl_selectedMembers_toAdd);
    //    }
    //


nbn(2);        
  NSLog(@"gbl_selectedMembers_toAdd=[%@]",gbl_selectedMembers_toAdd);
    // sort array  gbl_selectedMembers_toAdd 
    if (gbl_selectedMembers_toAdd)  { [gbl_selectedMembers_toAdd  sortUsingSelector: @selector(caseInsensitiveCompare:)]; }
nbn(3);        
  NSLog(@"gbl_selectedMembers_toAdd=[%@]",gbl_selectedMembers_toAdd);


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
   
tn();
nbn(4);


    // NOTE:  check below for gbl_MAX_personsInGroup is not necessary because
    // MAMB09_selNewMembersTableViewController.m only shows candidate new group members who are not in the group already
    // AND  gbl_MAX_persons  =  gbl_MAX_personsInGroup  =  200 
    // so  memberships can never grow to > 200
    //
    //
    // BEFORE adding all the people in gbl_selectedMembers_toAdd to the group gbl_lastSelectedGroup,
    // CHECK  for gbl_MAX_personsInGroup
    //
    //
    //    // get_gbl_numMembersInCurrentGroup  populates gbl_numMembersInCurrentGroup, gbl_namesInCurrentGroup  using  gbl_lastSelectedGroup
    //    //
    //    [myappDelegate get_gbl_numMembersInCurrentGroup ];   // populates gbl_numMembersInCurrentGroup  using  gbl_lastSelectedGroup
    //
    //    if ( gbl_numMembersInCurrentGroup + gbl_selectedMembers_toAdd.count  >=  gbl_MAX_personsInGroup )
    //    // end of CHECK  for gbl_MAX_personsInGroup
    //



    NSString *member_record;
    for (NSString *add_me in gbl_selectedMembers_toAdd)   // add each new member to group
    {
        member_record = [NSString stringWithFormat:  @"%@|%@|", gbl_lastSelectedGroup, add_me ];

//  NSLog(@"ADDED MEMBERSHIP     = [%@]", member_record);
//  NSLog(@"gbl_lastSelectedGroup=[%@]",gbl_lastSelectedGroup);
//  NSLog(@"gbl_arrayMem before add new mbr=[%@]",gbl_arrayMem );

        [gbl_arrayMem addObject: member_record ];                        //  Person name for pick

//  NSLog(@"gbl_arrayMem after add new mbr=[%@]",gbl_arrayMem );

    }
nbn(5);

    [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; // sort array by name
    [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"member"]; // write new array data to file
//  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"member"]; // read new data from file to array

nbn(6);

//    // after write of array data to file, allow user interaction events again
//    //
//    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) {  // re-enable handling of touch-related events
//        [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
//NSLog(@"STOP IGnoring events");
//    }


    gbl_justWroteMemberFile = 1;

    // go back to home and ask for what kind of save there
    //
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



//- (IBAction)pressedInfoButton:(id)sender     // this is the Cancel on left of Nav Bar
//{
//  NSLog(@"pressedInfoButton");
//  NSLog(@" // go to info screen ");
//
//} // pressedInfoButton
//




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  NSLog(@"gbl_arrayNewMembersToPickFrom.count =[%ld]",(long)gbl_arrayNewMembersToPickFrom.count );
    return gbl_arrayNewMembersToPickFrom.count ;
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

//        if([[self.tableView indexPathsForSelectedRows] containsObject:indexPath]) {
        if([gbl_selectedMembers_toAdd containsObject:indexPath]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

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




//--------------------------------------------------------------------------------------------
// SECTION INDEX VIEW
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;  // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))


//
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?
//
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
tn();
  NSLog(@"in sectionIndexTitlesForTableView !");

//return nil;  // test no section index

    NSInteger myCountOfRows;
    myCountOfRows = 0;


    //    if ([gbl_ExampleData_show isEqualToString: @"yes"])
    //    {
    //       myCountOfRows = gbl_arrayPer.count;
    //    } else {
    //       // Here we do not want to show example data.
    //       // Because example data names start with "~", they sort last,
    //       // so we can just reduce the number of rows to exclude example data from showing on the screen.
    //       myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
    //    }

    // myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;  //  never show ~ example data to pick as members

    // myCountOfRows =  [gbl_arrayNewMembersToPickFrom count ];         //  Person name for picking as members

    // gbl_arrayNewMembersToPickFrom  is not created yet so 
    // do calculation
    //
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate get_gbl_numMembersInCurrentGroup ];   // populates gbl_numMembersInCurrentGroup  using  gbl_lastSelectedGroup

     myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per - gbl_numMembersInCurrentGroup ;  //  never show ~ example data to pick as members

//tn();
//  NSLog(@"gbl_arrayPer.count           =[%ld]",(long) gbl_arrayPer.count );
//  NSLog(@"gbl_ExampleData_count_per    =[%ld]",(long) gbl_ExampleData_count_per );
//  NSLog(@"gbl_numMembersInCurrentGroup =[%ld]",(long) gbl_numMembersInCurrentGroup );
//  NSLog(@"myCountOfRows                =[%ld]",(long) myCountOfRows          );

nbn(160);
  NSLog(@"myCountOfRows              =[%ld]", (long)myCountOfRows );
  NSLog(@"gbl_numRowsToTriggerIndexBar=[%ld]", (long)gbl_numRowsToTriggerIndexBar);
    if (myCountOfRows <= gbl_numRowsToTriggerIndexBar) {
nbn(161);
//        return myEmptyArray ;  // no sectionindex
        return nil ;  // no sectionindex
    }
nbn(162);

    NSArray *mySectionIndexTitles = [NSArray arrayWithObjects:  // 33 items  last index=32
//         @"A", @"B", @"C", @"D",  @"E", @"F", @"G", @"H", @"I", @"J",  @"K", @"L", @"M",
//         @"N", @"O", @"P",  @"Q", @"R", @"S", @"T", @"U", @"V",  @"W", @"X", @"Y", @"Z",   nil ];

            @"_______",
            @"TOP",
            @"     ", @"     ", @"     ", @"     ",  @"     ", 
            @"__",
            @"     ", @"     ", @"     ", @"     ",  @"     ",
            @"__",
            @"     ", @"     ", @"     ", @"     ",  @"     ", 
            @"__",
            @"     ", @"     ", @"     ", @"     ",  @"     ", 
            @"END",
            @"_______",
            nil
    ];


    gbl_numSectionIndexTitles = mySectionIndexTitles.count;

    return mySectionIndexTitles;

} // end of sectionIndexTitlesForTableView



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{

  NSLog(@"sectionForSectionIndexTitle!  in HOME");
  NSLog(@"title=[%@]",title);
  NSLog(@"atIndex=[%ld]",(long)index);



    // find first group starting with title letter (guaranteed to be there, see sectionIndexTitlesForTableView )
    NSInteger newRow;  newRow = 0;
    NSIndexPath *newIndexPath;
    NSInteger myCountOfRows;
    myCountOfRows = 0;

    //        if ([gbl_ExampleData_show isEqualToString: @"yes"] ) 
    //        {
    //           myCountOfRows = gbl_arrayPer.count;
    //        } else {
    //           // Here we do not want to show example data.
    //           // Because example data names start with "~", they sort last,
    //           // so we can just reduce the number of rows to exclude example data from showing on the screen.
    //           myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
    //        }
    //

    // myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;  //  never show ~ example data to pick as members
    myCountOfRows =  [gbl_arrayNewMembersToPickFrom count ];         //  Person name for picking as members

    if (     [title isEqualToString:@"TOP"]) newRow = 0;
    else if ([title isEqualToString:@"END"]) newRow = myCountOfRows - 1;
    else                                     newRow = ((double) (index + 1) / (double) gbl_numSectionIndexTitles ) * (double)myCountOfRows ;

    if (newRow == myCountOfRows)  newRow = newRow - 1;

  NSLog(@"gbl_numSectionIndexTitles =[%ld]",(long)gbl_numSectionIndexTitles );
  NSLog(@"newRow                    =[%ld]", (long)newRow);
  NSLog(@"myCountOfRows             =[%ld]", (long)myCountOfRows   );


    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];

    return index;

} // sectionForSectionIndexTitle


// end of SECTION INDEX VIEW
//--------------------------------------------------------------------------------------------



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
