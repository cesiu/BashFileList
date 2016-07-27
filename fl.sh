#!/bin/bash

# Represents a linked list using files as nodes.
# author: Christopher (cesiu)

# Gets the nth element in a linked list of files.
# $1 - the current node
# $2 - n
function get {
   current=$(tail -n 1 $1)
   rest=$(head -n 1 $1)
   let restlen=$2-1

   if [ "$2" -eq "0" ]; then
      echo "$current"
   else
      get $rest $restlen
   fi
}

# Gets the name of the file containing the nth element.
# $1 - the head of the list
# $2 - n
function getNode {
   rest=$(head -n 1 $1)
   let restlen=$2-1

   if [ "$2" -eq "0" ]; then
      echo $rest
   else
      getNode $rest $restlen
   fi
}

# Adds an element to the head of the list.
# $1 - the head of the list to add to
# $2 - the element to add
function add {
   oldHead=$(head -n 1 $1)
   let size=$(tail -n 1 $1)+1 

   printf "%s\n%s" $oldHead $2 > node$size
   printf "%s\n%s" node$size $size > $1
}

# Adds an element at an index.
# $1 - the head of the list
# $2 - n
# $3 - the element to add
function addAtIdx {
   if [ "$2" -eq "0" ]; then
      add $1 $3
   else
      let prevIdx=$2-1
      let size=$(tail -n 1 $1)+1
      prev=$(getNode $1 $prevIdx)

      if [ "$2" -eq $(tail -n 1 $1) ]; then
         cur="none"
      else
         cur=$(getNode $1 $2)
      fi
   
      printf "%s\n%s" $cur $3 > node$size
      printf "%s\n%s" node$size $(tail -n 1 $prev) > $prev
      printf "%s\n%s" $(head -n 1 $1) $size > $1
   fi
}

# Removes an element from the head of the list.
# $1 - the head of the list to add to
function remove {
   oldHead=$(head -n 1 $1)
   oldVal=$(tail -n 1 $oldHead)
   let size=$(tail -n 1 $1)-1
   newHead=$(head -n 1 $oldHead)
   
   printf "%s\n%s" $newHead $size > $1
   rm $oldHead
   echo $oldVal
}

# Removes an element at an index.
# $1 - the head of the list
# $2 - n
function removeAtIdx {
   if [ "$2" -eq "0" ]; then
      remove $1
   else
      let prevIdx=$2-1
      let size=$(tail -n 1 $1)-1
      prev=$(getNode $1 $prevIdx)
      cur=$(getNode $1 $2)
      next=$(head -n 1 $cur)
      oldVal=$(tail -n 1 $cur)

      printf "%s\n%s" $next $(tail -n 1 $prev) > $prev
      printf "%s\n%s" $(head -n 1 $1) $size > $1
      rm $cur
      echo $oldVal
   fi
}

# Prints out an entire linked list of files (non-nested)
# $1 - the current node
function printList {
   current=$(tail -n 1 $1)
   rest=$(head -n 1 $1)
   echo $current
  
   if [ "$rest" != "none" ]; then
      printList $rest
   fi
}

# Example usage:
cd demo

# Print the list.
echo "Printing list..."
printList $(head -n 1 list1)

# Add to the list.
printf "\nAdding hello...\n"
add "list1" "hello"
printList $(head -n 1 list1)

printf "\nAdding world...\n"
add "list1" "world"
printList $(head -n 1 list1)

# Get an element.
printf "\nGetting the element at index 1...\n"
get $(head -n 1 list1) 1

# Get the name of a node.
printf "\nGetting the name of the node at index 1...\n"
getNode "list1" 1

# Add an element at an index.
printf "\nAdding 327 at index 2...\n"
addAtIdx "list1" 2 327
printList $(head -n 1 list1)

printf "\nAdding 94 at index 0...\n"
addAtIdx "list1" 0 94
printList $(head -n 1 list1)

printf "\nAdding 1138 at index 7...\n"
addAtIdx "list1" 7 1138
printList $(head -n 1 list1)

# Remove from the list.
printf "\nRemoved %s...\n" $(remove "list1")
printList $(head -n 1 list1)

# Remove from an index.
printf "\nRemoved %s from index 1...\n" $(removeAtIdx "list1" 1)
printList $(head -n 1 list1)

printf "\nRemoved %s from index 5...\n" $(removeAtIdx "list1" 5)
printList $(head -n 1 list1)

printf "\nRemoved %s from index 0...\n" $(removeAtIdx "list1" 0)
printList $(head -n 1 list1)

# Reset the test.
printf "\nRemoved %s...\n" $(remove "list1")
printList $(head -n 1 list1)

cd ..
