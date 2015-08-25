//
//  main.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSArray+EKStuff.h"
#import "NSArray+EKSorting.h"
#import "NSNumber+EKStuff.h"
#import "NSString+EKStuff.h"
#import "EKStack.h"
#import "EKQueue.h"
#import "EKDeque.h"
#import "EKBHeap.h"
#import "EKVertex.h"
#import "EKGraph.h"
#import "EKEdge.h"
#import "EKLinkedList.h"
#import "EKNode.h"
#import "EKBSTree.h"
#import "EKAVLTree.h"
#import "EKTree.h"
#import "EKBTree.h"
#import "EKRecursionStuff.h"

int main(int argc, const char *argv[])
{
	@autoreleasepool {
#pragma mark - Array
        
        //Init array with 5 random elements
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            [array addObject:@(arc4random() % 20)];
        }

        //Max element of array
        NSLog(@"Max element of created array %@ equals to %@ and stored at index %li", [array debugDescription],
              array[(long)[array indexOfMaximumElement]],
              (long)[array indexOfMaximumElement]);

        //Get the Max and Min Simultaneously.
        NSArray *indexes = [array indexesOfMinimumAndMaximumElements];
        NSLog(@"Min and max elements of created array %@ equal to %@ and %@ and stored at indexes: %@ %@", [array debugDescription], array[[[indexes firstObject] unsignedIntegerValue]], array[[[indexes lastObject] unsignedIntegerValue]],
              [indexes firstObject], [indexes lastObject]);

        //Longest string from array
        NSLog(@"The longest string is %@", [@[@"Kiev", @"Moscow", @"Tokyo", @"Saint-Petersburg", @"SanFrancisco"] longestString]);

        //Shortest string from array
        NSLog(@"The shortest string is %@", [@[@"DRY", @"KISS", @"YAGNI", @"SOLID", @"GRASP"] shortestString]);

        //Reverse of array
        NSLog(@"Reversed array is %@", [[@[@"one", @"two", @"three", @"four", @"five"] mutableCopy] reverse]);

        //Intersection of two arrays
        NSLog(@"Intersection is %@", [@[@"one", @"two", @"three"] intersectionWithArray: @[@"two", @"three", @"four"]]);

        //Union of two arrays
        NSLog(@"Union is %@", [@[@"Honda", @"Toyota"] unionWithoutDuplicatesWithArray: @[@"Toyota", @"Alfa Romeo"]]);
        
        // Union of two arrays for key
        NSString *someKey = @"someKey";
        NSMutableArray *oneArray = [NSMutableArray arrayWithCapacity:100];
        NSMutableArray *twoArray = [NSMutableArray arrayWithCapacity:100];
        for (int i = 0; i < 100; i ++) {
            NSMutableDictionary *currentDic = [[NSMutableDictionary alloc] init];
            [currentDic setValue:[NSString stringWithFormat:@"EKAlgorithms%d", i] forKeyPath:someKey];
            [oneArray addObject:currentDic];
            [twoArray addObject:currentDic];
        }
        [oneArray addObject:@{someKey: @"EKAlgorithms100"}];
        NSLog(@"Union some key is %@", [oneArray unionWithoutDuplicatesWithArray:twoArray forKey:someKey]);
        
        //Find duplicates
        NSLog(@"Result of finding duplicates is %@", [@[@"foo", @"bar", @"buzz", @"foo"] hasDuplicates] ? @"YES" : @"NO");

        //Random object
        NSLog(@"Random array %@", [NSArray randomObjectsWithArraySize:5 maxRandomValue:6 uniqueObjects:YES]);

        //Is sorted check
        NSLog(@"Given array sorted? --> %@", [@[@1.1, @1.5, @1.9, @2.5, @3, @4, @4] isSorted] ? @"YES" : @"NO");

        // Array Shuffle (Fisherâ€“Yates)
        NSLog(@"Array Shuffle of array: %@ is: %@", array, [[array mutableCopy] shuffle]);

        //Sum of elements in array
        NSLog(@"Sum is --> %@", [@[@ - 5, @ - 5, @ - 5, @ - 5, @ - 5] sumOfElements]);

        //Find occurences of each element in array
        NSLog(@"Occurences is --> %@", [@[@3, @3, @4, @5, @4, @1, @3, @8, @1] occurencesOfEachElementInArray_naive]);
        NSLog(@"Occurences by using dictionary is --> %@", [@[@[], @{}, @"four", @"five", @"four", @"one", @"three", @"eight", @"one", @"four"] occurencesOfEachElementInArray]);
        NSLog(@"Occurences is --> %@", [@[@3, @3, @4, @5, @4, @1, @3, @8, @1] occurencesOfEachElementInArray]);
        //NSLog(@"Occurences by using dictionary is --> %@", [@[@[], @{}, @"four", @"five", @"four", @"one", @"three", @"eight", @"one", @"four"] occurencesOfEachElementInArrayByUsingDictionary]);
        NSLog(@"Occurences via Cocoa APIs is --> %@", [@[@3, @3, @4, @5, @4, @1, @3, @8, @1] CocoaImplementationOfOccurencesOfEachElementInArray]);

#pragma mark - Search
        //SEARCH------------------------------------------------------------------------------------

        //Linear search
        NSLog(@"Linear search result: %li", (long)[@[@6, @9, @12, @13, @14, @29, @42] indexOfObjectViaLinearSearch: @42]);

        //Binary search
        NSLog(@"Binary search result: %li", (long)[@[@6, @9, @12, @13, @14, @29, @42] indexOfObjectViaBinarySearch: @42]);

#pragma mark - Search
        //SORTING-----------------------------------------------------------------------------------

        //Bubble sort
        NSLog(@"Bubble sorted array is: %@", [[array mutableCopy] bubbleSort]);

        //Shell sort
        NSLog(@"Shell sorted array is %@", [[@[@2, @45, @8, @1, @27, @16, @5.3, @ - 53.7] mutableCopy] shellSort]);

        //Merge sort
        NSLog(@"Merge sorted array %@", [[@[@21, @45, @87, @10, @273, @616, @0.2, @ - 0.52] mutableCopy] mergeSort]);

        //Quick sort numbers
        NSLog(@"Quick sorted array %@", [[@[@2.1, @405, @817, @10, @2732, @616, @0.2, @ - 0.52] mutableCopy] quickSortWithLeftIndex: 0
                                                                                                                     withRightIndex:[[NSMutableArray arrayWithArray:@[@21, @45, @87, @10, @273, @616, @0.2, @ - 0.52]] count] - 1]);
        //Insertion sort
        NSLog(@"Insertion sorted array %@", [[@[@ - 23.0154, @46, @0.021, @42, @5, @NO, @YES] mutableCopy] insertionSort]);

        //Selection sort
        NSLog(@"Selection sorted array  %@", [[@[@160, @0.097, @NO, @89, @ - 61.001256, @7.5, @YES] mutableCopy] selectionSort]);

        //Radix sort
        NSLog(@"Radix sorted array (BASE 10) %@", [[@[@160, @210, @997, @1222, @1334, @3411, @1] mutableCopy] radixSortForBase:10]);
        
        //Heap sort
        NSLog(@"Heap sorted array --> %@", [[@[@9871523, @0.0987516, @NO, @89, @ - 61.001256, @712.5, @YES, @384756] mutableCopy] heapSort]);

#pragma mark - Strings
        //STRINGS-----------------------------------------------------------------------------------

        //Palindrome string
        NSLog(@"Palindrome? Answer:%@", [@"Was it a car or a cat I saw" isPalindrome] ? @"YES" : @"NO");

        NSLog(@"Palindrome? Answer:%@", [@"wasitacaroracatisaw" isPalindrome] ? @"YES" : @"NO");

        //Reverse
        NSLog(@"Reverse is: %@", [@"Lorem ipsum dolor" reversedString]);

        //Count words
        NSLog(@"Words # %lu", (unsigned long)[@"fgf fgfdgfdg dfgfdgfd dfgfdgfd dfg" numberOfWordsInString]);

        //Permutations
        char a[] = "ABC";
        [NSString allPermutationsOfCString:a withFirstCharacterPosition:0 lastCharacterPosition:2];

        //Count each letter occurence in string
        [@"Hello World" countEachCharacterOccurrenceInString];

        //Needles in haystack
        NSLog(@"Needle %lu", (unsigned long)[@"Foo is a bar with foo bar foo" numberOfOccurrenciesOfString: @"foo"]);

        //Random string
        NSLog(@"Random string %@", [NSString randomStringWithLength:100]);

        //Concat
        NSLog(@"Concat string is --> %@", [@"Hello" concatenateWithString: @"World!"]);

        //First occurance of needle in a haystack
        NSLog(@"Index is --> %ld", (long)[@"Lorem ipsum dolor sit amet lorem ipsum" indexOfFirstOccurrenceOfNeedle: @"em"]);

        //Last occurance of needle in a haystack
        NSLog(@"Index is --> %ld", (long)[@"Lorem ipsum dolor sit amet lorem ipsum" indexOfLastOccurrenceOfNeedle: @"or"]);

        //Longest common sequence
        NSLog(@"Longest common sequence of abcdbceea and cabdefga is --> %@", [@"abcdbceea" LCS_WithString: @"cabdefga"]);

        //Levenshtein Distance
        NSLog(@"Levenshtein Distance of levenshtein and meilenstein is --> %ld", (long)[@"levenshtein" LD_WithString: @"meilenstein"]);
        
        // KMP
        NSLog(@"Index of KMP string match is --> %ld", [@"bacbababaabcbab" KMPindexOfSubstringWithPattern:@"bab"]);
        
#pragma mark - Numeric problems
        //NUMERIC PROBLEMS--------------------------------------------------------------------------

        //Sieve of Eratosf
        NSLog(@"Primes from sieve %@", [[NSNumber primeNumbersFromSieveEratosthenesWithMaxNumber:42] description]);

        //GCD
        NSLog(@"Greatest common divisor of two numbers is %lu", (unsigned long)[@42 greatestCommonDivisorWithNumber: 84]);

        //LCM
        NSLog(@"Least common multiple of two numbers is %lu", [@16 leastCommonMultipleWithNumber: 20]);

        //Swap integer pointers without using a third element
        NSInteger intValue1 = 12, intValue2 = 21;
        NSLog(@"Integer values before swap: %ld, %ld", (long)intValue1, (long)intValue2);
        [NSNumber swapValueOfIntPointer:&intValue1 withValueOfIntPointer:&intValue2];
        NSLog(@"Integer values after swap: %ld, %ld", (long)intValue1, (long)intValue2);

        //Factorial
        NSLog(@"Factorial is %llu", (unsigned long long)[@3 factorial]);

        //Fibonacci numbers
        NSLog(@"Fibonacci series is %@", [NSNumber fibonacciNumbersUpToNumber:15]);

        for (int i = 298; i < 300; i++) {
            NSLog(@"Fibonacci at index %i: %@", i, [NSNumber fibonacciAtIndex:i]);         //limited by 92
            NSLog(@"Fibonacci at index %i: %@", i, [NSNumber fibonacciWithDecimal:i]);
        }

        //Find sum of digits
        NSLog(@"Sum of digits is: %lu", (unsigned long)[@1234 sumOfDigits]);

        //Binary to decimal convertion
        NSLog(@"Decimal is: %lu", (unsigned long)[NSNumber decimalNumberFromBinary:1101]);

        //Decimal to binary
        NSLog(@"Binary is %lu", (unsigned long)[NSNumber binaryNumberFromDecimal:3]);

        //Fast Exp
        NSLog(@"Fast exp %ld", (long)[NSNumber fastExpForNumber:2 withPower:10]);

        //Number reverse
        NSLog(@"Reversed number is %li", (long)[@123456789 reverseNumber]);

        //Even/Odd
        NSLog(@"Given number even? - %@", [@1234567 isEven] ? @"YES" : @"NO");

        //Leap year check
        NSLog(@"Is given year leap? - %@", [@2000 isLeapGivenYear] ? @"YES" : @"NO");

        //Armstrong number check
        NSLog(@"Is given number Armstrong? --> %@", [@407 isArmstrongNumber] ? @"YES" : @"NO");

        //Prime Number Check
        NSLog(@"Is given number Prime? --> %@", [@23 isPrime] ? @"YES" : @"NO");

        //Nth prime
        NSLog(@"Nth prime is --> %lu", (unsigned long)[NSNumber nthPrime:101]);

        //Square root
        NSLog(@"Square root is --> %f", [@ - 144.0 squareRoot]);
        NSLog(@"Square root is --> %f", [@2.0 squareRoot]);

        //Convertion to another numeral system
        NSLog(@"Converted number is --> %@", [@42 convertedNumberWithBase: 2]);

        //Fast inverse square root
        NSLog(@"FISR is --> %@", @([@5 fastInverseSquareRoot]));

#pragma mark - Data structures
        //DATA STRUCTURES---------------------------------------------------------------------------

        //Stack
        EKStack *stack = [[EKStack alloc] initWithSize:3];
        [stack push:@"Hello"];
        [stack push:@"World"];
        [stack push:@"Programming is fun!"];
        NSLog(@"All objects from stack %@", [stack allObjectsFromStack]);
        [stack popLastObject];
        NSLog(@"All objects from stack after POP %@", [stack allObjectsFromStack]);
        NSLog(@"PEEK %@", [stack peek]);

        //Queue
        EKQueue *queue = [[EKQueue alloc] init];
        [queue insertObject:@"Foo"];
        [queue insertObject:@"Bar"];
        [queue insertObject:@"HakunaMatata"];
        NSLog(@"All objects from queue %@", [queue allObjectsFromQueue]);
        [queue removeFirstObject];
        NSLog(@"All objects from queue after REMOVE %@", [queue allObjectsFromQueue]);
        NSLog(@"PEEK object %@", [queue peek]);

        //Deque
        EKDeque *deque = [[EKDeque alloc] init];
        [deque insertObjectToFront:@"Foo"];
        [deque insertObjectToFront:@"Bar"];
        NSLog(@"All objects from deque %@", [deque allObjectsFromDeque]);
        [deque insertObjectToBack:@"Hi"];
        NSLog(@"All objects from deque %@", [deque allObjectsFromDeque]);
        NSLog(@"PEEK first object %@", [deque peekFirstObject]);
        [deque removeFirstObject];
        NSLog(@"All objects from deque %@", [deque allObjectsFromDeque]);
        NSLog(@"PEEK last object %@", [deque peekLastObject]);
        [deque removeLastObject];
        NSLog(@"All objects from deque %@", [deque allObjectsFromDeque]);

        // Binary Heap
        EKBHeap *heap = [[EKBHeap alloc] init];
        [heap insertNumber:@6];
        [heap insertNumber:@7];
        [heap insertNumber:@12];
        [heap insertNumber:@10];
        [heap insertNumber:@15];
        [heap insertNumber:@17];
        [heap insertNumber:@5];

        NSLog(@"Minimum Number deleted: %@", [heap deleteMin]);

        //Graph stuff

        //DFS
        //Init vertices
        EKVertex *aV = [[EKVertex alloc] init];         //this is a start vertex
        aV.label = @"A vertex";

        EKVertex *bV = [[EKVertex alloc] init];
        bV.label = @"B vertex";

        EKVertex *cV = [[EKVertex alloc] init];
        cV.label = @"C vertex";

        EKVertex *dV = [[EKVertex alloc] init];
        dV.label = @"D vertex";

        EKVertex *eV = [[EKVertex alloc] init];
        eV.label = @"E vertex";

        EKVertex *fV = [[EKVertex alloc] init];
        fV.label = @"F vertex";

        EKVertex *gV = [[EKVertex alloc] init];
        gV.label = @"G vertex";

        //Set adjacent vertices
        aV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:aV To:cV andWeight:@4],
                            [[EKEdge alloc] initWithAdjacentFrom:aV To:dV andWeight:@1],
                            [[EKEdge alloc] initWithAdjacentFrom:aV To:bV andWeight:@2], nil];
        bV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:bV To:aV andWeight:@2],
                            [[EKEdge alloc] initWithAdjacentFrom:bV To:dV andWeight:@3],
                            [[EKEdge alloc] initWithAdjacentFrom:bV To:eV andWeight:@10], nil];
        cV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:cV To:aV andWeight:@4],
                            [[EKEdge alloc] initWithAdjacentFrom:cV To:dV andWeight:@2],
                            [[EKEdge alloc] initWithAdjacentFrom:cV To:fV andWeight:@5], nil];
        dV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:dV To:aV andWeight:@1],
                            [[EKEdge alloc] initWithAdjacentFrom:dV To:bV andWeight:@3],
                            [[EKEdge alloc] initWithAdjacentFrom:dV To:cV andWeight:@2],
                            [[EKEdge alloc] initWithAdjacentFrom:dV To:eV andWeight:@7],
                            [[EKEdge alloc] initWithAdjacentFrom:dV To:fV andWeight:@8],
                            [[EKEdge alloc] initWithAdjacentFrom:dV To:gV andWeight:@4], nil];
        eV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:eV To:bV andWeight:@10],
                            [[EKEdge alloc] initWithAdjacentFrom:eV To:dV andWeight:@7],
                            [[EKEdge alloc] initWithAdjacentFrom:eV To:gV andWeight:@6], nil];
        fV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:fV To:cV andWeight:@5],
                            [[EKEdge alloc] initWithAdjacentFrom:fV To:dV andWeight:@8],
                            [[EKEdge alloc] initWithAdjacentFrom:fV To:gV andWeight:@1], nil];
        gV.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:gV To:fV andWeight:@1],
                            [[EKEdge alloc] initWithAdjacentFrom:gV To:dV andWeight:@4],
                            [[EKEdge alloc] initWithAdjacentFrom:gV To:eV andWeight:@6], nil];

        //Init graph (see EKGraphPicture.png)
        EKGraph *graph = [[EKGraph alloc] initWithStartVertex:aV];
        graph.vertices = [@[aV, bV, cV, dV, eV, fV, gV] mutableCopy];


        //Is it a directed Graph
        if ([graph isUndirectedGraph]) {
            NSLog(@"This graph is a undirected graph");
        } else {
            NSLog(@"This graph is a directed graph");
        }

        [graph depthFirstSearch];

        //BFS
        [graph breadthFirstSearch];

        //Prim
        [graph primMST:aV];

        //Kruskal
        [graph kruskalMST];

        //Dijkstra
        [graph dijkstraSPTFrom:aV To:nil];

        //Topsort (see EKTopsort.png)
        EKVertex *c101V = [[EKVertex alloc] init];         //We simulate courses in university
        c101V.label = @"C101";

        EKVertex *c102V = [[EKVertex alloc] init];
        c102V.label = @"C102";

        EKVertex *c103V = [[EKVertex alloc] init];
        c103V.label = @"C103";

        EKVertex *d211V = [[EKVertex alloc] init];
        d211V.label = @"D211";

        EKVertex *e107V = [[EKVertex alloc] init];
        e107V.label = @"E107";

        EKVertex *f110V = [[EKVertex alloc] init];
        f110V.label = @"F110";

        EKVertex *g201V = [[EKVertex alloc] init];
        g201V.label = @"G201";

        c101V.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:c101V To:c103V andWeight:@1], nil];
        c103V.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:c103V To:g201V andWeight:@1], nil];
        c102V.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:c102V To:c103V andWeight:@1],
                               [[EKEdge alloc] initWithAdjacentFrom:c102V To:d211V andWeight:@1],
                               [[EKEdge alloc] initWithAdjacentFrom:c102V To:e107V andWeight:@1], nil];
        d211V.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:d211V To:g201V andWeight:@1],
                               [[EKEdge alloc] initWithAdjacentFrom:d211V To:f110V andWeight:@1], nil];
        e107V.adjacentEdges = [[NSMutableSet alloc] initWithObjects:[[EKEdge alloc] initWithAdjacentFrom:e107V To:f110V andWeight:@1], nil];

        EKGraph *topGraph = [[EKGraph alloc] init];
        topGraph.vertices = [@[c101V, c102V, c103V, d211V, e107V, f110V, g201V] mutableCopy];

        //Result may vary due to random order in Objective-C fast enumeration
        [topGraph topSort];

        //Linked list stuff
        EKLinkedList *list = [[EKLinkedList alloc] initWithHead:@5];
        [list addToFront:@7];
        [list addToFront:@9];
        [list addToFront:@11];
        [list addToFront:@13];
        [list addToFront:@15];
        [list addToBack:@11];
        [list addToBack:@5];

        NSLog(@"Head is %@", list.head.value);
        NSLog(@"Nodes in list - %lu", (unsigned long)[list count]);

        [list printList];

        [list reverseList];
        NSLog(@"Nodes in list after reverse:");
        [list printList];

        [list removeObjectAtIndex:3];

        NSLog(@"Nodes in list after remove - %lu", (unsigned long)[list count]);
        [list printList];

        NSLog(@"Find number 3 in list, count: %lu", (unsigned long)[list findObject:@3].count);
        NSLog(@"Find number 11 in list, count: %lu", (unsigned long)[list findObject:@11].count);


        //BST stuff
        EKBSTree *tree = [[EKBSTree alloc] initWithObject:@4 compareSelector:@selector(compare:)];
        [tree insertObject:@9];
        [tree insertObject:@2];
        [tree insertObject:@10];
        [tree insertObject:@7];
        [tree insertObject:@ - 5];
        [tree insertObject:@ - 1];
        [tree insertObject:@2.5f];
        [tree insertObject:@ - 5.5f];

        [tree printDescription];         // see EKBSTree.png picture

        NSLog(@"Finded %@", [tree find:@7].object);        // find @7 and print it

        NSLog(@"Deleted %@", [tree deleteObject:@2]);      // delete @2 node

        [tree printDescription];


        // AVL Tree stuff.

        EKAVLTree *avlt = [[EKAVLTree alloc] initWithObject:@4 compareSelector:@selector(compare:)];
        [avlt insertObject:@9];
        [avlt insertObject:@2];
        [avlt insertObject:@10];
        [avlt insertObject:@7];
        [avlt insertObject:@ - 5];
        [avlt insertObject:@ - 1];
        [avlt insertObject:@2.5f];
        [avlt insertObject:@ - 5.5f];
        [avlt insertObject:@11];
        [avlt insertObject:@22];
        [avlt insertObject:@21];

        [avlt printDescription];

        [avlt deleteObject:@11];

        [avlt printDescription];

        // Tree stuff
        EKTree *forest1 = [[EKTree alloc] initWithObject:@"A"];
        EKTree *forest2 = [[EKTree alloc] initWithObject:@"D"];

        EKTreeNode *nodeB = [[EKTreeNode alloc] init];
        nodeB.object = @"B";
        EKTreeNode *nodeC = [[EKTreeNode alloc] init];
        nodeC.object = @"C";
        EKTreeNode *nodeE = [[EKTreeNode alloc] init];
        nodeE.object = @"E";
        EKTreeNode *nodeF = [[EKTreeNode alloc] init];
        nodeF.object = @"F";
        EKTreeNode *nodeG = [[EKTreeNode alloc] init];
        nodeG.object = @"G";
        EKTreeNode *nodeH = [[EKTreeNode alloc] init];
        nodeH.object = @"H";
        EKTreeNode *nodeJ = [[EKTreeNode alloc] init];
        nodeJ.object = @"J";
        EKTreeNode *nodeK = [[EKTreeNode alloc] init];
        nodeK.object = @"K";

        [forest1 insertNode:nodeB leftSibling:nil parent:forest1.root];
        [forest1 insertNode:nodeC leftSibling:nodeB parent:forest1.root];
        [forest1 insertNode:nodeK leftSibling:nil parent:nodeC];
        
        [forest2 insertNode:nodeE leftSibling:nil parent:forest2.root];
        [forest2 insertNode:nodeH leftSibling:nil parent:nodeE];
        [forest2 insertNode:nodeF leftSibling:nodeE parent:forest2.root];
        [forest2 insertNode:nodeJ leftSibling:nil parent:nodeF];
        [forest2 insertNode:nodeG leftSibling:nodeF parent:forest2.root];
        
        [forest1 printDescription];
        [forest2 printDescription];
        
        [[EKTree forestToBinaryTree:@[forest1, forest2]] levelOrderTraversal];
        
#pragma mark - Recursion
        //RECURSION---------------------------------------------------------------------------------
        
        //Tower of Hanoi
        [EKRecursionStuff solveTowerOfHanoiWithDisksNumber:3 from:@"A" to:@"C" withExtraPin:@"B"];
    }
    
	return 0;
}
