//
//  RBTree.h
//  RedBlack
//
//  Created by Richard on 11/23/13.
//
//

#import <Foundation/Foundation.h>
#import "RBTreeNode.h"
#import "RBNodeView.h"

@interface RBTree : NSObject

@property (strong, nonatomic) RBTreeNode *root;
@property (nonatomic) NSInteger size;

- (void)put:(id)value;
- (void)remove:(id)value;
- (BOOL)contains:(id)value;
- (id)get:(id)value;
- (BOOL)isEmpty;
- (void)levelOrderTraversal;
- (NSMutableArray*)getNodes;
- (CGSize)fixNodePositions:(CGSize)size;

@end
