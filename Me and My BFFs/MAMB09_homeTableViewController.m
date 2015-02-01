//
//  MAMB09_homeTableViewController.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    code here
//});
//
//When you tap a cell, the willSelectRowAtIndexPath and didSelectRowAtIndexPath are called - supplying you the currently selected NSIndexPath
//– tableView:willSelectRowAtIndexPath:
//– tableView:didSelectRowAtIndexPath:
//– tableView:willDeselectRowAtIndexPath:
//– tableView:didDeselectRowAtIndexPath:

// #import "mamblib.h"
#import "MAMB09_homeTableViewController.h"
#import "MAMB09_selectReportsTableViewController.h"
#import "rkdebug_externs.h"
#import "MAMB09AppDelegate.h"   // to get globals
#import "mamblib.h"


@interface MAMB09_homeTableViewController ()

@end


@implementation MAMB09_homeTableViewController

//@synthesize mambyObjectList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // assign height of tableview rows here
    
    fopen_fpdb_for_debug();
    trn("in viewDidLoad in home");
    

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    [[NSNotificationCenter defaultCenter] addObserver:self  // run method doStuffOnEnteringForeground()  when entering Foreground
                                             selector:@selector(doStuffOnEnteringForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil  ];

    BOOL haveGrp, havePer, haveMem, haveGrpRem, havePerRem;
    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
                                                                                   //BOOL ret01;
    NSError *err01;


//        // remove all "*.txt" files from TMP directory before creating new one
//        //
//        NSArray *docFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: gbl_appDocDirStr error:NULL];
//        NSLog(@"docFiles.count=%lu",(unsigned long)docFiles.count);
//                for (NSString *fil in docFiles) {
//            NSLog(@"fil=%@",fil);
//            if ([fil hasSuffix: @"txt"]) {
//                NSLog(@"remove this txt    fil=%@",fil);
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", gbl_appDocDirStr, fil] error: &err01];
//                if (err01) { NSLog(@"error on rm fil %@ = %@", fil, err01 ); }
//            }
//            if ([fil hasPrefix: @"mambd"] || [fil hasPrefix: @"mambG"]    ) {
//                 NSLog(@"remove this mambd  fil=%@",fil);
//                //[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error: &err01];
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", gbl_appDocDirStr, fil] error: &err01];
//                if (err01) { NSLog(@"error on rm fil %@ = %@", fil, [err01 localizedFailureReason]); }
//            }
//        }
//    //   for test   TO SIMULATE first downloading the app-  when there are no data files
//



//    //   FOR test   remove all regular named files   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//    //   for test   TO SIMULATE first downloading the app-  when there are no data files
//    //
//    [gbl_sharedFM removeItemAtURL: gbl_URLToGroup error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm group  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToPerson error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm person %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToMember error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm Member %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToGrpRem error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm GrpRem%@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToPerRem error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm PerRem%@", [err01 localizedFailureReason]); }
//    // end of   FOR test   remove all regular named files   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//


    // check all files exist now
    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    tn();ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);


    //havePer = NO;  // for test  put new example per data

    NSLog(@"%d  %d  %d", haveGrp, havePer, haveMem);
    if ( haveGrp && havePer && haveMem ) {   // good to go
        NSLog(@"%@", @"use regular files!");

    } else {   // INIT with example data    (here  at least one  have = NO )
       // possibly implement later 
        //        if (haveGrp && havePer && !haveMem) {
        //            NSLog (@"building member file from other files");
        //            //  TODO
        //            // without this todo done,  here you lose all  members from all groups 
        //        else if (!haveGrp && havePer && haveMem) {
        //            NSLog (@"building group file from other files");
        //            //  TODO
        //            // without this todo done,  here you lose all  groups 
        //        } else {
        //        }
        //

        NSLog(@"%@", @"use example data arrays!");

        // delete all data files, if present, and write and use example data arrays
        //
        if (!havePer) {
            //      remove all data named files (these cannot exist - no overcopy)
            [gbl_sharedFM removeItemAtURL:gbl_URLToGroup error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
            [gbl_sharedFM removeItemAtURL:gbl_URLToPerson error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
            [gbl_sharedFM removeItemAtURL:gbl_URLToMember error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Mem %@", err01); }

            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplegroup"];
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"exampleperson"];
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplemember"];
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplegrprem"];
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"exampleperrem"];

            //    // for test   check all files exist  after 
            //    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
            //    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
            //    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
            //    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
            //    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
            //    tn();tr("after write example");ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);
            //
        }
    } // check data files

    
    // read data files  with regular names into arrays
    // and sort the arrays in place by name
    //
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"group"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"person"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"member"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"grprem"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"perrem"];
    //    NSLog(@"gbl_arrayGrp=%@",gbl_arrayGrp);
    //    NSLog(@"gbl_arrayPer=%@",gbl_arrayPer);
    //    NSLog(@"gbl_arrayMem=%@",gbl_arrayMem);
        NSLog(@"home viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
        NSLog(@"home viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);

    [gbl_arrayGrp sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [gbl_arrayPer sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [gbl_arrayMem sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];


    [self doStuffOnEnteringForeground];  // read   lastEntity stuff

    // for test  LOOK AT all files in doc dir
    NSArray *docFiles2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: gbl_appDocDirStr error:NULL];
    NSLog(@"docFiles2.count=%lu",(unsigned long)docFiles2.count);
    for (NSString *fil in docFiles2) { NSLog(@"doc fil=%@",fil); }
    // for test  LOOK AT all files in doc dir


} // - (void)viewDidLoad


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The App received an Memory Warning"
                                                    message: @"The system has determined that the \namount of available memory is very low."
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
} // didReceiveMemoryWarning 

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    return 1;
} // numberOfSectionsInTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return 0;
    //return mambyObjectList.count;
    //if ([_mambCurrentEntity isEqualToString:@"group"])  return gbl_arrayGrp.count;
    //if ([_mambCurrentEntity isEqualToString:@"person"]) return gbl_arrayPer.count;
    if ([gbl_lastSelectionType isEqualToString:@"group"])  return gbl_arrayGrp.count;
    if ([gbl_lastSelectionType isEqualToString:@"person"]) return gbl_arrayPer.count;
    return 0;
} // numberOfRowsInSection


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"in cellForRowAtIndexPath");

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"MyCell1";
    
    // check to see if we can reuse a cell from a row that has just rolled off the screen
    // if there are no cells to be reused, create a new cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    NSLog(@"in cellForRowAtIndexPath 2222");
