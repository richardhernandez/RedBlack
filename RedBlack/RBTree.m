//
//  RBTree.m
//  RedBlack
//
//  Created by Richard on 11/23/13.
//
//

#import "RBTree.h"

void setNodePosition(RBTreeNode* node, NSInteger h, float i) {
    if (!node || (!node.leftChild && !node.rightChild)) return;
    float i2 = 1.0f + i/(h + i);
    float i3 = CIRCLE_SIZE * (h - i)/2;
    if (node.leftChild) [node.leftChild setX:[node x] - i3 Y:[node y] + i2 * CIRCLE_SIZE];
    if (node.rightChild) [node.rightChild setX:[node x] + i3 Y:[node y] + i2 * CIRCLE_SIZE];
    i++;
    setNodePosition(node.leftChild, h, i);
    setNodePosition(node.rightChild, h, i);
}

void addNodesToArray(NSMutableArray* arr, RBTreeNode* node) {
    if (!node) return;
    [arr addObject:node];
    addNodesToArray(arr, node.leftChild);
    addNodesToArray(arr, node.rightChild);
}

void traverse(RBTreeNode *node) {
    if (!node) return;
    NSLog(@"%@", [node toString]);
    traverse(node.leftChild);
    traverse(node.rightChild);
}

void rotateLeft(RBTreeNode *node, RBTree *tree) {
    RBTreeNode *t = [node rightChild];
    [node setRightChild:[t leftChild]];
    [t setParent:[node parent]];
    if (![node parent]) [tree setRoot:t];
    else {
        if (node == [[node parent] leftChild]) [[node parent] setLeftChild:t];
        else [[node parent] setRightChild:t];
    }
    
    [t setLeftChild:node];
}

void rotateRight(RBTreeNode *node, RBTree *tree) {
    RBTreeNode *t = [node leftChild];
    [node setLeftChild:[t rightChild]];
    [t setParent:[node parent]];
    if (![node parent]) [tree setRoot:t];
    else {
        if (node == [[node parent] rightChild]) [[node parent] setRightChild:t];
        else [[node parent] setLeftChild:t];
    }
    
    [t setRightChild:node];
}

NSInteger height(RBTreeNode* node) {
    if (!node) return -1;
    return 1 + MAX(height(node.leftChild), height(node.rightChild));
}

RBTreeNode* getSmallest(RBTreeNode* node) {
    RBTreeNode *smallest = node;
    while (smallest.leftChild) {
        smallest = smallest.leftChild;
    }
    
    return smallest;
}

RBTreeNode* getLargest(RBTreeNode* node) {
    while (node.rightChild) {
        node = [node rightChild];
    }
    
    return node;
}

@implementation RBTree

- (id)init
{
    self = [super init];
    if (self) {
        self.root = nil;
        self.size = 0;
    }
    
    return self;
}

- (void)put:(id)value
{
    if ([self contains:value]) return;
    [self putNode:[[RBTreeNode alloc] initWithValue:value color:RED subtreeCount:1]];
    _root.color = BLACK;
}

- (void)putNode:(RBTreeNode *)node
{
    if (!_root) {
        _root = node;
        self.size++;
    }
    
    else [self putAssist:node curr:_root];
    
    RBTreeNode *t;
    while (node != _root && [[node parent] color] == RED) {
        if ([node parent] == [[[node parent] parent] leftChild]) {
            t = [[[node parent] parent] rightChild];
            if (t && [t color] == RED) {
                [node parent].color = BLACK;
                t.color = BLACK;
                [[node parent] parent].color = RED;
                node = [[node parent] parent];
            }
            else {
                if (node == [[node parent] rightChild]) {
                    node = [node parent];
                    rotateLeft(node, self);
                }
                
                [node parent].color = BLACK;
                [[node parent] parent].color = RED;
                rotateRight([[node parent] parent], self);
            }
        }
        else {
            t = [[[node parent] parent] leftChild];
            if (t && [t color] == RED) {
                [node parent].color = BLACK;
                t.color = BLACK;
                [[node parent] parent].color = RED;
                node = [[node parent] parent];
            }
            else {
                if (node == [[node parent] leftChild]) {
                    node = [node parent];
                    rotateRight(node, self);
                }
                
                [node parent].color = BLACK;
                [[node parent] parent].color = RED;
                rotateLeft([[node parent] parent], self);
            }
        }
    }
}

- (void)putAssist:(RBTreeNode *)node curr:(RBTreeNode *)curr
{
    NSComparisonResult res = [node.value compare:curr.value];
    switch (res) {
        case (NSOrderedAscending):
            if (!curr.leftChild) {
                [curr setLeftChild:node];
                self.size++;
            }
            
            else [self putAssist:node curr:curr.leftChild];
            break;
        case (NSOrderedDescending):
            if (!curr.rightChild) {
                [curr setRightChild:node];
                self.size++;
            }
            
            else [self putAssist:node curr:curr.rightChild];
            break;
        case (NSOrderedSame):
            break;
    }
}

