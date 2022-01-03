import express from 'express';
import contractRouter from './contract/index.js';

const rootRouter = express.Router();

rootRouter.use('/contract', contractRouter);

rootRouter.get('/test', (req, res) => {
  res.send('We are live nowsssssssssss');
});

export default rootRouter;
