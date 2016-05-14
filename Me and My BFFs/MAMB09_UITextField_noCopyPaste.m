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


//
//// Hide the cursor (caret)
//- (CGRect)caretRectForPosition:(UITextPosition*)position
//{
//  NSLog(@"in caretRectForPosition  in MAMB09_UITextField_noCopyPaste.m");
//    return CGRectZero;   // Hide the cursor (caret)
//}
//

//- (void) setSelectedRange:(NSRange) range
//{
//tn();
//  NSLog(@"in setSelectedRange!");
//    //NSLog(@"range=[%@]",range);
//  NSLog(@"range.location %lu](unsigned long)",range.location );
//  NSLog(@"range.length   %lu](unsigned long)",range.length   );
//
//    UITextPosition* beginning = self.beginningOfDocument;
//
////    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
////    UITextPosition* endPosition   = [self positionFromPosition:beginning offset:range.location + range.length];
////    UITextRange* selectionRange   = [self textRangeFromPosition:startPosition toPosition:endPosition];
//    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
//    UITextPosition* endPosition   = [self positionFromPosition:beginning offset:range.location + range.length];
//    UITextRange* selectionRange   = [self textRangeFromPosition:startPosition toPosition:endPosition];
//
//    [self setSelectedTextRange:selectionRange];
//  }
//

// trying to get no selection bars on double tap

//- (void) setSelectedTextRange: (UITextRange *) selectedTextRange
//{
//  NSLog(@"in setSelectedTextRange!  2]");
////    [super setSelectedTextRange: nil ];
////    [self setSelectedTextRange: nil ];
////    [self setSelectedTextRange: 0 ];
//
//
//    gbl_timesthrusetsel =  gbl_timesthrusetsel  + 1;
//  NSLog(@"                 hey  10!");
//    if (gbl_timesthrusetsel > 1) {
//  NSLog(@"                 hey  11!");
//        gbl_timesthrusetsel = 0;
//        return;
//    }
//  NSLog(@"                 hey  12!");
//
//
////  NSLog(@"in setSelectedTextRange!  7]");
////    [super setSelectedTextRange: selectedTextRange ];
//
//  NSLog(@"in setSelectedTextRange!  3]");
//    // Get current selected range , this example assumes is an insertion point or empty selection
//    UITextRange *selectedRange = [gbl_myname selectedTextRange];
//
//  NSLog(@"in setSelectedTextRange!  4]");
//    // Calculate the new position, - for left and + for right
////    UITextPosition *newPosition = [textField positionFromPosition:selectedRange.start offset:-5];
//    UITextPosition *newPosition = [gbl_myname positionFromPosition:selectedRange.start offset:0];
//
//  NSLog(@"in setSelectedTextRange!  5]");
//    // Construct a new range using the object that adopts the UITextInput, our textfield
////    UITextRange *newRange = [textField textRangeFromPosition:newPosition toPosition:selectedRange.start];
//    UITextRange *newRange = [gbl_myname textRangeFromPosition:newPosition toPosition:selectedRange.start];
//
////  NSLog(@"in setSelectedTextRange!  6]");
////    // Set new range
//////    [textField setSelectedTextRange: newRange];
//    [gbl_myname setSelectedTextRange: newRange];
//
//
//
////  NSLog(@"in setSelectedTextRange!  7]");
////    [super setSelectedTextRange: newRange ];
//
//  NSLog(@"                 hey!");
//}
//

//- (void)selectionWillChange: (id<UITextInput>)textInput
//{
//tn();
//  NSLog(@"in selectionWillChange!");
//
////    [super setSelectedTextRange: selectedTextRange];
////    [super setSelectedTextRange: NSMakeRange(0, 0) ];
//
//
////    setSelectedRange:(NSRange) range
////3312:            NSRange searchRange = NSMakeRange(0, [myStringNoAttr length]);
//
////   [self setSelectedRange: NSMakeRange(0, 0) ];
//}
//
////- (void)selectionWillChange:(nullable id <UITextInput>)textInput  { }
//- (void)selectionDidChange:(nullable id <UITextInput>)textInput   {
//  NSLog(@"in selectionDidChange!]");
//}
//- (void)textWillChange:(nullable id <UITextInput>)textInput       {
//  NSLog(@"in textWillChange!]");
//}
//- (void)textDidChange:(nullable id <UITextInput>)textInput        {
//  NSLog(@"in textDidChange!]");
//}
//




//<.>
//nbn(47);
//    // try doubleTapGestureRecognizer that does nil
//    gbl_doubleTapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: nil
//    ];
//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
////    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//    gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//    [gbl_myname addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//<.>
//




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
//  NSLog(@"in canPerformAction  11111111111111111111111111111111111111111111 11111111 11111111 111111111");
//  NSLog(@"function=[%s] sender=[%@] selector=[%s]",   __FUNCTION__,   sender,  sel_getName(action) );
    
//  NSLog(@"sender.description =[%@]",sender.description );


    NSString *myStringForAction;
    myStringForAction = NSStringFromSelector(action);

//  NSLog(@"myStringForAction =[%@]",myStringForAction );
//  NSLog(@" EVERYTHING   return NO");
       return NO; // always return NO

//
////  NSLog(@"NSStringFromSelector(action)=[%@]",NSStringFromSelector(action));
//
////    if (action == @selector(delete:))
//
//    // allow copy, cut
//    if ([ myStringForAction isEqualToString: @"cut:" ])   
//    {
////  NSLog(@"myStringForAction=[cut:]  return NO");
//       return NO;
//    }
//    if ([ myStringForAction isEqualToString: @"copy:" ])   
//    {
////  NSLog(@"myStringForAction=[copy:]  return NO");
//       return NO;
//    }
//
////    if ([ myStringForAction isEqualToString: @"delete:" ])
////    {
////  NSLog(@"myStringForAction=[delete:]  return NO");
////       return NO;
////    }
//    if ([ myStringForAction isEqualToString: @"paste:" ])   
//    {
////  NSLog(@"myStringForAction=[paste:]  return NO");
//       return NO;
//    }
//    if ([ myStringForAction isEqualToString: @"selectAll:" ])
//    {
////  NSLog(@"myStringForAction=[selectAll:]  return NO" );
//       return NO;
//    }
//
//    if ([ myStringForAction isEqualToString: @"makeTextWritingDirectionRightToLeft:" ])  
//    {
////  NSLog(@"myStringForAction=[makeTextWritingDirectionRightToLeft:]  return NO");
//       return NO;
//    }
//    if ([ myStringForAction isEqualToString: @"makeTextWritingDirectionRightToLeft:" ])  
//    {
////  NSLog(@"myStringForAction=[makeTextWritingDirectionLeftTORight:]  return NO");
//       return NO;
//    }
//
//    // no delete: no share:  allowed  ( vars beginning with "_"   protected ? )
//
////    return [super canPerformAction:action withSender:sender];
//
////  NSLog(@"action=[%@]  return YES", myStringForAction);
//    return YES;
//

} // canPerformAction:(SEL)action withSender:(id)sender 



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