//    NSLog(@"all array[%@]", mambyObjectList);
//    NSLog(@"current  row=[%@]", [mambyObjectList objectAtIndex:indexPath.row]);

    // set the text attribute to the name of
    // whatever we are currently looking at in our array
    // name is 1st element in csv
    //
    // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);

    NSString *currentLine, *nameOfGrpOrPer;
    // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);


    //if ([_mambCurrentEntity isEqualToString:@"group"]) {
    // NSLog(@"gbl_lastSelectionType =%@",gbl_lastSelectionType );

    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
        currentLine = [gbl_arrayGrp objectAtIndex:indexPath.row];
    } else {
        //if ([_mambCurrentEntity isEqualToString:@"person"]) {
        if ([gbl_lastSelectionType isEqualToString:@"person"]) {
            currentLine = [gbl_arrayPer objectAtIndex:indexPath.row];
        } else {
            currentLine = @"Unknown|";
        }
    }
    // NSLog(@"currentLine=%@",currentLine);

    _arr = [currentLine componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    nameOfGrpOrPer = _arr[0];
    //NSLog(@"nameOfGrpOrPer=%@",nameOfGrpOrPer);
    cell.textLabel.text = nameOfGrpOrPer;
    
//    UIFont *myFont = [ UIFont fontWithName:@"Menlo" size:16];
//    cell.textLabel.font            = myFont;
// cell.textLabel.font.lineHeight = 20;

    
    // set the detail disclosure indicator
    //
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //   NSLog(@"in cellForRowAtIndexPath 5555");
  
    return cell;
} // cellForRowAtIndexPath


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    cell.backgroundColor = [UIColor clearColor];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in prepareForSegue() in home!");

// moved to didSelectRow
//    // get the indexpath of current row
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//    gbl_savePrevIndexPath  = myIdxPath;
//    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
//
//    /* segueHomeToReportList
//    */
//    if ([segue.identifier isEqualToString:@"segueHomeToReportList"]) {
//        // UINavigationController *nc = segue.destinationViewController;
//        // UINavigationController *nc = segue.destinationViewController;
//        //  MAMB09_selectReportsTableViewController *myDestTableViewController = segue.destinationViewController;
//
//        // myDestTableViewController.fromHomeCurrentSelectionType = _mambCurrentSelectionType; // "group" or "person" or "pair"
//        // gbl_fromHomeCurrentSelectionType = _mambCurrentSelectionType; // "group" or "person" or "pair"
//        
//        //myDestTableViewController.fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"
//        //gbl_fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"
//        //gbl_fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"
//        gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
//
//    
//        if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
//            // NSLog(@"current  row 231=[%@]", [gbl_arrayGrp objectAtIndex:myIdxPath.row]);
//            //myDestTableViewController.fromHomeCurrentSelectionPSV = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//        }
//        if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
//            // NSLog(@"current  row 232=[%@]", [gbl_arrayPer objectAtIndex:myIdxPath.row]);
//            //myDestTableViewController.fromHomeCurrentSelectionPSV = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//        }
//        NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//        NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
//        NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//        NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//
//
//        
//        // this infinite loops on performseg s
//        // Because background threads are not prioritized and will wait a very long time
//        // before you see results, unlike the mainthread, which is high priority for the system.
//        //
//        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
//        //
////        ntrn("calling dispatch home to rptlist !!!!!!!!!!!!!!!!!!!!!");
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [self performSegueWithIdentifier:@"segueHomeToReportList" sender:self];
////        });
////        ntrn("calling dispatch home to rptlist !!!!!!!!!!!!!!!!!!!!!");
//
//    } /* segueHomeToReportList */
//

} // end of  prepareForSegue 


