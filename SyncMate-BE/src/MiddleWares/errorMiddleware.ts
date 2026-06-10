import type { Request, Response, NextFunction } from 'express';
import { HTTP_STATUS } from '../Constant/index';
import { config } from '../Config/env';

export const errorHandler = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  err.statusCode = err.statusCode || HTTP_STATUS.INTERNAL_SERVER_ERROR;
  err.status = err.status || 'error';

  // Log error for debugging
  console.error('Error:', err);

  res.status(err.statusCode).json({
    status: err.status,
    message: err.message,
    ...(config.server.env === 'development' && { stack: err.stack }),
  });
};
