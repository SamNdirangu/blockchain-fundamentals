import rateLimit from 'express-rate-limit';

// Limits the number of maximum connections to the auth routes,
// preventing brute force attacks or something :-)
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 20,
  skipSuccessfulRequests: true,
});

export default authLimiter;
