import { MiddlewareConsumer, Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from '../modules/auth/auth.module';
import { ClientsModule } from '../modules/clients/clients.module';
import { ProductsModule } from '../modules/products/products.module';
import { UsersModule } from '../modules/users/users.module';
import { ConfigModule } from '../config/config.module';
import { PrismaService } from 'src/database/prisma.service';
import { ClientMiddleware } from 'src/middleware/client.middleware';

@Module({
  imports: [AuthModule, ClientsModule, ProductsModule, UsersModule, ConfigModule],
  controllers: [AppController],
  providers: [AppService,PrismaService],
})
export class AppModule {
    configure(consumer: MiddlewareConsumer) {
      consumer.apply(ClientMiddleware).forRoutes('*');
  }
}
