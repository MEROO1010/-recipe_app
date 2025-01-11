const express = require('express');
const auth = require('../middleware/auth');
const User = require('../models/User');
const Recipe = require('../models/Recipe');

const router = express.Router();

// Add favorite recipe
router.post('/add', auth, async (req, res) => {
  const { id, title, image } = req.body;
  try {
    const recipe = await Recipe.findOneAndUpdate(
      { id },
      { id, title, image },
      { upsert: true, new: true }
    );

    await User.findByIdAndUpdate(
      req.user.id,
      { $addToSet: { favorites: recipe._id } },
      { new: true }
    );

    res.status(200).json({ message: 'Recipe added to favorites' });
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// Remove favorite recipe
router.post('/remove', auth, async (req, res) => {
  const { id } = req.body;
  try {
    const recipe = await Recipe.findOne({ id });
    if (!recipe) return res.status(400).json({ message: 'Recipe not found' });

    await User.findByIdAndUpdate(
      req.user.id,
      { $pull: { favorites: recipe._id } },
      { new: true }
    );

    res.status(200).json({ message: 'Recipe removed from favorites' });
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// Get favorite recipes
router.get('/', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user.id).populate('favorites');
    res.status(200).json(user.favorites);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;