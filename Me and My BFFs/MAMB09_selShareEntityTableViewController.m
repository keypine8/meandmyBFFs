//
//  MAMB09_selShareEntityTableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-04-19.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_selShareEntityTableViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_selShareEntityTableViewController ()

@end

@implementation MAMB09_selShareEntityTableViewController


//  segueHomeToSelShareEntity 


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

tn();
    NSLog(@"in viewDidLoad!  in  SELECT Entities to Share   ");

//  NSLog(@"gbl_arrayMem in viewdidload TOP =[%@]",gbl_arrayMem );

    [gbl_selectedPeople_toShare  removeAllObjects];
     gbl_selectedPeople_toShare  = [[NSMutableArray alloc] init];

    [gbl_selectedGroups_toShare  removeAllObjects];
     gbl_selectedGroups_toShare  = [[NSMutableArray alloc] init];


    [self.tableView setEditing:YES animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;


    [self.tableView setBackgroundColor: gbl_colorSelShareEntityBG ];


        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                                         target: self
                                                                                         action: @selector(pressedSaveDone:)];

        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                                         target: self
                                                                                         action: @selector(pressedCancel:)];

    // set the Nav Bar Title
    //
    do {
        // setup for NAV BAR TITLE

        UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

        NSString *myNavBar2lineTitle;
       
        myNavBar2lineTitle = @"Select ? to Share";
        if ([ gbl_lastSelectionType isEqualToString: @"person"] ) myNavBar2lineTitle =  @"Select People to Share"; 
        if ([ gbl_lastSelectionType isEqualToString: @"group"]  ) myNavBar2lineTitle =  @"Select Groups to Share"; 


        // iPhone4s    = 640 × 960
        // iPhone5, 5s = 640 × 1136
        // iPhone6, 6s = 750 x 1134
        // iPhone6plus = 1242 x 2208
        //
        //  if (        myScreenWidth >= 414.0)  { myFontSize = 16.0; }  // 6+ and 6s+  and bigger
        //  else if (   myScreenWidth  < 414.0   
        //           && myScreenWidth  > 320.0)  { myFontSize = 16.0; }  // 6 and 6s
        //  else if (   myScreenWidth <= 320.0)  { myFontSize = 16.0; }  //  5s and 5 and 4s and smaller
        //  else                                 { myFontSize = 16.0; }  //  other ?
        UIFont *navBarFont;

        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            navBarFont = [UIFont boldSystemFontOfSize: 16.0];
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            navBarFont = [UIFont boldSystemFontOfSize: 16.0];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            navBarFont = [UIFont boldSystemFontOfSize: 13.0];
        }


        myNavBarLabel.numberOfLines = 1;
        myNavBarLabel.font          = navBarFont;
        myNavBarLabel.textColor     = [UIColor blackColor];
        myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
        myNavBarLabel.text          = myNavBar2lineTitle;
        myNavBarLabel.adjustsFontSizeToFitWidth = YES;
        [myNavBarLabel sizeToFit];


        dispatch_async(dispatch_get_main_queue(), ^{   

            // Disable the swipe to make sure you get your chance to save  
            // self.navigationController?.interactivePopGestureRecognizer.enabled = false
            self.navigationController.interactivePopGestureRecognizer.enabled = false ;

            self.navigationItem.titleView           = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
            self.navigationItem.leftBarButtonItem   = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: 
                navSaveButton,
                nil
            ]; 
        });

    } while (FALSE);


    // get array to populate tableview with
    //
    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
        [gbl_peopleToPickFrom removeAllObjects];
         gbl_peopleToPickFrom = [[NSMutableArray alloc] init];

         for (NSString *perRec in gbl_arrayPer)
         {
              NSArray *psvArray;
              NSString *perName;
              
              psvArray = [perRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
              perName  = psvArray[0];

              //   // EXCLUDE       people who are example data ("~")
              if ([perName hasPrefix: @"~" ])   continue;         // no example people to share
             
              [gbl_peopleToPickFrom  addObject: perName ];   //  Person name for pick
         }
  NSLog(@"gbl_peopleToPickFrom  =[%@]",gbl_peopleToPickFrom  );

    } else {
        [gbl_groupsToPickFrom removeAllObjects];
         gbl_groupsToPickFrom = [[NSMutableArray alloc] init];

         for (NSString *grpRec in gbl_arrayGrp)
         {
              NSArray *psvArray;
              NSString *grpName;
              
              psvArray = [grpRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
              grpName  = psvArray[0];

              if ([grpName hasPrefix: @"~" ]) continue;         // no example people to share
              if ([grpName hasPrefix: @"#" ]) continue;         // no group #allpeople to share
             
              [gbl_groupsToPickFrom addObject: grpName ];   //  Group name for pick
         }

  NSLog(@"gbl_groupsToPickFrom =[%@]",gbl_groupsToPickFrom );
    }


//  NSLog(@" // set up sectionindex  or not");
//    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex  or not


} // viewDidLoad


