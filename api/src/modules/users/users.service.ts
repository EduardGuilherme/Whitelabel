import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';
import * as bcrypt from 'bcrypt';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update.user.dto';
import { BadRequestException } from '@nestjs/common';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(dto: CreateUserDto, clientId: number) {
    const client = await this.prisma.client.findUnique({ where: { id: dto.clientId }});
if (!client) throw new BadRequestException('Client not found');
    const hashedPassword = await bcrypt.hash(dto.password, 10);

    const user = await this.prisma.user.create({
      data: {
        ...dto,
        password: hashedPassword,
        clientId: clientId,
        /*name: dto.name,
        email: dto.email,
        password: hashedPassword,
        clientId: dto.clientId,*/
      },
    });

    return user;
  }

  async validateUser(email: string, password: string, clientId: number) {
    const user = await this.findByEmail(email);
    if (!user) return null;

    const match = await bcrypt.compare(password, user.password);
    if (!match) return null;

    return user; 
  }

  async findAll() {
    return this.prisma.user.findMany();
  }

  async findOne(id: number) {
    const user = await this.prisma.user.findUnique({ where: { id } });
    if (!user) throw new NotFoundException('User not found');
    return user;
  }

  async findByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }

  async update(id: number, dto: UpdateUserDto) {
    const user = await this.prisma.user.update({
      where: { id },
      data: {
        ...dto,
        updatedAt: new Date(),
      },
    });
    return user;
  }

  async remove(id: number) {
    await this.prisma.user.delete({ where: { id } });
    return { message: 'User deleted successfully' };
  }
}
