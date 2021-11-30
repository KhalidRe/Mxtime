var express = require("express");
var mysql = require("mysql");
var bodyParser = require("body-parser");
var session = require("express-session");
var path = require("path");

const app = express();
var db = mysql.createConnection({
  multipleStatements: true,
  host: "localhost",
  user: "root",
  database: "marinex",
});

db.connect((err) => {
  if (err) throw err;
  console.log("Mysql Connected");
});
app.use(
  session({
    secret: "secret",
    resave: true,
    saveUninitialized: true,
  })
);
app.use(bodyParser.urlencoded({ extended: false }));

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  next();
});

app.get("/createtableprojects", (req, res) => {
  let sql =
    "CREATE TABLE users(id int AUTO_INCREMENT, Username VARCHAR(255), Password VARCHAR(255), Name VARCHAR(255), Active int, Created int, Completion int, Profile VARCHAR(255), PRIMARY KEY (id))";
  db.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Post table created.....");
  });
});
app.get("/addpost1", (req, res) => {
  let post = {
    Username: "MXkhalid",
    Password: "C~%!XZh!9vy}C8xk",
    Name: "Khalid",
    Active: 0,
    Created: 0,
    Completion: 0,
    Profile: "Khalid.jpg",
  };
  let sql = "INSERT INTO users SET ?";
  let query = db.query(sql, post, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Project Created");
  });
});
app.get("/viewprojects", (req, res) => {
  let sql = "SELECT * FROM projects";
  let query = db.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.json(result);
  });
});
app.post("/createproject", (req, res) => {
  let project = {
    title: req.body.title,
    author: req.body.author,
    workers: req.body.workers,
    date: req.body.date,
    deadline: req.body.deadline,
    completed: req.body.completed,
  };
  let sql = "INSERT INTO projects SET ?";
  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
  res.send("Project Created");
});

app.post("/deleteproject", (req, res) => {
  let project = { id: req.body.id };
  let sql = `DELETE from projects WHERE id = ${project.id}; SET @num := 0;UPDATE projects SET id = @num := (@num+1);ALTER TABLE projects AUTO_INCREMENT = 1;`;
  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
  res.send("Project Deleted");
});
app.post("/editproject", (req, res) => {
  let project = {
    id: req.body.id,
    title: req.body.title,
    author: req.body.author,
    workers: req.body.workers,
    date: req.body.date,
    deadline: req.body.deadline,
    completed: req.body.completed,
  };
  let sql = `UPDATE projects SET Title = '${project.title}', Author = '${project.author}', Workers = '${project.workers}', Date = '${project.date}', Deadline = '${project.deadline}', Completed = '${project.completed}' WHERE id = ${project.id}`;
  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
  res.send("Updated table");
});
app.post("/authenticate", function (req, res) {
  var Username = req.body.Username;
  var Password = req.body.Password;
  if (Username && Password) {
    db.query(
      `SELECT * FROM users WHERE Username = ? AND Password = ?`,
      [Username, Password],
      function (error, results, fields) {
        if (results.length > 0) {
          req.session.loggedin = true;
          req.session.Username = Username;
          res.redirect("http://localhost:8080/#/Home");
        } else {
          res.send("Incorrect Username and/or Password!");
        }
        res.end();
      }
    );
  } else {
    res.send("Please enter Username and Password!");
    res.end();
  }
});

app.listen("3000", () => {
  console.log("server started on port 3000");
});
