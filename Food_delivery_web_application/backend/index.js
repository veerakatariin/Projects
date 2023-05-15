const { response } = require('express')
const express = require('express')
const app = express()
const port = process.env.PORT || 3001 
const path = require('path')
const cors = require('cors')
app.use(cors())

const restaurant_model = require('./restaurant_model')

app.use(express.json())

// Kommaa jos teet lokaalisti:
/*
app.use(express.static(path.join(__dirname, 'build')))
  app.get('/', (req, res) => {
    res.sendFile(path.resolve(__dirname, 'build', 'index.html'));
  })
*/
 


  //  UNCOMMAA TÄMÄ JOS DEVAAT LOKAALISTI
  app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');
  next();
});

app.use(express.static(path.join(__dirname, 'build')))

app.get('/customer_restaurants', (req, res) => {
  restaurant_model.getRestaurants()
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})


app.get('/restaurant_menu', (req, res) => {
  restaurant_model.getMenu()
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})


app.post('/restaurant_menu', (req, res) => {
  console.log("req"+JSON.stringify(req.body))
  restaurant_model.getMenuById(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/myrestaurants', (req, res) => {
  console.log("req"+JSON.stringify(req.body))
  restaurant_model.getRestaurantsById(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/create_restaurant_menu', (req, res) => {
  restaurant_model.createMenu(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/restaurant_login', (req, res) => {
  restaurant_model.postRestaurantLogin(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/restaurant', (req, res) => {
  restaurant_model.createRestaurant(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/user_login', (req, res) => {
  
  restaurant_model.postUserLogin(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/create_user_login', (req, res) => {
  console.log(req.body)
  restaurant_model.createUserLogin(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/create_restaurant_login', (req, res) => {
  restaurant_model.createRestaurantLogin(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.delete('/restaurant/:id', (req, res) => {
  restaurant_model.deleteRestaurant(req.params.id)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})
app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})

app.post('/user_orderhistory', (req, res) => {
  restaurant_model.createUserOrder(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/restaurant_orderhistory', (req, res) => {
  restaurant_model.createRestaurantOrder(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/restaurantorderhistory', (req, res) => {
  console.log("joo"+req.body.restaurant_id)
  restaurant_model.postUserOrderHistory(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

app.post('/userorderhistory', (req, res) => {
  console.log("joo"+req.body.username)
  restaurant_model.postRestaurantOrderHistory(req.body)
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})


app.get('/*', (req, res) => {
  res.sendFile(path.resolve(__dirname, 'build', 'index.html'));
})