- (void)viewDidAppear:(BOOL)animated
{
  NSLog(@"in viewDidAppear!  in  SELECT Entities to Share   ");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
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
    NSString *tmpName = cell.textLabel.text;

    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
        [gbl_selectedPeople_toShare addObject: tmpName ];          //  Person name for pick
    } else {
        [gbl_selectedGroups_toShare addObject: tmpName ];          //  Person name for pick
    }
} // didSelectRowAtIndexPath


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in didDeselectRowAtIndexPath! in sel new mbr");
    UITableViewCell* cell   = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType      = UITableViewCellAccessoryNone;
    NSString *tmpName = cell.textLabel.text;

    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
        [gbl_selectedPeople_toShare removeObject: tmpName ];          //  Person name for pick
    } else {
        [gbl_selectedGroups_toShare removeObject: tmpName ];          //  Person name for pick
    }
} // didDeselectRowAtIndexPath


//<.>

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

    NSString *member_record;
    for (NSString *add_me in gbl_selectedMembers_toAdd)   // add each new member
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

//<.>



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




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
  NSLog(@"gbl_peopleToPickFrom.count=[%ld]",(long)gbl_peopleToPickFrom.count);
        return gbl_peopleToPickFrom.count ;
    } else {
  NSLog(@"gbl_groupsToPickFrom.count=[%ld]",(long)gbl_groupsToPickFrom.count);
        return gbl_groupsToPickFrom.count ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"in cellForRow ");


//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelShareEntityCellIdentifier";
    
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

        if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
        {
            cell.textLabel.text = [gbl_peopleToPickFrom objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = [gbl_groupsToPickFrom objectAtIndex:indexPath.row];
        }

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
} // cellForRowAtIndexPath



// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];

    // UIColor *gbl_colorEditingBG_current;  // is now yellow or blue for add a record screen  (addChange view)
    // [self.tableView setBackgroundColor: gbl_colorSelShareEntityBG ];
    // cell.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = gbl_colorSelShareEntityBG ;
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

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate get_gbl_numMembersInCurrentGroup ];   // populates gbl_numMembersInCurrentGroup  using  gbl_lastSelectedGroup

    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
        myCountOfRows = gbl_peopleToPickFrom.count ;
    } else {
        myCountOfRows = gbl_groupsToPickFrom.count ;
    }

//  NSLog(@"myCountOfRows                =[%ld]",(long) myCountOfRows          );

  NSLog(@"myCountOfRows              =[%ld]", (long)myCountOfRows );
  NSLog(@"gbl_numRowsToTriggerIndexBar=[%ld]", (long)gbl_numRowsToTriggerIndexBar);
    if (myCountOfRows <= gbl_numRowsToTriggerIndexBar) {
//        return myEmptyArray ;  // no sectionindex
        return nil ;  // no sectionindex
    }

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


    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
        myCountOfRows = gbl_peopleToPickFrom.count ;
    } else {
        myCountOfRows = gbl_groupsToPickFrom.count ;
    }

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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
