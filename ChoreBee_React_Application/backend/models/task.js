const mongoose = require('mongoose')
mongoose.set('strictQuery',false)

const url = process.env.MONGODB_URI
mongoose.connect(url)

  const taskSchema = new mongoose.Schema({
      headline: String,
      description: String,
      location: String,
      salary: String,
      duration: String,
      active: Boolean,
      user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
      },
      category: {
        cleaning: Boolean,
        yard_work: Boolean,
        assembly: Boolean,
        shopping: Boolean,
        pets: Boolean,
        home_repair: Boolean,
        moving: Boolean,
        transport: Boolean, 
        electronics: Boolean
      }
  }, {collection : 'tasks'})

  const Task = mongoose.model('Task', taskSchema)
  module.exports = mongoose.model('Task', taskSchema)