#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is not installed${NC}"
    echo "Please install jq first:"
    echo "For Ubuntu/Debian: sudo apt-get install jq"
    echo "For MacOS: brew install jq"
    echo "For CentOS/RHEL: sudo yum install jq"
    exit 1
fi

# Check if file argument is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No JSON file specified${NC}"
    echo "Usage: $0 <path-to-json-file>"
    exit 1
fi

# Check if file exists
if [ ! -f "$1" ]; then
    echo -e "${RED}Error: File '$1' not found${NC}"
    exit 1
fi

# Validate JSON
if jq empty "$1" 2>/dev/null; then
    echo -e "${GREEN}✓ JSON is valid${NC}"
    exit 0
else
    echo -e "${RED}✗ JSON is invalid${NC}"
    echo -e "${RED}Error details:${NC}"
    jq empty "$1" 2>&1
    exit 1
fi 