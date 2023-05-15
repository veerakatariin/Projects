const mongoose = require('mongoose')
mongoose.set('strictQuery',false)
const url = process.env.MONGODB_URI

console.log('connecting to', url)
mongoose.connect(url)
  .then(result => {
    console.log('connected to MongoDB')
  })
  .catch((error) => {
    console.log('error connecting to MongoDB:', error.message)
  })

  const userSchema = new mongoose.Schema({
      name: String,
      age: Number,
      info: String,
      password: String,
      number: String,
      address: String,
      email: String,
      id: Object,
      tasks: [
        {
          type: mongoose.Schema.Types.ObjectId,
          ref: 'Task'
        }
      ],
      reviews: [
        {
          type: mongoose.Schema.Types.ObjectId,
          ref: 'Review'
        }
      ],
      reviewed: [
        {
          type: mongoose.Schema.Types.ObjectId,
          ref: 'Review'
        }
      ],
  }, {collection : 'users'})

  const User = mongoose.model('User', userSchema)

  userSchema.set('toJSON', {
    transform: (document, returnedObject) => {
      returnedObject.id = returnedObject._id.toString()
      delete returnedObject._id
      delete returnedObject.__v
    }
  })

  module.exports = mongoose.model('User', userSchema)