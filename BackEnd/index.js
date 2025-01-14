import 'dotenv/config';
import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { publicRouter } from './src/routers/publicRouter.js';
import { privateRouter } from './src/routers/privateRouter.js';
import { bodySanitizerMiddleware } from './src/middlewares/bodySanitizer.js';
import { checkLoggedIn } from './src/middlewares/checkLoggedIn.js';
import { checkToken } from './src/middlewares/checkToken.js';
import cors from 'cors';
import { adminRouter } from './src/routers/adminRouter.js';
import session from 'express-session';
import { createServer } from 'http';
import { Server } from 'socket.io';
import jsonwebtoken from 'jsonwebtoken';
import {
  putToReadMessage,
  sendMessageToUser,
} from './src/controllers/messageController.js';

// Convert import.meta.url to __filename and __dirname
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();
const server = createServer(app);

app.use(cors(process.env.ALLOWED_DOMAINS || '*'));

const io = new Server(server, {
  cors: {
    origin: 'http://localhost:3000',
    credential: true,
  },
});

app.use(express.urlencoded({ extended: true })); // Parser les bodies de type "application/www-form-urlencoded"
app.use(express.json()); // Parser les bodies de type "application/json"

app.use(
  session({
    resave: false,
    saveUninitialized: false,
    secret: process.env.SESSION_KEY,
    cookie: {
      secure: false,
      maxAge: 1000 * 60 * 60, // une heure
    },
  })
);

app.use(bodySanitizerMiddleware);

app.disable('x-powered-by');

app.use(checkToken);

io.use((socket, next) => {
  const sessionID = socket.handshake.auth.sessionID;
  sessionID
    ? ''
    : () => {
        return console.log('no token');
      };
  // check if session exist
  if (sessionID === socket.sessionID) {
    console.log('session existing');
    return next();
  }
  try {
    const verify = jsonwebtoken.verify(sessionID, process.env.TOKEN_KEY);
    // console.log(verify);
    // create new session
    socket.sessionID = sessionID;
    socket.userID = verify.userId;
    socket.username = verify.name;
    // TODO:add picture if necessary
  } catch (error) {
    return console.error(error);
  }
  next();
});

io.on('connection', (socket) => {
  console.log('user connected');
  socket.emit('session', {
    sessionID: socket.sessionID,
    userID: socket.userID,
  });
  socket.join(socket.userID);
  socket.on('disconnect', () => console.log('user disconnected'));
});

io.on('connection', (socket) => {
  socket.on('Chat Message', (content) => {
    const { message, to } = content;
    console.log(content);
    socket.to(to).to(socket.userID).emit('Chat Message', {
      message,
      from: socket.userID,
      to: to,
    });
    sendMessageToUser(message, to, socket.userID);
  });

  socket.on('Read Receipt', (receip) => {
    console.log('message lu');
    const { read, to } = receip;
    socket.to(to).emit('Read Receipt', {
      read,
      from: socket.userID,
    });
    putToReadMessage(to, socket.userID);
  });
});

app.use('/api/public', publicRouter);
app.use('/api/private', checkLoggedIn, privateRouter);

// Body parser
app.use(express.urlencoded({ extended: true }));
// Setup view engine
app.set('view engine', 'ejs');
app.set('views', './src/views');

// Statically served files
app.use(express.static(path.join(__dirname, 'src/assets')));

app.use('/admin', adminRouter);

server.listen(process.env.PORT, () => {
  console.log(
    `❤️  SeniorLove server listening at http://localhost:${process.env.PORT} ❤️`
  );
});