- (IBAction)actionSwitchEntity:(id)sender {  // segemented control on home page
    NSLog(@"in actionSwitchEntity() in home!");

    NSLog(@"gbl_LastSelectedPerson=%@",gbl_lastSelectedPerson);
    NSLog(@"gbl_LastSelectedGroup=%@" ,gbl_lastSelectedGroup);
    NSLog(@"gbl_lastSelectionType=%@" ,gbl_lastSelectionType);


    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
        // NSLog(@"change grp to per!");
        //_mambCurrentSelectionType = @"person";
        gbl_fromHomeCurrentEntity        = @"person";
        gbl_fromHomeCurrentSelectionType = @"person";
        gbl_lastSelectionType            = @"person";
    } else if ([gbl_lastSelectionType isEqualToString:@"person"]){
        // NSLog(@"change per to grp!");
        //_mambCurrentSelectionType = @"person";
        gbl_fromHomeCurrentEntity        = @"group";
        gbl_fromHomeCurrentSelectionType = @"group";
        gbl_lastSelectionType            = @"group";
    }
    NSLog(@"gbl_fromHomeCurrentEntity        =%@",gbl_fromHomeCurrentEntity        );
    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );


    // highlight correct entity in seg control at top
    //
    NSString *nameOfGrpOrPer;
    NSInteger idxGrpOrPer;
    NSArray *arrayGrpOrper;
    idxGrpOrPer = -1;   // zero-based idx

    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"]) {
        _segEntityOutlet.selectedSegmentIndex = 0;

        // NSLog(@"reload table here!");
        [self.tableView reloadData];

        // highlight lastEntity row in tableview
        //
        
        // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
        for (id eltGrp in gbl_arrayGrp) {
          idxGrpOrPer = idxGrpOrPer + 1;
          //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
          //NSLog(@"eltGrp=%@", eltGrp);

          NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
          arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
          nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

          //if ([nameOfGrpOrPer isEqualToString: _mambCurrentSelection]) 
          if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedGroup]) {
            break;
          }
        }  // search thru gbl_arrayGrp
        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

        // get the indexpath of row num idxGrpOrPer in tableview
        //   assumes index of entity in gbl_array Per or Grp
        //   is the same as its index (row) in the tableview
        NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];

//tn();trn("SCROLL 333333333333333333333333333333333333333333333333333333333");
        // select the row in UITableView
        // This puts in the light grey "highlight" indicating selection
        [self.tableView selectRowAtIndexPath: foundIndexPath 
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionNone];
        //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                          animated: YES];
    }
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
        _segEntityOutlet.selectedSegmentIndex = 1;

        // NSLog(@"reload table here!");
        [self.tableView reloadData];

        // highlight lastEntity row in tableview
        //

        // find index of _mambCurrentSelection (like "~Dave") in gbl_arrayPer
        for (id eltPer in gbl_arrayPer) {
          idxGrpOrPer = idxGrpOrPer + 1;
          //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
          //NSLog(@"eltPer=%@", eltPer);
          NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
          arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
          nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

          //if ([nameOfGrpOrPer isEqualToString: _mambCurrentSelection]) 
          if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
            break;
          }
        } // search thru gbl_arrayPer
        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

        // get the indexpath of row num idxGrpOrPer in tableview
        NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];

//tn();trn("SCROLL 444444444444444444444444444444444444444444444444444444444");
        // select the row in UITableView
        // This puts in the light grey "highlight" indicating selection
        [self.tableView selectRowAtIndexPath: foundIndexPath 
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionNone];
        //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                          animated: YES];
    }

} // end of   (IBAction)actionSwitchEntity:(id)sender {  // segemented control on home page



- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()  in HOME");

//tn();trn("SCROLL 555555555555555555555555555555555555555555555555555555555");
    

    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//NSLog(@"myIdxPath5=%@",myIdxPath);
//NSLog(@"myIdxPath.row5=%ld",(long)myIdxPath.row);
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath:myIdxPath
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
//                              scrollPosition:UITableViewScrollPositionMiddle];
    }

    //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");

    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                      animated: YES];
} // end of viewDidAppear



- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in willDeselectRowAtIndexPath() in home!");

    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.

    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
 
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);

    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);

    
    // here deselect "previously" selected row
    // and remove yellow highlight
    //NSLog(@"willDeselectRowAtIndexPath()  DESELECT #######################################################");
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: YES];
    return previouslyselectedIndexPath;

} // end of willDeselectRowAtIndexPath




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
//     // deselect previous row, select new one  (grey highlight)
//     //
//     // When the user selects a cell, you should respond by deselecting the previously selected cell (
//     // by calling the deselectRowAtIndexPath:animated: method) as well as by
//     // performing any appropriate action, such as displaying a detail view.
//     // 
//     NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];  // this is the "previously" selected row now
//     [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath  // deselect "previously" selected row and remove light grey highlight
//                                   animated: NO];
// 
//     NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow]; // get the indexpath of current row
//     if(myIdxPath) {
//         [self.tableView selectRowAtIndexPath:myIdxPath // puts highlight on this row (?)
//                                     animated:YES
//                               scrollPosition:UITableViewScrollPositionNone];
//     }


// tn();     NSLog(@"in didSelectRowAtIndexPath in home !!!!!!!!!!  BEFORE  !!!!!!!!!!!!!");
//             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
//             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
//             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
//             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//             //NSLog(@"=%@",);
// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");


    // this is the "currently" selected row now
    //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    

    // below is from prep for segue
    gbl_savePrevIndexPath  = myIdxPath;
    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
    gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
    }
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
    }
    NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
    // above is from prep for segue


    const char *my_psvc;  // psv=pipe-separated values
    char my_psv[1024], psvName[32];
    my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
    strcpy(my_psv, my_psvc);
    strcpy(psvName, csv_get_field(my_psv, "|", 1));
    NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSString

    gbl_fromHomeCurrentEntityName = myNameOstr;  // like "~Anya" or "~Swim Team"
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        gbl_lastSelectedPerson = myNameOstr;
    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
        gbl_lastSelectedGroup  = myNameOstr;
    }


// tn();     NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!  AFTER   !!!!!!!!!!!!!");
//             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
//             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
//             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
//             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//             //NSLog(@"=%@",);
// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

//tn();trn("SCROLL 666666666666666666666666666666666666666666666666666666666");
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    //[self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
    [self.tableView selectRowAtIndexPath: myIdxPath
                                animated: YES
                          scrollPosition: UITableViewScrollPositionNone];

    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                      animated: YES];
    b(31);


} // end of  didSelectRowAtIndexPath: (NSIndexPath *) indexPath


-(void) viewWillAppear:(BOOL)animated {
 NSLog(@"in viewWillAppear() in home   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
}


- (void) doStuffOnEnteringForeground 
{
tn();trn("in doStuffOnEnteringForeground()   NOTIFICATION method     lastEntity stuff");

    //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m

    // get Document directory as URL and Str
    //
    gbl_sharedFM = [NSFileManager defaultManager];
    gbl_possibleURLs = [gbl_sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    gbl_appDocDirURL = nil;
    if ([gbl_possibleURLs count] >= 1) {
        gbl_appDocDirURL = [gbl_possibleURLs objectAtIndex:0];
    }
//    NSString *gbl_appDocDirStr = [gbl_appDocDirURL path];
    
    
    // lastEntity stuff  to (1) highlight correct entity in seg control at top and (2) highlight correct person-or-group
    //
    //
    NSString *lastEntityStr = [myappDelegate mambReadLastEntityFile];

    //NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"=|"];
    NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"];
    _arr = [lastEntityStr componentsSeparatedByCharactersInSet: myNSCharacterSet];
     NSLog(@"_arr=%@", _arr);

    gbl_lastSelectionType            = _arr[0];  //  group OR person or pair
    gbl_fromHomeCurrentSelectionType = _arr[0];  //  group OR person or pair
    NSLog(@"gbl_lastSelectionType=%@",gbl_lastSelectionType);
    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
    
    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
      gbl_lastSelectedGroup  =  _arr[1];  // like "~Swim Team"
      gbl_lastSelectedPerson =  _arr[3];  // like "~Dave"
    }
    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
      gbl_lastSelectedPerson =  _arr[1];  // like "~Dave"
      gbl_lastSelectedGroup  =  _arr[3];  // like "~Swim Team"
    }
    NSLog(@"gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
    NSLog(@"gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );



    // highlight correct entity in seg control at top
    //
    //
    NSString  *nameOfGrpOrPer;
    NSInteger idxGrpOrPer;
    NSArray *arrayGrpOrper;
    idxGrpOrPer = -1;   // zero-based idx
    if ([gbl_lastSelectionType isEqualToString:@"group"]) {

        _segEntityOutlet.selectedSegmentIndex = 0;
        // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
        for (id eltGrp in gbl_arrayGrp) {
          idxGrpOrPer = idxGrpOrPer + 1;
          //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
          //NSLog(@"eltGrp=%@", eltGrp);
          NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
          arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
          nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

          if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedGroup]) {
            break;
          }
        } // search thru gbl_arrayGrp
        //NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

        // get the indexpath of row num idxGrpOrPer in tableview
        NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
//tn();trn("SCROLL 111111111111111111111111111111111111111111111111111111111");
        // select the row in UITableView
        // This puts in the light grey "highlight" indicating selection
        [self.tableView selectRowAtIndexPath: foundIndexPath 
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionNone];
        //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                  animated: YES];
    }
    //if ([_mambCurrentEntity isEqualToString:@"person"]) 
    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
        _segEntityOutlet.selectedSegmentIndex = 1;
        NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);

        // highlight lastEntity row in tableview
        //
        
        // find index of _mambCurrentSelection (like "~Dave") in gbl_arrayPer
        for (id eltPer in gbl_arrayPer) {
            idxGrpOrPer = idxGrpOrPer + 1; 
//              NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
//              NSLog(@"eltPer=%@", eltPer);
//
          NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
          arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
          nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

          //if ([nameOfGrpOrPer isEqualToString: _mambCurrentSelection]) 
          if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
            break;
          }
        } // search thru gbl_arrayPer
        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

        // get the indexpath of row num idxGrpOrPer in tableview
        NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
        NSLog(@"foundIndexPath=%@",foundIndexPath);
        NSLog(@"foundIndexPath.row=%ld",(long)foundIndexPath.row);


        // select the row in UITableView
        // This puts in the light grey "highlight" indicating selection
        [self.tableView selectRowAtIndexPath: foundIndexPath 
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionMiddle];
//                                  scrollPosition: UITableViewScrollPositionNone];
        //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                          animated: YES];

    }
    // end of   highlight correct entity in seg control at top
    
} // end of  doStuffOnEnteringForeground()


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];  // will crash without this
}

