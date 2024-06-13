#!/bin/bash

TASK_FILE="$HOME/tasks.txt"     # defines where tasks will be stored

# ANSI escape sequences for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'                    # no color

# Function to display the menu
show_menu() {
    echo -e "${BLUE}Task Manager${NC}"         # Blue color
    echo -e "${BLUE}------------${NC}"         # Blue color
    echo -e "1. ${GREEN}Add a Task${NC}"        # Green color
    echo -e "2. ${GREEN}List Tasks${NC}"        # Green color
    echo -e "3. ${GREEN}Remove a Task${NC}"     # Green color
    echo -e "4. ${RED}Exit${NC}"                # Red color
    echo
    echo -n -e "${YELLOW}Choose an option: ${NC}"  # Yellow color
}

# Function to add a task
add_task() {
    echo -n -e "${YELLOW}Enter the task: ${NC}"   # Yellow color
    read task
    echo "$task" >> $TASK_FILE  # appends task var into end of task_file
    echo -e "${GREEN}Task added!${NC}"           # Green color
}

# Function to list tasks
list_tasks() {
    if [ ! -f $TASK_FILE ] || [ ! -s $TASK_FILE ]; then 
        echo -e "${RED}No tasks found!${NC}"     # Red color
    else
        echo -e "${BLUE}Tasks:${NC}"             # Blue color
        nl -w 2 -s '. ' $TASK_FILE
    fi
}

# Function to remove a task
remove_task() {
    list_tasks
    echo -n -e "${YELLOW}Enter the task number to remove: ${NC}"   # Yellow color
    read task_number
    if sed -i '' "${task_number}d" $TASK_FILE 2>/dev/null; then
        echo -e "${GREEN}Task removed!${NC}"   # Green color
    else
        echo -e "${RED}Invalid task number!${NC}"  # Red color
    fi
}

# Main loop
while true; do
    show_menu
    read option
    case $option in
        1) add_task ;;
        2) list_tasks ;;
        3) remove_task ;;
        4) break ;;
        *) echo -e "${RED}Invalid option! Please try again.${NC}" ;;   # Red color
    esac
    echo
done

echo -e "${BLUE}Goodbye!${NC}"   # Blue color
