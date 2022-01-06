//
//  main.swift
//  DataStructuresAndAlgorithsm
//
//  Created by Raymond Donkemezuo on 1/5/22.
//

import Foundation

/// Node class
/*
 Properties of a node
 - Must have a value
 - can have a reference to the next node on the linked list that it is pointing to (optional)
 */

class Node<Value> {
    var value: Value
    var next: Node?
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

// To print out a node in the form of a linked list, we check if the node is pointing to another node. if yes, print the value of our node and print the next value as well
extension Node: CustomStringConvertible {
    var description: String {
        // check if the current node is the last node
        guard let nextNode = next else {
            return "\(value)"
        }
        return "\(value) -> \(String(describing: nextNode)) "
    }
}

/// - TAG:  Linked List implementation
/*
 A linked list is a linear data structure which holds a series of nodes
 
 - Our linked list is a generic type, so it can hold data of any time
 
 Properties of a Linked list
 - Head node (first node on the linked list )
 - Tail node (last node on the linked list )
 
 */

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    init() {}
}


/*
 Operations that can be performed on a linked list
 
 - isEmpty: We can check if the linked list is empty. i.e if the head node is nil
 - Push: Pushes a new node into the list. The pushed node will be the new head and the old head node will be the next node to the new head.
 
 - Append: Adds a new node into the front of the linked list. i.e the appended node becomes the new tail of the linked list
 - insert after: Given an index and a new value, we inside the new value after the given index
 
 */

extension LinkedList {
    var isEmpty: Bool {
        return head == nil
    }
    
    /// - TAG:  Adds a new head to the linked list
    mutating func push(newValue: Value) {
        if isEmpty {
            head = Node(value: newValue)
        } else {
            let currentHeadNode = head
            let newHeadNode = Node(value: newValue, next: currentHeadNode)
            head = newHeadNode
        }
        
        if tail == nil {
            tail = head
        }
    }
    /// - TAG:  Adds a new tail to the linked list
    mutating func append(newValue: Value) {
        if isEmpty {
            push(newValue: newValue)
        } else {
            let currentTails = tail
            let newTail = Node(value: newValue, next: nil)
            tail = newTail
            currentTails?.next = newTail
        }
        if head == nil {
            head = tail
        }
    }
    
    /// - TAG: A function that returns a node given an index
    func nodeAtIndex(at index: Int) -> Node<Value>? {
        var currentIndex = 0
        var currentNode = head
        
        while (currentNode != nil && currentIndex < index) {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    /// - TAG: Adds a new node to the linked list using a specific index
    mutating func insertAfter(index: Int, newValue: Value) {
        guard let nodeAtIndex = nodeAtIndex(at: index) else { return }
        let newNode = Node(value: newValue, next: nodeAtIndex.next)
        nodeAtIndex.next = newNode
    }
    
    /// - TAG: Remove item from the link list. The pop operation removes nodes starting from the head
    mutating func pop() -> Value? {
        guard let currentHead = head else { return nil }
        guard let newHead = currentHead.next else {
            head = nil
            tail = nil
            return head?.value
        }
        
        head = newHead
        if isEmpty {
            tail = nil
        }
        return currentHead.value
    }
    /// - TAG: Remove the current tail node from the linked list
    mutating func removeLast() -> Value? {
        guard !isEmpty else { return nil }
        guard head?.next != nil else { return pop() }
        
        var current = head
        var currentPrevious = head
        
        while (current?.next != nil ) {
            currentPrevious = current
            current = current?.next
        }
        currentPrevious?.next = nil
        tail = currentPrevious
        return current?.value
    }
    
    mutating func removeAfter(index: Int) -> Value? {
        guard !isEmpty else { return nil }
        guard let nodeAtIndex = nodeAtIndex(at: index) else { return nil }
        if nodeAtIndex.next === tail {
            tail = nodeAtIndex
        }
        let deletingNode = nodeAtIndex.next
        nodeAtIndex.next = deletingNode?.next
        return deletingNode?.value
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else { return " Linked list is empty " }
        return head.description
    }
}

/// - TAG: Stacks Implementation
/*
 Stacks are a Last In First Out data structure where the last item to go in is the first element to go out
 
 Properties of a stack are;
 - storage which is an array to store and manage the data
 */


struct Stack<Element> {
    private var storage = [Element]()
    init() {}
}

/*
 Operations on a stack
 - Push operation: Appends a new item into the stack
 - Pop operation: Removes the element at the top of the stack (last element to go into the stack)
 */

extension Stack: CustomStringConvertible {
    // Printing out a stack
    var description: String {
        let topDivider = "------top------\n"
        let bottomDivider = "\n---------------"
        let stackElements = storage.map{"\($0)"}.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
    
    // Adds a new element into the top of the stack
    mutating func push(newElement: Element) {
        storage.append(newElement)
    }
    // removes and returns the last element that was added to the stack
    mutating func pop() -> Element? {
        return storage.popLast()
    }
}

/// - TAG: Queue Implementation
/*
 The first element to enter the queue is the first element to go out of the Queue (FIFO)
 Properties of a Queue
 - A storage array to hold and manage data
 - isEmpty is a checker to see if the queue is empty or not
 - Peek is the first element on the stack
 -
 */

struct Queue<Element> {
    private var storage = [Element]()
    var isEmpty: Bool {
        return storage.isEmpty
    }
    init() {}
    
    var peek: Element? {
        return storage.first
    }
    
    mutating func enqueue(_ element: Element) -> Bool {
        storage.append(element)
        return true
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        } else {
            return storage.removeFirst()
        }
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return String(describing: storage)
    }
}


var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(2)
queue.enqueue(34)
queue.enqueue(55)
print(queue)

print("Before dequeue() ")

queue.dequeue()

print(queue)

print("After dequeue() ")
