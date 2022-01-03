import compression from 'compression';
import cors from 'cors';
import express, { json, urlencoded } from 'express';
import mongoSanitize from 'express-mongo-sanitize';
import helmet from 'helmet';
import httpStatus from 'http-status';
import xss from 'xss-clean';
import { env } from './configs/configs.js';
import { errorHandler as _errorHandler, successHandler } from './configs/morgan.js';
import { errorConverter, errorHandler } from './middlewares/error.js';
import authLimiter from './middlewares/rateLimiter.js';
import rootRouter from './apis/index.js';
import ApiError from './utils/ApiError.js';

const app = express();

if (env !== 'test') {
  app.use(successHandler);
  app.use(_errorHandler);
}

// Set security HTTP headers
app.use(helmet());

// Parse json request body
app.use(json());

// Parse urlencoded request body
app.use(urlencoded({ extended: true }));

// Sanitize request data
app.use(xss());
app.use(mongoSanitize());

// Gzip compression
app.use(compression());

// Enable cors
app.use(cors());
app.options('*', cors());

// Limit repeated failed requests to auth endpoints
if (env === 'production') {
  app.use('/v1/auth', authLimiter);
}

// V1 api routes
app.use(rootRouter);

// Send back a 404 error for any unknown api request
app.use((req, res, next) => {
  next(new ApiError(httpStatus.NOT_FOUND, 'Not found'));
});

// Convert error to ApiError, if needed
app.use(errorConverter);

// Handle error
app.use(errorHandler);

export default app;
