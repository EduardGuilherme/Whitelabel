/*
  Warnings:

  - A unique constraint covering the columns `[domain]` on the table `Client` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Client" ADD COLUMN     "domain" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Client_domain_key" ON "Client"("domain");
