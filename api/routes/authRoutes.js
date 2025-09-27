const express = require('express');
const router = express.Router();
const { registerUser, loginUser, getProfile } = require('../controllers/authController');

router.post('/register', registerUser); // Yeni kayıt 
router.post('/login', loginUser); // Giriş 
router.get('/profile', getProfile); // Profilleri geti

module.exports = router;