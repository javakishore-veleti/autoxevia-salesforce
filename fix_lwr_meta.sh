#!/bin/bash

echo ""
echo "==============================================="
echo "  AutoXevia LWR Meta Fix Script"
echo "  Updating meta.xml files for LWR compatibility"
echo "==============================================="
echo ""

ROOT="force-app/main/default"

# New valid LWR targets
NEW_TARGETS=$(cat <<EOF
    <targets>
        <target>lightning__Tab</target>
        <target>lightning__AppPage</target>
        <target>lightning__RecordPage</target>
    </targets>

    <targetConfigs>
        <targetConfig targets="lightning__Tab">
            <supportedFormFactors>
                <supportedFormFactor type="Large"/>
                <supportedFormFactor type="Small"/>
            </supportedFormFactors>
        </targetConfig>
    </targetConfigs>
EOF
)

# Find all top* meta.xml files under domains except xevHeader
FILES=$(find "$ROOT/domains" "$ROOT/lwc" -name "top*js-meta.xml" 2>/dev/null)

if [[ -z "$FILES" ]]; then
    echo "❌ No top* LWC meta files found."
    exit 1
fi

for file in $FILES; do
    if [[ "$file" == *"xevHeader"* ]]; then
        continue
    fi
    
    echo "→ Fixing: $file"

    # Backup original
    cp "$file" "$file.bak"

    # Replace <targets> block completely
    sed -i '' '/<targets>/,/<\/targets>/d' "$file"

    # Remove any old targetConfigs
    sed -i '' '/<targetConfigs>/,/<\/targetConfigs>/d' "$file"

    # Insert new targets before closing </LightningComponentBundle>
    sed -i '' "s#</LightningComponentBundle>#${NEW_TARGETS}\n</LightningComponentBundle>#" "$file"
done

echo ""
echo "==============================================="
echo "  DONE! All meta files updated for LWR."
echo "  Next Step: Run"
echo "     sf deploy metadata --source-dir force-app/main/default"
echo "==============================================="
