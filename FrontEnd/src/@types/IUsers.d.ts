export interface IUsers {
  id: number;
  name: string;
  alt: string;
  age: number;
  picture: string;
  picture_id: string;
  birth_date: Date;
  gender: string;
  description: string;
  hobbies: IHobby[];
  email: string;
  old_password?: string;
  new_password?: string;
  repeat_new_password?: string;
  events?: IEvent[];
}
