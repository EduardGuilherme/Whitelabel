import { Controller, Get, Req, UnauthorizedException, UseGuards } from '@nestjs/common';
import { ProviderService } from './provider.service';
import { JwtAuthGuard } from 'src/commom/jwt-auth.guard';

@Controller('products')
export class ProductsController {
    constructor(private provider: ProviderService) {}

  @UseGuards(JwtAuthGuard)
  /*@Get()
  async findAll(@Req() req: any) {
    const clientId = req.client;

    if (!clientId) {
      throw new UnauthorizedException('Client ID not found in token');
    }

    return this.provider.getProductsFromClient(clientId);
  }*/

@Get()
async findAll(@Req() req: any) {
  console.log('➡️ Entrou no controller de PRODUCTS');

  const client = req.client;
  console.log('➡️ Client:', client);

  if (!client) {
    throw new UnauthorizedException('Client not found for this domain');
  }

  const data = await this.provider.getProductsFromClient(client);
  console.log('➡️ Dados recebidos do provider:', data);

  return data;
}
}
