#!/bin/bash

#===============================================================================
# save-instance-configuration.bash
#===============================================================================
# Author: mitzvahcapitalist
# Created: Wednesday, January 15, 2024
# Last Modified: Wednesday, January 15, 2024
# Copyright: Mitzvah Capital LLC
# License: GNU General Public License v3.0 (GPLv3)
#===============================================================================
# Overview:
#   This script saves the current instance configuration as templates after
#   the user has created and populated their .env file and updated auth.ts.
#   It is meant to be run after the initial setup and configuration is complete.
#
# Usage:
#   bash scripts/save-instance-configuration.bash
#
# Actions performed:
#   1. Saves current auth.ts as template
#   2. Saves current .env as template
#   3. Verifies files exist before attempting to copy
#
# Requirements:
#   - Must be run from project root or scripts directory
#   - .env file must exist and be populated
#   - auth.ts must be configured
#===============================================================================

# Ensure we're in the project root directory
cd "$(dirname "$0")/.." || exit 1

# Function to verify required files exist
verify_files() {
    if [[ ! -f ".env" ]]; then
        echo "Error: .env file not found. Please configure your environment variables first."
        exit 1
    fi

    if [[ ! -f "src/config/auth.ts" ]]; then
        echo "Error: auth.ts not found. Please configure your authentication settings first."
        exit 1
    fi
}

# Main function
main() {
    echo "Saving instance configuration templates..."
    echo "============================================================"

    # Verify files exist
    verify_files

    # Save auth.ts template
    cp src/config/auth.ts src/config/auth.template.ts
    echo "Created src/config/auth.template.ts"

    # Save .env template
    cp .env .env.template
    echo "Created .env.template"

    echo
    echo "Configuration templates saved successfully"
    echo "============================================================"
    echo
    echo "Templates will be used to restore your configuration when"
    echo "pulling updates from upstream. You can modify them at any time"
    echo "to update your default instance configuration."
}

# Execute main function
main