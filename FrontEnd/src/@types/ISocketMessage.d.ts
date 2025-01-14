export interface SocketMessage {
  message: string;
  fromSelf: boolean;
  from: number;
  to: number;
  date: Date;
}
