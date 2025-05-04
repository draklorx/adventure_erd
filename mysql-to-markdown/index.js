const fs = require('fs');
const path = require('path');
const executeQuery = require('./src/utils/query-executor');
const formatMarkdown = require('./src/utils/markdown-formatter');
const buildAdventureQuery = require('./src/utils/adventure-query-builder');
const outputFilePath = path.join(__dirname, './output/results.md');
const dotenv = require('dotenv');
dotenv.config();

async function main() {
    try {
        const query = buildAdventureQuery(24); // Replace with the desired adventure ID
        const results = await executeQuery(query);
        
        const markdownContent = formatMarkdown(results);
        
        fs.writeFileSync(outputFilePath, markdownContent);
        console.log('Markdown file has been created successfully!');
        
    } catch (error) {
        console.error('Error executing the query:', error);
    }
}

main();