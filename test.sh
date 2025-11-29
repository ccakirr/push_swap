#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════
#                       PUSH_SWAP ULTIMATE TESTER v2.0
# ═══════════════════════════════════════════════════════════════════════════
#                          Created by: CANER
# ═══════════════════════════════════════════════════════════════════════════

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# COLORS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

DEF_COLOR='\033[0;39m'
BLACK='\033[0;30m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
MAGENTA='\033[0;95m'
CYAN='\033[0;96m'
GRAY='\033[0;90m'
WHITE='\033[0;97m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# GLOBAL VARIABLES
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

PUSH_SWAP="./push_swap"
CHECKER="./checker"
CHECKER_LINUX="./checker_linux"
LOG_FILE="test_results.log"
ERROR_LOG="error_cases.log"
TRACE_FILE="traces.txt"
STATS_FILE="statistics.json"

TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
MEMORY_LEAKS=0

# Test kategorileri için sonuçlar
ERROR_TESTS_PASSED=0
ERROR_TESTS_FAILED=0
BASIC_TESTS_PASSED=0
BASIC_TESTS_FAILED=0
SIZE_TESTS_PASSED=0
SIZE_TESTS_FAILED=0
PERFORMANCE_TESTS_PASSED=0
PERFORMANCE_TESTS_FAILED=0

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# UTILITY FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

print_header() {
    local title="$1"
    local width=80
    printf "\n${BLUE}${BOLD}"
    printf '═%.0s' $(seq 1 $width)
    printf "\n"
    printf "%-${width}s" "$title" | sed "s/^/  /"
    printf "\n"
    printf '═%.0s' $(seq 1 $width)
    printf "${DEF_COLOR}\n\n"
}

print_subheader() {
    local title="$1"
    printf "\n${CYAN}${BOLD}▶ $title${DEF_COLOR}\n"
    printf "${CYAN}"
    printf '─%.0s' $(seq 1 60)
    printf "${DEF_COLOR}\n"
}

print_test_result() {
    local test_num="$1"
    local status="$2"
    local details="$3"
    
    if [ "$status" == "OK" ]; then
        printf "${GREEN}✓ Test #%-4d [PASS]${DEF_COLOR}" "$test_num"
        ((PASSED_TESTS++))
    else
        printf "${RED}✗ Test #%-4d [FAIL]${DEF_COLOR}" "$test_num"
        ((FAILED_TESTS++))
    fi
    
    if [ -n "$details" ]; then
        printf " ${GRAY}→ %s${DEF_COLOR}" "$details"
    fi
    printf "\n"
    ((TOTAL_TESTS++))
}

print_performance() {
    local moves="$1"
    local size="$2"
    local limit="$3"
    
    if [ $moves -lt $limit ]; then
        printf "${GREEN}[★★★★★ Excellent]${DEF_COLOR} "
    elif [ $moves -lt $((limit + (limit / 5))) ]; then
        printf "${CYAN}[★★★★☆ Good]${DEF_COLOR} "
    elif [ $moves -lt $((limit + (limit / 3))) ]; then
        printf "${YELLOW}[★★★☆☆ Average]${DEF_COLOR} "
    elif [ $moves -lt $((limit + (limit / 2))) ]; then
        printf "${YELLOW}[★★☆☆☆ Below Average]${DEF_COLOR} "
    else
        printf "${RED}[★☆☆☆☆ Poor]${DEF_COLOR} "
    fi
    printf "${CYAN}Moves: %d/%d${DEF_COLOR}\n" "$moves" "$limit"
}

check_program_exists() {
    if [ ! -f "$1" ]; then
        printf "${RED}${BOLD}ERROR: %s not found!${DEF_COLOR}\n" "$1"
        printf "${YELLOW}Please compile your program first.${DEF_COLOR}\n"
        exit 1
    fi
    
    if [ ! -x "$1" ]; then
        printf "${RED}${BOLD}ERROR: %s is not executable!${DEF_COLOR}\n" "$1"
        printf "${YELLOW}Run: chmod +x %s${DEF_COLOR}\n" "$1"
        exit 1
    fi
}

check_memory_leaks() {
    local args="$1"
    local output=$(valgrind --leak-check=full --error-exitcode=1 $PUSH_SWAP $args 2>&1 > /dev/null)
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        return 0
    else
        ((MEMORY_LEAKS++))
        return 1
    fi
}

