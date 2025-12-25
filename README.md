# Push Swap

An efficient sorting algorithm implementation using two stacks with a limited set of operations. This project is part of the 42 School curriculum, focusing on algorithm optimization and complexity analysis.

## 📋 Description

Push Swap is a sorting algorithm that uses two stacks (A and B) to sort a list of integers in ascending order with the minimum number of operations. The challenge lies in optimizing the sorting process while being restricted to specific stack operations.

## 🎯 Project Goals

- Sort random integers using only two stacks
- Minimize the number of operations required
- Handle different dataset sizes efficiently
- Implement robust error handling and input validation

## 🛠️ Available Operations

| Operation | Description                                           |
| --------- | ----------------------------------------------------- |
| `sa`      | Swap the first 2 elements at the top of stack A       |
| `sb`      | Swap the first 2 elements at the top of stack B       |
| `ss`      | `sa` and `sb` at the same time                        |
| `pa`      | Push the top element from stack B to stack A          |
| `pb`      | Push the top element from stack A to stack B          |
| `ra`      | Rotate stack A (shift all elements up by 1)           |
| `rb`      | Rotate stack B (shift all elements up by 1)           |
| `rr`      | `ra` and `rb` at the same time                        |
| `rra`     | Reverse rotate stack A (shift all elements down by 1) |
| `rrb`     | Reverse rotate stack B (shift all elements down by 1) |
| `rrr`     | `rra` and `rrb` at the same time                      |

## 🚀 Installation & Usage

### Compilation

```bash
make
```

### Usage

```bash
./push_swap [numbers]
```

### Examples

```bash
# Single argument with multiple numbers
./push_swap "3 2 5 1 4"

# Multiple arguments
./push_swap 3 2 5 1 4

# Test with checker (if available)
./push_swap 3 2 5 1 4 | ./checker_linux 3 2 5 1 4
```

### Clean

```bash
make clean   # Remove object files
make fclean  # Remove object files and executable
make re      # Rebuild everything
```

## 📊 Performance Benchmarks

The algorithm is optimized for different dataset sizes:

| Dataset Size | Maximum Operations | Target     |
| ------------ | ------------------ | ---------- |
| 3 numbers    | ≤ 3                | Optimal    |
| 5 numbers    | ≤ 12               | Excellent  |
| 100 numbers  | < 700              | Grade: 5/5 |
| 500 numbers  | < 5500             | Grade: 5/5 |

## 🧠 Algorithm Strategy

### Small Stack (< 5 elements)

- Direct sorting with hardcoded optimal solutions
- Minimal operation count guaranteed

### Medium Stack (5-100 elements)

- Chunk-based sorting algorithm
- Divides the stack into manageable chunks
- Optimized rotation and push operations

### Large Stack (100+ elements)

- Enhanced chunk-based approach
- Dynamic chunk size calculation
- Minimizes unnecessary rotations

## 📁 Project Structure

```
push_swap/
├── main.c              # Entry point and main logic
├── parser.c            # Input parsing and validation
├── push_swap.h         # Header file with structures and prototypes
├── Makefile            # Build configuration
├── algorithm/          # Sorting algorithms
│   ├── ft_sort.c
│   ├── ft_sort_small.c
│   ├── ft_sort_chunks.c
│   └── ft_sort_utils.c
├── ops/                # Stack operations
│   ├── swap_funcs.c
│   ├── r_swap_funcs.c
│   └── reverse_r_swap_funcs.c
└── libft/              # Custom library functions
    ├── ft_split.c
    ├── libft_func.c
    ├── ft_printf.c
    └── ft_printf_utils.c
```

## ⚠️ Error Handling

The program handles various error cases:

- Non-integer arguments
- Numbers outside integer range (INT_MIN to INT_MAX)
- Duplicate numbers
- Invalid input format

On error, the program outputs `Error` to stderr and exits.

## 🧪 Testing

```bash
# Test with random numbers
ARG=$(seq 1 100 | shuf); ./push_swap $ARG | wc -l

# Test with checker
ARG=$(seq 1 100 | shuf); ./push_swap $ARG | ./checker_linux $ARG

# Visual test (if you have a visualizer)
python3 visualizer.py `seq 1 100 | shuf`
```

## 👤 Author

**Caner Çakır** - [ccakirr](https://github.com/ccakirr)

## 📝 License

This project is part of the 42 School curriculum.
