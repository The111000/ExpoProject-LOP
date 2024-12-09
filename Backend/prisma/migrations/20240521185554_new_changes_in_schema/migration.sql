/*
  Warnings:

  - You are about to drop the column `dropOffId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `passengerStatusId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `pickUpId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the `PassengerStatus` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `wayPoint` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_dropOffId_fkey";

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_passengerStatusId_fkey";

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_pickUpId_fkey";

-- DropForeignKey
ALTER TABLE "PassengerStatus" DROP CONSTRAINT "PassengerStatus_passengerStatusId_fkey";

-- DropForeignKey
ALTER TABLE "PassengerStatus" DROP CONSTRAINT "PassengerStatus_requestedUserId_fkey";

-- DropForeignKey
ALTER TABLE "wayPoint" DROP CONSTRAINT "wayPoint_rideId_fkey";

-- AlterTable
ALTER TABLE "Booking" DROP COLUMN "dropOffId",
DROP COLUMN "passengerStatusId",
DROP COLUMN "pickUpId";

-- DropTable
DROP TABLE "PassengerStatus";

-- DropTable
DROP TABLE "wayPoint";