save_statistics() {
    cat > "$STATS_FILE" << EOF
{
    "total_tests": $TOTAL_TESTS,
    "passed": $PASSED_TESTS,
    "failed": $FAILED_TESTS,
    "memory_leaks": $MEMORY_LEAKS,
    "success_rate": $(echo "scale=2; ($PASSED_TESTS * 100) / $TOTAL_TESTS" | bc)%,
    "categories": {
        "error_handling": {
            "passed": $ERROR_TESTS_PASSED,
            "failed": $ERROR_TESTS_FAILED
        },
        "basic_sorting": {
            "passed": $BASIC_TESTS_PASSED,
            "failed": $BASIC_TESTS_FAILED
        },
        "size_tests": {
            "passed": $SIZE_TESTS_PASSED,
            "failed": $SIZE_TESTS_FAILED
        },
        "performance": {
            "passed": $PERFORMANCE_TESTS_PASSED,
            "failed": $PERFORMANCE_TESTS_FAILED
        }
    }
}
EOF
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# INITIALIZATION
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

init_test_environment() {
    clear
    printf "${CYAN}${BOLD}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║                    PUSH_SWAP ULTIMATE TESTER v2.0                        ║
║                                                                           ║
║                         Comprehensive Testing Suite                       ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
EOF
    printf "${DEF_COLOR}\n"
    
    # Cleanup old files
    rm -f "$LOG_FILE" "$ERROR_LOG" "$TRACE_FILE" "$STATS_FILE" 0 test_check.txt
    
    # Create new log files
    touch "$LOG_FILE" "$ERROR_LOG" "$TRACE_FILE"
    
    printf "${YELLOW}Checking required programs...${DEF_COLOR}\n"
    check_program_exists "$PUSH_SWAP"
    
    if [ -f "$CHECKER" ]; then
        CHECKER_PROG="$CHECKER"
        printf "${GREEN}✓ Found custom checker${DEF_COLOR}\n"
    elif [ -f "$CHECKER_LINUX" ]; then
        CHECKER_PROG="$CHECKER_LINUX"
        printf "${GREEN}✓ Found checker_linux${DEF_COLOR}\n"
    else
        printf "${YELLOW}⚠ No checker found, skipping verification tests${DEF_COLOR}\n"
        CHECKER_PROG=""
    fi
    
    printf "${GREEN}✓ Test environment initialized${DEF_COLOR}\n"
    sleep 1
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ERROR HANDLING TESTS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_error_handling() {
    print_header "ERROR HANDLING TESTS"
    
    local test_num=0
    local error_cases=(
        "a|Non-numeric input"
        "111a11|Invalid number format"
        "hello world|Text input"
        "''|Empty string"
        "0 0|Duplicate numbers"
        "-01 -001|Duplicate with leading zeros"
        "111-1 2 -3|Invalid format"
        "-3 -2 -2|Duplicate negative"
        "'\n'|Newline character"
        "-2147483649|Below INT_MIN"
        "-2147483650|Below INT_MIN"
        "2147483648|Above INT_MAX"
        "2147483649|Above INT_MAX"
        "8 008 12|Duplicates with zeros"
        "10 -1 -2 -3 -4 -5 -6 90 99 10|Duplicate in list"
        "1 +1 -1|Plus sign duplicate"
        "3333-3333 1 4|Invalid concatenation"
        "111a111 -4 3|Alpha in number"
        "111111 -4 3 03|Leading zero duplicate"
        "42 42|Simple duplicate"
        "42 -42 -42|Negative duplicate"
        "4222-4222|Invalid format"
        "99999999999999999999999999|Too large positive"
        "-99999999999999999999999999|Too large negative"
        "0 -0 1 -1|Zero duplicate"
        "0 +0 1 -1|Signed zero duplicate"
        "111+111 -4 3|Plus concatenation"
        "-|Single minus"
        "+|Single plus"
        "--123 1 321|Double minus"
        "++123 1 321|Double plus"
        "0000000000000000000000009 000000000000000000000009|Long zero duplicates"
        "00000001 1 9 3|Leading zero duplicate"
        "00000003 003 9 1|Multiple leading zeros"
        "--21345|Double minus prefix"
        "1 01|Leading zero duplicate simple"
        "-000 -0000|Negative zero duplicates"
        "-00042 -000042|Negative leading zeros"
        "42 a 41|Letter between numbers"
        "42 41 40 45 101 x 202 -1 224 3|Letter in sequence"
        "42 -2 10 11 0 90 45 500 -200 e|Letter at end"
        "3 +3|Plus sign duplicate simple"
        "3+3|Plus concatenated"
        "2147483647+1|Max int overflow"
        "0 1 2 3 4 5 0|Zero duplicate in sequence"
    )
    
    for test_case in "${error_cases[@]}"; do
        ((test_num++))
        IFS='|' read -r args description <<< "$test_case"
        args=$(eval echo "$args")  # Process escape sequences
        
        local output=$($PUSH_SWAP $args 2>&1)
        local exit_code=$?
        
        if echo "$output" | grep -q "Error" || [ $exit_code -ne 0 ]; then
            print_test_result $test_num "OK" "$description"
            ((ERROR_TESTS_PASSED++))
        else
            print_test_result $test_num "FAIL" "$description - No error output"
            ((ERROR_TESTS_FAILED++))
            echo "Test #$test_num: $args - $description" >> "$ERROR_LOG"
        fi
    done
    
    printf "\n${CYAN}Error Handling Tests: ${GREEN}$ERROR_TESTS_PASSED passed${DEF_COLOR}, "
    printf "${RED}$ERROR_TESTS_FAILED failed${DEF_COLOR}\n"
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ALREADY SORTED TESTS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_already_sorted() {
    print_header "ALREADY SORTED TESTS"
    
    local test_num=0
    local sorted_cases=(
        "''|Empty input"
        "1|Single number"
        "1 2|Two sorted"
        "1 2 3|Three sorted"
        "1 2 3 4|Four sorted"
        "1 2 3 4 5|Five sorted"
        "1 2 3 4 5 6 7 8 9|Nine sorted"
        "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30|Thirty sorted"
        "6 7 8|Three sorted (non-sequential)"
        "2147483645 2147483646 2147483647|Near INT_MAX sorted"
        "-2147483648 -2147483647 -2147483646|Near INT_MIN sorted"
        "$(seq 1 50 | tr '\n' ' ')|Fifty sorted"
        "$(seq 1 77 | tr '\n' ' ')|Seventy-seven sorted"
        "$(seq 1 100 | tr '\n' ' ')|Hundred sorted"
    )
    
    for test_case in "${sorted_cases[@]}"; do
        ((test_num++))
        IFS='|' read -r args description <<< "$test_case"
        args=$(eval echo "$args")
        
        if [ -z "$args" ]; then
            local moves=0
        else
            local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
        fi
        
        if [ $moves -eq 0 ]; then
            print_test_result $test_num "OK" "$description - No moves needed"
            
            # Memory leak check for sorted inputs
            if [ -n "$args" ] && check_memory_leaks "$args"; then
                printf "  ${GREEN}└─ Memory: OK${DEF_COLOR}\n"
            elif [ -n "$args" ]; then
                printf "  ${RED}└─ Memory: LEAK DETECTED${DEF_COLOR}\n"
            fi
        else
            print_test_result $test_num "FAIL" "$description - $moves moves (expected 0)"
            echo "Test #$test_num: $args - Generated $moves moves for sorted input" >> "$ERROR_LOG"
        fi
    done
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# BASIC SORTING TESTS (2-5 numbers)
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_basic_sorting() {
    print_header "BASIC SORTING TESTS (Size 2-5)"
    
    print_subheader "Size 2 (Max 1 move)"
    test_size_2
    
    print_subheader "Size 3 (Max 3 moves)"
    test_size_3
    
    print_subheader "Size 4 (Max 12 moves)"
    test_size_4
    
    print_subheader "Size 5 (Max 12 moves)"
    test_size_5
    
    printf "\n${CYAN}Basic Sorting Tests: ${GREEN}$BASIC_TESTS_PASSED passed${DEF_COLOR}, "
    printf "${RED}$BASIC_TESTS_FAILED failed${DEF_COLOR}\n"
}

test_size_2() {
    local test_num=0
    local cases=("2 1")
    
    for args in "${cases[@]}"; do
        ((test_num++))
        local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
        local result=""
        
        if [ -n "$CHECKER_PROG" ]; then
            result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
        fi
        
        if [ $moves -le 1 ] && ([ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]); then
            print_test_result $test_num "OK" "Args: $args, Moves: $moves"
            ((BASIC_TESTS_PASSED++))
        else
            print_test_result $test_num "FAIL" "Args: $args, Moves: $moves, Result: $result"
            ((BASIC_TESTS_FAILED++))
            echo "Size 2 Test #$test_num: $args - $moves moves" >> "$ERROR_LOG"
        fi
    done
}

test_size_3() {
    local test_num=0
    local cases=(
        "1 3 2" "2 1 3" "2 3 1" "3 1 2" "3 2 1"
    )
    
    for args in "${cases[@]}"; do
        ((test_num++))
        local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
        local result=""
        
        if [ -n "$CHECKER_PROG" ]; then
            result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
        fi
        
        if [ $moves -le 3 ] && ([ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]); then
            print_test_result $test_num "OK" "Args: $args, Moves: $moves"
            ((BASIC_TESTS_PASSED++))
        else
            print_test_result $test_num "FAIL" "Args: $args, Moves: $moves, Result: $result"
            ((BASIC_TESTS_FAILED++))
            echo "Size 3 Test #$test_num: $args - $moves moves" >> "$ERROR_LOG"
        fi
    done
}

test_size_4() {
    local test_num=0
    
    # Test all 24 permutations of 4 numbers
    for a in 1 2 3 4; do
        for b in 1 2 3 4; do
            [ $a -eq $b ] && continue
            for c in 1 2 3 4; do
                [ $a -eq $c ] || [ $b -eq $c ] && continue
                for d in 1 2 3 4; do
                    [ $a -eq $d ] || [ $b -eq $d ] || [ $c -eq $d ] && continue
                    
                    ((test_num++))
                    local args="$a $b $c $d"
                    local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
                    local result=""
                    
                    if [ -n "$CHECKER_PROG" ]; then
                        result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
                    fi
                    
                    if [ $moves -le 12 ] && ([ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]); then
                        printf "${GREEN}.${DEF_COLOR}"
                        ((BASIC_TESTS_PASSED++))
                        ((PASSED_TESTS++))
                    else
                        printf "${RED}F${DEF_COLOR}"
                        ((BASIC_TESTS_FAILED++))
                        ((FAILED_TESTS++))
                        echo "Size 4 Test #$test_num: $args - $moves moves" >> "$ERROR_LOG"
                    fi
                    ((TOTAL_TESTS++))
                done
            done
        done
    done
    printf "\n"
}

test_size_5() {
    local test_num=0
    local test_count=100
    
    printf "${YELLOW}Testing $test_count random permutations of size 5...${DEF_COLOR}\n"
    
    for i in $(seq 1 $test_count); do
        local args=$(echo "1 2 3 4 5" | tr ' ' '\n' | shuf | tr '\n' ' ')
        local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
        local result=""
        
        if [ -n "$CHECKER_PROG" ]; then
            result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
        fi
        
        if [ $moves -le 12 ] && ([ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]); then
            printf "${GREEN}.${DEF_COLOR}"
            ((BASIC_TESTS_PASSED++))
            ((PASSED_TESTS++))
        else
            printf "${RED}F${DEF_COLOR}"
            ((BASIC_TESTS_FAILED++))
            ((FAILED_TESTS++))
            echo "Size 5 Test #$i: $args - $moves moves" >> "$ERROR_LOG"
        fi
        ((TOTAL_TESTS++))
        
        if [ $((i % 50)) -eq 0 ]; then
            printf " [%d/%d]\n" "$i" "$test_count"
        fi
    done
    printf "\n"
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# PERFORMANCE TESTS (Large inputs)
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_performance() {
    print_header "PERFORMANCE TESTS"
    
    print_subheader "Size 100 Tests (Expected: < 700 moves for 5/5)"
    test_size_100
    
    print_subheader "Size 500 Tests (Expected: < 5500 moves for 5/5)"
    test_size_500
    
    printf "\n${CYAN}Performance Tests: ${GREEN}$PERFORMANCE_TESTS_PASSED passed${DEF_COLOR}, "
    printf "${RED}$PERFORMANCE_TESTS_FAILED failed${DEF_COLOR}\n"
}

test_size_100() {
    local test_count=${1:-100}
    local total_moves=0
    local max_moves=0
    local min_moves=999999
    local grade_5=0
    local grade_4=0
    local grade_3=0
    local grade_2=0
    local grade_1=0
    
    printf "${YELLOW}Running $test_count tests with 100 numbers...${DEF_COLOR}\n\n"
    
    for i in $(seq 1 $test_count); do
        local args=$(seq 0 99 | shuf | tr '\n' ' ')
        local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
        local result=""
        
        if [ -n "$CHECKER_PROG" ]; then
            result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
        fi
        
        total_moves=$((total_moves + moves))
        [ $moves -gt $max_moves ] && max_moves=$moves
        [ $moves -lt $min_moves ] && min_moves=$moves
        
        printf "Test %3d: " "$i"
        
        if [ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]; then
            if [ $moves -lt 700 ]; then
                print_performance $moves 100 700
                ((grade_5++))
                ((PERFORMANCE_TESTS_PASSED++))
            elif [ $moves -lt 900 ]; then
                print_performance $moves 100 700
                ((grade_4++))
                ((PERFORMANCE_TESTS_PASSED++))
            elif [ $moves -lt 1100 ]; then
                print_performance $moves 100 700
                ((grade_3++))
            elif [ $moves -lt 1300 ]; then
                print_performance $moves 100 700
                ((grade_2++))
            else
                print_performance $moves 100 700
                ((grade_1++))
                ((PERFORMANCE_TESTS_FAILED++))
            fi
            ((PASSED_TESTS++))
        else
            printf "${RED}[UNSORTED] Moves: %d${DEF_COLOR}\n" "$moves"
            ((FAILED_TESTS++))
            ((PERFORMANCE_TESTS_FAILED++))
            echo "Size 100 Test #$i: FAILED - Not sorted" >> "$ERROR_LOG"
        fi
        ((TOTAL_TESTS++))
    done
    
    local avg_moves=$((total_moves / test_count))
    
    printf "\n${CYAN}${BOLD}Statistics for 100 numbers:${DEF_COLOR}\n"
    printf "${CYAN}├─ Average moves: %d${DEF_COLOR}\n" "$avg_moves"
    printf "${CYAN}├─ Maximum moves: %d${DEF_COLOR}\n" "$max_moves"
    printf "${CYAN}├─ Minimum moves: %d${DEF_COLOR}\n" "$min_moves"
    printf "${CYAN}└─ Grade distribution:${DEF_COLOR}\n"
    printf "   ${GREEN}├─ [5/5] < 700:    %3d tests${DEF_COLOR}\n" "$grade_5"
    printf "   ${CYAN}├─ [4/5] < 900:    %3d tests${DEF_COLOR}\n" "$grade_4"
    printf "   ${YELLOW}├─ [3/5] < 1100:   %3d tests${DEF_COLOR}\n" "$grade_3"
    printf "   ${YELLOW}├─ [2/5] < 1300:   %3d tests${DEF_COLOR}\n" "$grade_2"
    printf "   ${RED}└─ [1/5] >= 1300:  %3d tests${DEF_COLOR}\n" "$grade_1"
}

test_size_500() {
    local test_count=${1:-100}
    local total_moves=0
    local max_moves=0
    local min_moves=999999
    local grade_5=0
    local grade_4=0
    local grade_3=0
    local grade_2=0
    local grade_1=0
    
    printf "${YELLOW}Running $test_count tests with 500 numbers...${DEF_COLOR}\n\n"
    
    for i in $(seq 1 $test_count); do
        local args=$(seq -250 249 | shuf | tr '\n' ' ')
        local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
        local result=""
        
        if [ -n "$CHECKER_PROG" ]; then
            result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
        fi
        
        total_moves=$((total_moves + moves))
        [ $moves -gt $max_moves ] && max_moves=$moves
        [ $moves -lt $min_moves ] && min_moves=$moves
        
        printf "Test %3d: " "$i"
        
        if [ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]; then
            if [ $moves -lt 5500 ]; then
                print_performance $moves 500 5500
                ((grade_5++))
                ((PERFORMANCE_TESTS_PASSED++))
            elif [ $moves -lt 7000 ]; then
                print_performance $moves 500 5500
                ((grade_4++))
                ((PERFORMANCE_TESTS_PASSED++))
            elif [ $moves -lt 8500 ]; then
                print_performance $moves 500 5500
                ((grade_3++))
            elif [ $moves -lt 10000 ]; then
                print_performance $moves 500 5500
                ((grade_2++))
            else
                print_performance $moves 500 5500
                ((grade_1++))
                ((PERFORMANCE_TESTS_FAILED++))
            fi
            ((PASSED_TESTS++))
        else
            printf "${RED}[UNSORTED] Moves: %d${DEF_COLOR}\n" "$moves"
            ((FAILED_TESTS++))
            ((PERFORMANCE_TESTS_FAILED++))
            echo "Size 500 Test #$i: FAILED - Not sorted" >> "$ERROR_LOG"
        fi
        ((TOTAL_TESTS++))
    done
    
    local avg_moves=$((total_moves / test_count))
    
    printf "\n${CYAN}${BOLD}Statistics for 500 numbers:${DEF_COLOR}\n"
    printf "${CYAN}├─ Average moves: %d${DEF_COLOR}\n" "$avg_moves"
    printf "${CYAN}├─ Maximum moves: %d${DEF_COLOR}\n" "$max_moves"
    printf "${CYAN}├─ Minimum moves: %d${DEF_COLOR}\n" "$min_moves"
    printf "${CYAN}└─ Grade distribution:${DEF_COLOR}\n"
    printf "   ${GREEN}├─ [5/5] < 5500:   %3d tests${DEF_COLOR}\n" "$grade_5"
    printf "   ${CYAN}├─ [4/5] < 7000:   %3d tests${DEF_COLOR}\n" "$grade_4"
    printf "   ${YELLOW}├─ [3/5] < 8500:   %3d tests${DEF_COLOR}\n" "$grade_3"
    printf "   ${YELLOW}├─ [2/5] < 10000:  %3d tests${DEF_COLOR}\n" "$grade_2"
    printf "   ${RED}└─ [1/5] >= 10000: %3d tests${DEF_COLOR}\n" "$grade_1"
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# EDGE CASE TESTS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_edge_cases() {
    print_header "EDGE CASE TESTS"
    
    local test_num=0
    
    # INT_MAX and INT_MIN tests
    print_subheader "Integer Limits"
    ((test_num++))
    local args="2147483647"
    test_single_case $test_num "$args" "INT_MAX"
    
    ((test_num++))
    args="-2147483648"
    test_single_case $test_num "$args" "INT_MIN"
    
    ((test_num++))
    args="2147483647 2147483646 2147483645"
    test_single_case $test_num "$args" "Near INT_MAX"
    
    ((test_num++))
    args="-2147483648 -2147483647 -2147483646"
    test_single_case $test_num "$args" "Near INT_MIN"
    
    # Large number sets
    print_subheader "Various Number Ranges"
    ((test_num++))
    args=$(seq 0 450 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "451 numbers (0-450)"
    
    ((test_num++))
    args=$(seq 250 720 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "471 numbers (250-720)"
    
    ((test_num++))
    args=$(seq 10000 10479 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "480 large numbers"
    
    ((test_num++))
    args=$(seq -500 -50 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "451 negative numbers"
    
    ((test_num++))
    args=$(seq -500 -9 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "492 negative numbers"
    
    # Very large ranges
    print_subheader "Extreme Number Ranges"
    ((test_num++))
    args=$(seq 5000 5499 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "500 numbers starting at 5000"
    
    ((test_num++))
    args=$(seq 50000 50499 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "500 numbers starting at 50000"
    
    ((test_num++))
    args=$(seq 500000 500499 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "500 numbers starting at 500000"
    
    ((test_num++))
    args=$(seq -2147483648 -2147483149 | shuf | tr '\n' ' ')
    test_single_case $test_num "$args" "500 numbers from INT_MIN"
}

test_single_case() {
    local test_num=$1
    local args="$2"
    local description="$3"
    
    local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
    local result=""
    
    if [ -n "$CHECKER_PROG" ]; then
        result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
    fi
    
    if [ -z "$CHECKER_PROG" ] || [ "$result" == "OK" ]; then
        print_test_result $test_num "OK" "$description - $moves moves"
    else
        print_test_result $test_num "FAIL" "$description - Result: $result"
        echo "Edge case test #$test_num: $description - FAILED" >> "$ERROR_LOG"
    fi
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# MEMORY LEAK TESTS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_memory_leaks() {
    print_header "MEMORY LEAK TESTS"
    
    if ! command -v valgrind &> /dev/null; then
        printf "${YELLOW}Valgrind not found. Skipping memory tests.${DEF_COLOR}\n"
        return
    fi
    
    printf "${YELLOW}Running comprehensive memory leak tests...${DEF_COLOR}\n\n"
    
    local test_num=0
    local leak_tests=(
        "3 2 1|Size 3"
        "5 4 3 2 1|Size 5"
        "$(seq 0 9 | shuf | tr '\n' ' ')|Size 10"
        "$(seq 0 49 | shuf | tr '\n' ' ')|Size 50"
        "$(seq 0 99 | shuf | tr '\n' ' ')|Size 100"
        "''|Empty input"
        "42|Single number"
        "1 2 3|Already sorted"
        "2147483647 -2147483648|Extreme values"
    )
    
    for test_case in "${leak_tests[@]}"; do
        ((test_num++))
        IFS='|' read -r args description <<< "$test_case"
        args=$(eval echo "$args")
        
        printf "Test %2d (%s): " "$test_num" "$description"
        
        if [ -z "$args" ]; then
            printf "${YELLOW}[SKIPPED]${DEF_COLOR}\n"
            continue
        fi
        
        if check_memory_leaks "$args"; then
            printf "${GREEN}[NO LEAKS]${DEF_COLOR}\n"
        else
            printf "${RED}[LEAK DETECTED]${DEF_COLOR}\n"
            echo "Memory leak in test #$test_num: $description" >> "$ERROR_LOG"
        fi
    done
    
    printf "\n${CYAN}Total memory leaks detected: ${RED}$MEMORY_LEAKS${DEF_COLOR}\n"
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# STRESS TEST
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_stress() {
    print_header "STRESS TEST"
    
    printf "${YELLOW}${BOLD}Warning: This test will take a long time!${DEF_COLOR}\n"
    printf "${YELLOW}Testing all sizes from 2 to 500 with multiple iterations...${DEF_COLOR}\n\n"
    
    read -p "Do you want to continue? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        printf "${YELLOW}Stress test skipped.${DEF_COLOR}\n"
        return
    fi
    
    local failed_sizes=()
    
    # Test sizes 2-10: all permutations
    for size in {2..10}; do
        printf "\n${CYAN}Testing size %d (all permutations)...${DEF_COLOR}\n" "$size"
        local size_passed=true
        
        # Generate all permutations and test
        local count=0
        while IFS= read -r perm; do
            ((count++))
            local args=$(echo "$perm" | tr '\n' ' ')
            local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
            local result=""
            
            if [ -n "$CHECKER_PROG" ]; then
                result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
            fi
            
            if [ -n "$CHECKER_PROG" ] && [ "$result" != "OK" ]; then
                printf "${RED}.${DEF_COLOR}"
                size_passed=false
                echo "Stress test size $size failed: $args" >> "$ERROR_LOG"
            else
                printf "${GREEN}.${DEF_COLOR}"
            fi
            
            if [ $((count % 50)) -eq 0 ]; then
                printf " [%d]\n" "$count"
            fi
        done < <(python3 -c "from itertools import permutations; [print(' '.join(map(str, p))) for p in permutations(range(1, $size + 1))]" 2>/dev/null || echo "1 2")
        
        printf "\n"
        
        if [ "$size_passed" = false ]; then
            failed_sizes+=($size)
        fi
    done
    
    # Test sizes 11-100: random sampling
    for size in {11..100}; do
        printf "\n${CYAN}Testing size %d (100 random samples)...${DEF_COLOR}\n" "$size"
        local size_passed=true
        
        for i in {1..100}; do
            local args=$(seq 1 $size | shuf | tr '\n' ' ')
            local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
            local result=""
            
            if [ -n "$CHECKER_PROG" ]; then
                result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
            fi
            
            if [ -n "$CHECKER_PROG" ] && [ "$result" != "OK" ]; then
                printf "${RED}.${DEF_COLOR}"
                size_passed=false
                echo "Stress test size $size failed at iteration $i" >> "$ERROR_LOG"
            else
                printf "${GREEN}.${DEF_COLOR}"
            fi
            
            if [ $((i % 50)) -eq 0 ]; then
                printf " [%d/100]\n" "$i"
            fi
        done
        
        printf "\n"
        
        if [ "$size_passed" = false ]; then
            failed_sizes+=($size)
        fi
    done
    
    # Test larger sizes: fewer samples
    for size in 200 300 400 500; do
        printf "\n${CYAN}Testing size %d (50 random samples)...${DEF_COLOR}\n" "$size"
        local size_passed=true
        
        for i in {1..50}; do
            local args=$(seq 1 $size | shuf | tr '\n' ' ')
            local moves=$($PUSH_SWAP $args 2>/dev/null | wc -l)
            local result=""
            
            if [ -n "$CHECKER_PROG" ]; then
                result=$($PUSH_SWAP $args 2>/dev/null | $CHECKER_PROG $args 2>/dev/null)
            fi
            
            if [ -n "$CHECKER_PROG" ] && [ "$result" != "OK" ]; then
                printf "${RED}.${DEF_COLOR}"
                size_passed=false
                echo "Stress test size $size failed at iteration $i" >> "$ERROR_LOG"
            else
                printf "${GREEN}.${DEF_COLOR}"
            fi
            
            if [ $((i % 25)) -eq 0 ]; then
                printf " [%d/50]\n" "$i"
            fi
        done
        
        printf "\n"
        
        if [ "$size_passed" = false ]; then
            failed_sizes+=($size)
        fi
    done
    
    printf "\n${CYAN}${BOLD}Stress Test Complete${DEF_COLOR}\n"
    if [ ${#failed_sizes[@]} -eq 0 ]; then
        printf "${GREEN}✓ All sizes passed!${DEF_COLOR}\n"
    else
        printf "${RED}✗ Failed sizes: ${failed_sizes[*]}${DEF_COLOR}\n"
    fi
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# BONUS CHECKER TESTS
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test_bonus_checker() {
    if [ ! -f "$CHECKER" ]; then
        return
    fi
    
    print_header "BONUS: CHECKER TESTS"
    
    print_subheader "Invalid Operations"
    test_checker_invalid_operations
    
    print_subheader "Valid Operations"
    test_checker_valid_operations
    
    print_subheader "Checker Error Handling"
    test_checker_errors
}

test_checker_invalid_operations() {
    local test_num=0
    local invalid_ops=(
        "saa|Invalid operation"
        "sa\n|Operation with newline"
        "SA|Uppercase operation"
        "sa |Space after operation"
        "pa pb px|Invalid operation in sequence"
    )
    
    for test_case in "${invalid_ops[@]}"; do
        ((test_num++))
        IFS='|' read -r ops description <<< "$test_case"
        
        local result=$(echo -e "$ops" | $CHECKER "3 2 1" 2>&1)
        
        if echo "$result" | grep -q "Error"; then
            print_test_result $test_num "OK" "$description"
        else
            print_test_result $test_num "FAIL" "$description - No error detected"
        fi
    done
}

test_checker_valid_operations() {
    local test_num=0
    
    # Test SA
    ((test_num++))
    local result=$(echo -e "sa" | $CHECKER "2 1 3")
    if [ "$result" == "OK" ]; then
        print_test_result $test_num "OK" "sa operation"
    else
        print_test_result $test_num "FAIL" "sa operation - Result: $result"
    fi
    
    # Test SB
    ((test_num++))
    result=$(echo -e "pb\npb\nsb\npa\npa" | $CHECKER "2 1 3 4")
    if [ "$result" == "OK" ]; then
        print_test_result $test_num "OK" "sb operation"
    else
        print_test_result $test_num "FAIL" "sb operation - Result: $result"
    fi
    
    # Test SS
    ((test_num++))
    result=$(echo -e "pb\npb\nss\npa\npa" | $CHECKER "2 1 4 3")
    if [ "$result" == "OK" ]; then
        print_test_result $test_num "OK" "ss operation"
    else
        print_test_result $test_num "FAIL" "ss operation - Result: $result"
    fi
    
    # Test all operations
    ((test_num++))
    result=$(echo -e "sa\nsb\nss\npa\npb\npa\npb\nsb\npa\nra\nrb\nrr\nrra\nrrb\nrrr" | $CHECKER "1")
    if [ "$result" == "OK" ]; then
        print_test_result $test_num "OK" "All operations sequence"
    else
        print_test_result $test_num "FAIL" "All operations - Result: $result"
    fi
}

test_checker_errors() {
    local test_num=0
    
    # Test with push_swap output
    for args in "3 2 1" "5 4 3 2 1" "$(seq 0 9 | shuf | tr '\n' ' ')"; do
        ((test_num++))
        local result=$($PUSH_SWAP $args | $CHECKER $args)
        
        if [ "$result" == "OK" ]; then
            print_test_result $test_num "OK" "Checker with push_swap output"
        else
            print_test_result $test_num "FAIL" "Checker validation - Result: $result"
        fi
    done
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# FINAL REPORT
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

print_final_report() {
    print_header "FINAL TEST REPORT"
    
    local success_rate=0
    if [ $TOTAL_TESTS -gt 0 ]; then
        success_rate=$(echo "scale=2; ($PASSED_TESTS * 100) / $TOTAL_TESTS" | bc)
    fi
    
    printf "\n"
    printf "${CYAN}${BOLD}╔════════════════════════════════════════════════════════════════╗${DEF_COLOR}\n"
    printf "${CYAN}${BOLD}║                       TEST SUMMARY                             ║${DEF_COLOR}\n"
    printf "${CYAN}${BOLD}╠════════════════════════════════════════════════════════════════╣${DEF_COLOR}\n"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  Total Tests:        %-40d ${CYAN}${BOLD}║${DEF_COLOR}\n" "$TOTAL_TESTS"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  ${GREEN}Passed:${DEF_COLOR}             %-40d ${CYAN}${BOLD}║${DEF_COLOR}\n" "$PASSED_TESTS"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  ${RED}Failed:${DEF_COLOR}             %-40d ${CYAN}${BOLD}║${DEF_COLOR}\n" "$FAILED_TESTS"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  ${YELLOW}Memory Leaks:${DEF_COLOR}       %-40d ${CYAN}${BOLD}║${DEF_COLOR}\n" "$MEMORY_LEAKS"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  Success Rate:       %-39s%% ${CYAN}${BOLD}║${DEF_COLOR}\n" "$success_rate"
    printf "${CYAN}${BOLD}╠════════════════════════════════════════════════════════════════╣${DEF_COLOR}\n"
    printf "${CYAN}${BOLD}║                    CATEGORY BREAKDOWN                          ║${DEF_COLOR}\n"
    printf "${CYAN}${BOLD}╠════════════════════════════════════════════════════════════════╣${DEF_COLOR}\n"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  Error Handling:     ${GREEN}%-4d${DEF_COLOR} passed  ${RED}%-4d${DEF_COLOR} failed            ${CYAN}${BOLD}║${DEF_COLOR}\n" "$ERROR_TESTS_PASSED" "$ERROR_TESTS_FAILED"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  Basic Sorting:      ${GREEN}%-4d${DEF_COLOR} passed  ${RED}%-4d${DEF_COLOR} failed            ${CYAN}${BOLD}║${DEF_COLOR}\n" "$BASIC_TESTS_PASSED" "$BASIC_TESTS_FAILED"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  Size Tests:         ${GREEN}%-4d${DEF_COLOR} passed  ${RED}%-4d${DEF_COLOR} failed            ${CYAN}${BOLD}║${DEF_COLOR}\n" "$SIZE_TESTS_PASSED" "$SIZE_TESTS_FAILED"
    printf "${CYAN}${BOLD}║${DEF_COLOR}  Performance:        ${GREEN}%-4d${DEF_COLOR} passed  ${RED}%-4d${DEF_COLOR} failed            ${CYAN}${BOLD}║${DEF_COLOR}\n" "$PERFORMANCE_TESTS_PASSED" "$PERFORMANCE_TESTS_FAILED"
    printf "${CYAN}${BOLD}╚════════════════════════════════════════════════════════════════╝${DEF_COLOR}\n"
    
    printf "\n"
    
    if [ $FAILED_TESTS -eq 0 ] && [ $MEMORY_LEAKS -eq 0 ]; then
        printf "${GREEN}${BOLD}"
        cat << "EOF"
    ██████╗ ███████╗██████╗ ███████╗███████╗ ██████╗████████╗    ██╗
    ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝    ██║
    ██████╔╝█████╗  ██████╔╝█████╗  █████╗  ██║        ██║       ██║
    ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██╔══╝  ██║        ██║       ╚═╝
    ██║     ███████╗██║  ██║██║     ███████╗╚██████╗   ██║       ██╗
    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝   ╚═╝       ╚═╝
EOF
        printf "${DEF_COLOR}\n"
        printf "${GREEN}${BOLD}Congratulations! All tests passed! 🎉${DEF_COLOR}\n"
    else
        printf "${RED}${BOLD}Some tests failed. Check the logs for details.${DEF_COLOR}\n"
        printf "${YELLOW}Error log: $ERROR_LOG${DEF_COLOR}\n"
        printf "${YELLOW}Full log: $LOG_FILE${DEF_COLOR}\n"
    fi
    
    printf "\n${CYAN}Detailed statistics saved to: $STATS_FILE${DEF_COLOR}\n"
    save_statistics
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# MAIN MENU
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

show_menu() {
    clear
    printf "${CYAN}${BOLD}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════════╗
║                    PUSH_SWAP ULTIMATE TESTER v2.0                        ║
║                           Main Menu                                       ║
╚═══════════════════════════════════════════════════════════════════════════╝
EOF
    printf "${DEF_COLOR}\n"
    
    printf "${CYAN}1.${DEF_COLOR} Run All Tests (Comprehensive)\n"
    printf "${CYAN}2.${DEF_COLOR} Error Handling Tests Only\n"
    printf "${CYAN}3.${DEF_COLOR} Already Sorted Tests\n"
    printf "${CYAN}4.${DEF_COLOR} Basic Sorting Tests (2-5 numbers)\n"
    printf "${CYAN}5.${DEF_COLOR} Performance Tests (100 & 500 numbers)\n"
    printf "${CYAN}6.${DEF_COLOR} Edge Case Tests\n"
    printf "${CYAN}7.${DEF_COLOR} Memory Leak Tests\n"
    printf "${CYAN}8.${DEF_COLOR} Stress Test (All sizes 2-500)\n"
    printf "${CYAN}9.${DEF_COLOR} Bonus Checker Tests\n"
    printf "${CYAN}10.${DEF_COLOR} Custom Test (Manual input)\n"
    printf "${CYAN}0.${DEF_COLOR} Exit\n"
    printf "\n${YELLOW}Enter your choice: ${DEF_COLOR}"
}

run_custom_test() {
    print_header "CUSTOM TEST"
    
    printf "${YELLOW}Enter numbers (space-separated): ${DEF_COLOR}"
    read -r custom_args
    
    printf "\n${CYAN}Running push_swap...${DEF_COLOR}\n"
    $PUSH_SWAP $custom_args
    
    printf "\n${CYAN}Number of moves: ${DEF_COLOR}"
    local moves=$($PUSH_SWAP $custom_args 2>/dev/null | wc -l)
    printf "${GREEN}%d${DEF_COLOR}\n" "$moves"
    
    if [ -n "$CHECKER_PROG" ]; then
        printf "\n${CYAN}Checking result...${DEF_COLOR}\n"
        local result=$($PUSH_SWAP $custom_args 2>/dev/null | $CHECKER_PROG $custom_args 2>/dev/null)
        if [ "$result" == "OK" ]; then
            printf "${GREEN}✓ Sorted correctly!${DEF_COLOR}\n"
        else
            printf "${RED}✗ Not sorted correctly!${DEF_COLOR}\n"
        fi
    fi
    
    printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
    read
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# MAIN FUNCTION
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

main() {
    init_test_environment
    
    # Parse command line arguments
    case "${1:-}" in
        -a|--all)
            test_error_handling
            test_already_sorted
            test_basic_sorting
            test_performance "${2:-100}" "${3:-100}"
            test_edge_cases
            test_memory_leaks
            test_bonus_checker
            print_final_report
            ;;
        -e|--error)
            test_error_handling
            print_final_report
            ;;
        -b|--basic)
            test_already_sorted
            test_basic_sorting
            print_final_report
            ;;
        -p|--performance)
            test_performance "${2:-100}" "${3:-100}"
            print_final_report
            ;;
        -m|--memory)
            test_memory_leaks
            print_final_report
            ;;
        -s|--stress)
            test_stress
            print_final_report
            ;;
        -100)
            test_size_100 "${2:-100}"
            print_final_report
            ;;
        -500)
            test_size_500 "${2:-100}"
            print_final_report
            ;;
        *)
            # Interactive menu
            while true; do
                show_menu
                read choice
                
                case $choice in
                    1)
                        test_error_handling
                        test_already_sorted
                        test_basic_sorting
                        test_performance 100 100
                        test_edge_cases
                        test_memory_leaks
                        test_bonus_checker
                        print_final_report
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    2)
                        test_error_handling
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    3)
                        test_already_sorted
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    4)
                        test_basic_sorting
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    5)
                        printf "${YELLOW}Enter number of tests for size 100 [default: 100]: ${DEF_COLOR}"
                        read count100
                        printf "${YELLOW}Enter number of tests for size 500 [default: 100]: ${DEF_COLOR}"
                        read count500
                        test_performance "${count100:-100}" "${count500:-100}"
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    6)
                        test_edge_cases
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    7)
                        test_memory_leaks
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    8)
                        test_stress
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    9)
                        test_bonus_checker
                        printf "\n${YELLOW}Press Enter to continue...${DEF_COLOR}"
                        read
                        ;;
                    10)
                        run_custom_test
                        ;;
                    0)
                        printf "${GREEN}Goodbye!${DEF_COLOR}\n"
                        exit 0
                        ;;
                    *)
                        printf "${RED}Invalid choice. Please try again.${DEF_COLOR}\n"
                        sleep 1
                        ;;
                esac
            done
            ;;
    esac
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# RUN
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

main "$@"