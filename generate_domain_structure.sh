#!/bin/bash

# ==========================================================
# AutoXevia Enterprise Domain Architecture Generator
# SAFE / AGILE VERSION (NO OBJECTS CREATED)
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
echo "=============================================="
echo "Using project root: $ROOT"
echo ""

mkdir -p "$ROOT/domains"

for domain in "${DOMAINS[@]}"; do

    DOMAIN_PATH="$ROOT/domains/$domain"
    DOMAIN_CAPITALIZED="$(tr '[:lower:]' '[:upper:]' <<< ${domain:0:1})${domain:1}"

    echo "→ Creating domain: $domain"

    # Create base folders
    mkdir -p "$DOMAIN_PATH/lwc"
    mkdir -p "$DOMAIN_PATH/services"
    mkdir -p "$DOMAIN_PATH/api"
    mkdir -p "$DOMAIN_PATH/apex"
    mkdir -p "$DOMAIN_PATH/utils"
    mkdir -p "$DOMAIN_PATH/widgets"

    # -------------------------------------------------------
    # Create Apex boilerplate (DAO + Service)
    # -------------------------------------------------------
    APX="$DOMAIN_PATH/apex"

    if [ ! -f "$APX/${DOMAIN_CAPITALIZED}DAO.cls" ]; then
    cat <<EOF > "$APX/${DOMAIN_CAPITALIZED}DAO.cls"
public with sharing class ${DOMAIN_CAPITALIZED}DAO {
    // TODO: Add SOQL queries for domain: $domain
    public static List<SObject> getRecords() {
        return new List<SObject>();
    }
}
EOF
    fi

    if [ ! -f "$APX/${DOMAIN_CAPITALIZED}Service.cls" ]; then
    cat <<EOF > "$APX/${DOMAIN_CAPITALIZED}Service.cls"
public with sharing class ${DOMAIN_CAPITALIZED}Service {
    // TODO: Add business logic for domain: $domain

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return ${DOMAIN_CAPITALIZED}DAO.getRecords();
    }
}
EOF
    fi

    # -------------------------------------------------------
    # Create JS API layer
    # -------------------------------------------------------
    API_PATH="$DOMAIN_PATH/api"

    if [ ! -f "$API_PATH/${domain}Api.js" ]; then
    cat <<EOF > "$API_PATH/${domain}Api.js"
export async function fetch${DOMAIN_CAPITALIZED}Data() {
    // TODO: Call Apex or REST API for $domain
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

export async function get${DOMAIN_CAPITALIZED}Data() {
    // Wrap API + apply logic
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
export const ${domain}Constants = {
    MODULE: "$domain"
};

// TODO: add shared domain utilities
EOF
    fi

    # -------------------------------------------------------
    # Create sample LWC (top widget)
    # -------------------------------------------------------
    LWC_PATH="$DOMAIN_PATH/lwc/top${DOMAIN_CAPITALIZED}"
    mkdir -p "$LWC_PATH"

    if [ ! -f "$LWC_PATH/top${DOMAIN_CAPITALIZED}.js" ]; then
    cat <<EOF > "$LWC_PATH/top${DOMAIN_CAPITALIZED}.js"
import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/${DOMAIN_CAPITALIZED}Service.fetchData';

export default class Top${DOMAIN_CAPITALIZED} extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
EOF
    fi

    if [ ! -f "$LWC_PATH/top${DOMAIN_CAPITALIZED}.html" ]; then
    cat <<EOF > "$LWC_PATH/top${DOMAIN_CAPITALIZED}.html"
<template>
    <template if:true={hasData}>
        <lightning-card title="Top ${DOMAIN_CAPITALIZED}">
            <template for:each={records.data} for:item="item">
                <p key={item.Id}>{item.Name}</p>
            </template>
        </lightning-card>
    </template>

    <template if:false={hasData}>
        <p>No ${domain} data available.</p>
    </template>
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
