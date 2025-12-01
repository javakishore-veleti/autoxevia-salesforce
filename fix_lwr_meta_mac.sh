#!/bin/bash

echo ""
echo "==============================================="
echo " AutoXevia LWR Meta Fix Script (macOS SAFE)"
echo "==============================================="
echo ""

ROOT="force-app/main/default"

NEW_TARGETS=$(cat <<'EOF'
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

FILES=$(find "$ROOT" -type f -name "top*js-meta.xml")

if [[ -z "$FILES" ]]; then
    echo "❌ No meta.xml files found."
    exit 1
fi

for file in $FILES; do
    echo "→ Fixing $file"

    cp "$file" "$file.bak"

    awk -v newTargets="$NEW_TARGETS" '
        BEGIN { inTargets=0; }
        /<targets>/ { inTargets=1; next; }
        /<\/targets>/ { inTargets=0; next; }
        /<targetConfigs>/ { inTargets=1; next; }
        /<\/targetConfigs>/ { inTargets=0; next; }
        {
            if (!inTargets)
                print $0;
        }
        /<\/LightningComponentBundle>/ {
            print newTargets;
        }
    ' "$file.bak" > "$file"
done

echo ""
echo "==============================================="
echo " DONE — Meta XML updated for all top* LWCs!"
echo " Run:"
echo "   sf deploy metadata --source-dir force-app/main/default"
echo "==============================================="
