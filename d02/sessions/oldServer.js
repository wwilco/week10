var express = require ('express');
var session = require ('express-session');
var bodyparser = require ('body-parser')
var app = express();


var secret = require('./secret.json');;
app.use(bodyparser.urlencoded({extended:false}));

app.use(session({
  secret: secret.password,
  resave: false,
  SaveUninitialized: true
}));

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

app.post('/session', function(req, res){
  if (req.body.password === secret.password){
    req.session.valid_user = true;
    res.redirect('/secret')
  } else {
    res.redirect('/')
  };
});

app.get('/secret', function(req, res){
  if (req.session.valid_user){
    res.sendFile(__dirname + '/secret.html');
  } else {
    res.redirect('/')
  };
});

app.get('/secret2', function(req, res){
  if (req.session.valid_user === true){
    res.sendFile(__dirname + '/secret2.html');
  } else {
    res.redirect('/')
  };
});

app.listen(3000);
