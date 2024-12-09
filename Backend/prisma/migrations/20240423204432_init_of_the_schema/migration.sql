-- CreateTable
CREATE TABLE "User" (
    "userId" SERIAL NOT NULL,
    "userName" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "profile_picture" TEXT,
    "email" TEXT NOT NULL,
    "phoneNumber" INTEGER NOT NULL,
    "address" TEXT NOT NULL,
    "Occupation" TEXT,
    "Ratings" DOUBLE PRECISION NOT NULL DEFAULT 3.00,
    "joinedOn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accountStatus" TEXT NOT NULL DEFAULT 'banned',
    "drivingLiscenceNumber" INTEGER,
    "drivingLiscencePicture" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Review" (
    "reviewId" SERIAL NOT NULL,
    "reviewText" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("reviewId")
);

-- CreateTable
CREATE TABLE "Vehicle" (
    "vehicleId" SERIAL NOT NULL,
    "Company" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "purchaseYear" TIMESTAMP(3),
    "vehicleType" TEXT NOT NULL,
    "capacity" INTEGER NOT NULL,

    CONSTRAINT "Vehicle_pkey" PRIMARY KEY ("vehicleId")
);

-- CreateTable
CREATE TABLE "Ride" (
    "rideId" SERIAL NOT NULL,
    "driverId" INTEGER NOT NULL,
    "vehicleId" INTEGER NOT NULL,
    "origin" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "departureTime" TIMESTAMP(3) NOT NULL,
    "EstimatedArrivalTime" TIMESTAMP(3) NOT NULL,
    "seatsRemaining" INTEGER NOT NULL,

    CONSTRAINT "Ride_pkey" PRIMARY KEY ("rideId")
);

-- CreateTable
CREATE TABLE "wayPoint" (
    "wayPointId" SERIAL NOT NULL,
    "rideId" INTEGER NOT NULL,
    "wayPointLocation" TEXT NOT NULL,
    "wayPointTime" TIMESTAMP(3) NOT NULL,
    "numberOfSeatsAtWayPoint" INTEGER NOT NULL,

    CONSTRAINT "wayPoint_pkey" PRIMARY KEY ("wayPointId")
);

-- CreateTable
CREATE TABLE "PassengerStatus" (
    "passengerStatusId" SERIAL NOT NULL,
    "requestedUserId" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',

    CONSTRAINT "PassengerStatus_pkey" PRIMARY KEY ("passengerStatusId")
);

-- CreateTable
CREATE TABLE "Booking" (
    "bookingId" SERIAL NOT NULL,
    "riderId" INTEGER NOT NULL,
    "rideId" INTEGER NOT NULL,
    "pickUpId" INTEGER NOT NULL,
    "dropOffId" INTEGER NOT NULL,
    "bookingStatus" TEXT NOT NULL,
    "paymentStatus" TEXT NOT NULL,
    "passengerStatusId" INTEGER,

    CONSTRAINT "Booking_pkey" PRIMARY KEY ("bookingId")
);

-- CreateTable
CREATE TABLE "_asPassenger" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userName_key" ON "User"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "_asPassenger_AB_unique" ON "_asPassenger"("A", "B");

-- CreateIndex
CREATE INDEX "_asPassenger_B_index" ON "_asPassenger"("B");

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ride" ADD CONSTRAINT "Ride_driverId_fkey" FOREIGN KEY ("driverId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ride" ADD CONSTRAINT "Ride_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("vehicleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wayPoint" ADD CONSTRAINT "wayPoint_rideId_fkey" FOREIGN KEY ("rideId") REFERENCES "Ride"("rideId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PassengerStatus" ADD CONSTRAINT "PassengerStatus_passengerStatusId_fkey" FOREIGN KEY ("passengerStatusId") REFERENCES "Ride"("rideId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PassengerStatus" ADD CONSTRAINT "PassengerStatus_requestedUserId_fkey" FOREIGN KEY ("requestedUserId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_riderId_fkey" FOREIGN KEY ("riderId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_rideId_fkey" FOREIGN KEY ("rideId") REFERENCES "Ride"("rideId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_pickUpId_fkey" FOREIGN KEY ("pickUpId") REFERENCES "wayPoint"("wayPointId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_dropOffId_fkey" FOREIGN KEY ("dropOffId") REFERENCES "wayPoint"("wayPointId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_passengerStatusId_fkey" FOREIGN KEY ("passengerStatusId") REFERENCES "PassengerStatus"("passengerStatusId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_asPassenger" ADD CONSTRAINT "_asPassenger_A_fkey" FOREIGN KEY ("A") REFERENCES "Ride"("rideId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_asPassenger" ADD CONSTRAINT "_asPassenger_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE CASCADE;