- (void)remove:(id)value
{
    if (![self contains:value]) return;
    [self removeAssist:[self get:value withNode:_root]];
    self.size--;
}

- (void)removeAssist:(RBTreeNode *)node
{
    RBTreeNode *t, *v;
    if (![node leftChild] || ![node rightChild]) t = node;
    else t = [self getSuccessor:node];
    if ([t leftChild]) v = [t leftChild];
    else v = [t rightChild];
    if (!v) v = [[RBTreeNode alloc] initWithValue:nil color:BLACK];
    [v setParent:[t parent]];
    if (![t parent]) _root = v;
    else if (t == [[t parent] leftChild]) [[t parent] setLeftChild:v];
    else [[t parent] setRightChild:v];
    if (t != node) node.value = t.value;
    if ([t color] == BLACK) [self RBFix:v];
    if (v.value == nil) {
        if (v == [[v parent] leftChild]) [[v parent] setLeftChild:nil];
        else [[v parent] setRightChild:nil];
        [v setParent:nil];
        v = nil;
    }
}

- (void)RBFix:(RBTreeNode *)node
{
    RBTreeNode *t;
    while ([node color] == BLACK && node != _root) {
        if (node == [[node parent] leftChild]) {
            t = [[node parent] rightChild];
            if ([t color] == RED) {
                [t setColor:BLACK];
                [[node parent] setColor:RED];
                rotateLeft([node parent], self);
                t = [[node parent] rightChild];
            }
            
            if ([[t rightChild] color] == BLACK && [[t leftChild] color] == BLACK) {
                [t setColor:RED];
                node = [node parent];
            }
            else {
                if ([[node rightChild] color] == BLACK) {
                    [[t leftChild] setColor:BLACK];
                    [t setColor:RED];
                    rotateRight(t, self);
                    t = [[node parent] rightChild];
                }
                
                [t setColor:[[node parent] color]];
                [[node parent] setColor:BLACK];
                [[t rightChild] setColor:BLACK];
                rotateLeft([node parent], self);
                node = _root;
            }
        }
        else {
            t = [[node parent] leftChild];
            if ([t color] == RED) {
                [t setColor:BLACK];
                [[node parent] setColor:RED];
                rotateRight([node parent], self);
                t = [[node parent] leftChild];
            }
            
            if ([[t rightChild] color] == BLACK && [[t leftChild] color] == BLACK) {
                [t setColor:RED];
                node = [node parent];
            }
            else {
                if ([[node leftChild] color] == BLACK) {
                    [[t rightChild] setColor:BLACK];
                    [t setColor:RED];
                    rotateLeft(t, self);
                    t = [[node parent] leftChild];
                }
                
                [t setColor:[[node parent] color]];
                [[node parent] setColor:BLACK];
                [[t leftChild] setColor:BLACK];
                rotateRight([node parent], self);
                node = _root;
            }
        }
    }
    
    [node setColor:BLACK];
}

- (id)get:(id)value
{
    return [[self get:value withNode:_root] value];
}

- (RBTreeNode *)get:(id)value withNode:(RBTreeNode *)node
{
    while (node) {
        NSComparisonResult res = [value compare:node.value];
        switch (res) {
            case (NSOrderedAscending):
                node = node.leftChild;
                break;
            case (NSOrderedDescending):
                node = node.rightChild;
                break;
            case (NSOrderedSame):
                return node;
                break;
        }
    }
    
    return nil;
}

- (RBTreeNode *)getSuccessor:(RBTreeNode *)node
{
    if ([node rightChild]) return getSmallest([node rightChild]);
    RBTreeNode *t = [node parent], *s;
    while (t && (s = [t rightChild])) {
        s = t;
        t = [t parent];
    }
    
    return t;
}

- (BOOL)contains:(id)value
{
    return [self get:value] != nil;
}

- (BOOL)isEmpty {
    return _root == nil;
}

- (void)levelOrderTraversal {
    traverse(_root);
}

- (NSMutableArray *)getNodes
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[self size]];
    addNodesToArray(arr, _root);
    return arr;
}

- (CGSize)fixNodePositions:(CGSize)size
{
    [_root setX:size.width/2 - CIRCLE_SIZE/2 Y:CIRCLE_SIZE/2 + 5];
    setNodePosition(_root, height(_root) + 1, 0);
    
    CGFloat ll = 0.0, lr = 0.0;
    RBTreeNode *node = _root;
    while ([node leftChild]) {
        ll += [node x] - [[node leftChild] x] + CIRCLE_SIZE/1.5;
        node = [node leftChild];
    }
    
    node = _root;
    while ([node rightChild]) {
        lr += [[node rightChild] x] - [node x] + CIRCLE_SIZE/1.5;
        node = [node rightChild];
    }
    
    if (ll+lr > size.width) {
        [_root setX:(ll + lr - CIRCLE_SIZE)/2];
        setNodePosition(_root, height(_root) + 1, 0.0);
    }
    
    return CGSizeMake(MAX(ll+lr, 320), size.height);
}

@end
