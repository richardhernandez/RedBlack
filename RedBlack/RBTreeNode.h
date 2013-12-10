//
//  RBTreeNode.h
//  RedBlack
//
//  Created by Richard on 11/23/13.
//
//

#import <Foundation/Foundation.h>
#define RED 0
#define BLACK 1

@interface RBTreeNode : NSObject

@property (strong, nonatomic) id value;
@property (strong, nonatomic) RBTreeNode *leftChild;
@property (strong, nonatomic) RBTreeNode *rightChild;
@property (weak, nonatomic) RBTreeNode *parent;
@property (assign, nonatomic) NSInteger color;
@property (assign, nonatomic) NSInteger subtreeCount;
@property (assign, nonatomic) NSInteger x;
@property (assign, nonatomic) NSInteger y;

- (id)initWithValue:(id) value;
- (id)initWithValue:(id)value color:(NSInteger)color;
- (id)initWithValue:(id)value color:(NSInteger)color subtreeCount:(NSInteger)subtreeCount;
- (NSString *)toString;
- (void)setX:(NSInteger)x Y:(NSInteger)y;

@end
