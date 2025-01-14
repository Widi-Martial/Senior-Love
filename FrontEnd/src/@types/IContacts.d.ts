import { IMessages } from './IMessages';

export interface IContacts {
  id: number;
  messages: IMessages[];
  name: string;
  picture: string;
}
