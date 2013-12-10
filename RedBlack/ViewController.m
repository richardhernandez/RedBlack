//
//  ViewController.m
//  RedBlack
//
//  Created by Richard on 11/23/13.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tree;

- (void)viewDidLoad
{
	[_textField setDelegate:self];
    [_textField setReturnKeyType:UIReturnKeyDone];
    [_textField addTarget:self action:@selector(closeTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tree = [[RBTree alloc] init];
    [_treeDisplayView setContentSize:[_treeDisplayView bounds].size];
    [super viewDidLoad];
}

- (IBAction)closeTextField:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)addValue:(id)sender
{
    NSString *text = [_textField text];
    if (text.length == 0) {
        [self drawTree];
        return;
    }
    
    NSNumber *value = [[NSNumber alloc] initWithInteger:[text integerValue]];
    [tree put:value];
    [_textField setText:@""];
    [tree fixNodePositions:[_treeDisplayView contentSize]];
    [self drawTree];
}

- (IBAction)logTree:(id)sender
{
    NSLog(@"======== LOGGING TREE ========");
    [tree levelOrderTraversal];
}

- (IBAction)clearTree:(id)sender
{
    [self clearTreeView];
    tree = [[RBTree alloc] init];
    [_treeDisplayView setContentSize:[_treeDisplayView bounds].size];
}

- (IBAction)removeValue:(id)sender
{
    NSString *text = [_textField text];
    if (text.length == 0) {
        return;
    }
    
    NSNumber *value = [[NSNumber alloc] initWithInteger:[text integerValue]];
    [tree remove:value];
    [_textField setText:@""];
    [tree fixNodePositions:[_treeDisplayView contentSize]];
    [self drawTree];
}

//- (void)drawTree
//{
//    [self clearTreeView];
//    [tree fixNodePositions:[_treeDisplayView bounds].size];
//    NSInteger treeSize = tree.size;
//    NSMutableArray *nodeArray = [tree getNodes];
//    for (int i = 0; i < treeSize; i++) {
//        RBTreeNode *newNode = [nodeArray objectAtIndex:i];
//        while ([newNode x] < 0 || [newNode x] > [_treeDisplayView contentSize].width) {
//            [_treeDisplayView setContentSize:CGSizeMake([_treeDisplayView contentSize].width + CIRCLE_SIZE + 3,
//                                                        [_treeDisplayView contentSize].height)];
//            [tree fixNodePositions:[_treeDisplayView contentSize]];
//            [self clearTreeView];
//            for (int j = 0; j < i; j++) {
//                [_treeDisplayView addSubview:[[RBNodeView alloc] initWithRBTreeNode:[nodeArray objectAtIndex:j]]];
//            }
//        }
//        
//        while ([newNode y] < 0 || [newNode y] > [_treeDisplayView contentSize].height) {
//            [_treeDisplayView setContentSize:CGSizeMake([_treeDisplayView contentSize].width,
//                                                        [_treeDisplayView contentSize].height + CIRCLE_SIZE)];
//            [tree fixNodePositions:[_treeDisplayView contentSize]];
//            [self clearTreeView];
//            for (int j = 0; j < i; j++) {
//                [_treeDisplayView addSubview:[[RBNodeView alloc] initWithRBTreeNode:[nodeArray objectAtIndex:j]]];
//            }
//        }
//    
//        [_treeDisplayView addSubview:[[RBNodeView alloc] initWithRBTreeNode:newNode]];
//    }
//}

- (void)drawTree
{
    [self clearTreeView];
    [_treeDisplayView setContentSize:[tree fixNodePositions:[_treeDisplayView contentSize]]];
    NSMutableArray *nodes = [tree getNodes];
    for (NSUInteger i = 0; i < [tree size]; i++) {
        [_treeDisplayView addSubview:[[RBNodeView alloc] initWithRBTreeNode:[nodes objectAtIndex:i]]];
    }
}

- (void)clearTreeView
{
    for (UIView *v in [_treeDisplayView subviews]) {
        if ([v class] == [RBNodeView class]) {
            [v removeFromSuperview];
        }
    }
}

- (void)drawLines
{
    for (RBTreeNode *t in [tree getNodes]) {
        if ([t leftChild]) {
        }
    }
}

@end
