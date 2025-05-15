const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const session = require('express-session');

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
    secret: 'sugallangtohehe', // Use a strong secret in production
    resave: false,
    saveUninitialized: false
}));

// DB connection
// DB connection
// DB connection
const db = mysql.createConnection({
    host: process.env.DB_HOST || 'your-db-host.render.com',
    user: process.env.DB_USER || 'your database username',
    password: process.env.DB_PASSWORD || 'your database password',
    database: process.env.DB_NAME || 'penguin_race',
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 3306
});

db.connect(err => {
    if (err) throw err;
    console.log('Connected to MySQL');
});

// View engine
app.set('view engine', 'html');
app.engine('html', require('ejs').renderFile);

// Routes (views)
app.get('/', (req, res) => res.redirect('/register'));
app.get('/index', (req, res) => res.render('index.html'));
app.get('/login', (req, res) => res.render('login.html'));
app.get('/register', (req, res) => res.render('register.html'));
app.get('/profile', (req, res) => res.render('profile.html'));
app.get('/home', (req, res) => res.render('home.html'));
app.get('/bet_history', (req, res) => res.render('bet_history.html'));

app.get('/bet_history_data', (req, res) => {
    const userId = req.session.user?.id;
    if (!userId) return res.status(401).json({ error: 'Unauthorized' });

    const query = `
        SELECT penguin_selected, bet_amount, outcome, winnings, race_time
        FROM bet_history
        WHERE user_id = ?
        ORDER BY race_time DESC
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error fetching bet history:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});

// Register route
app.post('/register', async (req, res) => {
    const { username, password } = req.body;
    const hashed = await bcrypt.hash(password, 10);

    db.query('SELECT * FROM users WHERE username = ?', [username], (err, results) => {
        if (err) return res.send('Error checking username.');

        if (results.length > 0) {
            return res.send('Username already taken. Please choose another.');
        }

        db.query('INSERT INTO users (username, password, is_deleted) VALUES (?, ?, 0)', [username, hashed], (err2) => {
            if (err2) return res.send('Error registering user.');
            res.redirect('/login');
        });
    });
});

// Login route
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    db.query('SELECT * FROM users WHERE username = ? AND is_deleted = 0', [username], async (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
            const user = results[0];
            const match = await bcrypt.compare(password, user.password);

            if (match) {
                req.session.user = { id: user.id, username: user.username };
                return res.redirect('/home');
            }
        }

        res.send('Invalid credentials or account has been deleted.');
    });
});

// Profile update route
app.post('/update-profile', async (req, res) => {
    const { newUsername, newPassword } = req.body;
    const userId = req.session.user?.id;

    if (!userId) return res.status(401).send('Unauthorized');

    let query = 'UPDATE users SET username = ?';
    const params = [newUsername];

    if (newPassword && newPassword.trim() !== "") {
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        query += ', password = ?';
        params.push(hashedPassword);
    }

    query += ' WHERE id = ?';
    params.push(userId);

    db.query(query, params, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error updating profile');
        }

        req.session.destroy(() => {
            res.send('Profile updated. Please log in again with your new credentials.');
        });
    });
});

// Delete account (soft delete)
app.post('/delete-account', (req, res) => {
    const userId = req.session.user?.id;
    if (!userId) return res.redirect('/login');

    db.query('UPDATE users SET is_deleted = 1 WHERE id = ?', [userId], (err, result) => {
        if (err) throw err;

        req.session.destroy(() => {
            res.send('Your account has been deleted.');
        });
    });
});


app.post('/place-bet', (req, res) => {
    const userId = req.session.user?.id;
    const { penguin_selected, bet_amount, outcome, winnings } = req.body;

    if (!userId) return res.status(401).send('Unauthorized');

    const query = `
        INSERT INTO bet_history (user_id, penguin_selected, bet_amount, outcome, winnings, race_time)
        VALUES (?, ?, ?, ?, ?, NOW())
    `;

    db.query(query, [userId, penguin_selected, bet_amount, outcome, winnings], (err, result) => {
        if (err) {
            console.error('Error inserting bet:', err);
            return res.status(500).send('Error saving bet');
        }
        res.status(200).send('Bet saved successfully');
    });
});

// Logout
app.get('/logout', (req, res) => {
    req.session.destroy(err => {
        if (err) return res.status(500).send("Error in logging out");
        res.redirect('/login');
    });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
