export interface IMessage {
  id: number;
  messages: {
    id: number;
    message: string;
    sender_id: number;
    sender: { picture: string };
  }[];
  picture: string;
  name: string;
}
