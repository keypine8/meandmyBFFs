//
//  MAMB09_UITextField_noCopyPaste.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-04-10.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_UITextField_noCopyPaste.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"


@implementation MAMB09_UITextField_noCopyPaste

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// Hide the cursor (caret)
- (CGRect)caretRectForPosition:(UITextPosition*)position
{
  NSLog(@"in caretRectForPosition  in MAMB09_UITextField_noCopyPaste.m");
    return CGRectZero;   // Hide the cursor (caret)
}


//Disables magnifying glass
-(void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        gestureRecognizer.enabled = NO;   //Disables magnifying glass
    }
    [super addGestureRecognizer:gestureRecognizer];
}



// problem:  this is called before textFieldShouldBeginEditing
//
////
//// All touches inside will be ignored
//// and intercepted by the superview
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//  NSLog(@"in pointInside !");
//
////    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
//
//  NSLog(@"gbl_firstResponder_previous=[%@]",gbl_firstResponder_previous);
//  NSLog(@"gbl_firstResponder_current =[%@]",gbl_firstResponder_current);
//  NSLog(@"gbl_fieldTap_leaving       =[%@]",gbl_fieldTap_leaving);
//  NSLog(@"gbl_fieldTap_goingto       =[%@]",gbl_fieldTap_goingto);
//
//
//
////    if ([gbl_firstResponder_current isEqualToString: gbl_currentEditingField ])  return NO;
////    else return YES;
//
//    return YES;
//}
//




- (BOOL)canPerformAction:(SEL)action withSender:(id)sender { //  NOTE  still shows paste
  NSLog(@"in canPerformAction  11111111111111111111111111111111111111111111 11111111 11111111 111111111");
  NSLog(@"function=[%s] sender=[%@] selector=[%s]",   __FUNCTION__,   sender,  sel_getName(action) );

    NSString *myStringForAction;
    myStringForAction = NSStringFromSelector(action);

  NSLog(@"myStringForAction =[%@]",myStringForAction );
  NSLog(@" EVERYTHING   return NO");
       return NO;


//  NSLog(@"NSStringFromSelector(action)=[%@]",NSStringFromSelector(action));

//    if (action == @selector(delete:))

    // allow copy, cut
    if ([ myStringForAction isEqualToString: @"cut:" ])   
    {
  NSLog(@"myStringForAction=[cut:]  return NO");
       return NO;
    }
    if ([ myStringForAction isEqualToString: @"copy:" ])   
    {
  NSLog(@"myStringForAction=[copy:]  return NO");
       return NO;
    }

//    if ([ myStringForAction isEqualToString: @"delete:" ])
//    {
//  NSLog(@"myStringForAction=[delete:]  return NO");
//       return NO;
//    }
    if ([ myStringForAction isEqualToString: @"paste:" ])   
    {
  NSLog(@"myStringForAction=[paste:]  return NO");
       return NO;
    }
    if ([ myStringForAction isEqualToString: @"selectAll:" ])
    {
  NSLog(@"myStringForAction=[selectAll:]  return NO" );
       return NO;
    }

    if ([ myStringForAction isEqualToString: @"makeTextWritingDirectionRightToLeft:" ])  
    {
  NSLog(@"myStringForAction=[makeTextWritingDirectionRightToLeft:]  return NO");
       return NO;
    }
    if ([ myStringForAction isEqualToString: @"makeTextWritingDirectionRightToLeft:" ])  
    {
  NSLog(@"myStringForAction=[makeTextWritingDirectionLeftTORight:]  return NO");
       return NO;
    }

    // no delete: no share:  allowed  ( vars beginning with "_"   protected ? )

//    return [super canPerformAction:action withSender:sender];

  NSLog(@"action=[%@]  return YES", myStringForAction);
    return YES;
}


//
//- (BOOL)canPerformAction: (SEL)action
//              withSender: (id)sender
//{
////  NSLog(@"canPerformAction ! in MAMB09_UITextField_noCopyPaste.m");
//  NSLog(@"canPerformAction !  action=[%@]", NSStringFromSelector(action) );
////  NSLog(@"action =[%@]",(SEL _Nonnull) action);
////  NSLog(@"action =[%@]",(id) action);
//
//
////    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//////        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
////        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
////    }];
////    return [super canPerformAction:action withSender:sender];
////
//
//    if (   action == @selector(copy:) ) return YES;
//
////
////    if (   action == @selector(paste:    )
////        || action == @selector(cut:      )
////        || action == @selector(copy:     )
////        || action == @selector(select:   )
////        || action == @selector(selectAll:)
////        || action == @selector(delete:   )
//////        action == @selector(promptForReplace:) ||
//////        action == @selector(makeTextWritingDirectionLeftToRight:  ) ||
//////        action == @selector(makeTextWritingDirectionRightToLeft:  ) ||
//////        action == @selector(toggleBoldface:                       ) ||
//////        action == @selector(toggleItalics:                        ) ||
//////        action == @selector(toggleUnderline:                      )
//////        action == @selector(_promptForReplace:)   ||
//////        action == @selector(_transliterateChinese:)   ||
//////        action == @selector(_showTextStyleOptions:)   ||
//////        action == @selector(_addShortcut:)   ||
//////        action == @selector(_accessibilitySpeak:)   ||
//////        action == @selector(_accessibilitySpeakLanguageSelection:)   ||
//////        action == @selector(_accessibilityPauseSpeaking:)   ||
////
////        ) {
////  NSLog(@"return  NO !");
//////tn();        
////        return NO;
////    }
////
////  NSLog(@"return YES !");
//////tn();        
////        return YES;
////
//
//  NSLog(@"return [super canPerformAction:action withSender:sender]; ");
//tn();        
//    return [super canPerformAction:action withSender:sender];
//
//
//
//} // end of canPerformAction  in MAMB09_UITextField_noCopyPaste.m
//
//

@end
