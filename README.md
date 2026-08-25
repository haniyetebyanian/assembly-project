# RISC-V Debt Management System

A course project for the Computer Architecture course, implementing a debt and loan management system using **RISC-V Assembly**.

The program processes financial transactions between individuals and maintains their balances and mutual debts. It also supports several queries for analyzing financial relationships between individuals.

## Overview

The system starts with no outstanding debts. As transactions are processed, individuals may become debtors or creditors of one another.

The program supports up to **150,000 commands** and a maximum of **100 individuals**.

## Commands

| Command | Format      | Description                                                               |
| ------- | ----------- | ------------------------------------------------------------------------- |
| `1`     | `1 s1 s2 x` | `s1` lends `x` dollars to `s2`                                            |
| `2`     | `2`         | Find the individual with the highest positive balance                     |
| `3`     | `3`         | Find the individual with the lowest negative balance                      |
| `4`     | `4 s`       | Count the number of people to whom `s` owes money                         |
| `5`     | `5 s`       | Count the number of people who owe money to `s`                           |
| `6`     | `6 s1 s2`   | Calculate the amount required to settle the balance between `s1` and `s2` |

For commands `2` and `3`, if multiple individuals have the same balance, the lexicographically smallest name is selected.

If there is no positive balance for command `2`, or no negative balance for command `3`, the program outputs `-1`.

## Implementation

### Name Storage

The names of individuals are stored in a dedicated memory region.

* Maximum of 100 individuals
* Maximum name length of 8 lowercase English characters
* Individuals are identified by their index in memory

### Balance Storage

Each individual's net balance is stored separately.

```text
balance = received money - paid money
```

The balance array uses the same indices as the name storage.

### Debt Matrix

The financial relationship between every pair of individuals is represented using a `100 × 100` matrix.

Since the matrix is stored as a one-dimensional array, an element is addressed using:

```text
base + (i * 100 + j) * 4
```

This allows the program to represent the complete set of pairwise relationships within the available memory.

### Fixed-Point Arithmetic

Financial values are stored as integers scaled by 100 instead of using floating-point arithmetic.

For example:

```text
5.50          → 550
10.00         → 1000
0.01          → 1
10000000.99   → 1000000099
```

This approach preserves two decimal places while allowing all financial calculations to be performed using integer arithmetic.

### Lexicographical Comparison

Since RISC-V Assembly does not provide a direct string comparison operation, names are compared character by character using their ASCII values.

This comparison is used when selecting between individuals with equal balances.

## Helper Procedures

The program uses several procedures for common operations:

* `find_name` — Searches for an individual and returns their index.
* `compare_names` — Compares two names lexicographically.
* `print_number` — Prints a scaled integer as a monetary value with two decimal places.
* `print_string` — Prints a string stored in memory.

## Constraints

* Maximum commands: `150,000`
* Maximum individuals: `100`
* Maximum name length: `8` lowercase English characters
* Monetary values contain two decimal places
* Monetary range: `0.01` to `10,000,000.99`

## Execution

The program is designed to run in the **CPULator** RISC-V simulator.

1. Open the project in CPULator.
2. Load `project.asm`.
3. Provide input according to the command formats above.
4. Assemble and run the program.

## Project Structure

```text
assembly-project/
└── project.asm
```

## Documentation

The project documentation is available here:  
[`docs/پروژه CPULator.pdf`](docs/پروژه%20CPULator.pdf)
