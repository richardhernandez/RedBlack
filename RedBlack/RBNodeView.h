//
//  RBNodeView.h
//  RedBlack
//
//  Created by Richard on 11/27/13.
//
//

#import <UIKit/UIKit.h>
#import "RBTreeNode.h"
#define CIRCLE_SIZE 60.0

@interface RBNodeView : UIView

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) UIColor *color;
@property (strong, nonatomic) RBTreeNode *node;

- (id)initWithTitle:(NSString *)title Color:(NSInteger)Color X:(CGFloat)x Y:(CGFloat)y;
- (id)initWithRBTreeNode:(RBTreeNode *)node;

@end