@end




// for test
//     do {  // update delimited string  for saving selection in remember fields
//         NSLog(@"before ®gbl_arrayPer 0 =%@",gbl_arrayPer[0]);
//         MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
//         NSString *myStrToUpdate = gbl_arrayPer[0];
//         NSString *myupdatedStr =
//         [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
//                                  delimitedBy: (NSString *) @"|"
//                     updateOneBasedElementNum: (NSInteger)  11
//                               withThisString: (NSString *) @"not locked"
//          ];
//         gbl_arrayPer[0] = myupdatedStr;
//         NSLog(@"after gbl_arrayPer 0 =%@",gbl_arrayPer[0]);
//     } while (FALSE);
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  12
//                          withThisString: (NSString *) @"2005"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  13
//                          withThisString: (NSString *) @"20141205"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  14
//                          withThisString: (NSString *) @"~Liz"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  15
//                          withThisString: (NSString *) @"~Family"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
// for (id eltTst in gbl_arrayPer) { NSLog(@"aft eltGrp=%@", eltTst); }

//            ret01 = [arrayMAMBexampleGroup   writeToURL:gbl_URLToGroup atomically:YES];
//            if (!ret01)  NSLog(@"Error write to Grp \n  %@", [err01 localizedFailureReason]);
//
//
//            ret01 = [arrayMAMBexamplePerson       writeToURL:gbl_URLToPerson atomically:YES];
//            if (!ret01)  NSLog(@"Error write to Per \n  %@", [err01 localizedFailureReason]);
//

//<.>
//            ret01 = [arrayMAMBexampleMember writeToURL:gbl_URLToMember atomically:YES];
//            if (!ret01)  NSLog(@"Error write to Mem \n  %@", [err01 localizedFailureReason]);
//

//NSLog(@"arrayMAMBexampleGroup=%@",arrayMAMBexampleGroup);
//            NSLog(@"arrayMAMBexampleMember=%@",arrayMAMBexampleMember);
//            tn();trn("after writeMemberArray");
//
//    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];   // for test member
//    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
//kin(haveGrp);
//kin(havePer);
//kin(haveMem);
//[myappDelegate mambReadMemberFile];
//tn();  NSLog(@"after test read Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//

    //[myMA sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //  for (id eltTst in gbl_arrayGrp) { NSLog(@"eltGrp=%@", eltTst); }
    //    // Log all data file contents
    //        NSMutableArray *arrayTst;
    //        arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToGroup];
    //        if (arrayTst == nil) { NSLog(@"%@", @"Error reading Grp"); }
    //        for (id eltTst in arrayTst) { NSLog(@"eltGrp=%@", eltTst); }
    //
    //    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToPerson];
    //    if (arrayTst == nil) { NSLog(@"%@", @"Error reading Per"); }
    //    for (id eltTst in arrayTst) { NSLog(@"eltPer=%@", eltTst); }
    //    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToMember];
    //    if (arrayTst == nil) { NSLog(@"%@", @"Error reading Mem"); }
    //    for (id eltTst in arrayTst) { NSLog(@"eltMem=%@", eltTst); }
    

    // Log all data in gbl_arrayPer file array contents
    // for (id eltTst in gbl_arrayPer) { NSLog(@"bef eltGrp=%@", eltTst); }

