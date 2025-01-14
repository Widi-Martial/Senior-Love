export interface IMessages {
  id: number;
  message: string;
  receiver_id: number;
  created_at: Date;
  read: boolean;
  sender: {
    id: number;
    name: string;
    picture: string;
  };
  sender_id: number;
}
