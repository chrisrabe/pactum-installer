import { Builder } from 'builder-pattern';
import { User } from '../models/user';

export const ThreeUsers = new Array(3).fill(0).map((_, i) => Builder<User>().id(`${i}`).name(`Username ${i}`).build());