//
////    gbl_arrayMem = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToMember];
////    if (gbl_arrayMem == nil) { NSLog(@"%@", @"Error reading Mem"); }
////
//tn();  NSLog(@"before test read Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//tn();  NSLog(@"before sort Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//            NSLog(@"arrayMAMBexampleMember=%@",arrayMAMBexampleMember);
//            tn();trn("after writeMemberArray");
//    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];   // for test member
//    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
//kin(haveGrp);
//kin(havePer);
//kin(haveMem);
//tn();  NSLog(@"after sort Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//


//
//        haveGrpLastGood = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroupLastGood];
//        havePerLastGood = [gbl_sharedFM fileExistsAtPath: gbl_pathToPersonLastGood];
//        haveMemLastGood = [gbl_sharedFM fileExistsAtPath: gbl_pathToMemberLastGood];
//kin(havePerLastGood );
//kin(haveGrpLastGood );
//kin(haveMemLastGood );
//
////havePerLastGood = NO;  // for test put new example per data
//
//        NSLog(@"%d  %d  %d", haveGrpLastGood, havePerLastGood, haveMemLastGood);
//
//        if ( haveGrpLastGood && havePerLastGood && haveMemLastGood ) {
//            NSLog(@"%@", @"use  LastGood files!");
//            //      remove all regular named files (these cannot exist - no overcopy)
//            [gbl_sharedFM removeItemAtURL:gbl_URLToGroup error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToPerson error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToMember error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Mem %@", err01); }
//
//            //      copy lastGood DB files to regular names
//            [gbl_sharedFM copyItemAtURL:gbl_URLToGroupLastGood toURL:gbl_URLToGroup error:&err01];
//            if (err01) { NSLog(@"cp lg to grp %@", err01); }
//            [gbl_sharedFM copyItemAtURL:gbl_URLToPersonLastGood toURL:gbl_URLToPerson error:&err01];
//            if (err01) { NSLog(@"cp lg to per %@", err01); }
//            [gbl_sharedFM copyItemAtURL:gbl_URLToMemberLastGood toURL:gbl_URLToGroup error:&err01];
//            if (err01) { NSLog(@"cp lg to Mem %@", err01); }
//


//
//            // remove any lastGood files (err code NSFileNoSuchFileError = 4)
//            [gbl_sharedFM removeItemAtURL:gbl_URLToGroupLastGood error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grpLg %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToPersonLastGood error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"perLg %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToMemberLastGood error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"MemLg %@", err01); }
//
            
            // write out example data files from internal arrays
//            [myappDelegate mambWriteGroupArray:  (NSArray *) arrayMAMBexampleGroup];
//            [myappDelegate mambWritePersonArray: (NSArray *) arrayMAMBexamplePerson]; 
//            [myappDelegate mambWriteMemberArray: (NSArray *) arrayMAMBexampleMember]; 
//


    
    // check if DB files are there
    // if all are there, good to go
    // else {

//    //   if all lastGood are there,
//    //      remove all regular named files
//    //      copy lastGood DB files to regular names
//    //   else
//    //      remove any lastGood files
//

    //      write example data from arrays into new DB files
    // }
    // read regular DB files into arrays



