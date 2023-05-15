const mongoose = require('mongoose')
mongoose.set('strictQuery',false)

const url = process.env.MONGODB_URI
mongoose.connect(url)

  const reviewSchema = new mongoose.Schema({
      text: String,
      date: String,
      stars: Number,
      reviewer: {
        type: mongoose.Schema.Types.String,
        ref: 'User'
      },
      reviewed_user: {
        type: mongoose.Schema.Types.String,
        ref: 'User'
      },

  }, {collection : 'reviews'})

  const Review = mongoose.model('Review', reviewSchema)

  reviewSchema.set('toJSON', {
    transform: (document, returnedObject) => {
      returnedObject.id = returnedObject._id.toString()
      delete returnedObject._id
      delete returnedObject.__v
    }
  })

  module.exports = mongoose.model('Review', reviewSchema)