const mysql = require("mysql2");
const dbConfig = require("../config/db");
require("dotenv").config();

const executeQuery = async (query) => {
  const connection = mysql.createConnection(dbConfig);
  
  return new Promise((resolve, reject) => {
    connection.execute(query, (error, results) => {
      // Always close the connection, whether there's an error or not
      connection.end(err => {
        if (err) console.error('Error closing connection:', err);
      });
      
      if (error) {
        return reject(error);
      }
      resolve(results);
    });
  });
};

module.exports = executeQuery;
