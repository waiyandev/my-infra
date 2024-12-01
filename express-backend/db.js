const { Pool } = require("pg");

const pool = new Pool({
    user: "kiz2zy",
    host: "localhost",
    database: "discord_db",
    password: "kix2xy",
    port: 5432,
});

// (async () => {
//     try {
//         await pool.query("SELECT 1");
//         console.log("Successfully connected to database.");
//     } catch (error) {
//         console.error("Database connection error:", error.message);
//         process.exit(1);
//     }
// })();

module.exports = pool;