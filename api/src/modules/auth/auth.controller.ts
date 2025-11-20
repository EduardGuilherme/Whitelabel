import { Controller, Post, Body,Headers , Request, UseGuards, Get, Req, UnauthorizedException} from '@nestjs/common';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from 'src/commom/jwt-auth.guard';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
async login(
  @Req() req: Request,
  @Body() body: { email: string; password: string }
) {
  const client = (req as any).client;

  /*const user = await this.authService.validateUser(
    body.email,
    body.password,
    client.id
  );*/

  if (!client) {
    throw new UnauthorizedException('Credenciais inválidas para este domínio.');
  }

  return this.authService.login(body.email,
    body.password,
    client.id);
}


@UseGuards(JwtAuthGuard)
@Get('me')
findMe(@Request() req) {
   return {
    user: req.user,
    client: req.client,
  };
}
}
