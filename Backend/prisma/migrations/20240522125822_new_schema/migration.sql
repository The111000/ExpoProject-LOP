-- AlterTable
ALTER TABLE "Booking" ADD COLUMN     "driverId" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "Ride" ADD COLUMN     "completed" BOOLEAN NOT NULL DEFAULT false;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_driverId_fkey" FOREIGN KEY ("driverId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
