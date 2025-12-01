#!/bin/bash

# ==========================================================
# AutoXevia Apex Stub Generator (Option A - Safe Fake Data)
# Creates Service + DAO Apex classes ONLY in /classes
# ==========================================================

CLASSES_DIR="force-app/main/default/classes"

DOMAINS=(
  "ProductCatalog"
  "Customers"
  "Orders"
  "Leads"
  "Issues"
  "Analytics"
)

echo ""
echo "=============================================="
echo " AutoXevia Apex Stub Generator"
echo " Creating Service + DAO classes in /classes"
echo " Option A: Fake Data (always deployable)"
echo "=============================================="
echo ""

mkdir -p "$CLASSES_DIR"

for DOMAIN in "${DOMAINS[@]}"; do

SERVICE_FILE="$CLASSES_DIR/${DOMAIN}Service.cls"
SERVICE_META="$CLASSES_DIR/${DOMAIN}Service.cls-meta.xml"

DAO_FILE="$CLASSES_DIR/${DOMAIN}DAO.cls"
DAO_META="$CLASSES_DIR/${DOMAIN}DAO.cls-meta.xml"

echo "→ Generating Apex stubs for: $DOMAIN"

# -------------------------------------------------------
# Create Service class
# -------------------------------------------------------
if [ ! -f "$SERVICE_FILE" ]; then
cat <<EOF > "$SERVICE_FILE"
public with sharing class ${DOMAIN}Service {

    @AuraEnabled(cacheable=true)
    public static List<String> get${DOMAIN}Data() {
        return ${DOMAIN}DAO.fetch${DOMAIN}Data();
    }
}
EOF
fi

cat <<EOF > "$SERVICE_META"
<?xml version="1.0" encoding="UTF-8"?>
<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>59.0</apiVersion>
    <status>Active</status>
</ApexClass>
EOF

# -------------------------------------------------------
# Create DAO class
# -------------------------------------------------------
if [ ! -f "$DAO_FILE" ]; then
cat <<EOF > "$DAO_FILE"
public with sharing class ${DOMAIN}DAO {

    public static List<String> fetch${DOMAIN}Data() {
        // TEMP FAKE DATA
        return new List<String>{
            '${DOMAIN} Item A',
            '${DOMAIN} Item B',
            '${DOMAIN} Item C'
        };
    }
}
EOF
fi

cat <<EOF > "$DAO_META"
<?xml version="1.0" encoding="UTF-8"?>
<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>59.0</apiVersion>
    <status>Active</status>
</ApexClass>
EOF

done

echo ""
echo "=============================================="
echo " Apex Stub Generation COMPLETE"
echo " Files created in: $CLASSES_DIR"
echo "=============================================="
echo ""
