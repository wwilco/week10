var express = require ('express');
var session = require ('express-session');
var bodyparser = require ('body-parser')
var sqlite3 = require ('sqlite3').verbose();

var db = new sqlite3.Database("authentication.db");
var app = express();

app.use(session({
  secret: "password",
  resave: false,
  saveUninitialized: true
}));

app.use(bodyparser.urlencoded({extended:false}));

app.get('/xindex', function(req, res){
  res.sendFile(__dirname + '/xindex.html');
});

// app.post('/user', function(req, res){
//   var username = req.body.username;
//   var password = req.body.password;
//   var confirmPassword = req.body.confirmPassword;
//
//   if (password === confirmPassword) {
//     db.run("INSERT INTO users (username, password) VALUES (?, ?)",
//     username, password, function(err){
//       if (err) {
//         throw err;
//       } else {
//         req.session.valid_user = true;
//         res.redirect("/secret");
//       }
//     });
//   }
//   else {
//     res.redirect("/xindex");
//   }
// });

app.post('/user', function(req, res){
  var username = req.body.username;
  var password = req.body.password;
  var confirmPassword = req.body.confirmPassword;

  if (password != confirmPassword){
    res.redirect('/xindex');
  } else {
    db.run("INSERT INTO users (username, password) VALUES (?, ?)",
    username, password, function(err){
      if (err) {throw err;}
      else {
        req.session.valid_user = true;
        res.redirect("/secret");
      }
    })
  }
});

app.post('/session', function(req, res){
  var username = req.body.username;
  var password = req.body.password;

  db.get("SELECT * FROM users WHERE username=? AND password=?",
  username, password, function(err, row){
    if (err){ throw err;}
    if (row){
      req.session.valid_user = true;
      res.redirect('/secret')
    }
    else {
      res.redirect("/xindex");
    }
  });
});


app.get('/secret', function(req, res){
  if (req.session.valid_user){
    res.sendFile(__dirname + '/secret.html');
  } else {
    res.redirect('/xindex')
  };
});

app.get('/secret2', function(req, res){
  if (req.session.valid_user === true){
    res.sendFile(__dirname + '/secret2.html');
  } else {
    res.redirect('/xindex')
  };
});

app.listen(3000);
