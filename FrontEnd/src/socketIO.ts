import { io } from 'socket.io-client';

const SOCKET = io('http://localhost:4000', {
  autoConnect: false,
});
export default SOCKET;
