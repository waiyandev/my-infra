const express = require("express");
const app = express();
const cors = require("cors");
const port = 3000;
// const pool = require("./db");
const { SearchSource } = require("jest");

app.use(cors());
app.use(express.json());

app.get("/api/v1/hello", (req, res) => {
  res.json({ message: "Okay Lah!" });
});

// app.get("/api/v1/users", async (req, res) => {
//     try {
//         const result = await pool.query("SELECT * FROM users");
//         res.json(result.rows);
//     } catch (error) {
//         console.error(error.message);
//         res.status(500).json({ error: "Internal server error" });
//     }
// });

// app.post("/api/v1/users", async (req, res) => {
//     try {
//         const { name, email } = req.body;
//         const result = await pool.query(
//             "INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id",
//             [name, email]
//         );
//         res.status(201).json({
//             id: result.rows[0].id,
//             name: name,
//             email: email,
//         });
//     } catch (error) {
//         if (error.constraint === "users_email_key") {
//             res.status(400).json({
//                 error: "Email already exists. Please use a different email.",
//             });
//         } else {
//             console.error(error.message);
//             res.status(500).json({ error: "Internal server error" });
//         }
//     }
// });

// default catch-all router
app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});

const server = app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

module.exports = { app, server };

const shutdown = () => {
  console.log("Received signal to shutdown.");
  server.close(() => {
    console.log("Server closed.");
    pool.end(() => {
      console.log("Database connections closed.");
      process.exit(0);
    });
  });
};

process.on("SIGINT", shutdown);
process.on("SIGTERM", shutdown);
