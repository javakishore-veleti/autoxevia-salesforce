#!/bin/bash

echo ""
echo "==============================================="
echo " AutoXevia LWR Meta Fix Script (macOS SAFE 2)"
echo "==============================================="
echo ""

ROOT="force-app/main/default"

FILES=$(find "$ROOT" -type f -name "top*js-meta.xml")

if [[ -z "$FILES" ]]; then
    echo "❌ No meta.xml files found."
    exit 1
fi

for file in $FILES; do
    echo "→ Fixing: $file"

    cp "$file" "$file.bak"

    awk '
        BEGIN {skip=0}
        
        /<targets>/ { skip=1; next }
        /<\/targets>/ { skip=0; next }

        /<targetConfigs>/ { skip=1; next }
        /<\/targetConfigs>/ { skip=0; next }

        {
            if(skip==0) print $0;
        }

        /<\/LightningComponentBundle>/ {
            print "    <targets>";
            print "        <target>lightning__Tab</target>";
            print "        <target>lightning__AppPage</target>";
            print "        <target>lightning__RecordPage</target>";
            print "    </targets>";
            print "    <targetConfigs>";
            print "        <targetConfig targets=\"lightning__Tab\">";
            print "            <supportedFormFactors>";
            print "                <supportedFormFactor type=\"Large\"/>";
            print "                <supportedFormFactor type=\"Small\"/>";
            print "            </supportedFormFactors>";
            print "        </targetConfig>";
            print "    </targetConfigs>";
        }
    ' "$file.bak" > "$file"
done

echo ""
echo "==============================================="
echo " DONE — All meta.xml files updated correctly!"
echo " Next: run"
echo "     sf deploy metadata --source-dir force-app/main/default"
echo "==============================================="