//
//    // This is the initial example data in DB when app first starts.
//    // This is NOT the ongoing data, which is in ".txt" data files.
//    //
//    NSArray *arrayMAMBexampleGroup =   // field 1=name-of-group  field 2=locked-or-not
//    @[
//      @"~Swim Team||",
//      @"~My Family||",
//      ];
//    NSArray *arrayMAMBexamplePerson = // field 11= locked or not
//    @[
//      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States||",
//      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States||",
//      @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
//      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
//      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
//      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||",
//      @"~Mike|4|20|1992|6|30|1|Los Angeles|California|United States||",
//      @"~Anya 789012345|10|19|1990|8|20|0|Los Angeles|California|United States||",
//      @"~Billy 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
//      @"~Emma|5|17|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Jacob|10|10|1992|0|1|1|Los Angeles|California|United States||",
//      @"~Grace|8|21|1994|1|20|0|Los Angeles|California|United States||",
//      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States||",
//      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States||",
//      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||",
//      @"~Jim|2|3|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Olivia|4|13|1994|0|53|1|Los Angeles|California|United States||",
//      @"~Dave|4|8|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States||",
//      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
//      @"~Susie|2|3|1992|8|10|0|Los Angeles|California|United States||",
//      ];
//    NSArray *arrayMAMBexampleMember =
//    @[
//      @"~My Family|~Brother|",
//      @"~My Family|~Father|",
//      @"~My Family|~Grandma|",
//      @"~My Family|~Mother|",
//      @"~My Family|~Sister1|",
//      @"~My Family|~Sister2|",
//      @"~Swim Team|~Anya|",
//      @"~Swim Team|~Billy 89012345|",
//      @"~Swim Team|~Dave|",
//      @"~Swim Team|~Emma|",
//      @"~Swim Team|~Grace|",
//      @"~Swim Team|~Ingrid|",
//      @"~Swim Team|~Jacob|",
//      @"~Swim Team|~Jen|",
//      @"~Swim Team|~Jim|",
//      @"~Swim Team|~Liz|",
//      @"~Swim Team|~Mike|",
//      @"~Swim Team|~Noah|",
//      @"~Swim Team|~Olivia|",
//      @"~Swim Team|~Sophie|",
//      @"~Swim Team|~Susie|",
//      ];
//
//    // REMEMBER DATA for each Group 
//    //     field 1  name-of-group
//    //     field 2  last report selected for this Group:
//    //              ="m"  for   "Best Match"
//    //              ="a"  for   "Most Assertive Person"
//    //              ="e"  for   "Most Emotional"
//    //              ="r"  for   "Most Restless"
//    //              ="p"  for   "Most Passionate"
//    //              ="d"  for   "Most Down-to-earth"
//    //              ="u"  for   "Most Ups and Downs"
//    //              ="y"  for   "Best Year ..."
//    //              ="d"  for   "Best Day ..."
//    //     field  3  last year  last selection for this report parameter for this Group
//    //     field  4  day        last selection for this report parameter for this Group
//    //     + extra "|" at end
//    // 
//    NSArray *arrayMAMBexampleGroupRemember = 
//    @[
//      @"~Family||||",
//      @"~My Family||||",
//      ];
//
//    // REMEMBER DATA for each Person
//    //     field 1  name-of-person
//    //     field 2  last report selected for this Person:
//    //              ="m"  for   "Best Match"
//    //              ="y"  for   "Calendar Year ...",
//    //              ="p"  for   "Personality",
//    //              ="c"  for   "Compatibility Paired with ...",
//    //              ="g"  for   "My Best Match in Group ...",
//    //              ="d"  for   "How was your Day? ...",
//    //     field 3  last year
//    //     field 4  person
//    //     field 5  group
//    //     field 6  day
//    //              extra "|" at end
//    //
//    NSArray *arrayMAMBexamplePersonRemember = 
//    @[
//      @"~Father||||||",
//      @"~Mother||||||",
//      @"~Sister1||||||",
//      @"~Sister2||||||",
//      @"~Brother||||||",
//      @"~Grandma||||||",
//      @"~Mike||||||",
//      @"~Anya 789012345||||||",
//      @"~Billy 89012345||||||",
//      @"~Emma||||||",
//      @"~Jacob||||||",
//      @"~Grace||||||",
//      @"~Ingrid||||||",
//      @"~Jen||||||",
//      @"~Liz||||||",
//      @"~Jim||||||",
//      @"~Olivia||||||",
//      @"~Dave||||||",
//      @"~Noah||||||",
//      @"~Sophia||||||",
//      @"~Susie||||||",
//      ];
//
//    
//    //    for (id s in arrayMAMBexampleGroup)       {NSLog(@"eltG: %@",s);}
//    //    for (id s in arrayMAMBexampleperson)      {NSLog(@"eltP: %@",s);}
//    //    for (id s in arrayMAMBexampleMember)      {NSLog(@"eltGM: %@",s);}
//    //
//    
//

