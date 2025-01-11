const mongoose = require('mongoose');

const recipeSchema = new mongoose.Schema({
  id: { type: Number, required: true, unique: true },
  title: { type: String, required: true },
  image: { type: String, required: true },
});

module.exports = mongoose.model('Recipe', recipeSchema);