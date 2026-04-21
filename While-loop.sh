#!/bin/bash

#for loop examples
# Iterating Over a Range of Numbers
echo "Iterating Over a Range of Numbers"
for i in {1..10}; do
	echo "iterating $i"
done

# Iterating Over a List of Strings
echo "Iterating Over a List of Strings"
for fruit in apple banana orange; do
	echo "I like $fruit"
done

#C-Style For Loop
# Used for more complex numeric control with initialization, condition, and increment:
echo "C-Style For Loop"
for ((i = 0; i <= 10; i++)); do
	echo "counter: $i"
done

# Iterating Over Files
echo "Iterating Over Files"
for file in ./*.sh; do
	echo "processing $file"
done

# Single-Line Syntax
echo "Single-Line Syntax"
for i in {1..10}; do echo "iteration $i"; done

echo "--------------------------------"
echo "--------------------------------"
#While Loop
# Counter-Based Loop :Increments a variable until it reaches a specific limit.
echo "Counter-Based Loop"
count=1
while [ $count -le 5 ]; do
	echo "Iteration $count"
	((count++))
done

# Reading a File Line by Line?
echo "Reading a File Line by Line"
filename="./user.service"
while IFS= read -r line; do
	echo "processing: $line"
done <"$filename"
