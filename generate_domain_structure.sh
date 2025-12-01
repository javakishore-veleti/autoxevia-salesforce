#!/bin/bash

# ==========================================================
# AutoXevia Enterprise Domain Architecture Generator
# CORRECTED VERSION — NO APEX IN DOMAINS
# Domain folders will contain ONLY:
#  - lwc
#  - api
#  - services
#  - utils
#  - widgets
#  - docs
# Apex classes must live ONLY under /classes
# ==========================================================

ROOT="force-app/main/default"

DOMAINS=(
  "productCatalog"
  "customers"
  "orders"
  "leads"
  "issues"
  "analytics"
)

echo ""
echo "=============================================="
echo " AutoXevia Domain Architecture Generator"
echo " CORRECTED — Apex is NOT created under domains/"
echo "=============================================="
echo "Using project root: $ROOT"
echo ""

mkdir -p "$ROOT/domains"

for domain in "${DOMAINS[@]}"; do

    DOMAIN_PATH="$ROOT/domains/$domain"
    DOMAIN_CAPITALIZED="$(tr '[:lower:]' '[:upper:]' <<< ${domain:0:1})${domain:1}"

    echo ""
    echo "→ Creating domain structure for: $domain"
    echo "  Path: $DOMAIN_PATH"

    # -------------------------------------------------------
    # Create domain sub-folders (NO APEX here)
    # -------------------------------------------------------
    mkdir -p "$DOMAIN_PATH/lwc"
    mkdir -p "$DOMAIN_PATH/services"
    mkdir -p "$DOMAIN_PATH/api"
    mkdir -p "$DOMAIN_PATH/utils"
    mkdir -p "$DOMAIN_PATH/widgets"
    mkdir -p "$DOMAIN_PATH/docs"

    # -------------------------------------------------------
    # Create JS API layer
    # -------------------------------------------------------
    API_PATH="$DOMAIN_PATH/api"

    if [ ! -f "$API_PATH/${domain}Api.js" ]; then
    cat <<EOF > "$API_PATH/${domain}Api.js"
// API layer for $domain domain
// Use this to call Apex or external services

export async function fetch${DOMAIN_CAPITALIZED}Data() {
    console.log("Calling ${domain}Api...");
    return [];
}
EOF
    fi

    # -------------------------------------------------------
    # Create JS Service layer
    # -------------------------------------------------------
    SERVICES_PATH="$DOMAIN_PATH/services"

    if [ ! -f "$SERVICES_PATH/${domain}Service.js" ]; then
    cat <<EOF > "$SERVICES_PATH/${domain}Service.js"
import { fetch${DOMAIN_CAPITALIZED}Data } from '../api/${domain}Api.js';

// Business logic layer for $domain domain

export async function get${DOMAIN_CAPITALIZED}Data() {
    return await fetch${DOMAIN_CAPITALIZED}Data();
}
EOF
    fi

    # -------------------------------------------------------
    # Create Utils
    # -------------------------------------------------------
    UTILS_PATH="$DOMAIN_PATH/utils"

    if [ ! -f "$UTILS_PATH/${domain}Utils.js" ]; then
    cat <<EOF > "$UTILS_PATH/${domain}Utils.js"
// Shared utilities for $domain domain

export const ${domain}Constants = {
    MODULE: "$domain"
};
EOF
    fi

    # -------------------------------------------------------
    # Create Sample LWC Component
    # -------------------------------------------------------
    LWC_PATH="$DOMAIN_PATH/lwc/top${DOMAIN_CAPITALIZED}"
    mkdir -p "$LWC_PATH"

    if [ ! -f "$LWC_PATH/top${DOMAIN_CAPITALIZED}.js" ]; then
    cat <<EOF > "$LWC_PATH/top${DOMAIN_CAPITALIZED}.js"
import { LightningElement } from 'lwc';

export default class Top${DOMAIN_CAPITALIZED} extends LightningElement {
    // Placeholder LWC. Replace with real logic.
}
EOF
    fi

    if [ ! -f "$LWC_PATH/top${DOMAIN_CAPITALIZED}.html" ]; then
    cat <<EOF > "$LWC_PATH/top${DOMAIN_CAPITALIZED}.html"
<template>
    <lightning-card title="Top ${DOMAIN_CAPITALIZED}">
        <p class="slds-p-around_medium">No data loaded yet.</p>
    </lightning-card>
</template>
EOF
    fi

    if [ ! -f "$LWC_PATH/top${DOMAIN_CAPITALIZED}.js-meta.xml" ]; then
    cat <<EOF > "$LWC_PATH/top${DOMAIN_CAPITALIZED}.js-meta.xml"
<?xml version="1.0" encoding="UTF-8"?>
<LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
    <targets>
        <target>lightning__RecordPage</target>
        <target>lightning__AppPage</target>
        <target>lightningCommunity__Page</target>
    </targets>
</LightningComponentBundle>
EOF
    fi

done

echo ""
echo "=============================================="
echo " AutoXevia domain architecture generation DONE"
echo "=============================================="
echo ""
