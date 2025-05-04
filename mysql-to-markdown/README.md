# MySQL to Markdown

This project is a Node.js application that connects to a MySQL database, retrieves data, and formats the results into a Markdown document. The application is designed to be simple and efficient, allowing users to easily export database content into a readable format.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [License](#license)

## Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd mysql-to-markdown
   ```

3. Install the dependencies:
   ```
   npm install
   ```

4. Create a `.env` file based on the `.env.example` file and fill in your database credentials.

## Usage

To run the application, execute the following command:
```
node src/index.js
```

This will connect to the MySQL database, execute the predefined query, and generate a Markdown file in the `output` directory.

## Configuration

The database connection settings can be configured in `src/config/db.js`. Ensure that you provide the correct host, user, password, and database name.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.