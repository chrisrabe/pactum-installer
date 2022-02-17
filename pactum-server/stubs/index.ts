import { addStub } from './utils';
import { ThreeUsers } from './mocks/threeUsers';

export const createStubs = () => {
  // Modify this to add new endpoints
  addStub('/api/users', ThreeUsers);
};
