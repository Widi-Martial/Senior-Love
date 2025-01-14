import { IHobby } from './IHobby';
import { IEvent } from './IEvent';

export interface IUsersFull {
  id: number;
  name: string;
  birth_date: Date;
  age: number;
  description: string;
  gender: string;
  picture: string;
  email: string;
  events: IEvent;
  hobbies: IHobby;
}
