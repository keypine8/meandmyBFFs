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
nbn(410);
        [gbl_peopleToPickFrom removeAllObjects];
         gbl_peopleToPickFrom = [[NSMutableArray alloc] init];

         for (NSString *perRec in gbl_arrayPer)
         {
              NSArray *psvArray;
              NSString *perName;
              
              psvArray = [perRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
              perName  = psvArray[0];
  NSLog(@"perName  =[%@]",perName  );

              //   // EXCLUDE       people who are example data ("~")
              if ([perName hasPrefix: @"~" ])   continue;         // no example people to share
             
              [gbl_peopleToPickFrom  addObject: perName ];   //  Person name for pick
nbn(419);
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


    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex  or not

    [self.tableView reloadSectionIndexTitles ];  // MAGIC do NOT know why this is necessary to show the section index here, but it works

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
        [gbl_selectedPeople_toShare addObject: tmpName ];      
    } else {
        [gbl_selectedGroups_toShare addObject: tmpName ];     
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
        [gbl_selectedPeople_toShare removeObject: tmpName ]; 
    } else {
        [gbl_selectedGroups_toShare removeObject: tmpName ];
    }
} // didDeselectRowAtIndexPath



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



- (IBAction)pressedSaveDone:(id)sender
{
tn();
  NSLog(@"in pressedSAVEDONE!  in selShareEntity ");


    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m

    // loop thru the seleced people or groups
    // and build a text file of the data
    //

    //    NSArray *fields = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"];
    //    fldName      =  fields[ 0];
    //    fldMth       =  fields[ 1];
    //    fldDay       =  fields[ 2];
    //    fldYear      =  fields[ 3];
    //    fldHour      =  fields[ 4];
    //    fldMin       =  fields[ 5];
    //    fldAmPm      =  fields[ 6];
    //    fldCity      =  fields[ 7];
    //    fldProv      =  fields[ 8];
    //    fldCountry   =  fields[ 9];
    //    fldKindOfSave  = fields[10];  // = "hs" or ""
    //


    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person" ])
    {
       [gbl_arraySharePeople removeAllObjects];                  // init before setting
        gbl_arraySharePeople = [[NSMutableArray alloc] init];    // init before setting

        NSString *myPerson_PSV;
        NSString *myPerson_PSV_share;
        for (NSString *selectedPerson  in  gbl_selectedPeople_toShare) 
        {
            // get PSV for selectedPerson from gbl_arrayPer
            myPerson_PSV = [myappDelegate getPSVforPersonName: (NSString *) selectedPerson ]; 

            // make share record for person  import/export
            // prepend code "p" for person record
            myPerson_PSV_share = [NSString stringWithFormat:  @"p|%@|", myPerson_PSV ];
    
            // add share record for person  import/export  to gbl_arraySharePeople
            [gbl_arraySharePeople  addObject: myPerson_PSV_share ];
        }
  NSLog(@"gbl_arraySharePeople  =[%@]",gbl_arraySharePeople );


        gbl_mamb_fileNameOnEmail = @"people.mamb";

        [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"sharepeople"]; // write gbl_arraySharePeople to mambd7 in gbl_appDocDirStr


    } // person

    // worked
    //  // for test,   read back with mambReadArrayFileWithDescription 
    //        [gbl_arraySharePeople  removeAllObjects];               // empty array
    //         gbl_arraySharePeople  = [[NSMutableArray alloc] init];   // init  array
    //  NSLog(@"gbl_arraySharePeople  =[%@]",gbl_arraySharePeople );
    //        [myappDelegate mambReadArrayFileWithDescription:  (NSString *) @"sharepeople"]; // read new data from file to array
    //  NSLog(@"gbl_arraySharePeople  =[%@]",gbl_arraySharePeople );
    //


    if ([gbl_fromHomeCurrentEntity isEqualToString: @"group" ])
    {
       [gbl_arrayShareGroups removeAllObjects];                  // init before setting
        gbl_arrayShareGroups = [[NSMutableArray alloc] init];    // init before setting

        NSString *myGroup_PSV;
        NSString *myGroup_PSV_share;
        for (NSString *selectedGroup  in  gbl_selectedGroups_toShare) 
        {
            // --------------------------------------------------------
            // add the group share record for this selected group
            // --------------------------------------------------------

            // get PSV for selectedGroup from gbl_arrayPer
            myGroup_PSV = [myappDelegate getPSVforGroupName: (NSString *) selectedGroup ]; 

            // make share record for group  import/export
            // prepend code "g" for group record
            myGroup_PSV_share = [NSString stringWithFormat:  @"g|%@|", myGroup_PSV ];
    
            // add share record for group  import/export  to gbl_arrayShareGroups
            [gbl_arrayShareGroups  addObject: myGroup_PSV_share ];


            // --------------------------------------------------------
            // add all member share records for this selected group
            // add all person share records for this selected group
            // --------------------------------------------------------
            for (NSString *myMemberRec in gbl_arrayMem)
            {
                NSArray *psvArray;
                NSString *currGroup;
                NSString *currMember;
                NSString *myMember_PSV_share;
                NSString *myPerson_PSV;
                NSString *myPerson_PSV_share;
                
                psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
                currGroup  = psvArray[0];
                currMember = psvArray[1];

                if ([currGroup isEqualToString: selectedGroup ] )
                {
                    // make share record for group member
                    // prepend code "m" for group member record
                    myMember_PSV_share = [NSString stringWithFormat:  @"m|%@|", myMemberRec ];
            
                    // add share record for group  import/export  to gbl_arrayShareGroups
                    [gbl_arrayShareGroups  addObject: myMember_PSV_share ];


                    // get PSV for person who is member of selectedGroup
                    myPerson_PSV = [myappDelegate getPSVforPersonName: (NSString *) currMember ]; 

                    // make share record for person  import/export
                    // prepend code "p" for person record
                    myPerson_PSV_share = [NSString stringWithFormat:  @"p|%@|", myPerson_PSV ];
            
                    // add share record for person  import/export  to gbl_arraySharePeople
                    [gbl_arrayShareGroups  addObject: myPerson_PSV_share ];

                } // for member of this selected group

            } // all members of all groups

        } // for each selected group to share

  NSLog(@"gbl_arrayShareGroups  =[%@]",gbl_arrayShareGroups );


        gbl_mamb_fileNameOnEmail = @"groups.mamb";

        [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"sharegroups"]; // write gbl_arrayShareGroups to mambd7 in gbl_appDocDirStr

    } // group


    [self doMailComposeSend ];

} // pressedSaveDone  for Add selected members


