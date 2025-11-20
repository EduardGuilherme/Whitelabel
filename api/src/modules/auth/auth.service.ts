import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../../database/prisma.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwt: JwtService,
    private prisma: PrismaService,
  ) {}

  async login(email: string, password: string, clientId: number) {
    const user = await this.usersService.validateUser(email, password , clientId);

    if (!user) throw new UnauthorizedException('Invalid credentials');

    const client = await this.prisma.client.findUnique({
      where: { id: user.clientId ??undefined},
    });

    if (!client) throw new UnauthorizedException('User has no client');


    const payload = {
      sub: user.id,
      email: user.email,
      clientId: user.clientId,
    };
    //console.log('Payload:', payload);
    return {
      token: await this.jwt.signAsync(payload),
    };
  }

  async validateUser(email: string, password: string, clientId: number) {
  const user = await this.prisma.user.findUnique({
    where: { email },
  });

  if (!user || user.clientId !== clientId) {
    return null;
  }

  const isMatch = await bcrypt.compare(password, user.password);
  return isMatch ? user : null;
}
}
