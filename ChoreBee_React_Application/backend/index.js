const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config()
//const { default: axios } = require('axios')

const User = require('./models/user')
const Task = require('./models/task.js')
const Review = require('./models/review.js')
const loginRouter = require('./controllers/login')
const user = require('./models/user')

app.use(express.static('build'))
app.use(cors())
app.use(express.json())
app.use('/login', loginRouter)

//gets all the users from the database
app.get('/users', (req, res) => {
  User.find({}).then(users => {
    res.json(users)
  })
})

//gets one user from database
app.get('/users/:id', (req, res) => {
  User.findById(req.params.id).populate('tasks').then(async user => {
    res.json(user)
  })
})

app.get('/reviews', (req, res) => {
  Review.find({}).then(reviews => {
    res.json(reviews)
  })
})

app.get('/reviews/:id', (req, res) => {
  User.findById(req.params.id).populate('reviews').populate('reviewed').then(async user => {
    res.json(user)
    console.log(res.json)
  })
})

//posts a new user to database

app.post('/users', (req, res) => {
  const body = req.body

  const user = new User({
    name: body.name,
    age: body.age,
    info: body.info,
    number: body.number,
    address: body.address,
    email: body.email,
    password: body.password,
  })

  user.save().then(savedUser => {
    res.json(savedUser)
    console.log(savedUser)
  })
})

//updates specific users values with its id
app.put('/users/:id', (req, res) => {
  const body = req.body

  const user = {
    name: body.name,
    age: body.age,
    info: body.info,
    password: body.password,
    number: body.number,
    address: body.address,
    id: body.id,
    tasks: body.tasks
  }

  User.findByIdAndUpdate(req.params.id, user, { new: true })
    .then(updatedUser => {
      res.json(updatedUser)
    })
})

//gets all tasks from database
app.get('/tasks', (req, res) => {
  Task.find({}).then(tasks => {
    res.json(tasks)
  })
})

//gets one task from database
app.get('/tasks/:id', (req, res) => {
  Task.findById(req.params.id).then(task => {
    res.json(task)
  })
})

//posts a new task to database
app.post('/tasks', (req, res) => {
  const body = req.body

  const task = new Task({
    headline: body.headline,
    description: body.description,
    location: body.location,
    salary: body.salary,
    duration: body.duration,
    active: body.active,
    user: body.user,
    category : body.category
  })
  console.log('jeee', task)

  task.save().then(async savedTask => {
    res.json(savedTask)
    console.log(savedTask)
  })
})

//update a specific tasks values with its id
app.put('/tasks/:id', (req, res) => {
  const body = req.body

  const task = {
    headline: body.headline,
    description: body.description,
    location: body.location,
    salary: body.salary,
    duration: body.duration,
    active: body.active,
    user: body.user
  }

  Task.findByIdAndUpdate(req.params.id, task, { new: true })
    .then(updatedTask => {
      res.json(updatedTask)
    })
})

//gets all users and their tasks from database
app.get('/pop', async (req, res) => {
  const users = await User
    .find({}).populate('tasks')
  res.json(users)
})



const PORT = process.env.PORT
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})

