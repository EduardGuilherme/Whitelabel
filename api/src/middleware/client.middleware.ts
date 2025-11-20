import { Injectable, NestMiddleware } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';

@Injectable()
export class ClientMiddleware implements NestMiddleware {
  constructor(private prisma: PrismaService) {}

  async use(req: any, res: any, next: () => void) {
    const host = req.hostname;
    //console.log('Host from middleware:', host);

    const client = await this.prisma.client.findUnique({
      where: { domain: host }, 
    });

    console.log('Client fetched:', client);

    (req as any).client = client;
    next();
  }
}
