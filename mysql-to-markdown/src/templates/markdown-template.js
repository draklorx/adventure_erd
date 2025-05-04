module.exports = (data) => {
    let markdown = '';

    data.forEach(item => {
        const { section_type, header, text, sort_order } = item;

        if (section_type === 'header') {
            markdown += `# ${header}\n\n`;
        } else if (section_type === 'subheader') {
            markdown += `## ${header}\n\n`;
        } else if (section_type === 'paragraph') {
            markdown += `${text}\n\n`;
        } else if (section_type === 'list') {
            markdown += `- ${text}\n`;
        }
    });

    return markdown.trim();
};