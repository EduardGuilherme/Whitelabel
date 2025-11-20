import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {

  await prisma.client.upsert({
    where: { domain: 'devnology.local' },
    update: {},
    create: {
      name: 'Devnology',
      url: 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider',
      domain: 'devnology.local',
      primaryColor: '#00a86b',
    },
  });

  await prisma.client.upsert({
    where: { domain: 'in8.local' },
    update: {},
    create: {
      name: 'In8',
      url: 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider',
      domain: 'in8.local',
      primaryColor: '#6a0dad',
    },
  });

  console.log('Seed finished');
  await prisma.$disconnect();
}

main();
