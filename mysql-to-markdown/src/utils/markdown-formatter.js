function formatMarkdown(results) {
  let markdown = "";

  results.forEach((row) => {
    const { section_type, header, text } = row;
    try {
      switch (section_type) {
        case "adventure_title":
          markdown += `# ${header}\n\n`;
          break;
        case "adventure_description":
        case "adventure_details":
          markdown += `**${header}**\n\n`;
          markdown += `${text}\n\n`;
          break;
        case "location":
          markdown += `## ${header}\n\n`;
          markdown += `${text}\n\n`;
          break;
          case "encounter":
            markdown += `#### ${header}\n\n`;
            markdown += `---\n`;
            markdown += `*${text}*\n\n`;
            markdown += `---\n`;
            break;
            case "poi":
              markdown += `**${header}**\n\n`;
              markdown += `${text}\n\n`;
              break;
              case "poi_monster":
                case "poi_ability":
                markdown += `${header}: `;
                markdown += `${text}\n\n`;
                break;
        default:
          throw new Error(`Unknown section type: ${section_type}`);
      }
    } catch (error) {
      console.error(`Error processing row: ${JSON.stringify(row)}`);
      console.error(`Error message: ${error.message}`);
    }
  });

  return markdown.trim();
}

module.exports = formatMarkdown;
