const fs = require('fs');
const path = require('path');

// Paths
const qazalFolderPath = path.join(__dirname, 'Qazal');
const jsonFilePath = path.join(__dirname, '#Hafez', 'HafezQazal.json');

// Function to extract poem number from filename
function extractPoemNumber(filename) {
    const match = filename.match(/sh(\d+)/);
    return match ? match[1] : null;
}

// Function to extract URL from text file
function extractUrl(content) {
    const lines = content.split('\n');
    for (const line of lines) {
        const trimmedLine = line.trim();
        if (trimmedLine.startsWith('https://ganjoor.net/')) {
            return trimmedLine;
        }
    }
    return null;
}

try {
    // Read the JSON file
    const jsonData = JSON.parse(fs.readFileSync(jsonFilePath, 'utf8'));
    console.log(`Read ${jsonData.length} poems from JSON file`);

    // Create a map for easier lookup
    const poemMap = {};
    jsonData.forEach((poem, index) => {
        // Extract poem ID number (e.g., "HQ495" -> "495")
        const idNumber = poem.id.replace('HQ', '');
        // Pad with leading zeros to match format in filename
        const paddedNumber = idNumber.padStart(3, '0');
        poemMap[paddedNumber] = index;
    });

    // Read all files in the Qazal folder
    const files = fs.readdirSync(qazalFolderPath);
    console.log(`Found ${files.length} files in Qazal folder`);

    let updatedCount = 0;

    // Process each file
    for (const file of files) {
        if (file.startsWith('hafez_ghazal_sh')) {
            const poemNumber = extractPoemNumber(file);
            if (poemNumber) {
                const filePath = path.join(qazalFolderPath, file);
                const content = fs.readFileSync(filePath, 'utf8');
                const url = extractUrl(content);

                if (url) {
                    // Find the corresponding poem in the JSON data
                    const index = poemMap[poemNumber];
                    if (index !== undefined) {
                        jsonData[index].link1 = url;
                        updatedCount++;
                    }
                }
            }
        }
    }

    // Save the updated JSON data
    fs.writeFileSync(jsonFilePath, JSON.stringify(jsonData, null, 4), 'utf8');
    console.log(`Updated link1 field for ${updatedCount} poems`);

} catch (error) {
    console.error('Error:', error.message);
} 