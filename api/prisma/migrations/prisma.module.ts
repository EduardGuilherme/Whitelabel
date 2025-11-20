import { Global, Module } from '@nestjs/common';
import { PrismaService } from '../../src/database/prisma.service';

@Global() // opcional — deixa o PrismaService acessível em todos os módulos sem precisar importar
@Module({
  providers: [PrismaService],
  exports: [PrismaService],
})
export class PrismaModule {}
