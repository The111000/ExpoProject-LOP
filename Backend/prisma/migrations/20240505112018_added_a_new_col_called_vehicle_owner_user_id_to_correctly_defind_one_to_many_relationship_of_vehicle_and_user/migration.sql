-- DropForeignKey
ALTER TABLE "Vehicle" DROP CONSTRAINT "Vehicle_vehicleId_fkey";

-- AlterTable
ALTER TABLE "Vehicle" ADD COLUMN     "vehicleOwnerUserId" INTEGER NOT NULL DEFAULT 3;

-- AddForeignKey
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_vehicleOwnerUserId_fkey" FOREIGN KEY ("vehicleOwnerUserId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
