//
//  ViewController.h
//  RedBlack
//
//  Created by Richard on 11/23/13.
//
//

#import <UIKit/UIKit.h>
#import "RBTree.h"
#import "RBNodeView.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *logButton;
@property (weak, nonatomic) IBOutlet UIScrollView *treeDisplayView;
@property (strong, nonatomic) RBTree *tree;
@property (weak, nonatomic) IBOutlet UIButton *clearTreeButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

- (IBAction)addValue:(id)sender;
- (IBAction)logTree:(id)sender;
- (IBAction)clearTree:(id)sender;
- (IBAction)removeValue:(id)sender;

@end
