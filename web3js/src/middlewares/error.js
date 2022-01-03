import httpStatus from 'http-status';
import { env } from '../configs/configs.js';
import logger from '../configs/logger.js';
import ApiError from '../utils/ApiError.js';

const { BAD_REQUEST, INTERNAL_SERVER_ERROR } = httpStatus;

const errorConverter = (err, req, res, next) => {
  let error = err;
  if (!(error instanceof ApiError)) {
    const statusCode = error.statusCode || error instanceof Error
      ? BAD_REQUEST : INTERNAL_SERVER_ERROR;
    const message = error.message || httpStatus[statusCode];
    error = new ApiError(statusCode, message, false, err.stack);
  }

  next(error);
};

// eslint-disable-next-line no-unused-vars
const errorHandler = (err, req, res, next) => {
  let { statusCode, message } = err;
  if (env === 'production' && !err.isOperational) {
    statusCode = INTERNAL_SERVER_ERROR;
    message = httpStatus[INTERNAL_SERVER_ERROR];
  }

  res.locals.errorMessage = err.message;

  const response = {
    code: statusCode,
    message,
    ...(env === 'development' && { stack: err.stack }),
  };

  if (env === 'development') {
    logger.error(err);
  }

  res.status(statusCode).send(response);
};

export {
  errorConverter,
  errorHandler,
};