// into read func
//         //NSString *pathToLastEntity = [appDocDirStr stringByAppendingPathComponent: @"mambLastEntity.txt"];
//         NSString *pathToLastEntity = [appDocDirStr stringByAppendingPathComponent: @"mambd1"];
//         NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];
// 
//          // for test, remove lastEntity file
//          //  [sharedFM removeItemAtURL:URLToLastEntity
//          //                      error:&err01];
//          //  if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity test rm %@", err01); }
// 
//         BOOL haveLastEntity        = [sharedFM fileExistsAtPath: pathToLastEntity];
// NSLog(@"haveLastEntity= %@", (haveLastEntity? @"YES" : @"NO"));
// NSLog(@"haveLastEntity= %d", haveLastEntity);
//         
//         // haveLastEntity = NO;
//         
//         if ( ! haveLastEntity ) {
// nb(20);
//             // remove old, write out new lastEntity file with default entity
//             [sharedFM removeItemAtURL:URLToLastEntity
//                                 error:&err01];
//             if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity %@", err01); }
//             
//             NSString *defaultEntity = @"person|~Anya|group|~Swim Team";
//             ret01 = [defaultEntity writeToURL: URLToLastEntity
//                                    atomically: YES
//                                      encoding: NSUTF8StringEncoding
//                                         error: &err01 ];
//             if (!ret01) { NSLog(@"Error write to lastEntity \n  %@", [err01 localizedFailureReason]); }
//             NSLog(@"%@", @"1 setting lastEntity to person|~Anya|group|~Swim Team");
//         }
// nb(21);
//         // get contents of LastEntity file and
//         // populate _mambCurrentEntity and _mambCurrentSelection and _mambCurrentSelectionType
//         NSString *lastEntityStr = [[NSString alloc]
//                                    initWithContentsOfURL:URLToLastEntity
//                                    encoding:NSUTF8StringEncoding
//                                    error:&err01
//                                    ];
// 
// NSLog(@"lastEntityStr = %@", lastEntityStr );
// 
// 
//           //lastEntityStr = nil;  // for test take default lastEntity
//         if (lastEntityStr == nil) {
//             NSLog(@"%@", @"2 setting lastEntity to person|~Anya|group=~Swim Team");
//             lastEntityStr = @"person|~Anya|group|~Swim Team";
//         }
//         NSLog(@"lastEntityStr=%@", lastEntityStr);
// 
// 

// from viewWillAppear
//tn();trn("SCROLL 777777777777777777777777777777777777777777777777777777777");

    // get the indexpath of current row
    //NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];

//NSLog(@"myIdxPath2=%@",myIdxPath);
//NSLog(@"myIdxPath.row=%ld",(long)myIdxPath.row);
//

//    myIdxPath = gbl_savePrevIndexPath;
//    NSLog(@"myIdxPath3=%@",gbl_savePrevIndexPath);

    //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");
//     if(myIdxPath) {
//         [self.tableView selectRowAtIndexPath:myIdxPath
//                                     animated:YES
//                               scrollPosition:UITableViewScrollPositionNone];
// //                              scrollPosition:UITableViewScrollPositionMiddle];
//     }
// 
//     //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");
// 
//     //[self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//     [self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
//                                                       animated: YES];
//    [self.tableView scrollToRowAtIndexPath: myIdxPath
 //                         atScrollPosition: UITableViewScrollPositionMiddle
  //                                animated: YES ];
    
        // myDestTableViewController = [nc.viewControllers objectAtIndex:0]; // First view in nav controller
        // Is the detailTableViewController embedded in a Navigation Controller? If so, you'll need to access it this way:
//      
//        - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
//            if ([[segue identifier] isEqualToString:@"nextScreen"]) {
//                UINavigationController *nc = segue.destinationViewController;
//                DetailTableViewController * detailTableViewController = [nc.viewControllers objectAtIndex:0]; // First view in nav controller
//                NSInteger tagIndex = [(UIButton *)sender tag];
//                detailTableViewController.productType = tagIndex;
//            }
//     

        
        //MAMB09_selectReportsTableViewController *myDestTableViewController =
        // UITableViewController *myDestTableViewController = segue.destinationViewController;
        // MAMB09_selectReportsTableViewController *myDestTableViewController = segue.destinationViewController;
        
//        if ([_mambCurrentEntity isEqualToString:@"group"]) {
//            NSLog(@"current  row 222=[%@]", [gbl_arrayGrp objectAtIndex:myIdxPath.row]);
//            myDestTableViewController.selectedObjectFromHome = [gbl_arrayGrp objectAtIndex:myIdxPath.row]
//        } else if ([_mambCurrentEntity isEqualToString:@"person"]) {
//            NSLog(@"current  row 223=[%@]", [gbl_arrayPer objectAtIndex:myIdxPath.row]);
//            myDestTableViewController.selectedObjectFromHome = [gbl_arrayPer objectAtIndex:myIdxPath.row]
//        }
    
        //myDestTableViewController.delegate = self;
        

//    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//        if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//            RecipeDetailViewController *destViewController = segue.destinationViewController;
//            destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
//        }
//    }
    
//        PlayerDetailsViewController *playerDetailsViewController =
//            [[navigationController viewControllers] objectAtIndex:0];
//        playerDetailsViewController.delegate = self;

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

//    
//    UITableViewController *SelectTblViewController = [[UITableViewController alloc] init];
//    SelectTblViewController = [segue destinationViewController];
    
    // get the indexpath
    //NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // here, pass information to destination tableview
    //if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        // MyDetailViewController *detailViewController = [segue destinationViewController];
        //  UIViewController *detailViewController = [segue destinationViewController];
    //NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    //detailViewController.data = [self.dataController objectInListAtIndex: myIndexPath.row];
    //}
