import { AuthGuard } from '@nestjs/passport';
import { ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';

@Injectable()
export class JwtAuthGuard extends AuthGuard('jwt') {
  async canActivate(context: ExecutionContext) {
    // Primeiro: valida o JWT e popula req.user
    await super.canActivate(context);

    const req = context.switchToHttp().getRequest();

    // Agora req.user EXISTE
    const user = req.user;

    if (!user?.clientId) {
      throw new UnauthorizedException('Client ID not found in token');
    }

    return true;
  }
}