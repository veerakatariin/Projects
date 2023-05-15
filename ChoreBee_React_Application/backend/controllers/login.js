const jwt = require('jsonwebtoken')
const loginRouter = require('express').Router()
const User = require('../models/user')

loginRouter.post('/', async (request, response) => {
  const { email, password } = request.body

  console.log('backendissä')

  const user = await User.findOne({ email })
  console.log(user)
  console.log(email)

  const correctPassword = password === user.password ? true : false
  const correctUser = user === user.email ? true : false

  if ((correctUser || correctPassword === false)) {
    return response.status(401).json({
      error: 'invalid username or password'
    })
  }

  const userForToken = {
    email: user.email,
    id: user._id,
  }

  const token = jwt.sign(userForToken, process.env.SECRET)

  response
    .status(200)
    .send({ token, email: user.email,
       id: user._id})
})

module.exports = loginRouter