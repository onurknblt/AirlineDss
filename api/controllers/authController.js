const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const SECRET_KEY = process.env.SECRET_KEY; 

const registerUser = (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) return res.status(400).json({ error: "Email ve parola gerekli" });

  bcrypt.hash(password, 10, (err, hashedPassword) => {
    if (err) return res.status(500).json({ error: "Hashleme hatası" });

    const sql = "INSERT INTO users (email, password) VALUES (?, ?)";
    db.query(sql, [email, hashedPassword], (err, result) => {
      if (err) {
        if (err.code === 'ER_DUP_ENTRY') {
          return res.status(400).json({ error: "Email zaten kayıtlı" });
        }
        return res.status(500).json({ error: err.message });
      }
      res.json({ message: "Kullanıcı başarıyla oluşturuldu", userId: result.insertId });
    });
  });
};

const loginUser = (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) return res.status(400).json({ error: "Email ve parola gerekli" });

  const sql = "SELECT * FROM users WHERE email = ?";
  db.query(sql, [email], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length === 0) return res.status(400).json({ error: "Kullanıcı bulunamadı" });

    const user = results[0];

    bcrypt.compare(password, user.password, (err, isMatch) => {
      if (err) return res.status(500).json({ error: "Hash karşılaştırma hatası" });
      if (!isMatch) return res.status(400).json({ error: "Parola yanlış" });

      const token = jwt.sign({ id: user.id, email: user.email }, SECRET_KEY, { expiresIn: '1h' });
      res.json({ message: "Giriş başarılı", token });
    });
  });
};

const getProfile = (req, res) => {
  const token = req.headers['authorization'];
  if (!token) return res.status(401).json({ error: "Token yok" });

  jwt.verify(token, SECRET_KEY, (err, decoded) => {
    if (err) return res.status(401).json({ error: "Token geçersiz" });
    res.json({ message: "Protected data", user: decoded });
  });
};

module.exports = { registerUser, loginUser, getProfile };
