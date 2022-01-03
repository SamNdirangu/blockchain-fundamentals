// This file includes functions to query our env file and present it to our app in an easy
// to access manner.
import joi from 'joi';
import dotenv from 'dotenv';

dotenv.config();
const envVarsSchema = joi.object()
  .keys({
    // Block Chain Keys
    BLOCKCHAIN_URL: joi.string().required(),
    CHAINID: joi.number().required().default(5777),
    MY_ADDRESS: joi.string().required().description('Blockchain account address'),
    PRIVATE_KEY: joi.string().required().description('Private Key for provided account address'),
    // Server Keys ================================================
    NODE_ENV: joi.string().valid('production', 'development', 'test').required(),
    PORT: joi.number().required().default(3000),
    MONGODB_URL: joi.string().description('Mongo DB url'),
    JWT_SECRET: joi.string().description('JWT secret key'),
    JWT_ACCESS_EXPIRATION_MINUTES: joi.number()
      .default(30)
      .description('minutes after which access tokens expire'),
    JWT_REFRESH_EXPIRATION_DAYS: joi.number()
      .default(30)
      .description('days after which refresh tokens expire'),
    JWT_RESET_PASSWORD_EXPIRATION_MINUTES: joi.number()
      .default(10)
      .description('minutes after which reset password token expires'),
    JWT_VERIFY_EMAIL_EXPIRATION_MINUTES: joi.number()
      .default(10)
      .description('minutes after which verify email token expires'),
    SMTP_HOST: joi.string().description('server that will send the emails'),
    SMTP_PORT: joi.number().description('port to connect to the email server'),
    SMTP_USERNAME: joi.string().description('username for email server'),
    SMTP_PASSWORD: joi.string().description('password for email server'),
    EMAIL_FROM: joi.string().description(
      'the from field in the emails sent by the app',
    ),
  })
  .unknown();

const { value: envVars, error } = envVarsSchema
  .prefs({ errors: { label: 'key' } })
  .validate(process.env);

if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

export const blockChain = {
  url: envVars.BLOCKCHAIN_URL,
  chainId: envVars.CHAINID,
  address: envVars.MY_ADDRESS,
  privateKey: envVars.PRIVATE_KEY,
};

export const env = envVars.NODE_ENV;
export const port = envVars.PORT;
export const mongoose = { // Our database settings could be others such as sequel
  url: envVars.MONGODB_URL + (envVars.NODE_ENV === 'test' ? '-test' : ''),
  options: {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
  },
};
export const jwt = { // Our jwt settings
  secret: envVars.JWT_SECRET,
  accessExpirationMinutes: envVars.JWT_ACCESS_EXPIRATION_MINUTES,
  refreshExpirationDays: envVars.JWT_REFRESH_EXPIRATION_DAYS,
  resetPasswordExpirationMinutes: envVars.JWT_RESET_PASSWORD_EXPIRATION_MINUTES,
  verifyEmailExpirationMinutes: envVars.JWT_VERIFY_EMAIL_EXPIRATION_MINUTES,
};
export const email = {
  smtp: {
    host: envVars.SMTP_HOST,
    port: envVars.SMTP_PORT,
    auth: {
      user: envVars.SMTP_USERNAME,
      pass: envVars.SMTP_PASSWORD,
    },
  },
  from: envVars.EMAIL_FROM,
};