- (void) doMailComposeSend 
{
    MFMailComposeViewController *myMailComposeViewController;

tn();    NSLog(@"in doMailComposeSend !  in selShare .m");

    // NSString *gbl_mamb_fileNameOnEmail ;  // "people.mamb"  or  "groups.mamb"  or  backup_yyyymmddhhmmss.mamb
       
    // here, export file is in mambd7 in gbl_appDocDirStr

    // remove all "*.mamb" files from TMP directory before creating new one
    //
    NSArray *tmpDirFiles;
    tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: NSTemporaryDirectory()  error: NULL];
  NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);

    for (NSString *fil in tmpDirFiles) {
  NSLog(@"fil=%@",fil);
        if ([fil hasSuffix: @"mamb"]) {
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
  NSLog(@"removed a MAMB file from TMP");
        }
    }

    // copy  export file mambd7 in gbl_appDocDirStr  to gbl_mamb_fileNameOnEmail (like "groups.mamb") in NSTemporaryDirectory()
    //
    NSURL    *URL_toExport_forEmailing;
    NSString *pathToExport_forEmailing;
    URL_toExport_forEmailing = [ NSURL fileURLWithPath: 
        [NSTemporaryDirectory() stringByAppendingPathComponent: gbl_mamb_fileNameOnEmail ] //  "groups.mamb"  or  "people.mamb"
    ];
  NSLog(@"URL_toExport_forEmailing =[%@]",URL_toExport_forEmailing );


    NSFileManager* sharedFM3 = [NSFileManager defaultManager];
    NSError *err05;
    [sharedFM3 copyItemAtURL: gbl_URLToExport             // mambd7 in gbl_appDocDirStr  
                       toURL: URL_toExport_forEmailing  // "people.mamb" or "groups.mamb" in tmp dir
                       error: &err05];
    if (err05) { NSLog(@"err on cp mambd7 to email name: %@", err05); }

    pathToExport_forEmailing = [
        NSTemporaryDirectory() stringByAppendingPathComponent: gbl_mamb_fileNameOnEmail  //  "groups.mamb"  or  "people.mamb"
    ]; 
  NSLog(@"pathToExport_forEmailing=[%@]",pathToExport_forEmailing);


    // Determine the file name and extension
    // 
    NSArray *fileparts = [
        pathToExport_forEmailing componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"./" ]
    ];
    
    NSString *baseFilename = [fileparts objectAtIndex: (fileparts.count -2)] ;  // count -1 is last in array
    NSString *extension    = [fileparts lastObject];
    NSString *filenameForAttachment = [NSString stringWithFormat: @"%@.%@", baseFilename, extension];
    

    // Get the resource path and read the file using NSData
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    //
    NSData *MAMBfileData = [NSData dataWithContentsOfFile: pathToExport_forEmailing ];   // ATTACHMENT
  NSLog(@"MAMBfileData.length=%lu",(unsigned long)MAMBfileData.length);


    NSString *emailTitle = [NSString stringWithFormat: @"%@  from Me and my BFFs", filenameForAttachment];

    NSString *myEmailMessage;
    NSString *first5;
    if ([gbl_mamb_fileNameOnEmail length] >=6) first5 = [gbl_mamb_fileNameOnEmail substringToIndex: 6];
    else                                       first5 = @"people or groups";

    myEmailMessage = [ NSString stringWithFormat:
@"\n\"Someone has sent you one or more %@ who can be imported into the App Me and my BFFs.\n\nOn the device where you have \"Me and my BFFs\" tap and hold on the \".mamb\" attachment icon below.  The app will come up and import the %@ for you.",
        first5,
        first5
    ];

    
    //   NSArray *toRecipents = [NSArray arrayWithObject:@"ijfo@jldks.com"];
    NSArray *toRecipients = [NSArray arrayWithObjects:@"", nil];  //  user types it in


    // Determine the MIME type
    NSString *mimeType;
    mimeType = @"mamb";
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    if ([MFMailComposeViewController canSendMail])
    {
        myMailComposeViewController = [[MFMailComposeViewController alloc] init];

        NSLog(@"This device CAN send email");

         myMailComposeViewController.mailComposeDelegate = self;
        [myMailComposeViewController              setSubject: emailTitle
        ];
        [myMailComposeViewController          setMessageBody: myEmailMessage
                                                      isHTML: NO 
        ];
        [myMailComposeViewController         setToRecipients: toRecipients 
        ];
        [myMailComposeViewController setModalTransitionStyle: UIModalTransitionStyleCrossDissolve 
        ];
        [myMailComposeViewController       addAttachmentData: MAMBfileData                // Add attachment    ATTACHMENT
                                                    mimeType: mimeType
                                                    fileName: filenameForAttachment
        ];
        
        // Present mail view controller on screen
        //
        //[self presentModalViewController:myMailComposeViewController animated:YES completion:NULL];


        dispatch_async(dispatch_get_main_queue(), ^(void){
                [self presentViewController: myMailComposeViewController animated:YES completion:NULL];
            }
        );
    }
    else
    {
//        NSLog(@"This device cannot send email");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cannot send email"
//                                                        message: @"Maybe email on this device is not set up."
//                                                       delegate: nil
//                                              cancelButtonTitle: @"OK"
//                                              otherButtonTitles: nil];
//        [alert show];
//
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Cannot send email"
                                                                       message: @"Maybe email on this device is not set up."
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];
    }
} // end of doMailComposeSend 


- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    if (error) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"An error happened"
                                                                       message: [error localizedDescription]
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
        } ];
        [alert addAction:  okButton];
        [self presentViewController: alert  animated: YES  completion: nil   ];

        // [self dismissViewControllerAnimated:yes completion:<#^(void)completion#>];

        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated: YES
                                     completion:NULL];
            }
        );
    }
    switch (result)
    {
        case MFMailComposeResultCancelled: {
NSLog(@"Mail cancelled");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail Send was Cancelled"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];

            break;
        }
        case MFMailComposeResultSaved: {
            NSLog(@"Mail saved");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail was Saved"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];

            break;
        }
        case MFMailComposeResultSent: {
            NSLog(@"Mail sent");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail was Sent"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];


            break;
        }
        case MFMailComposeResultFailed: {
            NSLog(@"Mail send failure: %@", [error localizedDescription]);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Failure of Mail Send"
                                                                           message: [error localizedDescription]
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];

            break;
        }
        default: { break; }
    }
    
    // Close the Mail Interface
//    [self becomeFirstResponder];  // from http://stackoverflow.com/questions/14263690/need-help-dismissing-email-composer-screen-in-ios

    //[self dismissModalViewControllerAnimated:YES

    dispatch_async(dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated:YES
                                     completion:NULL];
        }
    );

} // mailComposeController didFinishWithResult:




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
  NSLog(@"in sectionIndexTitlesForTableView !  in selShareEntity");

//return nil;  // test no section index

    NSInteger myCountOfRows;
    myCountOfRows = 0;

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
nbn(400);
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

nbn(401);
    return mySectionIndexTitles;

} // end of sectionIndexTitlesForTableView



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle: (NSString *) title
                                                                    atIndex:  (NSInteger) index
{
  NSLog(@"sectionForSectionIndexTitle!  in selShareEntity");
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
