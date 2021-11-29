var express = require("express");
var mysql = require("mysql");
var bodyParser = require("body-parser");
const app = express();
var db = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "marinex",
});

db.connect((err) => {
  if (err) throw err;
  console.log("Mysql Connected");
});

app.use(bodyParser.urlencoded({ extended: false }));

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  next();
});

app.get("/createtableprojects", (req, res) => {
  let sql =
    "CREATE TABLE users(id int AUTO_INCREMENT, user Varchar(255), password VARCHAR(255), active int, completion int, ratio int,  PRIMARY KEY (id))";
  db.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Post table created.....");
  });
});
app.get("/addpost1", (req, res) => {
  let post = {
    title: "Second Project",
    author: "Khalid",
    date: "2021-11-23",
    deadline: "2021-11-30",
    workers: "Ljung",
    completed: "No",
  };
  let sql = "INSERT INTO projects SET ?";
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
  const project = {
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

app.listen("3000", () => {
  console.log("server started on port 3000");
});
