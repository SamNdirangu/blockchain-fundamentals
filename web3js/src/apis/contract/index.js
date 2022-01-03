import express from 'express';
import Web3 from 'web3';
import { blockChain } from '../../configs/configs.js';

const contractRouter = express.Router();
// const w3 = new Web3(Web3.providers.HttpProvider(blockChain.url));

contractRouter.get('/deploy', (request, response) => {
  response.send(blockChain.url);
});

export default contractRouter;
