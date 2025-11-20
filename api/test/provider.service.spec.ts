
import { ProviderService } from '../src/modules/products/provider.service';
import axios from 'axios';

jest.mock('axios');

describe('ProviderService', () => {
  let service: ProviderService;

  beforeEach(() => {
    service = new ProviderService();
  });

  it('should fetch products successfully', async () => {
    (axios.get as jest.Mock).mockResolvedValue({ data: [{ id: 1 }] });

    const res = await service.getProductsFromClient({ url: 'http://test.com' });

    expect(res).toEqual([{ id: 1 }]);
  });

  it('should return array when provider returns object', async () => {
    (axios.get as jest.Mock).mockResolvedValue({ data: { id: 1 } });

    const res = await service.getProductsFromClient({ url: 'http://test.com' });

    expect(res).toEqual([{ id: 1 }]);
  });
});
