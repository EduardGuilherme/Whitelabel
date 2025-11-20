import { Injectable } from '@nestjs/common';
import axios from 'axios';

@Injectable()
export class ProductsService {
  private brazilUrl = 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider';
  private europeUrl = 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider';

  async fetchAll() {
    const [brazil, europe] = await Promise.all([
      axios.get(this.brazilUrl),
      axios.get(this.europeUrl),
    ]);
    return [...brazil.data, ...europe.data];
  }

  async findAll(filter?: string) {
    let products = await this.fetchAll();
    if (filter) products = products.filter(p => p.name?.toLowerCase().includes(filter.toLowerCase()));
    return products;
  }

  async findById(id: string) {
    
    try { const res = await axios.get(`${this.brazilUrl}/${id}`); return res.data; } catch {}
    try { const res = await axios.get(`${this.europeUrl}/${id}`); return res.data; } catch {}
    return null;
  }
}
