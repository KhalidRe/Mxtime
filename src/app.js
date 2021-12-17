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

app.use(express.urlencoded({ extended: true }));

app.use(express.json());

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  next();
});

app.get("/createtableprojects", (req, res) => {
  let sql =
    "CREATE TABLE time(id int AUTO_INCREMENT, Title VARCHAR(255), Name VARCHAR(255), Username VARCHAR(255), Description VARCHAR(255), Hours VARCHAR(255), Minutes VARCHAR(255), PRIMARY KEY(id))";

  db.query(sql, (err, result) => {
    if (err) throw err;

    res.send("Post table created.....");
  });
});
app.get("/addpost1", (req, res) => {
  let post = {
    Username: "MXphilip",
    Password: "kr3fG3(@X95{_>5;",
    Name: "Philip",
    Active: 0,
    Created: 0,
    Completion: 0,
    Profile: "Philip.jpeg",
  };
  let sql = "INSERT INTO users SET ?";
  let query = db.query(sql, post, (err, result) => {
    if (err) throw err;

    res.send("Project Created");
  });
});
app.get("/viewprojects", (req, res) => {
  let sql = "SELECT * FROM projects";
  let query = db.query(sql, (err, result) => {
    if (err) throw err;

    res.json(result);
  });
});
app.post("/myprojects", (req, res) => {
  let maker = {
    user: req.body.user,
  };

  let sql = `SELECT * FROM projects WHERE Author = (SELECT Name FROM users WHERE Username = '${maker.user}') `;
  let query = db.query(sql, (err, result) => {
    if (err) throw err;
    res.json(result);
  });
});
app.get("/getusers", (req, res) => {
  let sql = "SELECT * FROM users";
  let query = db.query(sql, (err, result) => {
    if (err) throw err;

    res.json(result);
  });
});
app.post("/workernav", (req, res) => {
  let maker = {
    user: req.body.user,
  };
  let sql = `SELECT * FROM users  WHERE Username = '${maker.user}'`;
  let query = db.query(sql, (err, result) => {
    if (err) throw err;

    res.json(result);
  });
});
app.post("/mytime", (req, res) => {
  let maker = {
    user: req.body.user,
  };
  let sql = `SELECT * FROM time  WHERE Username = '${maker.user}'`;
  let query = db.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.json(result);
  });
});

app.get("/chartdata", (req, res) => {
  let sql = "SELECT * FROM chart";
  let query = db.query(sql, (err, result) => {
    if (err) throw err;

    res.json(result);
  });
});
app.post("/addtime", (req, res) => {
  let tid = {
    title: req.body.title,
    name: req.body.name,
    username: req.body.username,
    description: req.body.description,
    hours: req.body.hours,
    minutes: req.body.minutes,
  };
  let sql = `INSERT INTO time SET ?; `;
  let query = db.query(sql, tid, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.json(result);
  });
});
app.post("/createproject", (req, res) => {
  let maker = {
    userid: req.body.userid,
  };
  let project = {
    title: req.body.title,
    author: req.body.author,
    workers: req.body.workers,
    date: req.body.date,
    deadline: req.body.deadline,
    completed: req.body.completed,
    precentage: req.body.precentage,
  };
  let sql3 = `UPDATE users SET Active = Active + 1 WHERE Name = '${project.workers}'`;
  let sql2 = `UPDATE users SET Created = Created + 1, Active = Active + 1 WHERE id = '${maker.userid}'`;
  let sql = `INSERT INTO projects SET ?; `;
  let sqlchart = `INSERT INTO chart (Title, Completion, Deadline, Author, Date) VALUES ('${project.title}','${project.precentage}','${project.deadline}','${project.author}','${project.date}')`;

  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
  });
  let query2 = db.query(sql2, maker, (err, result) => {
    if (err) throw err;
  });
  let query3 = db.query(sql3, project, (err, result) => {
    if (err) throw err;
  });
  let query4 = db.query(sqlchart, project, (err, result) => {
    if (err) throw err;
  });

  res.send("Project Created");
});

app.post("/deleteproject", (req, res) => {
  let project = {
    id: req.body.id,
    username: req.body.username,
    author: req.body.author,
    workers: req.body.workers,
  };

  let sql = `DELETE from projects WHERE id = ${project.id}; SET @num := 0;UPDATE projects SET id = @num := (@num+1);ALTER TABLE projects AUTO_INCREMENT = 1`;
  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
  });
  let sql2 = `UPDATE users SET Created = Created - 1, Active = Active -1 WHERE Name = '${project.author}' `;
  let query2 = db.query(sql2, project, (err, result) => {
    if (err) throw err;
  });
  let sql3 = `UPDATE users SET Active = Active - 1 WHERE Name = '${project.workers}'`;
  let query3 = db.query(sql3, project, (err, result) => {
    if (err) throw err;
  });
  res.send("Project Deleted");
});
app.post("/deletetime", (req, res) => {
  let project = {
    id: req.body.id,
  };

  let sql = `DELETE from time WHERE id = ${project.id}; SET @num := 0;UPDATE time SET id = @num := (@num+1);ALTER TABLE time AUTO_INCREMENT = 1`;
  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
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
    precentage: req.body.precentage,
  };
  let sql = `UPDATE projects SET Title = '${project.title}', Deadline = '${project.deadline}', Completed = '${project.completed}', Precentage=${project.precentage} WHERE id = ${project.id}`;
  let sqlchart = `INSERT INTO chart (Title, Completion, Deadline, Author, Date) VALUES ('${project.title}',${project.precentage},'${project.deadline}','${project.author}','${project.date}')`;
  let query = db.query(sql, project, (err, result) => {
    if (err) throw err;
  });
  let query2 = db.query(sqlchart, project, (err, result) => {
    if (err) throw err;
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
        if (results[0].Username === Username) {
          req.session.loggedin = true;
          req.session.Username = Username;
          res.redirect("/Home");
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
