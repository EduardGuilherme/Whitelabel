import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { PrismaService } from 'src/database/prisma.service';

@Injectable()
export class ProviderService {
  async getProductsFromClient(client: any) {
    const response = await axios.get(client.url);
console.log('➡️ Provider respondeu:', response.status);
    const data = response.data;

     console.log('➡️ Chamando provider URL:', client.url);

  //const response = await axios.get(client.url, { timeout: 8000 }); // 8s timeout
  

    // Se for objeto único → transforma em array
    if (!Array.isArray(data)) {
      return [data];
    }

    return data;
  }
}
