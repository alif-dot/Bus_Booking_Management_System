Introduction:
The Booking_System database is designed to manage bus bookings, schedules, and routes. It allows customers to make bookings, view schedules, and route information. This database is useful for bus transportation companies that operate multiple buses and manage their routes and schedules. 

Entities and Attributes:
1. Bus: This entity stores information about the buses. It has attributes such as Bus_lD, Bus_Name, Bus_Type, and Seat_No.

2. Route: This entity stores information about the routes. It has attributes such as Route_lD, Route_Name, Start_Point, End_Point, UnitPrice, and Bus_lD.

3. Route_Trigger: This entity stores information about the route triggers. It has attributes such as Route_lD, Route_Name, Start_Point, End_Point, UnitPrice, Bus_lD, Activity, DoneBy, and ActivityTime.

4. Schedule: This entity stores information about the schedules. It has attributes such as Schedule_lD, Departure_Time, Arrive_Time, Bus_lD, and Route_lD.

5. Booking: This entity stores information about the bookings. It has attributes such as Bookingl_lD, Customer_Name, Customer_Mobile, Booked_Date, Booked_Status, Price, Cancel_Date, Return_Amount, Return_Status, Bus_lD, and Schedule_lD.

6. BookingDetaiIs: This entity stores information about the booking details. It has attributes such as BookingDetails_|D, CustomerName, CustomerMobile, Bookingl_lD, Bus_lD, and Schedule_lD.

7. ScheduleDetails: This entity stores information about the schedule details. It has attributes such as ScheduleDetails_ID, Bus_lD, and Schedule_lD.

8. Bus_merge: This entity is used for merging bus information from different sources.

Relationships:
1. Bus and Route: The Bus entity has a one-to-many relationship with the Route entity. One bus can operate on multiple routes, but a route can only be assigned to one bus.

2. Route and Schedule: The Route entity has a one-to—many relationship with the Schedule entity. One route can have multiple schedules, but a schedule can only be assigned to one route.

3. Bus and Schedule: The Bus entity has a one-to-many relationship with the Schedule entity. One bus can have multiple schedules, but a schedule can only be assigned to one bus.

4. Schedule and Booking: The Schedule entity has a one-to-many relationship with the Booking entity. One schedule can have multiple bookings, but a booking can only be assigned to one schedule.

5. Booking and BookingDetaiIs: The Booking entity has a one-to-many relationship with the BookingDetails entity. One booking can have multiple booking details, but a booking detail can only be assigned to one booking.

6. Bus and BookingDetaiIs: The Bus entity has a one—to-many relationship with the BookingDetails entity. One bus can have multiple booking details, but a booking detail can only be assigned to one bus.

7. Schedule and ScheduleDetails: The Schedule entity has a one-to-many relationship withthe ScheduleDetails entity. One schedule can have multiple schedule details, but a schedule detail can only be assigned to one schedule.

8. Bus and ScheduleDetails: The Bus entity has a one-to-many relationship with the ScheduleDetails entity. One bus can have multiple schedule details, but a schedule detail can only be assigned to one bus.

Functionalities:
1. Bus Information Management: The database allows the addition, modification, and deletion of bus information such as Bus_Name, Bus_Type, and Seat_No.

2. Route Information Management: The database allows the addition, modification, and deletion of route information such as Route_Name, Start_Point, End_Point, and UnitPrice.

3. Schedule Management: The database allows the addition, modification, and deletion of schedule information such as Departure_Time and Arrive_Time.

4. Booking Management: The database allows the creation, modification, and cancellation of bookings. It also keeps track of the booking status, price, and return details.

5. Route Trigger Management: The database allows the addition, modification, and deletion of route trigger information such as Activity, DoneBy, and ActivityTime.

6. Booking Details Management: The database allows the creation and modification of booking details such as CustomerName and CustomerMobile.

7. Schedule Details Management: The database allows the creation and modification of schedule details.

8. Bus Information Merging: The database provides the functionality of merging bus information from different sources to facilitate efficient bus management.

9. View Information: The database provides the functionality of viewing information such as bus information, route information, schedule information, booking information, and trigger information.

Advantages:
1. Efficient Bus Management: The database provides a centralized platform for bus management, making it easier to manage bus information, schedules, and routes.

2. Improved Customer Experience: The database allows customers to view schedules, route information, and make bookings. This improves the overall customer experience.

3. Easy Tracking of Bookings: The database allows tracking of bookings, including booking status, cancellation, and return details.

4. Efficient Management of Route Triggers: The database allows the efficient management of route triggers, making it easier to track the activities done by different personnel.

5. Improved Data Accuracy: The database improves data accuracy by reducing errors that may occur in manual record-keeping.

Conclusion:
The Booking_System database provides an efficient platform for managing bus information, schedules, and bookings. It allows easy tracking of bookings and efficient management of route triggers. The database improves customer experience and data accuracy, making it a useful tool for bus transportation companies.

