import { Module } from '@nestjs/common';
import { ProductsController } from './products.controller';
import { ProductsService } from './products.service';
import { ProviderService } from './provider.service';

@Module({
  controllers: [ProductsController],
  providers: [ProductsService,ProviderService],
  exports: [ProviderService],
})
export class ProductsModule {}
